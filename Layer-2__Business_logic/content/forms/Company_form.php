<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the Affero General Public License as published by Affero Inc.,
// either version 1 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful to the Free
// Software community, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
// General Public License for more details.
//
// You should have received a copy of the Affero General Public License with this
// software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
// Suite 225, San Francisco, CA 94107, USA


require_once "../Layer-2__Business_logic/content/forms/Entity_form.php";
require_once "../Layer-4__DBManager_etc/PHP_Tools.php";

// Methods take the values from the global $_POST[] array.


class CompanyForm extends EntityForm
{
	private $data;


	public function processForm()
	{
		$phpTools = new PHPTools();

		// Check the log in state
		if ( $_SESSION['Logged'] == '1' ) // update
		{
			if ( $_SESSION['LoginType'] != 'Company' )
			{
				$error = "<p>Company: ".gettext("You can not access this section been logged as")." '".$_SESSION['LoginType']."'.</p>";
				throw new Exception($error,true);
			}

			if ( $this->loadCompanyForm() != true )
			{
				$error = "<p>Exception at [Company.php]: loadCompanyForm() != true</p>\n";
				throw new Exception($error,false);
			}
		}
		else // new
		{
			// Reset the PHP session is not needed because we have done it at logout and delete-entity time, leaving so a clean state.
		}

		// Process each button event
		if ( isset($_POST['delete']) and $_POST['delete'] == gettext('Delete me') )
		{
			$this->manager->deleteEntity();
			$phpTools->resetPHPsession();

			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Your information has been deleted from the data base. You have been logout automatically.')."<p>\n";
		}
		elseif ( isset($_POST['save']) and $_POST['save'] == gettext('Save') )
		{
			$this->saveCompanyForm();
		}
		elseif ( isset($_GET['email']) and $_GET['email'] != '' )
		{
			// Process the "register account" or "change account's email" operations.
			// It is not needed to check the log-in state. If it is needed, it is checked later.

			if ( isset($_GET['action']) and $_GET['action'] == "register" )
				$this->register(); // Register account
			else
				$this->changeEmail(); // Modify account's email
		}
	}


	public function printOutput()
	{
		if ( $_POST['delete'] == gettext('Delete me') or  ( $_POST['save'] == gettext('Save') and $this->checks['result'] == "pass" )  or $_GET['email'] != '' )
			echo $this->processingResult;
		else
			$this->printCompanyForm();
	}


	private function printCompanyForm()
	{
		$smarty = new Smarty;

		$countries = $this->manager->getCountryList();
		$countryTwoLetter = array_merge( array(""), array_keys($countries) );
		$countryNames = array_merge( array(""), array_values($countries) );
		$smarty->assign('countryTwoLetter', $countryTwoLetter);
		$smarty->assign('countryNames', $countryNames);


		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);

		$smarty->display("Company_form.tpl");
	}


	private function saveCompanyForm()
	{
		// First check, later process

		// Checks
		$this->checkCompanyForm();


		// Save the values in $data variable
		$_SESSION['EntityType'] = 'Company';

		if ( $this->data['Email'] != $_POST['Email'] )
		{
			$_SESSION['WantEmail'] = $_POST['Email'];
			$changeEmail = true;
		}
		else
		{
			$changeEmail = false;
		}

		$this->data['Email'] = trim($_POST['Email']);
		$this->data['Password'] = $_POST['Password'];
		$this->data['RetypePassword'] = $_POST['RetypePassword'];

		$this->data['Street'] = trim($_POST['Street']);
		$this->data['Suite'] = trim($_POST['Suite']);
		$this->data['City'] = trim($_POST['City']);
		$this->data['StateProvince'] = trim($_POST['StateProvince']);
		$this->data['PostalCode'] = $_POST['PostalCode'];
		$this->data['CountryCode'] = $_POST['CountryCode'];

		$this->data['Nationality'] = $_POST['Nationality'];

		$this->data['IpPhoneOrVideo'] = trim($_POST['IpPhoneOrVideo']);
		$this->data['Landline'] = trim($_POST['Landline']);
		$this->data['MobilePhone'] = trim($_POST['MobilePhone']);

		$this->data['Website'] = trim($_POST['Website']);

		$this->data['CompanyName'] = trim($_POST['CompanyName']);

		//XXX $this->data['PhotoOrLogo'] = 

		// Update or insert the values
		if ($this->checks['result'] == "pass" )
		{
			if ( $_SESSION['Logged'] == '1' ) // update
			{
				$this->manager->updateEntity();
				$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p>\n";

				if ( $changeEmail == true )
					$this->requestChangeEmail();
			}
			else // new
			{
				$this->requestRegister();
			}
		}
	}


	private function checkCompanyForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		// When the user request a Password modification both Password fields have to be equal
		if ( $_SESSION['Logged'] == '1' and $_POST['Password'] != $_POST['RetypePassword'] )
		{
			$this->checks['result'] = "fail";
			$this->checks['Password'] = gettext("Password fields differ"); // This message has priority over the below one, about the Password field too.
		}

		if ( trim($_POST['Email'])=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['Email'] = gettext('Please fill in here');
		}
		else
		{
			// The Email field have to keep the right syntax
			if (!preg_match("/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/", $_POST["Email"]))
			{
				$this->checks['result'] = "fail";
				$this->checks['Email'] = gettext('Invalid email address');
			}
		}
	}


	private function loadCompanyForm()
	{
		$result = $this->manager->getEntity($_SESSION['EntityId']);

		if ( count($result[0]) !=1 )
			return false;

		$this->data['Email'] = $result[0][0];
		// The Password is not exposed in the form.

		$_SESSION['WantEmail'] = $result[20][0];

		$this->data['Street'] = $result[3][0];
		$this->data['Suite'] = $result[4][0];
		$this->data['City'] = $result[5][0];
		$this->data['StateProvince'] = $result[6][0];
		$this->data['PostalCode'] = $result[7][0];
		$this->data['CountryCode'] = $result[8][0];

		$this->data['Nationality'] = $result[9][0];

		$this->data['IpPhoneOrVideo'] = $result[11][0];
		$this->data['Landline'] = $result[12][0];
		$this->data['MobilePhone'] = $result[13][0];

		$this->data['Website'] = $result[14][0];

		$this->data['CompanyName'] = $result[18][0];

		if ( file_exists("../entity_photos/".$_SESSION['EntityId']) )
			$this->data['ViewPhotoOrLogo'] = "true";
		else
			$this->data['ViewPhotoOrLogo'] = "false";

		return true;
	}
}
?>
