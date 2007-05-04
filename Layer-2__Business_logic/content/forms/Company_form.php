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

			if ( $_POST['back'] != gettext('Back') ) // $back='Back' exposes we are along a no finished operation, so we do not overrride the transitional $_SESSION variable values loading from the data base table.
			{
				if ( $this->loadCompanyForm() != true )
				{
					$error = "<p>Exception at [Company.php]: loadCompanyForm() != true</p>\n";
					throw new Exception($error,false);
				}
			}
		}
		else // new
		{
			$_SESSION['ViewPhotoOrLogo'] = "false"; // Initialization

			// If this HTTP request is not realizing any form operation, clear the session variables of this form to
			// show the user a clean form. The action is the same than the previous Cancel operation, which was removed.
			if ( $_POST['save'] != gettext('Save') and $_POST['back'] != gettext('Back') )
				$phpTools->resetPHPsession();
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
		if ( $_POST['delete'] == gettext('Delete me') || $_POST['save'] == gettext('Save') || $_GET['email'] != '' )
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

		$smarty->display("Company_form.tpl");
	}


	private function saveCompanyForm()
	{
		// First check, later process

		// Checks
		$this->checkCompanyForm();


		// Save the values in the session variables
		$_SESSION['EntityType'] = 'Company';

		if ( $_SESSION['Email'] != $_POST['Email'] )
		{
			$_SESSION['WantEmail'] = $_POST['Email'];
			$changeEmail = true;
		}
		else
		{
			$changeEmail = false;
		}

		$_SESSION['Email'] = trim($_POST['Email']);
		$_SESSION['Password'] = $_POST['Password'];
		$_SESSION['RetypePassword'] = $_POST['RetypePassword'];

		$_SESSION['Street'] = trim($_POST['Street']);
		$_SESSION['Suite'] = trim($_POST['Suite']);
		$_SESSION['City'] = trim($_POST['City']);
		$_SESSION['StateProvince'] = trim($_POST['StateProvince']);
		$_SESSION['PostalCode'] = $_POST['PostalCode'];
		$_SESSION['CountryCode'] = $_POST['CountryCode'];

		$_SESSION['Nationality'] = $_POST['Nationality'];

		$_SESSION['IpPhoneOrVideo'] = trim($_POST['IpPhoneOrVideo']);
		$_SESSION['Landline'] = trim($_POST['Landline']);
		$_SESSION['MobilePhone'] = trim($_POST['MobilePhone']);

		$_SESSION['Website'] = trim($_POST['Website']);

		$_SESSION['CompanyName'] = trim($_POST['CompanyName']);

		//XXX $_SESSION['PhotoOrLogo'] = 

		// Update or insert the values
		if ( $_SESSION['Logged'] == '1' ) // update
		{
			$this->manager->updateEntity();
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p>\n";

			// * $_SESSION variables have been saved previously.
			// * Do not destroy the session, so as to next time the values will be loaded from the $_SESSION variables. 

			if ( $changeEmail == true )
				$this->requestChangeEmail();
		}
		else // new
		{
			$this->requestRegister();
		}
	}


	private function checkCompanyForm()
	{
		// Both Password fields have to be equal. This check has be executed first to avoid to recover the mistaken password, if for example the Email is empty.
		if ( $_SESSION['Logged'] == '1' and $_POST['Password'] != $_POST['RetypePassword'] )
		{
			$_SESSION['Password'] = ''; // We are not sure what is right 'Password' or 'RetypePassword', so we empty both.

			$error = "<p>".gettext("The Password fields differ:")." '".trim($_POST['Password'])."' '".trim($_POST['RetypePassword'])."'. ".gettext('Please, write it again.')."</p>\n";
			throw new Exception($error,true);
		}

		// Some field can not be empty
		if ( trim($_POST['Email'])=='' or ($_SESSION['Logged'] == '1' and trim($_POST['Password'])=='') or trim($_POST['CompanyName'])=='' or trim($_POST['CountryCode'])=='' )
		{
			$error = "
				<p>".gettext('Some required fields are empty!. You have to fill them:')."</p>
				<table>
				<tr><td><b>Email</b>:</td><td> '$_POST[Email]'</td></tr>";

			if ( $_SESSION['Logged'] == '1' )
				$error .= "<tr><td><b>".gettext('Password')."</b>:</td><td> (<i>not showed</i>)</td></tr>";

			$error.="<tr><td><b>".gettext('Company name')."</b>:</td><td> '$_POST[CompanyName]'</td></tr>
				<tr><td><b>".gettext('Country')."</b>:</td><td> '$_POST[CountryCode]'</td></tr>
				</table>\n";
			throw new Exception($error,true); // The parameter 'true' is used to note that the 'Back' button must be shown.
		}

		// The Email field have to keep the right syntax
		if (!preg_match("/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/", $_POST["Email"]))
		{
			$error = "<p>".gettext('The Email field is not an email address.')."</p>\n";
			throw new Exception($error,true);
		}
	}


	private function loadCompanyForm()
	{
		$result = $this->manager->getEntity($_SESSION['EntityId']);

		if ( count($result[0]) !=1 )
			return false;

		$_SESSION['Email'] = $result[0][0];
		// The Password is not exposed in the form.

		$_SESSION['WantEmail'] = $result[20][0];

		$_SESSION['Street'] = $result[3][0];
		$_SESSION['Suite'] = $result[4][0];
		$_SESSION['City'] = $result[5][0];
		$_SESSION['StateProvince'] = $result[6][0];
		$_SESSION['PostalCode'] = $result[7][0];
		$_SESSION['CountryCode'] = $result[8][0];

		$_SESSION['Nationality'] = $result[9][0];

		$_SESSION['IpPhoneOrVideo'] = $result[11][0];
		$_SESSION['Landline'] = $result[12][0];
		$_SESSION['MobilePhone'] = $result[13][0];

		$_SESSION['Website'] = $result[14][0];

		$_SESSION['CompanyName'] = $result[18][0];

		if ( file_exists("../entity_photos/".$_SESSION['EntityId']) )
			$_SESSION['ViewPhotoOrLogo'] = "true";
		else
			$_SESSION['ViewPhotoOrLogo'] = "false";

		return true;
	}
}
?>
