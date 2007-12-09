<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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


require_once "../Layer-2__Business_logic/content/forms/Skills_form.php";

// Methods take the values from the global $_POST[] array.


class JobOfferForm extends SkillsForm
{
	private $checkresults;
	private $section2view;
	private $section2control;


	public function processForm()
	{
		// Find out the section we have to show to the user
		if ( $_POST['jump'] != '' )
			$this->section2view = $_POST['jump'];
		elseif ( $_POST['previous'] != '' )
			$this->section2view = $_POST['jump2previous'];
		elseif ( $_POST['next'] != '' )
			$this->section2view = $_POST['jump2next'];
		elseif ( $_POST['finish'] != '' )
			$this->section2view = $_POST['section2control']; // The section to show is the same than the section to process
		elseif ( $_POST['more'] != '' )
			$this->section2view = $_POST['section2control'];
		elseif ( $_GET['section'] != '' )
			$this->section2view = $_GET['section']; // Edit section via GET request
		elseif ( $_GET['JobOfferId'] == '' )
			$this->section2view = 'general'; // GET request: Submit from the language change form. Updating job offer
		else
			$this->section2view = 'general'; // GET request: Submit from the language change form. Creating job offer

		// Find out the section to process
		if ( $_POST['section2control'] != '' )
			$this->section2control = $_POST['section2control'];
		else
			$this->section2control = ''; // GET request from language change, POST request from "New offer", etc.

		// Find out the JobOfferId. It is used at saveJobOfferForm() and at the Smarty templates
		if ( $_GET['JobOfferId'] != '' )
			$_SESSION['JobOfferId'] = $_GET['JobOfferId']; // Updating a job offer
		elseif ( $_POST['new'] != '' )
			$_SESSION['JobOfferId'] = ''; // Create the first section of a new job offer
		elseif ( $_SESSION['JobOfferId'] != '' )
			; // After being created at least the first section of a new job offer
		else
			; // We are trying to create the first section of a job offer


		// Check the log in state
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>".gettext('To access this section you have to login first.')."</p>";
				throw new Exception($error,false);
			}

