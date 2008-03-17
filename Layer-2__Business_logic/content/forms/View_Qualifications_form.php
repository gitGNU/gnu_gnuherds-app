<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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


require_once "../Layer-4__DBManager_etc/DB_Manager.php";

// Methods take the values from the global $_POST[] array.


class ViewQualificationsForm
{
	private $manager;
	private $data;


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
				throw new Exception($error,false);
			}

			// Load the data
			if ( !isset( $_GET['EntityId'] ) or $_GET['EntityId']=='' )
			{
				$error = "<p>".gettext('ERROR: The identifier to show has not been specified!')."</p>";
				throw new Exception($error,false);
			}
			else
				$this->loadQualificationsForm();
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( isset($_POST['delete']) and $_POST['delete'] != '' )
		{
			$this->manager->deleteQualifications();
			$_SESSION['HasQualifications'] = 'f'; // Update the HasQualifications SESSION flag used to set the URL at the webapp menu
		}
	}


	public function printOutput()
	{
		if ( $_POST['delete'] != '' )
			echo "<p>&nbsp;</p><p>".gettext('The qualifications information has been deleted from the data base.')."<p>\n";
		else
			$this->printQualificationsForm();
	}


	private function printQualificationsForm()
	{
		// This function draw the form, with its controls. Note that the specific values of form controls are set via the $data array.
		// The $data array is loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in $data array.
		//   3. It is set in the smarty templates.

		$smarty = new Smarty;

		$smarty->assign('data', $this->data);
		$smarty->display("View_Qualifications_form.tpl");
	}


	private function loadQualificationsForm()
	{
		$result = $this->manager->getQualificationsForEntity($_GET['EntityId']);


		// Qualifications table

		$this->data['CompletedEdition'] = $result[10][0];

		$this->data['ProfessionalExperienceSinceYear'] = $result[0][0];

		$this->data['DesiredContractType'] = $result[2][0]; // Only for Person entity
		$this->data['DesiredWageRank'] = $result[3][0];
		$this->data['WageRankCurrency'] = $result[4][0];
		$this->data['WageRankByPeriod'] = $result[5][0];
		$this->data['CurrentEmployability'] = $result[6][0];

		if ($result[7][0]=='t')
			$this->data['AvailableToTravel'] = "true";
		else
			$this->data['AvailableToTravel'] = "false";

		if ($result[8][0]=='t')
			$this->data['AvailableToChangeResidence'] = "true";
		else
			$this->data['AvailableToChangeResidence'] = "false";

		$this->data['AcademicQualificationDescription'] = $result[9][0];

		if ( isset($result[15][0]) )
			$this->data['WageRankCurrencyName'] = $result[15][0];
		else
			$this->data['WageRankCurrencyName'] = '';

		// Qualification Academic table
		$this->data['DegreeList'] = $result[40];
		$this->data['AcademicLevelList'] = $result[41];
		$this->data['DegreeGrantedList'] = $result[42];
		$this->data['StartDateList'] = $result[43];
		$this->data['FinishDateList'] = $result[44];
		$this->data['InstitutionList'] = $result[45];
		$this->data['InstitutionURIList'] = $result[46];
		$this->data['ShortCommentList'] = $result[47];

		// Profiles tables
		$this->data['ProductProfileList'] = $result[20];
		$this->data['ProfessionalProfileList'] = $result[21];
		$this->data['FieldProfileList'] = $result[22];

		// Skills tables
		$this->data['SkillList'] = $result[31];
		$this->data['KnowledgeLevelList'] = $result[32];
		$this->data['ExperienceLevelList'] = $result[33];
		$this->data['CheckList'] = $result[34];

		// Certifications
		$this->data['CertificationsList'] = $result[23];
		$this->data['CertificationsStateList'] = $result[24];

		// Contributions/FreeSoftwareExperiences table
		$this->data['ContributionsListProject'] = $result[25];
		$this->data['ContributionsListDescription'] = $result[26];
		$this->data['ContributionsListURI'] = $result[27];

		// Qualification Languages table
		$this->data['LanguageList'] = $result[28];
		$this->data['LanguageSpokenLevelList'] = $result[29];
		$this->data['LanguageWrittenLevelList'] = $result[30];


		// Entity table

		$result = $this->manager->getEntity($_GET['EntityId']);

		$this->data['Email'] = $result[0][0];

		$this->data['EntityType'] = $result[2][0];

		$this->data['Street'] = $result[3][0];
		$this->data['Suite'] = $result[4][0];
		$this->data['City'] = $result[5][0];
		$this->data['StateProvince'] = $result[6][0];
		$this->data['PostalCode'] = $result[7][0];
		$this->data['CountryCode'] = $result[8][0];

		$this->data['BirthYear'] = $result[10][0];
		$this->data['PhotoOrLogo'] = '';

		$this->data['IpPhoneOrVideo'] = $result[11][0];
		$this->data['Landline'] = $result[12][0];
		$this->data['MobilePhone'] = $result[13][0];

		$this->data['Blog'] = $result[22][0];
		$this->data['Website'] = $result[14][0];

		$this->data['FirstName'] = $result[15][0];
		$this->data['LastName'] = $result[16][0];
		$this->data['MiddleName'] = $result[17][0];

		$this->data['CompanyName'] = $result[18][0];

		$this->data['NonprofitName'] = $result[19][0];

		$this->data['CountryName'] = $result[30][0];
		$this->data['NationalityNameList'] = $result[32];
		$this->data['JobLicenseAtCountryNameList'] = $result[34];

		if ( file_exists("../entity_photos/".$_GET['EntityId']) )
			$this->data['PhotoOrLogo'] = "true";
		else
			$this->data['PhotoOrLogo'] = "false";


		// Qualifications and JobOffers of 'trusted' entities (FSF accounts, etc.) are not filtered.
		if ( $result[21][0] == 'f' )
		{
			// Do not show Non-Free Software or Pending skills

			$count = count($this->data['CheckList']);
			for ($i=0,$j=0; $i < $count; $i++)
			{
				if ( $this->data['CheckList'][$i]=='Non-Free Software' or $this->data['CheckList'][$i]=='Pending' )
				{
				}
				else
				{
					$this->data['SkillList'][$j] = $this->data['SkillList'][$i];
					$this->data['KnowledgeLevelList'][$j] = $this->data['KnowledgeLevelList'][$i];
					$this->data['ExperienceLevelList'][$j] = $this->data['ExperienceLevelList'][$i];
					$this->data['CheckList'][$j] = $this->data['CheckList'][$i];
					$j++;
				}
			}
			for( $i=$j; $i < $count; $i++)
			{
				unset( $this->data['SkillList'][$i] );
				unset( $this->data['KnowledgeLevelList'][$i] );
				unset( $this->data['ExperienceLevelList'][$i] );
				unset( $this->data['CheckList'][$i] );
			}
		}
	}
}
?> 
