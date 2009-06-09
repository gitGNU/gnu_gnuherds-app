<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License as published by the Free Software Foundation,
// either version 3 of the License, or (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
// General Public License for more details.
// 
// You should have received a copy of the GNU Affero General Public License along with this
// program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.


require_once "../Layer-2__Business_logic/content/forms/Entity_form.php";
require_once "../lib/PHP_Tools.php";

// Methods take the values from the global $_POST[] array.


class CooperativeForm extends EntityForm
{
	private $data;


	public function processForm()
	{
		$phpTools = new PHPTools();

		// Check the log in state
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Cooperative' )
			{
				$error = "<p>Cooperative: ".gettext("You can not access this section been logged as")." '".$_SESSION['LoginType']."'.</p>";
				throw new Exception($error,true);
			}

			if ( $this->loadCooperativeForm() != true )
			{
				$error = "<p>Exception at [Cooperative.php]: loadCooperativeForm() != true</p>\n";
				throw new Exception($error,false);
			}
		}

		// Process each button event
		if ( isset($_POST['delete']) and $_POST['delete'] != '' )
		{
			$this->manager->deleteEntity();
			$phpTools->resetPHPsession();

			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Your information has been deleted from the data base. You have been logout automatically.')."<p>\n";
		}
		elseif ( $_POST['save'] != '' or $_POST['more'] != '' )
		{
			$this->saveCooperativeForm();
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
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_POST['save'] != '' and $this->checks['result'] == "pass" )
				echo $this->processingResult;
			else
				$this->printCooperativeForm();
		}
		else
		{
			if ( $_POST['delete'] != '' or $_GET['email'] != '' )
			{
				echo $this->processingResult;

				if ( $_GET['action'] == "register" or $_GET['action'] == "verify" )
				{
					echo "<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>";

					$smarty = new Smarty;
					$smarty->display("Access_form.tpl");
				}
			}
			else
			{
				echo "<p>".gettext('To access this section you have to login first.')."</p><p>&nbsp;</p>";

				$smarty = new Smarty;
				$smarty->display("Access_form.tpl");
			}
		}
	}


	private function printCooperativeForm()
	{
		$smarty = new Smarty;

		$countries = $this->manager->getCountryList();
		$countryTwoLetter = array_merge( array(""), array_keys($countries) );
		$countryNames = array_merge( array(""), array_values($countries) );
		$smarty->assign('countryTwoLetter', $countryTwoLetter);
		$smarty->assign('countryNames', $countryNames);

		$nationalities = $this->manager->getNationalityList();
		$nationalityTwoLetter = array_merge( array(""), array_keys($nationalities) );
		$nationalityNames = array_merge( array(""), array_values($nationalities) );
		$smarty->assign('nationalityTwoLetter', $nationalityTwoLetter);
		$smarty->assign('nationalityNames', $nationalityNames);


		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);

		$smarty->display("Cooperative_form.tpl");
	}


	private function saveCooperativeForm()
	{
		// First check, later process

		// Checks
		$this->checkCooperativeForm();

		// Clean empty rows and the one marked to be deleted
		$this->cleanPOST();

		// Save the values in $data variable
		$_SESSION['EntityType'] = 'Cooperative';

		if ( $this->data['Email'] != trim($_POST['Email']) )
		{
			$_SESSION['WantEmail'] = trim($_POST['Email']);
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

		$this->data['NationalityList'] = $_POST['NationalityList'];
		$this->data['JobLicenseAtList'] = $_POST['JobLicenseAtList'];

		$this->data['IpPhoneOrVideo'] = trim($_POST['IpPhoneOrVideo']);
		$this->data['Landline'] = trim($_POST['Landline']);
		$this->data['MobilePhone'] = trim($_POST['MobilePhone']);

		$this->data['Website'] = trim($_POST['Website']);

		$this->data['CooperativeName'] = trim($_POST['CooperativeName']);

		//XXX $this->data['PhotoOrLogo'] = 

		// Update the values
		if ($this->checks['result'] == "pass" )
		{
			$this->manager->updateEntity();
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p>\n";

			if ( $changeEmail == true )
				$this->requestChangeEmail();
		}
	}

	private function cleanPOST()
	{
		// Clean empty rows and the one marked to be deleted

		// Nationalities
		$count = count($_POST['NationalityList']);
		for( $i=0,$j=0; $i < $count; $i++)
		{
			if ( $_POST['NationalityList'][$i] == '' or ( isset($_POST['DeleteNationalityList']) and in_array("$i",$_POST['DeleteNationalityList']) ) )
			{
			}
			else
			{
				$_POST['NationalityList'][$j] = $_POST['NationalityList'][$i];
				$j++;
			}
		}
		for( $i=$j; $i < $count; $i++)
		{
			unset( $_POST['NationalityList'][$i] );
		}

		// JobLicenseAt Country
		$count = count($_POST['JobLicenseAtList']);
		for( $i=0,$j=0; $i < $count; $i++)
		{
			if ( $_POST['JobLicenseAtList'][$i] == '' or ( isset($_POST['DeleteJobLicenseAtList']) and in_array("$i",$_POST['DeleteJobLicenseAtList']) ) )
			{
			}
			else
			{
				$_POST['JobLicenseAtList'][$j] = $_POST['JobLicenseAtList'][$i];
				$j++;
			}
		}
		for( $i=$j; $i < $count; $i++)
		{
			unset( $_POST['JobLicenseAtList'][$i] );
		}
	}


	private function checkCooperativeForm()
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
			if (!preg_match("/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/", trim($_POST["Email"])))
			{
				$this->checks['result'] = "fail";
				$this->checks['Email'] = gettext('Invalid email address');
			}
		}
	}


	private function loadCooperativeForm()
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

		$this->data['NationalityList'] = $result[31];
		$this->data['JobLicenseAtList'] = $result[33];

		$this->data['IpPhoneOrVideo'] = $result[11][0];
		$this->data['Landline'] = $result[12][0];
		$this->data['MobilePhone'] = $result[13][0];

		$this->data['Website'] = $result[14][0];

		$this->data['CooperativeName'] = $result[40][0];

		if ( file_exists("../entity_photos/".$_SESSION['EntityId']) )
			$this->data['ViewPhotoOrLogo'] = "true";
		else
			$this->data['ViewPhotoOrLogo'] = "false";

		return true;
	}
}
?>
