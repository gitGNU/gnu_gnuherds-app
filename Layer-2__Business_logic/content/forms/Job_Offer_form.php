<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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


class JobOfferForm
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

			if ( $_POST['back'] != gettext('Back') and $_POST['JobOfferId'] != '' ) // $back='Back' exposes we are along a no finished operation, so we do not overrride the transitional $_SESSION variable values loading from the data base table.
			 	$this->loadJobOfferForm();
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if     ( count($_POST)==0 ) // new
		{
			// No POST request: A simple request to this URI has arrived.
			$this->resetFormSessionVars();
		}
		elseif ( count($_POST)==1 and isset($_POST['new']) and $_POST['new'] == gettext('New offer') ) // new
		{
			$this->resetFormSessionVars();
		}
		elseif ( count($_POST) >1 and isset($_POST['save']) and $_POST['save'] == gettext('Save') ) // update
		{
			$this->saveJobOfferForm();
		}
		elseif ( count($_POST)==1 and isset($_POST['JobOfferId']) and $_POST['JobOfferId'] != '' )
		{
			// POST request from Manage_Job_Offers_form.tpl: Edit JobOfferId
		}
		elseif ( count($_POST) >1 and isset($_POST['back']) and $_POST['back'] == gettext('Back') )
		{
			// POST request: The 'Back' button has been clicked.
		}
		elseif ( count($_POST) >1 and isset($_POST['language']) )
		{
			// POST request: Submit from the language change form.
		}
		elseif ( count($_POST)==2 and isset($_POST['JobOfferId']) and $_POST['JobOfferId'] != '' and isset($_POST['TranslationAvailablesToShow']) and $_POST['TranslationAvailablesToShow'] != '' )
		{
			// POST request: Submit of "Show translatable parts as" language.
		}
		elseif ( count($_POST) >1 )
		{
			// POST request: Some of the Entity checkbox has been changed, and its submit has runned.

			$this->saveToSessionVars();
		}
		else
		{
			$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
			throw new Exception($error,false);
		}
	}


	public function printOutput()
	{
		if ( $_POST['save'] == gettext('Save') )
			echo $this->processingResult;
		else
			$this->printJobOfferForm();
	}


	private function printJobOfferForm()
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


		$certificationsList = $this->manager->getCertificationsList();
		$smarty->assign('certificationsList', array_values($certificationsList) );


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


		$timeUnits = $this->manager->getTimeUnitsList();
		$timeUnitsId = array_merge( array(""), array_keys($timeUnits) );
		$timeUnitsName = array_merge( array(""), array_values($timeUnits) );

		$smarty->assign('timeUnitsId', $timeUnitsId );
		$smarty->assign('timeUnitsName', $timeUnitsName );


		$currencies = $this->manager->getCurrenciesList();
		$currenciesThreeLetter = array_merge( array(""), array_keys($currencies) );
		$currenciesName = array_merge( array(""), array_values($currencies) );

		$smarty->assign('currenciesThreeLetter', $currenciesThreeLetter);
		$smarty->assign('currenciesName', $currenciesName);


		$countries = $this->manager->getCountryList();
		$countryTwoLetter = array_merge( array(""), array_keys($countries) );
		$countryNames = array_merge( array(""), array_values($countries) );

		$smarty->assign('countryTwoLetter', $countryTwoLetter);
		$smarty->assign('countryNames', $countryNames);


		$smarty->display("Job_Offer_form.tpl");
	}


	private function resetFormSessionVars()
	{
		$_SESSION['jEmployerJobOfferReference'] = '';

		$_SESSION['jExpirationDate'] = '';

		$_SESSION['jClosed'] = 'false';
		$_SESSION['jHideEmployer'] = 'false';

		$_SESSION['jAllowPersonApplications'] = 'false';
		$_SESSION['jAllowCompanyApplications'] = 'false';
		$_SESSION['jAllowOrganizationApplications'] = 'false';

		$_SESSION['jVacancies'] = '';

		$_SESSION['jContractType'] = '';
		$_SESSION['jWageRank'] = '';
		$_SESSION['jWageRankCurrency'] = '';
		$_SESSION['jWageRankByPeriod'] = '';
		$_SESSION['jEstimatedEffort'] = '';
		$_SESSION['jTimeUnit'] = '';

		$_SESSION['jProfessionalExperienceSinceYear'] = '';
		$_SESSION['jAcademicQualification'] = '';

		$_SESSION['jProductProfileList'] = array();
		$_SESSION['jProfessionalProfileList'] = array();
		$_SESSION['jFieldProfileList'] = array();

		$_SESSION['jSkillList'] = array();
		$_SESSION['jSkillKnowledgeLevelList'] = array();
		$_SESSION['jSkillExperienceLevelList'] = array();

		$_SESSION['jCertificationsList'] = array();

		$_SESSION['jFreeSoftwareExperiences'] = '';

		$_SESSION['jLanguageList'] = array();
		$_SESSION['jLanguageSpokenLevelList'] = array();
		$_SESSION['jLanguageWrittenLevelList'] = array();

		$_SESSION['jTelework'] = '';

		$_SESSION['jCity'] = '';
		$_SESSION['jStateProvince'] = '';
		$_SESSION['jPostalCode'] = '';
		$_SESSION['jCountryCode'] = '';

		$_SESSION['jAvailableToTravel'] = 'false';
	}


	private function saveToSessionVars()
	{
		// Save the values in the session variables

		$_SESSION['jEmployerJobOfferReference'] = isset($_POST['EmployerJobOfferReference']) ? trim($_POST['EmployerJobOfferReference']) : '';

		$_SESSION['jExpirationDate'] = isset($_POST['ExpirationDate']) ? trim($_POST['ExpirationDate']) : '';

		if (isset($_POST['Closed']) and $_POST['Closed']=='on')
			$_SESSION['jClosed'] = "true";
		else
			$_SESSION['jClosed'] = "false";

		if (isset($_POST['HideEmployer']) and $_POST['HideEmployer']=='on')
			$_SESSION['jHideEmployer'] = "true";
		else
			$_SESSION['jHideEmployer'] = "false";

		if (isset($_POST['AllowPersonApplications']) and $_POST['AllowPersonApplications']=='on')
			$_SESSION['jAllowPersonApplications'] = "true";
		else
			$_SESSION['jAllowPersonApplications'] = "false";

		if (isset($_POST['AllowCompanyApplications']) and $_POST['AllowCompanyApplications']=='on')
			$_SESSION['jAllowCompanyApplications'] = "true";
		else
			$_SESSION['jAllowCompanyApplications'] = "false";

		if (isset($_POST['AllowOrganizationApplications']) and $_POST['AllowOrganizationApplications']=='on')
			$_SESSION['jAllowOrganizationApplications'] = "true";
		else
			$_SESSION['jAllowOrganizationApplications'] = "false";

		$_SESSION['jVacancies'] = isset($_POST['Vacancies']) ? trim($_POST['Vacancies']) : '';

		$_SESSION['jContractType'] = isset($_POST['ContractType']) ? $_POST['ContractType'] : '';
		$_SESSION['jWageRank'] = isset($_POST['WageRank']) ? $_POST['WageRank'] : '';
		$_SESSION['jWageRankCurrency'] = isset($_POST['WageRankCurrency']) ? $_POST['WageRankCurrency'] : '';
		$_SESSION['jWageRankByPeriod'] = isset($_POST['WageRankByPeriod']) ? $_POST['WageRankByPeriod'] : '';
		$_SESSION['jEstimatedEffort'] = isset($_POST['EstimatedEffort']) ? trim($_POST['EstimatedEffort']) : '';
		$_SESSION['jTimeUnit'] = isset($_POST['TimeUnit']) ? $_POST['TimeUnit'] : '';

		$_SESSION['jProfessionalExperienceSinceYear'] = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';
		$_SESSION['jAcademicQualification'] = isset($_POST['AcademicQualification']) ? trim($_POST['AcademicQualification']) : '';

		$_SESSION['jProductProfileList'] = isset($_POST['ProductProfileList']) ?  $_POST['ProductProfileList'] : array();
		$_SESSION['jProfessionalProfileList'] = isset($_POST['ProfessionalProfileList']) ? $_POST['ProfessionalProfileList'] : array();
		$_SESSION['jFieldProfileList'] = isset($_POST['FieldProfileList']) ? $_POST['FieldProfileList'] : array();

		$_SESSION['jSkillList'] = isset($_POST['SkillList']) ? $_POST['SkillList'] : array();
		$_SESSION['jSkillKnowledgeLevelList'] = isset($_POST['SkillKnowledgeLevelList']) ? $_POST['SkillKnowledgeLevelList'] : array();
		$_SESSION['jSkillExperienceLevelList'] = isset($_POST['SkillExperienceLevelList']) ? $_POST['SkillExperienceLevelList'] : array();

		$_SESSION['jCertificationsList'] = isset($_POST['CertificationsList']) ? $_POST['CertificationsList'] : array();

		$_SESSION['jFreeSoftwareExperiences'] = isset($_POST['FreeSoftwareExperiences']) ? trim($_POST['FreeSoftwareExperiences']) : '';

		$_SESSION['jLanguageList'] = isset($_POST['LanguageList']) ? $_POST['LanguageList'] : array();
		$_SESSION['jLanguageSpokenLevelList'] = isset($_POST['LanguageSpokenLevelList']) ? $_POST['LanguageSpokenLevelList'] : array();
		$_SESSION['jLanguageWrittenLevelList'] = isset($_POST['LanguageWrittenLevelList']) ? $_POST['LanguageWrittenLevelList'] : array();

		if (isset($_POST['Telework']) and $_POST['Telework']=='on')
			$_SESSION['jTelework'] = "true";
		else
			$_SESSION['jTelework'] = "false";

		$_SESSION['jCity'] = isset($_POST['City']) ? trim($_POST['City']) : '';
		$_SESSION['jStateProvince'] = isset($_POST['StateProvince']) ? trim($_POST['StateProvince']) : '';
		$_SESSION['jPostalCode'] = isset($_POST['PostalCode']) ? $_POST['PostalCode'] : '';
		$_SESSION['jCountryCode'] = isset($_POST['CountryCode']) ? $_POST['CountryCode'] : '';

		if (isset($_POST['AvailableToTravel']) and $_POST['AvailableToTravel']=='on')
			$_SESSION['jAvailableToTravel'] = "true";
		else
			$_SESSION['jAvailableToTravel'] = "false";
	}


	private function saveJobOfferForm()
	{
		$this->saveToSessionVars();

		// Checks
		$this->checkJobOfferForm();


		// Update or insert the values
		if ( $_POST['JobOfferId'] != '' ) // update
		{
			$this->manager->updateJobOffer($_POST['JobOfferId']);
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p><p>&nbsp;</p>\n";

			$this->processingResult .= "<center>\n";
			$this->processingResult .= "<form name='viewMyJobOffer' method='post' action='View_Job_Offer.php'>\n";
			$this->processingResult .= "<input type='hidden' name='ViewJobOfferId' value='$_POST[JobOfferId]'>\n";
			$this->processingResult .= "<input type='hidden' name='ViewEntityId' value='$_SESSION[EntityId]'>\n";
			$this->processingResult .= "<input type='submit' name='view' value='".gettext('Check job offer view')."'>\n";
			$this->processingResult .= "</form>\n";
			$this->processingResult .= "</center>\n";

			// $_SESSION variables have been saved previously.
			// Do not destroy the session, so as to next time the values will be loaded from the $_SESSION variables. 
		}
		else // new
		{
			$J1_Id = $this->manager->addJobOffer();
			$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Success. Your job offer have been saved.')."<p>\n";

			$this->processingResult .= "<center>\n";
			$this->processingResult .= "<form name='viewMyJobOffer' method='post' action='View_Job_Offer.php'>\n";
			$this->processingResult .= "<input type='hidden' name='ViewJobOfferId' value='$J1_Id'>\n";
			$this->processingResult .= "<input type='hidden' name='ViewEntityId' value='$_SESSION[EntityId]'>\n";
			$this->processingResult .= "<input type='submit' name='view' value='".gettext('Check job offer view')."'>\n";
			$this->processingResult .= "</form>\n";
			$this->processingResult .= "</center>\n";
		}
	}


	private function checkJobOfferForm()
	{
		// Note that the POST values has been saved on the SESSION before calling this method. We use SESSION instead POST due to they have the isset check done, and we want to avoid to repeat it.  :P

		// Some field can not be empty
		if ( $_SESSION['jExpirationDate']=='' or ($_SESSION['jAllowPersonApplications']=="false" and $_SESSION['jAllowCompanyApplications']=="false" and $_SESSION['jAllowOrganizationApplications']=="false") or $_SESSION['jVacancies']=='' or $_SESSION['jContractType']=='' or $_SESSION['jWageRank']=='' or $_SESSION['jWageRankCurrency']=='' or $_SESSION['jWageRankByPeriod']=='' or count($_SESSION['jProfessionalProfileList'])<1 or count($_SESSION['jLanguageList'])<1 or ($_SESSION['jWageRankByPeriod']=="by project" and ($_SESSION['jEstimatedEffort']=='' or $_SESSION['jTimeUnit']=='')) )
		{
			$AllowApplications = ( $_SESSION['jAllowPersonApplications']=="true" or $_SESSION['jAllowCompanyApplications']=="true" or $_SESSION['jAllowOrganizationApplications']=="true" ) ? "$_SESSION[jAllowPersonApplications] $_SESSION[jAllowCompanyApplications] $_SESSION[jAllowOrganizationApplications]" : '';
			$ProfessionalProfileList = count($_SESSION['jProfessionalProfileList'])<1 ? '' : count($_SESSION['jProfessionalProfileList']);
			$LanguageList = count($_SESSION['jLanguageList'])<1 ? '' : count($_SESSION['jLanguageList']);

			$error = "
				<p>".gettext('Some required fields are empty!. You have to fill them:')."</p>
				<table>
				<tr><td><b>".gettext('Expiration date')."</b>:</td><td> '$_SESSION[jExpirationDate]'</td></tr>

				<tr><td><b>".gettext('Allow applications from')."</b>:</td><td> '$AllowApplications'</td></tr>
				<tr><td><b>".gettext('Vacancies')."</b>:</td><td> '$_SESSION[jVacancies]'</td></tr>

				<tr><td><b>".gettext('Contract type')."</b>:</td><td> '$_SESSION[jContractType]'</td></tr>

				<tr><td><b>".gettext('Wage rank')."</b>:</td><td> '$_SESSION[jWageRank]'</td></tr>
				<tr><td><b>".gettext('Wage rank')." (currency)</b>:</td><td> '$_SESSION[jWageRankCurrency]'</td></tr>
				<tr><td><b>".gettext('Wage rank')." (by)</b>:</td><td> '$_SESSION[jWageRankByPeriod]'</td></tr>\n";

			if ($_SESSION['jWageRankByPeriod']=="by project")
				$error .= "<tr><td><b>".gettext('Estimated effort')."</b>:</td><td> '$_SESSION[jEstimatedEffort]'</td></tr>
					<tr><td><b>".gettext('Estimated effort')." (time unit)</b>:</td><td> '$_SESSION[jTimeUnit]'</td></tr>";

			$error .= "
				<tr><td><b>".gettext('Professional profiles')."</b>:</td><td> '$ProfessionalProfileList'</td></tr>
				<tr><td><b>".gettext('Required languages')."</b>:</td><td> '$LanguageList'</td></tr>
				</table>\n";
			throw new Exception($error,true); // The parameter 'true' is used to note that the 'Back' button must be shown.
		}

		// Telework or Country have to be filled
		if ( $_SESSION['jTelework']=="false" and $_SESSION['jCountryCode']=='' )
		{
			$error = "<p>".gettext('In the RESIDENCE LOCATION subsection, you have to fill an address (at least the Country), or activate the "Telework" checkbox.')."</p>\n";
			throw new Exception($error,true);
		}

		// Date format
		if ( ( !preg_match('/(\d\d)\-(\d\d)\-(\d\d\d\d)/',$_SESSION['jExpirationDate'],$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
		     ( !preg_match('/(\d\d\d\d)\-(\d\d)\-(\d\d)/',$_SESSION['jExpirationDate'],$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) ) and
		     ( !preg_match('/(\d\d)\/(\d\d)\/(\d\d\d\d)/',$_SESSION['jExpirationDate'],$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
		     ( !preg_match('/(\d\d\d\d)\/(\d\d)\/(\d\d)/',$_SESSION['jExpirationDate'],$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) )     )
		{
			$error = "<p>".gettext('Expiration date').": ".gettext('Incorrect format.')."</p>\n";
			throw new Exception($error,true);
		}
	}


	private function loadJobOfferForm()
	{
		// This function will not override the SESSION variables while the user is working in its form, because of before calling this function the 'Back' button value is checked. 

		$result = $this->manager->getJobOffer($_POST['JobOfferId']);


		// J1_JobOffers table

		$_SESSION['jEmployerJobOfferReference'] = $result[0][0];

		$_SESSION['jExpirationDate'] = $result[2][0];

		if ($result[3][0]=='t')
			$_SESSION['jClosed'] = "true";
		else
			$_SESSION['jClosed'] = "false";

		if ($result[4][0]=='t')
			$_SESSION['jHideEmployer'] = "true";
		else
			$_SESSION['jHideEmployer'] = "false";

		if ($result[5][0]=='t')
			$_SESSION['jAllowPersonApplications'] = "true";
		else
			$_SESSION['jAllowPersonApplications'] = "false";

		if ($result[6][0]=='t')
			$_SESSION['jAllowCompanyApplications'] = "true";
		else
			$_SESSION['jAllowCompanyApplications'] = "false";

		if ($result[7][0]=='t')
			$_SESSION['jAllowOrganizationApplications'] = "true";
		else
			$_SESSION['jAllowOrganizationApplications'] = "false";

		$_SESSION['jVacancies'] = trim($result[8][0]);

		$_SESSION['jContractType'] = $result[9][0];
		$_SESSION['jWageRank'] = $result[10][0];
		$_SESSION['jWageRankCurrency'] = $result[11][0];
		$_SESSION['jWageRankCurrencyName'] = $result[12][0];
		$_SESSION['jWageRankByPeriod'] = $result[13][0];
		$_SESSION['jEstimatedEffort'] = $result[23][0];
		$_SESSION['jTimeUnit'] = $result[24][0];

		$_SESSION['jProfessionalExperienceSinceYear'] = $result[14][0];
		$_SESSION['jAcademicQualification'] = $result[15][0];

		// Profiles tables
		$_SESSION['jProductProfileList'] = $result[30];
		$_SESSION['jProfessionalProfileList'] = $result[31];
		$_SESSION['jFieldProfileList'] = $result[32];

		// Skills tables
		$_SESSION['jSkillList'] = $result[43];
		$_SESSION['jSkillKnowledgeLevelList'] = $result[44];
		$_SESSION['jSkillExperienceLevelList'] = $result[45];

		$_SESSION['jCertificationsList'] = $result[50];

		$_SESSION['jFreeSoftwareExperiences'] = trim($result[16][0]);

		// Languages table
		$_SESSION['jLanguageList'] = $result[40];
		$_SESSION['jLanguageSpokenLevelList'] = $result[41];
		$_SESSION['jLanguageWrittenLevelList'] = $result[42];

		if ($result[17][0]=='t')
			$_SESSION['jTelework'] = "true";
		else
			$_SESSION['jTelework'] = "false";

		$_SESSION['jCity'] = $result[18][0];
		$_SESSION['jStateProvince'] = $result[19][0];
		$_SESSION['jCountryCode'] = $result[20][0];

		if ($result[21][0]=='t')
			$_SESSION['jAvailableToTravel'] = "true";
		else
			$_SESSION['jAvailableToTravel'] = "false";
	}
}
?> 
