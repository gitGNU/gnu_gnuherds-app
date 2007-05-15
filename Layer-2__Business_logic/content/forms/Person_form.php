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


class PersonForm extends EntityForm
{
	public function processForm()
	{
		$phpTools = new PHPTools();

		// Check the log in state and load the data
		if ( $_SESSION['Logged'] == '1' ) // update
		{
			if ( $_SESSION['LoginType'] != 'Person' )
			{
				$error = "<p>Person: ".gettext("You can not access this section been logged as")." '".$_SESSION['LoginType']."'.</p>";
				throw new Exception($error,true);
			}

			if ( $_POST['back'] != gettext('Back') ) // $back='Back' exposes we are along a no finished operation, so we do not overrride the transitional $_SESSION variable values loading from the data base table.
			{
				if ( $this->loadPersonForm() != true )
				{
					$error = "<p>Exception at [Person.php]: loadPersonForm() != true</p>\n";
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
		if ( isset($_POST['delete']) and $_POST['delete'] == gettext('Delete me from this Association') )
		{
			$this->manager->deleteEntity();
			$phpTools->resetPHPsession();

			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Your information has been deleted from the data base. You have been logout automatically.')."<p>\n";
		}
		elseif ( isset($_POST['save']) and $_POST['save'] == gettext('Save') )
		{
			$this->savePersonForm();
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
		if ( $_POST['delete'] == gettext('Delete me from this Association') or  ( $_POST['save'] == gettext('Save') and $this->checks['result'] == "pass" )  or $_GET['email'] != '' )
			echo $this->processingResult;
		else
			$this->printPersonForm();
	}


	private function printPersonForm()
	{
		$smarty = new Smarty;

		$countries = $this->manager->getCountryList();
		$countryTwoLetter = array_merge( array(""), array_keys($countries) );
		$countryNames = array_merge( array(""), array_values($countries) );

		$smarty->assign('countryTwoLetter', $countryTwoLetter);
		$smarty->assign('countryNames', $countryNames);

		$smarty->assign('checks', $this->checks);

		$smarty->display("Person_form.tpl");
	}


	private function savePersonForm()
	{
		// First check, later process

		// Checks
		$this->checkPersonForm();


		// Save the values in the session variables
		$_SESSION['EntityType'] = 'Person';

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

		$_SESSION['BirthYear'] = $_POST['BirthYear'];

		$_SESSION['IpPhoneOrVideo'] = trim($_POST['IpPhoneOrVideo']);
		$_SESSION['Landline'] = trim($_POST['Landline']);
		$_SESSION['MobilePhone'] = trim($_POST['MobilePhone']);

		$_SESSION['Website'] = trim($_POST['Website']);

		$_SESSION['FirstName'] = trim($_POST['FirstName']);
		$_SESSION['LastName'] = trim($_POST['LastName']);
		$_SESSION['MiddleName'] = trim($_POST['MiddleName']);

		//XXX $_SESSION['PhotoOrLogo'] = 

		// Update or insert the values
		if ($this->checks['result'] == "pass" )
		{
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
	}


	private function checkPersonForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		// Both Password fields have to be equal
		if ( $_SESSION['Logged'] == '1' and $_POST['Password'] != $_POST['RetypePassword'] )
		{
			$this->checks['result'] = "fail";
			$this->checks['Password'] = gettext("Password fields differ"); // This message has priority over the below one, about the Password field too.

			$_SESSION['Password'] = ''; // We are not sure what is right 'Password' or 'RetypePassword', so we empty both.
		}
		else
		{
			if ( $_SESSION['Logged'] == '1' and ( trim($_POST['Password'])=='' or trim($_POST['RetypePassword'])=='' ) )
			{
				$this->checks['result'] = "fail";
				$this->checks['Password'] = gettext('Please fill in here');
			}
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


	private function loadPersonForm()
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

		$_SESSION['BirthYear'] = $result[10][0];

		$_SESSION['IpPhoneOrVideo'] = $result[11][0];
		$_SESSION['Landline'] = $result[12][0];
		$_SESSION['MobilePhone'] = $result[13][0];

		$_SESSION['Website'] = $result[14][0];

		$_SESSION['FirstName'] = $result[15][0];
		$_SESSION['LastName'] = $result[16][0];
		$_SESSION['MiddleName'] = $result[17][0];

		if ( file_exists("../entity_photos/".$_SESSION['EntityId']) )
			$_SESSION['ViewPhotoOrLogo'] = "true";
		else
			$_SESSION['ViewPhotoOrLogo'] = "false";

		return true;
	}
}
?>