			if ( $_SESSION['JobOfferId'] != '' ) // We load the data from the data base and later overwrite it with the POST variables if it is needed. If JobOfferId comes from $_SESSION['JobOfferId'] we have to call to the loadJobOfferForm method too.
			{
			 	$this->loadJobOfferForm();
			}
			else
			{
				// Reset the visited-marks set by a previous qualifications edition
				$_SESSION['VisitedJobOffer_skills'] = false;
				$_SESSION['VisitedJobOffer_certifications'] = false;
				$_SESSION['VisitedJobOffer_projects'] = false;
				$_SESSION['VisitedJobOffer_location'] = false;
			}
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( isset($_POST['new']) and $_POST['new'] != '' ) // new
		{
		}
		elseif ( $_POST['previous'] != '' or $_POST['next'] != '' or $_POST['jump'] != '' or $_POST['finish'] != '' or $_POST['more'] != '' ) // update
		{
			// POST request from *_form.tpl: Edit JobOfferId
			$this->saveJobOfferForm();
		}
		elseif ( count($_GET)==2 and isset($_GET['JobOfferId']) and $_GET['JobOfferId'] != '' and isset($_GET['section']) and $_GET['section'] != '' ) // edit
		{
			// GET request from View_Job_Offer_form.tpl: Edit JobOfferId
		}
		elseif ( isset($_GET['language']) ) // change language
		{
			// GET request: Submit from the language change form
		}
		else
		{
			$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
			throw new Exception($error,false);
		}
	}


	public function printOutput()
	{
		if ( $_POST['finish'] != '' and $this->checks['result'] == "pass" and $this->can_save == true )
		{
			header('Location: /offers?id='.$_SESSION['JobOfferId']); // We reditect to the view-offer web page
			exit;
		}
		else
		{
			$this->printJobOfferForm();
		}
	}


	private function printJobOfferForm()
	{
		$smarty = new Smarty;

		// This function draw the form, with its controls. Note that the specific values of form controls are set via the $data array.
		// The $data array is loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in $data array.
		//   3. It is set in the smarty templates.


		$section = $this->section2view;

		// If there is section to control and its checks has failed, we do not show the section to view but instead we show
		// the section to control so that the user can fix the mistake and pass the checks rightly.
		if ( $this->section2control != '' and ( $this->checks['result'] == "fail" or $this->can_save == false ) )
			$section = $this->section2control;

		switch($section)
		{
			case 'general':
			break;

			case 'profiles_etc':
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
			break;

			case 'skills':
				$skills = $this->manager->getSkillsList();
				$smarty->assign('skills', array_merge( array(""), array_values($skills) ) );

				$skillKnowledgeLevels = $this->manager->getSkillKnowledgeLevelsList();
				$smarty->assign('skillKnowledgeLevelsId', array_merge( array(""), array_keys($skillKnowledgeLevels) ) );
				$smarty->assign('skillKnowledgeLevelsName', array_merge( array(""), array_values($skillKnowledgeLevels) ) );

				$skillExperienceLevels = $this->manager->getSkillExperienceLevelsList();
				$smarty->assign('skillExperienceLevelsId', array_merge( array(""), array_keys($skillExperienceLevels) ) );
				$smarty->assign('skillExperienceLevelsName', array_merge( array(""), array_values($skillExperienceLevels) ) );
			break;

			case 'languages':
				$languages = $this->manager->getLanguagesList();
				$smarty->assign('languagesName', array_merge( array(""), array_keys($languages) ) );
				$smarty->assign('languagesNameTranslated', array_merge( array(""), array_values($languages) ) );

				$languagesSpokenLevels = $this->manager->getLanguagesSpokenLevelsList();
				$smarty->assign('languagesSpokenLevelsId', array_merge( array(""), array_keys($languagesSpokenLevels) ) );
				$smarty->assign('languagesSpokenLevelsName', array_merge( array(""), array_values($languagesSpokenLevels) ) );

				$languagesWrittenLevels = $this->manager->getLanguagesWrittenLevelsList();
				$smarty->assign('languagesWrittenLevelsId', array_merge( array(""), array_keys($languagesWrittenLevels) ) );
				$smarty->assign('languagesWrittenLevelsName', array_merge( array(""), array_values($languagesWrittenLevels) ) );
			break;

			case 'certifications':
				$certificationsList = $this->manager->getCertificationsList();
				$smarty->assign('certificationsList', array_values($certificationsList) );
			break;

			case 'projects':
			break;

			case 'location':
				$countries = $this->manager->getCountryList();
				$countryTwoLetter = array_merge( array(""), array_keys($countries) );
				$countryNames = array_merge( array(""), array_values($countries) );
				$smarty->assign('countryTwoLetter', $countryTwoLetter);
				$smarty->assign('countryNames', $countryNames);
			break;

			case 'contract':
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
			break;

			default:
				$error = "<p>".gettext("Unexpected error")."</p>";
				throw new Exception($error,false);
		}

		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);
		$smarty->assign('checkresults', $this->checkresults);
		$smarty->assign('section', $section);
		$smarty->display("Job_Offer_".$section."_form.tpl");
	}


	private function saveJobOfferForm()
	{
		// Prepare data for view: $this->data  and  $_POST  array.
		$this->prepareData4View();

		// Set the check marks
		$this->checkJobOfferForm();

		if ( $this->checks['result'] == "pass" )
		{
			$this->can_save = $this->manageSuggestions(); // Get and process new suggestions
			if ( $this->can_save )
			{
				// Update or insert the values
				if ( $_SESSION['JobOfferId'] != '' ) // update
				{
					$this->manager->updateJobOffer($_SESSION['JobOfferId'],$this->section2control,$this->checks['completed_edition']);
				}
				else // new
				{
					$_SESSION['JobOfferId'] = $this->manager->addJobOffer($this->checks['completed_edition']); // Add a new job offer with the data from the 'general' section
					// We set this SESSION variable as a hack to be able to pass the J1_Id to the next form section
				}
			}
		}
	}


	private function prepareData4View()
	{
		// Save the section values in the $data variable

		switch($this->section2control)
		{
			case 'general':
				if (isset($_POST['AllowPersonApplications']) and $_POST['AllowPersonApplications']=='on')
					$this->data['AllowPersonApplications'] = "true";
				else
					$this->data['AllowPersonApplications'] = "false";

				if (isset($_POST['AllowCompanyApplications']) and $_POST['AllowCompanyApplications']=='on')
					$this->data['AllowCompanyApplications'] = "true";
				else
					$this->data['AllowCompanyApplications'] = "false";

				if (isset($_POST['AllowOrganizationApplications']) and $_POST['AllowOrganizationApplications']=='on')
					$this->data['AllowOrganizationApplications'] = "true";
				else
					$this->data['AllowOrganizationApplications'] = "false";

				$this->data['Vacancies'] = isset($_POST['Vacancies']) ? trim($_POST['Vacancies']) : '';

				if (isset($_POST['Closed']) and $_POST['Closed']=='on')
					$this->data['Closed'] = "true";
				else
					$this->data['Closed'] = "false";

				$this->data['ExpirationDate'] = isset($_POST['ExpirationDate']) ? trim($_POST['ExpirationDate']) : '';

				$this->data['EmployerJobOfferReference'] = isset($_POST['EmployerJobOfferReference']) ? trim($_POST['EmployerJobOfferReference']) : '';

				if (isset($_POST['HideEmployer']) and $_POST['HideEmployer']=='on')
					$this->data['HideEmployer'] = "true";
				else
					$this->data['HideEmployer'] = "false";
			break;

			case 'profiles_etc':
				$this->data['ProfessionalExperienceSinceYear'] = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';
				$this->data['AcademicQualification'] = isset($_POST['AcademicQualification']) ? trim($_POST['AcademicQualification']) : '';

				$this->data['ProductProfileList'] = isset($_POST['ProductProfileList']) ?  $_POST['ProductProfileList'] : array();
				$this->data['ProfessionalProfileList'] = isset($_POST['ProfessionalProfileList']) ? $_POST['ProfessionalProfileList'] : array();
				$this->data['FieldProfileList'] = isset($_POST['FieldProfileList']) ? $_POST['FieldProfileList'] : array();
			break;

			case 'skills':
				// Clean empty rows and the one marked to be deleted
				$count = count($_POST['SkillList']);
				for( $i=0,$j=0; $i < $count; $i++)
				{
					if ( ( $_POST['SkillList'][$i] == '' and $_POST['SkillKnowledgeLevelList'][$i] == '' and $_POST['SkillExperienceLevelList'][$i] == '' ) or
					     ( isset($_POST['DeleteSkillList']) and in_array("$i",$_POST['DeleteSkillList']) ) )
					{
					}
					else
					{
						$this->data['CheckList'][$j] = $this->data['CheckList'][$i];

						$_POST['SkillList'][$j] = $_POST['SkillList'][$i];
						$_POST['ShadowSkillList'][$j] = $_POST['ShadowSkillList'][$i];
						$_POST['SkillsToInsert'][$j] = $_POST['SkillsToInsert'][$i];
						$_POST['SuggestionSet'.$j] = $_POST['SuggestionSet'.$i];
						$_POST['SkillKnowledgeLevelList'][$j] = $_POST['SkillKnowledgeLevelList'][$i];
						$_POST['SkillExperienceLevelList'][$j] = $_POST['SkillExperienceLevelList'][$i];

						// '$checks' are generated later

						// '$suggestions' are generated later

						$j++;
					}
				}

				for( $i=$j; $i < $count; $i++)
				{
					unset( $this->data['CheckList'][$i] );

					unset( $_POST['SkillList'][$i] );
					unset( $_POST['ShadowSkillList'][$i] );
					unset( $_POST['SkillsToInsert'][$i] );
					unset( $_POST['SuggestionSet'.$i] );
					unset( $_POST['SkillKnowledgeLevelList'][$i] );
					unset( $_POST['SkillExperienceLevelList'][$i] );

					// '$checks' are generated later

					// '$suggestions' are generated later
				}
			break;

			case 'languages':
				// Clean empty rows and the one marked to be deleted
				$count = count($_POST['LanguageList']);
				for( $i=0,$j=0; $i < $count; $i++)
				{
					if ( ( $_POST['LanguageList'][$i] == '' and $_POST['LanguageSpokenLevelList'][$i] == '' and $_POST['LanguageWrittenLevelList'][$i] == '' and count($_POST['LanguageList']) > 1 ) or
					     ( isset($_POST['DeleteLanguageList']) and in_array("$i",$_POST['DeleteLanguageList']) ) ) // DeleteLanguageList is not saved at $data variable
					{
					}
					else
					{
						$_POST['LanguageList'][$j] = $_POST['LanguageList'][$i];
						$_POST['LanguageSpokenLevelList'][$j] = $_POST['LanguageSpokenLevelList'][$i];
						$_POST['LanguageWrittenLevelList'][$j] = $_POST['LanguageWrittenLevelList'][$i];
						$j++;
					}
				}

				for( $i=$j; $i < $count; $i++)
				{
					unset( $_POST['LanguageList'][$i] );
					unset( $_POST['LanguageSpokenLevelList'][$i] );
					unset( $_POST['LanguageWrittenLevelList'][$i] );
				}

				// Now, copy to the $data variable
				$this->data['LanguageList'] = isset($_POST['LanguageList']) ? $_POST['LanguageList'] : array();
				$this->data['LanguageSpokenLevelList'] = isset($_POST['LanguageSpokenLevelList']) ? $_POST['LanguageSpokenLevelList'] : array();
				$this->data['LanguageWrittenLevelList'] = isset($_POST['LanguageWrittenLevelList']) ? $_POST['LanguageWrittenLevelList'] : array();
			break;

			case 'certifications':
				$this->data['CertificationsList'] = isset($_POST['CertificationsList']) ? $_POST['CertificationsList'] : array(); //XXX pending
			break;

			case 'projects':
				$this->data['FreeSoftwareExperiences'] = isset($_POST['FreeSoftwareExperiences']) ? trim($_POST['FreeSoftwareExperiences']) : '';
			break;

			case 'location':
				$this->data['City'] = isset($_POST['City']) ? trim($_POST['City']) : '';
				$this->data['StateProvince'] = isset($_POST['StateProvince']) ? trim($_POST['StateProvince']) : '';
				$this->data['PostalCode'] = isset($_POST['PostalCode']) ? $_POST['PostalCode'] : '';
				$this->data['CountryCode'] = isset($_POST['CountryCode']) ? $_POST['CountryCode'] : '';

				if (isset($_POST['AvailableToTravel']) and $_POST['AvailableToTravel']=='on')
					$this->data['AvailableToTravel'] = "true";
				else
					$this->data['AvailableToTravel'] = "false";
			break;

			case 'contract':
				$this->data['ContractType'] = isset($_POST['ContractType']) ? $_POST['ContractType'] : '';
				$this->data['WageRank'] = isset($_POST['WageRank']) ? $_POST['WageRank'] : '';
				$this->data['WageRankCurrency'] = isset($_POST['WageRankCurrency']) ? $_POST['WageRankCurrency'] : '';
				$this->data['WageRankByPeriod'] = isset($_POST['WageRankByPeriod']) ? $_POST['WageRankByPeriod'] : '';
				$this->data['EstimatedEffort'] = isset($_POST['EstimatedEffort']) ? trim($_POST['EstimatedEffort']) : '';
				$this->data['TimeUnit'] = isset($_POST['TimeUnit']) ? $_POST['TimeUnit'] : '';
				$this->data['Deadline'] = isset($_POST['Deadline']) ? trim($_POST['Deadline']) : '';
			break;

			default:
				$error = "<p>".gettext("Unexpected error")."</p>";
				throw new Exception($error,false);
		}
	}


	private function checkJobOfferForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		// Note that the POST values has been saved in $data before calling this method. We use $data instead POST due to they have the isset check done, and we want to avoid to repeat it.  :P

		// Set the marks of non-required sections. The user has already viewed them in the previous edition when she set the JobOfferId.
		if ( $_GET['JobOfferId'] != '')
		{
			$_SESSION['VisitedJobOffer_skills'] = false;
			$_SESSION['VisitedJobOffer_certifications'] = false;
			$_SESSION['VisitedJobOffer_projects'] = false;
			$_SESSION['VisitedJobOffer_location'] = false;
		}


		// Some field can not be empty


		// 'general' section
		$this->checkresults['general'] = "pass";

		if ( ($this->data['AllowPersonApplications']=="false" or $this->data['AllowPersonApplications']=='') and ($this->data['AllowCompanyApplications']=="false" or $this->data['AllowCompanyApplications']=='') and ($this->data['AllowOrganizationApplications']=="false" or $this->data['AllowOrganizationApplications']=='') )
		{
			$this->checkresults['general'] = "fail";

			if ( $this->section2control == 'general' )
			{
				$this->checks['result'] = "fail";
				$this->checks['AllowApplications'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['AllowApplications'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
		}

		if ( $this->data['Vacancies']=='' )
		{
			$this->checkresults['general'] = "fail";

			if ( $this->section2control == 'general' )
			{
				$this->checks['result'] = "fail";
				$this->checks['Vacancies'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['Vacancies'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
		}

		if ( $this->data['ExpirationDate']=='' )
		{
			$this->checkresults['general'] = "fail";

			if ( $this->section2control == 'general' )
			{
				$this->checks['result'] = "fail";
				$this->checks['ExpirationDate'] = gettext('Please fill in here');
			}
		}
		else
		{
			// Date format
			if ( ( !preg_match('/(\d\d)\-(\d\d)\-(\d\d\d\d)/',$this->data['ExpirationDate'],$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
	     		( !preg_match('/(\d\d\d\d)\-(\d\d)\-(\d\d)/',$this->data['ExpirationDate'],$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) ) and
	     		( !preg_match('/(\d\d)\/(\d\d)\/(\d\d\d\d)/',$this->data['ExpirationDate'],$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
	     		( !preg_match('/(\d\d\d\d)\/(\d\d)\/(\d\d)/',$this->data['ExpirationDate'],$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) )     )
			{
				$this->checkresults['general'] = "fail";

				if ( $this->section2control == 'general' )
				{
					$this->checks['result'] = "fail";
					$this->checks['ExpirationDate'] = gettext('Incorrect date format');
				}
			}
			else
			{
				$this->checks['ExpirationDate'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
			}
		}


		// 'profiles_etc' section
		$this->checkresults['profiles_etc'] = "pass";

		if ( count($this->data['ProfessionalProfileList'])<1 )
		{
			$this->checkresults['profiles_etc'] = "fail";

			if ( $this->section2control == 'profiles_etc' )
			{
				$this->checks['result'] = "fail";
				$this->checks['ProfessionalProfileList'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['ProfessionalProfileList'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
		}


		// 'skills' section
		if ( $this->section2control == 'skills' )
			$_SESSION['VisitedJobOffer_skills'] = true; // Mark we have visited this section

		if ( $_GET['JobOfferId'] != '' or ($_GET['JobOfferId'] == '' and $_SESSION['JobOfferId'] != '' and $_SESSION['VisitedJobOffer_skills'] == true) )
			$this->checkresults['skills'] = "pass";   // If it has been visited then set check to pass.

		// Check all the 3xN matrix,  3 = (Skill,KnowledgeLevel,ExperienceLevel)
		for( $i=0; $i < count($_POST['SkillList']); $i++)
		{
			if ( $_POST['SkillList'][$i] == '' )
			{
				$this->checkresults['skills'] = "fail";

				if ( $this->section2control == 'skills' )
				{
					$this->checks['result'] = "fail";
					$this->checks['SkillList'][$i] = gettext('Please fill in here');
				}
			}
			else
			{
				$this->checks['SkillList'][$i] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
			}

			if ( $_POST['SkillKnowledgeLevelList'][$i] == '' )
			{
				$this->checkresults['skills'] = "fail";

				if ( $this->section2control == 'skills' )
				{
					$this->checks['result'] = "fail";
					$this->checks['SkillKnowledgeLevelList'][$i] = gettext('Please fill in here');
				}
			}
			else
			{
				$this->checks['SkillKnowledgeLevelList'][$i] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
			}

			if ( $_POST['SkillExperienceLevelList'][$i] == '' )
			{
				$this->checkresults['skills'] = "fail";

				if ( $this->section2control == 'skills' )
				{
					$this->checks['result'] = "fail";
					$this->checks['SkillExperienceLevelList'][$i] = gettext('Please fill in here');
				}
			}
			else
			{
				$this->checks['SkillExperienceLevelList'][$i] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
			}

			if ( $_POST['SkillKnowledgeLevelList'][$i] == 'Null' and $_POST['SkillExperienceLevelList'][$i] == 'Null' )
			{
				$this->checkresults['skills'] = "fail";

				if ( $this->section2control == 'skills' )
				{
					$this->checks['result'] = "fail";
					$this->checks['SkillKnowledgeLevelList'][$i] = gettext('Please fill in here');
					$this->checks['SkillExperienceLevelList'][$i] = gettext('Please fill in here');
				}
			}
			// else do not reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
		}

		// 'languages' section
		$this->checkresults['languages'] = "pass";

		if ( count($this->data['LanguageList']) < 1 )
		{
			$this->checkresults['languages'] = "fail";

				if ( $this->section2control == 'languages' )
				{
					$this->checks['result'] = "fail";

					$this->checks['LanguageList'][0] = gettext('Please fill in here');
					$this->checks['LanguageSpokenLevelList'][0] = gettext('Please fill in here');
					$this->checks['LanguageWrittenLevelList'][0] = gettext('Please fill in here');
				}
		}
		else
		{
			// Check all the 3xN matrix,  3 = (Language,SpokenLevel,WrittenLevel)
			for( $i=0; $i < count($this->data['LanguageList']); $i++)
			{
				if ( $this->data['LanguageList'][$i] == '' )
				{
					$this->checkresults['languages'] = "fail";

					if ( $this->section2control == 'languages' )
					{
						$this->checks['result'] = "fail";
						$this->checks['LanguageList'][$i] = gettext('Please fill in here');
					}
				}
				else
				{
					$this->checks['LanguageList'][$i] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
				}

				if ( $this->data['LanguageSpokenLevelList'][$i] == '' )
				{
					$this->checkresults['languages'] = "fail";

					if ( $this->section2control == 'languages' )
					{
						$this->checks['result'] = "fail";
						$this->checks['LanguageSpokenLevelList'][$i] = gettext('Please fill in here');
					}
				}
				else
				{
					$this->checks['LanguageSpokenLevelList'][$i] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
				}

				if ( $this->data['LanguageWrittenLevelList'][$i] == '' )
				{
					$this->checkresults['languages'] = "fail";

					if ( $this->section2control == 'languages' )
					{
						$this->checks['result'] = "fail";
						$this->checks['LanguageWrittenLevelList'][$i] = gettext('Please fill in here');
					}
				}
				else
				{
					$this->checks['LanguageWrittenLevelList'][$i] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
				}

				if ( $this->data['LanguageSpokenLevelList'][$i] == 'Null' and $this->data['LanguageWrittenLevelList'][$i] == 'Null' )
				{
					$this->checkresults['languages'] = "fail";

					if ( $this->section2control == 'languages' )
					{
						$this->checks['result'] = "fail";
						$this->checks['LanguageSpokenLevelList'][$i] = gettext('Please fill in here');
						$this->checks['LanguageWrittenLevelList'][$i] = gettext('Please fill in here');
					}
				}
				// else do not reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
			}
		}


		// 'certifications' section
		if ( $this->section2control == 'certifications' )
			$_SESSION['VisitedJobOffer_certifications'] = true; // Mark we have visited this section

		if ( $_GET['JobOfferId'] != '' or ($_GET['JobOfferId'] == '' and $_SESSION['JobOfferId'] != '' and $_SESSION['VisitedJobOffer_certifications'] == true) )
			$this->checkresults['certifications'] = "pass";


		// 'projects' section
		if ( $this->section2control == 'projects' )
			$_SESSION['VisitedJobOffer_projects'] = true; // Mark we have visited this section

		if ( $_GET['JobOfferId'] != '' or ($_GET['JobOfferId'] == '' and $_SESSION['JobOfferId'] != '' and $_SESSION['VisitedJobOffer_projects'] == true) )
			$this->checkresults['projects'] = "pass";


		// 'location' section
		if ( $this->section2control == 'location' )
			$_SESSION['VisitedJobOffer_location'] = true; // Mark we have visited this section

		if ( $_GET['JobOfferId'] != '' or ($_GET['JobOfferId'] == '' and $_SESSION['JobOfferId'] != '' and $_SESSION['VisitedJobOffer_location'] == true) )
			$this->checkresults['location'] = "pass";


		// 'contract' section
		$this->checkresults['contract'] = "pass";

		if ( $this->data['ContractType']=='' )
		{
			$this->checkresults['contract'] = "fail";

			if ( $this->section2control == 'contract' )
			{
				$this->checks['result'] = "fail";
				$this->checks['ContractType'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['ContractType'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
		}

		if ( $this->data['WageRank']=='' or $this->data['WageRankCurrency']=='' or $this->data['WageRankByPeriod']=='' )
		{
			$this->checkresults['contract'] = "fail";

			if ( $this->section2control == 'contract' )
			{
				$this->checks['result'] = "fail";
				$this->checks['WageRank'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['WageRank'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
		}

		if ( $this->data['WageRankByPeriod']=="by project" and ($this->data['EstimatedEffort']=='' or $this->data['TimeUnit']=='') )
		{
			$this->checkresults['contract'] = "fail";

			if ( $this->section2control == 'contract' )
			{
				$this->checks['result'] = "fail";
				$this->checks['EstimatedEffort'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['EstimatedEffort'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
		}

		if ( $this->data['Deadline']=='' )
		{
		}
		else
		{
			// Date format
			if ( ( !preg_match('/(\d\d)\-(\d\d)\-(\d\d\d\d)/',$this->data['Deadline'],$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
	     		( !preg_match('/(\d\d\d\d)\-(\d\d)\-(\d\d)/',$this->data['Deadline'],$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) ) and
	     		( !preg_match('/(\d\d)\/(\d\d)\/(\d\d\d\d)/',$this->data['Deadline'],$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
	     		( !preg_match('/(\d\d\d\d)\/(\d\d)\/(\d\d)/',$this->data['Deadline'],$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) )     )
			{
				$this->checkresults['contract'] = "fail";

				if ( $this->section2control == 'contract' )
				{
					$this->checks['result'] = "fail";
					$this->checks['Deadline'] = gettext('Incorrect date format');
				}
			}
			else
			{
				$this->checks['Deadline'] = ''; // Reset possible value set by the checkJobOfferForm() of loadJobOfferForm().
			}
		}


		if ( $this->checkresults['general'] == "pass" and $this->checkresults['profiles_etc'] == "pass" and $this->checkresults['skills'] == "pass" and $this->checkresults['languages'] == "pass" and
		     $this->checkresults['projects'] == "pass" and $this->checkresults['location'] == "pass" and $this->checkresults['contract'] == "pass" )
			$this->checks['completed_edition'] = "true";
		else
			$this->checks['completed_edition'] = "false";
	}


	private function manageSuggestions()
	{
		$can_save = true; // Default value

		switch($this->section2control)
		{
			case 'general':
				// There are no suggestions for this section
				return $can_save;
			break;

			case 'profiles_etc':
				// There are no suggestions for this section
				return $can_save;
			break;

			case 'skills':
				// If there is shadow change or the new-one-to-add is filled, then check them before saving to avoid crash
				$shadow_change = array();
				for( $i=0; $i < count($_POST['SkillList']); $i++)  // Both, updated and new entries are processed
				{
					if ( $_POST['SkillList'][$i] != $_POST['ShadowSkillList'][$i] )
					{
						$shadow_change[$i] = $_POST['SkillList'][$i];
					}
				}

				// Get the suggestions to be shown in the output, etc.
				if ( count($shadow_change) > 0 )
				{
					// Query the Expert System
					$suggestions = $this->getSuggestedSkillsLists($shadow_change);

					if ( count($suggestions) == 0 )
					{
						$_POST['SuggestedSkills'] = array();
						$can_save = true;
					}
					else
					{
						// Check all is ready to be saved
						$can_save = true;
						foreach ($suggestions as $i => $value)
						{
							foreach ($value as $key)
								;

							$letters = array('/');
							$escape = array('\/');
							$skillList_ = strtolower( str_replace($letters,$escape,quotemeta($_POST['SkillList'][$i])) );
							$skills_ = strtolower( $key );
							if ( count($suggestions[$i]) == 1 and ( preg_match("/^".$skillList_."$/", $skills_) or //   /^text$/
											        preg_match("/^.+\(".$skillList_."\)$/", $skills_) or //   /^.+\(text\)$/
											        ( preg_match("/^(.*) ".$skillList_."$/", $skills_, $matches) and substr_count($matches[1],' ') == 0 ) or //   /^.* text$/
											        preg_match("/^".$skillList_." \(.+\)$/", $skills_) or //   /^text[ \(.+\)]$/
											        ( preg_match("/^(.*) ".$skillList_." \(.+\)$/", $skills_, $matches) and substr_count($matches[1],' ') == 0 )//   /^.* text[ \(.+\)]$/
											      ) )
							{
								// Automatic suggestion selection

								$_POST['SkillList'][$i] = $key; // It is $suggestions[$i][$key];
								$_POST['ShadowSkillList'][$i] = $key; // It is $suggestions[$i][$key];

								unset( $suggestions[$i] );
							}
							else
							{
								// Force user to select an option
								$can_save = false;
							}
						}

						// Show new set of options to be shown in the view
						$_POST['SuggestedSkills'] = $suggestions;
					}
				}

				// Process the selected-suggestions which arrive on the request we are processing
				for( $i=0; $i < count($_POST['SkillList']); $i++)
				{
					if ( isset($_POST['SuggestionSet'.$i]) and $_POST['SkillList'][$i] == $_POST['SuggestionShadow'][$i] )
					{
						// Replace POST forms values
						if ( $_POST['SuggestionSet'.$i] == "Keep as is" )
						{
							$_POST['SkillsToInsert'][$i] = $_POST['SkillList'][$i];
							$_POST['ShadowSkillList'][$i] = $_POST['SkillList'][$i];
						}
						else
						{
							$_POST['SkillList'][$i] = $_POST['SuggestionSet'.$i];
							$_POST['ShadowSkillList'][$i] = $_POST['SuggestionSet'.$i];
						}

						// Delete that suggestions set
						unset( $suggestions[$i] );
						$_POST['SuggestedSkills'] = $suggestions; // copy again
					}
				}

				// Check if, after processing the selected-suggestions, the form can be saved to the data base, that is to say, is there yet some suggestions-set which the user have to choose from
				if ( $can_save == false )
				{
					$can_save = true;
					for( $i=0; $i < count($_POST['SkillList']); $i++)
					{
						if ( count($_POST['SuggestedSkills'][$i]) > 0 )
						{
							$can_save = false;
						}
					}
				}

				// Insert new skills in the data base if it is needed
				if ( $can_save == true and is_array($_POST['SkillsToInsert']) )
				{
					foreach ( array_unique($_POST['SkillsToInsert']) as $skill2insert )
					{
						if ( $skill2insert != '' )
						{
							$this->manager->addSkill($skill2insert);
						}
					}

					// Clean all the SkillsToInsert marks
					for( $i=0; $i < count($_POST['SkillsToInsert']); $i++)
					{
						$_POST['SkillsToInsert'][$i] = '';
					}
				}

				return $can_save;
			break;

			case 'languages':
				// There are no suggestions for this section
				return $can_save;
			break;

			case 'certifications':
				// There are no suggestions for this section
				return $can_save;
			break;

			case 'projects':
				// There are no suggestions for this section
				return $can_save;
			break;

			case 'location':
				// There are no suggestions for this section
				return $can_save;
			break;

			case 'contract':
				// There are no suggestions for this section
				return $can_save;
			break;

			default:
				$error = "<p>".gettext("Unexpected error")."</p>";
				throw new Exception($error,false);
		}
	}


	private function loadJobOfferForm()
	{
		// We load the data of all the sections, but only process and show one of them.

		$result = $this->manager->getJobOffer($_SESSION['JobOfferId']);


		// JobOffers table

		$this->data['EmployerJobOfferReference'] = $result[0][0];

		$this->data['ExpirationDate'] = $result[2][0];

		if ($result[3][0]=='t')
			$this->data['Closed'] = "true";
		else
			$this->data['Closed'] = "false";

		if ($result[4][0]=='t')
			$this->data['HideEmployer'] = "true";
		else
			$this->data['HideEmployer'] = "false";

		if ($result[5][0]=='t')
			$this->data['AllowPersonApplications'] = "true";
		else
			$this->data['AllowPersonApplications'] = "false";

		if ($result[6][0]=='t')
			$this->data['AllowCompanyApplications'] = "true";
		else
			$this->data['AllowCompanyApplications'] = "false";

		if ($result[7][0]=='t')
			$this->data['AllowOrganizationApplications'] = "true";
		else
			$this->data['AllowOrganizationApplications'] = "false";

		$this->data['Vacancies'] = trim($result[8][0]);

		$this->data['ContractType'] = $result[9][0];
		$this->data['WageRank'] = $result[10][0];
		$this->data['WageRankCurrency'] = $result[11][0];
		$this->data['WageRankCurrencyName'] = $result[12][0];
		$this->data['WageRankByPeriod'] = $result[13][0];
		$this->data['EstimatedEffort'] = $result[23][0];
		$this->data['TimeUnit'] = $result[24][0];
		$this->data['Deadline'] = $result[28][0];

		$this->data['ProfessionalExperienceSinceYear'] = $result[14][0];
		$this->data['AcademicQualification'] = $result[15][0];

		// JobOffer Profiles tables
		$this->data['ProductProfileList'] = $result[30];
		$this->data['ProfessionalProfileList'] = $result[31];
		$this->data['FieldProfileList'] = $result[32];

		// JobOffer Skills table
		$this->data['SkillList'] = $result[43];
		$this->data['SkillKnowledgeLevelList'] = $result[44];
		$this->data['SkillExperienceLevelList'] = $result[45];

		// The POST sort is different than the data base sort, $result[46], so we search and set the sort of the $this->data['CheckList'] array according to the POST sort
		if (isset($_POST['SkillList'][0]))
		{
			foreach ($result[46] as $i => $value)
			{
				$this->data['CheckList'][$i] = $result[46][ array_search($_POST['SkillList'][$i],$this->data['SkillList']) ];
			}
		}
		else
		{
			// There is not need to sort due to all come from the data base
			$this->data['CheckList'] = $result[46];
		}

		if ( $this->section2view == 'skills' and $this->section2control != 'skills' )
		{
			$_POST['SkillList'] = $this->data['SkillList'];
			$_POST['ShadowSkillList'] = $this->data['SkillList'];
			$_POST['SkillKnowledgeLevelList'] = $this->data['SkillKnowledgeLevelList'];
			$_POST['SkillExperienceLevelList'] = $this->data['SkillExperienceLevelList'];
		}
		elseif (  ( $this->section2view != 'skills' and $this->section2control == 'skills') or
			  ( $this->section2view == 'skills' and $this->section2control == 'skills')  )
		{
		}

		// JobOffer Certifications table
		$this->data['CertificationsList'] = $result[50];

		// JobOffer Contributions/FreeSoftwareExperiences table
		$this->data['FreeSoftwareExperiences'] = trim($result[16][0]);

		// JobOffer Languages table
		$this->data['LanguageList'] = $result[40];
		$this->data['LanguageSpokenLevelList'] = $result[41];
		$this->data['LanguageWrittenLevelList'] = $result[42];

		$this->data['City'] = $result[18][0];
		$this->data['StateProvince'] = $result[19][0];
		$this->data['CountryCode'] = $result[20][0];

		if ($result[21][0]=='t')
			$this->data['AvailableToTravel'] = "true";
		else
			$this->data['AvailableToTravel'] = "false";


		// Set the check marks
		$this->checkJobOfferForm();
	}
}
?>
