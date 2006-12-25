<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>
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

// Methods take the values from the global $_POST[] array.


class ViewQualificationsForm
{
	private $manager;


	function __construct()
	{
		$this->manager = new DBManager();
	}


	public function processForm()
	{
		// Check the log in state
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>".gettext('To access this section you have to login first.')."</p>";
				throw new Exception($error,true);
			}

			// Load the data
			if ( !isset( $_POST['ViewEntityId'] ) or $_POST['ViewEntityId']=='' )
			{
				$error = "<p>".gettext('The identifier to show has not been specified.')."</p>";
				throw new Exception($error,false);
			}
			else
				$this->loadQualificationsForm();
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,true);
		}
	}


	public function printOutput()
	{
		$this->printQualificationsForm();
	}


	private function printQualificationsForm()
	{
		// This function draw the form, with its controls. Note that the specific values of form controls are set via SESSION variables.
		// The SESSION variables are loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in SESSION variables.
		//   3. It is set in the smarty templates.

		$smarty = new Smarty;
		$smarty->display("View_Qualifications_form.tpl");
	}


	private function loadQualificationsForm()
	{
		// This function will not override the SESSION variables while the user is working in its form, because of before calling this function the 'Back' button value is checked. 

		$result = $this->manager->getQualificationsForEntity($_POST['ViewEntityId']);


		// Qualifications table

		$_SESSION['ViewProfessionalExperienceSinceYear'] = $result[0][0];
		$_SESSION['ViewAcademicQualification'] = $result[1][0];

		$_SESSION['ViewDesiredContractType'] = $result[2][0]; // Only for Person entity
		$_SESSION['ViewDesiredWageRank'] = $result[3][0];
		$_SESSION['ViewWageRankCurrency'] = $result[4][0];
		$_SESSION['ViewWageRankByPeriod'] = $result[5][0];
		$_SESSION['ViewCurrentEmployability'] = $result[6][0];

		if ($result[7][0]=='t')
			$_SESSION['ViewAvailableToTravel'] = "true";
		else
			$_SESSION['ViewAvailableToTravel'] = "false";

		if ($result[8][0]=='t')
			$_SESSION['ViewAvailableToChangeResidence'] = "true";
		else
			$_SESSION['ViewAvailableToChangeResidence'] = "false";

		$_SESSION['ViewAcademicQualificationDescription'] = $result[9][0];

		if ( isset($result[15][0]) )
			$_SESSION['ViewWageRankCurrencyName'] = $result[15][0];
		else
			$_SESSION['ViewWageRankCurrencyName'] = '';

		// Profiles tables
		$_SESSION['ViewProductProfileList'] = $result[20];
		$_SESSION['ViewProfessionalProfileList'] = $result[21];
		$_SESSION['ViewFieldProfileList'] = $result[22];

		// Skills tables
		$_SESSION['ViewSkillList'] = $result[31];
		$_SESSION['ViewKnowledgeLevelList'] = $result[32];
		$_SESSION['ViewExperienceLevelList'] = $result[33];

		// Certifications
		$_SESSION['ViewCertificationsList'] = $result[23];
		$_SESSION['ViewCertificationsStateList'] = $result[24];

		// Contributions/FreeSoftwareExperiences table
		$_SESSION['ViewContributionsListProject'] = $result[25];
		$_SESSION['ViewContributionsListDescription'] = $result[26];
		$_SESSION['ViewContributionsListURI'] = $result[27];

		// Qualification Languages table
		$_SESSION['ViewLanguageList'] = $result[28];
		$_SESSION['ViewLanguageSpokenLevelList'] = $result[29];
		$_SESSION['ViewLanguageWrittenLevelList'] = $result[30];


		// Entity table

		$result = $this->manager->getEntity($_POST['ViewEntityId']);

		$_SESSION['ViewEmail'] = $result[0][0];

		$_SESSION['ViewEntityType'] = $result[2][0];

		$_SESSION['ViewStreet'] = $result[3][0];
		$_SESSION['ViewSuite'] = $result[4][0];
		$_SESSION['ViewCity'] = $result[5][0];
		$_SESSION['ViewStateProvince'] = $result[6][0];
		$_SESSION['ViewPostalCode'] = $result[7][0];
		$_SESSION['ViewCountryCode'] = $result[8][0];

		$_SESSION['ViewNationality'] = $result[9][0];

		$_SESSION['ViewBirthYear'] = $result[10][0];
		$_SESSION['ViewPhoto'] = '';

		$_SESSION['ViewIpPhoneOrVideo'] = $result[11][0];
		$_SESSION['ViewLandline'] = $result[12][0];
		$_SESSION['ViewMobilePhone'] = $result[13][0];

		$_SESSION['ViewWebsite'] = $result[14][0];

		$_SESSION['ViewFirstName'] = $result[15][0];
		$_SESSION['ViewLastName'] = $result[16][0];
		$_SESSION['ViewMiddleName'] = $result[17][0];

		$_SESSION['ViewCompanyName'] = $result[18][0];

		$_SESSION['ViewNonprofitName'] = $result[19][0];

		$_SESSION['ViewCountryName'] = $result[30][0];
		$_SESSION['ViewNationalityName'] = $result[31][0];
	}
}
?> 
