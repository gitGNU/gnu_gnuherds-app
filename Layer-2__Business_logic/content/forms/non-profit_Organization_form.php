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


require_once "../Layer-4__DBManager_etc/DB_Manager.php";
require_once "../Layer-4__DBManager_etc/PHP_Tools.php";
require_once "../Layer-2__Business_logic/others/Log_form.php";

// Methods take the values from the global $_POST[] array.


class NonprofitOrganizationForm
{
	private $manager;
	private $processingResult;


	function __construct()
	{
		$this->manager = new DBManager();
		$this->processingResult = '';
	}


	public function processForm()
	{
		// Check the log in state
		if ( $_SESSION['Logged'] == '1' ) // update
		{
			if ( $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>non-profit Organization: ".gettext("You can not access this section been logged as")." '".$_SESSION['LoginType']."'.</p>";
				throw new Exception($error,true);
			}

			if ( $_POST['back'] != gettext('Back') ) // $back='Back' exposes we are along a no finished operation, so we do not overrride the transitional $_SESSION variable values loading from the data base table.
			{
				if ( $this->loadNonprofitForm() != true )
				{
					$error = "<p>Exception at loadNonprofitForm() != true</p>\n";
					throw new Exception($error,false);
				}
			}
		}
		else // new
			$_SESSION['ViewPhotoOrLogo'] = "false"; // Initialization

		// Process each button event
		$phpTools = new PHPTools();
		if ( isset($_POST['delete']) and $_POST['delete'] == gettext('Delete me') )
		{
			$this->manager->deleteEntity();
			$phpTools->resetPHPsession();

			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Your information has been deleted from the data base. You have been logout automatically.')."<p>\n";
		}
		else
			if ( isset($_POST['cancel']) and $_POST['cancel'] == gettext('Cancel') )
			{
				if ( $_SESSION['Logged'] == '1' ) // update
					;
					// Do not save the $_SESSION variables.
					// Do not destroy the session, so as to next time the values will be loaded from the $_SESSION variables. 
				else // new
					$phpTools->resetPHPsession();

				$this->processingResult .= "<p>&nbsp;</p><p>".gettext('The operation has been cancelled.')."</p>\n";
			}
			else
				if ( isset($_POST['save']) and $_POST['save'] == gettext('Save') )
					$this->saveNonprofitForm();
	}


	public function printOutput()
	{
		if ( $_POST['delete'] == gettext('Delete me') || $_POST['cancel'] == gettext('Cancel') || $_POST['save'] == gettext('Save') )
			echo $this->processingResult;
		else
			$this->printNonprofitForm();
	}


	private function printNonprofitForm()
	{
		$smarty = new Smarty;

		$countries = $this->manager->getCountryList();
		$countryTwoLetter = array_merge( array(""), array_keys($countries) );
		$countryNames = array_merge( array(""), array_values($countries) );

		$smarty->assign('countryTwoLetter', $countryTwoLetter);
		$smarty->assign('countryNames', $countryNames);

		$smarty->display("non-profit_Organization_form.tpl");
	}


	private function saveNonprofitForm()
	{
		$_SESSION['EntityType'] = 'non-profit Organization';

		// Save the values in the session variables
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

		$_SESSION['NonprofitName'] = trim($_POST['NonprofitName']);

		//XXX $_SESSION['PhotoOrLogo'] = 

		// Checks
		$this->checkNonprofitForm();

		// Update or insert the values
		if ( $_SESSION['Logged'] == '1' ) // update
		{
			$this->manager->updateEntity();
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p><p>&nbsp;</p>\n";

			// * $_SESSION variables have been saved previously.
			// * Do not destroy the session, so as to next time the values will be loaded from the $_SESSION variables. 
		}
		else // new
		{
			$this->manager->addEntity();
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Success. You have been logged automatically. You can realize others operations in the left menu.')."<p>\n";

			// Set the three 'Login state' variables: $_SESSION['Logged'], $_SESSION['EntityId'], $_SESSION['LoginType']
			$logForm = new LogForm();
			$logForm->logIn();
		}
	}


	private function checkNonprofitForm()
	{
		// Check if there is already a member with this email in the data base
		if (  ( $_SESSION['Logged'] != '1' and $this->manager->lookForEntity() == true )  or  ( $_SESSION['Logged'] == '1' and $_POST['Email'] != $_SESSION['LoginEmail'] and $this->manager->lookForEntity() == true )  )
		{
			$error = "<p>".gettext('There is already a member with this email in the data base. If that email is yours, get the password via the "Lost Password" form, else choose a different email.')."</p>";
			throw new Exception($error,true);
		}

		// Both Password fields have to be equal. This check has be executed first to avoid to recover the mistaken password, if for example the Email is empty.
		if ( trim($_POST['Password']) != trim($_POST['RetypePassword']) )
		{
			$_SESSION['Password'] = ''; // We are not sure what is right 'Password' or 'RetypePassword', so we empty both.

			$error = "<p>".gettext("The Password fields differ:")." '".trim($_POST['Password'])."' '".trim($_POST['RetypePassword'])."'. ".gettext('Please, write it again.')."</p>\n";
			throw new Exception($error,true);
		}

		// Some field can not be empty
		if ( trim($_POST['Email'])=='' or trim($_POST['Password'])=='' or trim($_POST['NonprofitName'])=='' or trim($_POST['CountryCode'])=='' )
		{
			$error = "
				<p>".gettext('Some required fields are empty!. You have to fill them:')."</p>
				<table>
				<tr><td><b>Email</b>:</td><td> '$_POST[Email]'</td></tr>
				<tr><td><b>".gettext('Password')."</b>:</td><td> (<i>not showed</i>)</td></tr>
				<tr><td><b>".gettext('Name')."</b>:</td><td> '$_POST[NonprofitName]'</td></tr>
				<tr><td><b>".gettext('Country')."</b>:</td><td> '$_POST[CountryCode]'</td></tr>
				</table>\n";
			throw new Exception($error,true); // The 'code' parameter '=true' is used to note that the 'Back' button must be shown.
		}

		// The Email field have to keep the right syntax
		if (!eregi("^[A-Z0-9._%-]+@[A-Z0-9._%-]+\.[A-Z]{2,6}$", $_POST["Email"])) // Ref.: http://php.net/eregi
		{
			$error = "<p>".gettext('The Email field is not an email address.')."</p>\n";
			throw new Exception($error,true);
		}
	}


	private function loadNonprofitForm()
	{
		$result = $this->manager->getEntity($_SESSION['EntityId']);

		if ( count($result[0]) !=1 )
			return false;

		$_SESSION['Email'] = $result[0][0];
		// The Password is not exposed in the form.

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

		$_SESSION['NonprofitName'] = $result[19][0];

		if ( file_exists("../entity_photos/".$_SESSION['EntityId']) )
			$_SESSION['ViewPhotoOrLogo'] = "true";
		else
			$_SESSION['ViewPhotoOrLogo'] = "false";

		return true;
	}
}
?> 
