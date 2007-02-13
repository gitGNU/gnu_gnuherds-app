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

// Methods take the values from the global $_POST[] array.


class QualificationsForm
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
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>".gettext('To access this section you have to login first.')."</p>";
				throw new Exception($error,false);
			}

			if ( $_POST['back'] != gettext('Back') ) // $back='Back' exposes we are along a no finished operation, so we do not overrride the transitional $_SESSION variable values loading from the data base table.
			{
				$_SESSION['HasQualifications'] = $this->loadQualificationsForm();
			}
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		$phpTools = new PHPTools();
		if ( isset($_POST['delete']) and $_POST['delete'] == gettext('Delete qualifications') )
		{
			$this->manager->deleteQualifications();
			$phpTools->cleanPHPsession(); // We do not have to reset variables by hand. We can reset all except the login state. If there is data in the data base server, the forms will get it again.

			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('The qualifications information has been deleted from the data base.')."<p>\n";
		}
		else
			if ( isset($_POST['cancel']) and $_POST['cancel'] == gettext('Cancel') )
			{
				// Do not save the $_SESSION variables.
				$phpTools->cleanPHPsession(); // Destroy the session, so as to next time the values will not be loaded from the $_SESSION variables. 

				$this->processingResult .= "<p>&nbsp;</p><p>".gettext('The operation has been cancelled.')."</p>\n";
			}
			else
				if ( isset($_POST['save']) and $_POST['save'] == gettext('Save') )
					$this->saveQualificationsForm();
	}


	public function printOutput()
	{
		if ( $_POST['delete'] == gettext('Delete qualifications') || $_POST['cancel'] == gettext('Cancel') || $_POST['save'] == gettext('Save') )
			echo $this->processingResult;
		else
			$this->printQualificationsForm();
	}


	private function printQualificationsForm()
	{
		$smarty = new Smarty;

		// This function draw the form, with its controls. Note that the specific values of form controls are set via SESSION variables.
		// The SESSION variables are loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in SESSION variables.
		//   3. It is set in the smarty templates.


		$academicQualifications = $this->manager->getAcademicQualificationsList();

		$smarty->assign('academicQualificationsId', array_merge( array(""), array_keys($academicQualifications) ) );
		$smarty->assign('academicQualificationsIdTranslated', array_merge( array(""), array_values($academicQualifications) ) );


		$productProfiles = $this->manager->getProductProfilesList();
		$smarty->assign('productProfiles', array_values($productProfiles) );


		$professionalProfiles = $this->manager->getProfessionalProfilesList();

		$smarty->assign('professionalProfilesId', array_keys($professionalProfiles) );
		$smarty->assign('professionalProfilesName', array_values($professionalProfiles) );


		$fieldProfiles = $this->manager->getFieldProfilesList();

		$smarty->assign('fieldProfilesId', array_keys($fieldProfiles) );
		$smarty->assign('fieldProfilesName', array_values($fieldProfiles) );


		$skillsBySets = $this->manager->getSkillsListsBySets();
		$smarty->assign('skillsBySets', $skillsBySets );


		$skills = $this->manager->getSkillsList();
		$smarty->assign('skills', array_merge( array(""), array_values($skills) ) );


		$skillKnowledgeLevels = $this->manager->getSkillKnowledgeLevelsList();

		$smarty->assign('skillKnowledgeLevelsId', array_keys($skillKnowledgeLevels) );
		$smarty->assign('skillKnowledgeLevelsName', array_values($skillKnowledgeLevels) );


		$skillExperienceLevels = $this->manager->getSkillExperienceLevelsList();

		$smarty->assign('skillExperienceLevelsId', array_keys($skillExperienceLevels) );
		$smarty->assign('skillExperienceLevelsName', array_values($skillExperienceLevels) );


		$notYetRequestedCertifications = $this->manager->getNotYetRequestedCertificationsForEntity();
		$smarty->assign('notYetRequestedCertifications', array_values($notYetRequestedCertifications) );


		$languages = $this->manager->getLanguagesList();

		$smarty->assign('languagesName', array_merge( array(""), array_keys($languages) ) );
		$smarty->assign('languagesNameTranslated', array_merge( array(""), array_values($languages) ) );


		$languagesSpokenLevels = $this->manager->getLanguagesSpokenLevelsList();

		$smarty->assign('languagesSpokenLevelsId', array_keys($languagesSpokenLevels) );
		$smarty->assign('languagesSpokenLevelsName', array_values($languagesSpokenLevels) );


		$languagesWrittenLevels = $this->manager->getLanguagesWrittenLevelsList();

		$smarty->assign('languagesWrittenLevelsId', array_keys($languagesWrittenLevels) );
		$smarty->assign('languagesWrittenLevelsName', array_values($languagesWrittenLevels) );


		$contractTypes = $this->manager->getContractTypesList();

		$smarty->assign('contractTypesId', array_merge( array(""), array_keys($contractTypes) ) );
		$smarty->assign('contractTypesIdTranslated', array_merge( array(""), array_values($contractTypes) ) );


		$byPeriod = $this->manager->getByPeriodList();
		$byPeriodId = array_merge( array(""), array_keys($byPeriod) );
		$byPeriodName = array_merge( array(""), array_values($byPeriod) );

		$smarty->assign('byPeriodId', $byPeriodId );
		$smarty->assign('byPeriodName', $byPeriodName );


		$currencies = $this->manager->getCurrenciesList();
		$currenciesThreeLetter = array_merge( array(""), array_keys($currencies) );
		$currenciesName = array_merge( array(""), array_values($currencies) );

		$smarty->assign('currenciesThreeLetter', $currenciesThreeLetter);
		$smarty->assign('currenciesName', $currenciesName);


		$employability = $this->manager->getEmployabilityList();

		$smarty->assign('employabilityId', array_merge( array(""), array_keys($employability) ) );
		$smarty->assign('employabilityIdTranslated', array_merge( array(""), array_values($employability) ) );


		$smarty->display("Qualifications_form.tpl");
	}


	private function saveQualificationsForm()
	{
		// Save the values in the session variables

		$_SESSION['ProfessionalExperienceSinceYear'] = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';

		$_SESSION['AcademicQualification'] = isset($_POST['AcademicQualification']) ? trim($_POST['AcademicQualification']) : '';
		$_SESSION['AcademicQualificationDescription'] = isset($_POST['AcademicQualificationDescription']) ? trim($_POST['AcademicQualificationDescription']) : '';

		$_SESSION['ProductProfileList'] = isset($_POST['ProductProfileList']) ? $_POST['ProductProfileList'] : array(); // Note: If it is set, we suppose it is array too.
		$_SESSION['ProfessionalProfileList'] = isset($_POST['ProfessionalProfileList']) ? $_POST['ProfessionalProfileList'] : array();
		$_SESSION['FieldProfileList'] = isset($_POST['FieldProfileList']) ? $_POST['FieldProfileList'] : array();

		$_SESSION['SkillList'] = isset($_POST['SkillList']) ? $_POST['SkillList'] : array();
		$_SESSION['SkillKnowledgeLevelList'] = isset($_POST['SkillKnowledgeLevelList']) ? $_POST['SkillKnowledgeLevelList'] : array();
		$_SESSION['SkillExperienceLevelList'] = isset($_POST['SkillExperienceLevelList']) ? $_POST['SkillExperienceLevelList'] : array();

		// The RequestedCertifications are not updated via this form, but directly by the certification team.
		$_SESSION['NotYetRequestedCertificationsList'] = isset($_POST['NotYetRequestedCertificationsList']) ? $_POST['NotYetRequestedCertificationsList'] : array();

		$_SESSION['ContributionsListProject'] = isset($_POST['ContributionsListProject']) ? $_POST['ContributionsListProject'] : array();
		$_SESSION['ContributionsListDescription'] = isset($_POST['ContributionsListDescription']) ? $_POST['ContributionsListDescription'] : array();
		$_SESSION['ContributionsListURI'] = isset($_POST['ContributionsListURI']) ? $_POST['ContributionsListURI'] : array();

		$_SESSION['LanguageList'] = isset($_POST['LanguageList']) ? $_POST['LanguageList'] : array();
		$_SESSION['LanguageSpokenLevelList'] = isset($_POST['LanguageSpokenLevelList']) ? $_POST['LanguageSpokenLevelList'] : array();
		$_SESSION['LanguageWrittenLevelList'] = isset($_POST['LanguageWrittenLevelList']) ? $_POST['LanguageWrittenLevelList'] : array();

		$_SESSION['DesiredContractType'] = isset($_POST['DesiredContractType']) ? trim($_POST['DesiredContractType']) : '';
		$_SESSION['DesiredWageRank'] = isset($_POST['DesiredWageRank']) ? trim($_POST['DesiredWageRank']) : '';
		$_SESSION['WageRankCurrency'] = isset($_POST['WageRankCurrency']) ? trim($_POST['WageRankCurrency']) : '';
		$_SESSION['WageRankByPeriod'] = isset($_POST['WageRankByPeriod']) ? $_POST['WageRankByPeriod'] : ''; // Note we have to avoid the trim to the combo box work properly.
		$_SESSION['CurrentEmployability'] = isset($_POST['CurrentEmployability']) ? trim($_POST['CurrentEmployability']) : '';

		if (isset($_POST['AvailableToTravel']))
			$_SESSION['AvailableToTravel'] = "true";
		else
			$_SESSION['AvailableToTravel'] = "false";

		if (isset($_POST['AvailableToChangeResidence']))
			$_SESSION['AvailableToChangeResidence'] = "true";
		else
			$_SESSION['AvailableToChangeResidence'] = "false";


		// Checks
		$this->checkQualificationsForm();


		// Update or insert the values
		if ( $_SESSION['HasQualifications'] ) // update
		{
			$this->manager->updateQualifications();
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p><p>&nbsp;</p>\n";

			$this->processingResult .= "<center>\n";
			$this->processingResult .= "<form name='viewMyQualifications' method='post' action='View_Qualifications.php'>\n";
			$this->processingResult .= "<input type='hidden' name='ViewEntityId' value='$_SESSION[EntityId]'>\n";
			$this->processingResult .= "<input type='submit' name='view' value='".gettext('Check qualifications view')."'>\n";
			$this->processingResult .= "</form>\n";
			$this->processingResult .= "</center>\n";

			// $_SESSION variables have been saved previously.
			// Do not destroy the session, so as to next time the values will be loaded from the $_SESSION variables. 
		}
		else // new
		{
			$this->manager->addQualifications();
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Success. Your qualifications have been saved.')."<p>\n";

			$this->processingResult .= "<center>\n";
			$this->processingResult .= "<form name='viewMyQualifications' method='post' action='View_Qualifications.php'>\n";
			$this->processingResult .= "<input type='hidden' name='ViewEntityId' value='$_SESSION[EntityId]'>\n";
			$this->processingResult .= "<input type='submit' name='view' value='".gettext('Check qualifications view')."'>\n";
			$this->processingResult .= "</form>\n";
			$this->processingResult .= "</center>\n";
		}
	}


	private function checkQualificationsForm()
	{
		// Note that the POST values has been saved on the SESSION before calling this method. We use SESSION instead POST due to they have the isset check done, and we want to avoid to repeat it.  :P

		// Some field can not be empty
		if ( $_SESSION['ProfessionalExperienceSinceYear']=='' or count($_SESSION['LanguageList'])<1 or
			$_SESSION['LoginType']=='Person' and
			  ( $_SESSION['DesiredContractType']=='' or $_SESSION['DesiredWageRank']=='' or $_SESSION['WageRankCurrency']=='' or $_SESSION['WageRankByPeriod']=='' or $_SESSION['CurrentEmployability']=='' )
		   )
		{
			$LanguageList = count($_SESSION['LanguageList'])<1 ? '' : count($_SESSION['LanguageList']);
				
			$error = "
				<p>".gettext('Some required fields are empty!. You have to fill them:').":</p>
				<table>
				<tr><td><b>".gettext('Professional experience since')."</b>:</td><td> '{$_SESSION['ProfessionalExperienceSinceYear']}'</td></tr>
				<tr><td><b>".gettext('Languages')."</b>:</td><td> '{$LanguageList}'</td></tr>";
			if ($_SESSION['LoginType']=='Person')
				$error .= "
				<tr><td><b>".gettext('Desired contract type')."</b>:</td><td> '{$_SESSION['DesiredContractType']}'</td></tr>
				<tr><td><b>".gettext('Desired wage rank')."</b>:</td><td> '{$_SESSION['DesiredWageRank']}'</td></tr>
				<tr><td><b>".gettext('Wage rank currency')."</b>:</td><td> '{$_SESSION['WageRankCurrency']}'</td></tr>
				<tr><td><b>".gettext('Wage rank By period')."</b>:</td><td> '{$_SESSION['WageRankByPeriod']}'</td></tr>
				<tr><td><b>".gettext('Currently you are')."</b>:</td><td> '{$_SESSION['CurrentEmployability']}'</td></tr>
				</table>\n";
			else
				$error .= "</table>\n";
			throw new Exception($error,true); // The parameter 'true' is used to note that the 'Back' button must be shown.
		}
	}


	private function loadQualificationsForm()
	{
		// This function will not override the SESSION variables while the user is working in its form, because of before calling this function the 'Back' button value is checked. 

		$result = $this->manager->getQualificationsForEntity($_SESSION['EntityId']);

		if ( count($result[0]) !=1 )
			return false;

		// Qualifications table

		$_SESSION['ProfessionalExperienceSinceYear'] = $result[0][0];
		$_SESSION['AcademicQualification'] = $result[1][0];

		// Only for Person entity
		$_SESSION['DesiredContractType'] = $result[2][0];
		$_SESSION['DesiredWageRank'] = $result[3][0];
		$_SESSION['WageRankCurrency'] = $result[4][0];
		$_SESSION['WageRankByPeriod'] = $result[5][0];
		$_SESSION['CurrentEmployability'] = $result[6][0];

		if ($result[7][0]=='t')
			$_SESSION['AvailableToTravel'] = "true";
		else
			$_SESSION['AvailableToTravel'] = "false";

		if ($result[8][0]=='t')
			$_SESSION['AvailableToChangeResidence'] = "true";
		else
			$_SESSION['AvailableToChangeResidence'] = "false";

		$_SESSION['AcademicQualificationDescription'] = $result[9][0];


		// Profiles tables
		$_SESSION['ProductProfileList'] = $result[20];
		$_SESSION['ProfessionalProfileList'] = $result[21];
		$_SESSION['FieldProfileList'] = $result[22];

		// Certifications
		$_SESSION['CertificationsList'] = $result[23];
		$_SESSION['CertificationsStateList'] = $result[24];

		// Contributions/FreeSoftwareExperiences table
		$_SESSION['ContributionsListProject'] = $result[25];
		$_SESSION['ContributionsListDescription'] = $result[26];
		$_SESSION['ContributionsListURI'] = $result[27];

		// Qualification Languages table
		$_SESSION['LanguageList'] = $result[28];
		$_SESSION['LanguageSpokenLevelList'] = $result[29];
		$_SESSION['LanguageWrittenLevelList'] = $result[30];

		// Qualification Skills table
		$_SESSION['SkillList'] = $result[31];
		$_SESSION['SkillKnowledgeLevelList'] = $result[32];
		$_SESSION['SkillExperienceLevelList'] = $result[33];

		return true;
	}
}
?> 
