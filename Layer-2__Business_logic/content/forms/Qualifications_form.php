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


require_once "../Layer-2__Business_logic/content/forms/Skills_form.php";

// Methods take the values from the global $_POST[] array.


class QualificationsForm extends SkillsForm
{
	private $checkresults;
	private $section2view;
	private $section2control;
	private $IE_workaround = false;


	public function processForm()
	{
		// Detect Microsoft InternetExplorer browsers
		$this->IE_workaround = preg_match("/^.*IE.*$/", $_SERVER["HTTP_USER_AGENT"]);

		// $_POST['jump']  value conversion.
		if ( $this->IE_workaround == true and $_POST['jump'] != '' )
			$this->Microsoft_InternetExplorer_workaround();


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
		elseif ( $_GET['EntityId'] == '' )
			$this->section2view = 'profiles_etc'; // GET request: Submit from the language change form. Updating job offer
		else
			$this->section2view = 'profiles_etc'; // GET request: Submit from the language change form. Creating job offer

		// Find out the section to process
		if ( $_POST['section2control'] != '' )
			$this->section2control = $_POST['section2control'];
		else
			$this->section2control = ''; // GET request from language change, POST request from "Create qualifications", etc.


		// Check the log in state
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Cooperative' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>".gettext('To access this section you have to login first.')."</p>";
				throw new Exception($error,false);
			}

			$_SESSION['HasQualifications'] = $this->loadQualificationsForm(); // Update the HasQualifications SESSION flag used to set the URL at the webapp menu

			if ( $_SESSION['HasQualifications'] != '1' ) // creating qualifications
			{
				// Reset the visited-marks set by a previous qualifications edition
				$_SESSION['VisitedQualifications_academic'] = false;
				$_SESSION['VisitedQualifications_skills'] = false;
				$_SESSION['VisitedQualifications_certifications'] = false;
				$_SESSION['VisitedQualifications_projects'] = false;
				$_SESSION['VisitedQualifications_location'] = false;
			}
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( count($_GET)==2 and isset($_GET['EntityId']) and $_GET['EntityId'] == '' and isset($_GET['section']) and $_GET['section'] != '' ) // new
		{
		}
		elseif ( $_POST['previous'] != '' or $_POST['next'] != '' or $_POST['jump'] != '' or $_POST['finish'] != '' or $_POST['more'] != '' ) // update
		{
			// POST request from *_form.tpl: Edit EntityId qualifications
			$this->saveQualificationsForm();
		}
		elseif ( count($_GET)==2 and isset($_GET['EntityId']) and $_GET['EntityId'] != '' and isset($_GET['section']) and $_GET['section'] != '' ) // edit
		{
			// GET request from View_Qualifications_form.tpl: Edit EntityId qualifications
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
			header('Location: /resume?id='.$_SESSION['EntityId']); // We reditect to the view-offer web page
			exit;
		}
		else
		{
			$this->printQualificationsForm();
		}
	}


	private function printQualificationsForm()
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
			case 'profiles_etc':
				$productProfiles = $this->manager->getProductProfilesList();
				$smarty->assign('productProfiles', array_values($productProfiles) );

				$professionalProfiles = $this->manager->getProfessionalProfilesList();
				$smarty->assign('professionalProfilesId', array_keys($professionalProfiles) );
				$smarty->assign('professionalProfilesName', array_values($professionalProfiles) );

				$fieldProfiles = $this->manager->getFieldProfilesList();
				$smarty->assign('fieldProfilesId', array_keys($fieldProfiles) );
				$smarty->assign('fieldProfilesName', array_values($fieldProfiles) );
			break;

			case 'academic':
				$academicLevels = $this->manager->getAcademicLevelsList();

				// Dirty hack: Delete the element which is only used in JobOffers
				unset( $academicLevels["Enrolled at a University (Undergraduate)"] );

				$smarty->assign('academicLevelsId', array_merge( array(""), array_keys($academicLevels) ) );
				$smarty->assign('academicLevelsIdTranslated', array_merge( array(""), array_values($academicLevels) ) );
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
				$notYetRequestedCertifications = $this->manager->getNotYetRequestedCertificationsForEntity();
				$smarty->assign('notYetRequestedCertifications', array_values($notYetRequestedCertifications) );
			break;

			case 'projects':
			break;

			case 'location':
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

				$currencies = $this->manager->getCurrenciesList();
				$currenciesThreeLetter = array_merge( array(""), array_keys($currencies) );
				$currenciesName = array_merge( array(""), array_values($currencies) );
				$smarty->assign('currenciesThreeLetter', $currenciesThreeLetter);
				$smarty->assign('currenciesName', $currenciesName);

				$employability = $this->manager->getEmployabilityList();
				$smarty->assign('employabilityId', array_merge( array(""), array_keys($employability) ) );
				$smarty->assign('employabilityIdTranslated', array_merge( array(""), array_values($employability) ) );
			break;

			default:
				$error = "<p>".gettext("ERROR: Unexpected condition")."</p>";
				throw new Exception($error,false);
		}

		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);
		$smarty->assign('checkresults', $this->checkresults);
		$smarty->assign('section', $section);
		$smarty->assign('IE_workaround', $this->IE_workaround);
		$smarty->display("Qualifications_".$section."_form.tpl");
	}


	private function saveQualificationsForm()
	{
		// Prepare data for view: $this->data  and  $_POST  array.
		$this->prepareData4View();

		// Set the check marks
		$this->checkQualificationsForm();

		if ( $this->checks['result'] == "pass" )
		{
			$this->can_save = $this->manageSuggestions(); // Get and process new suggestions
			if ( $this->can_save )
			{
				// Update or insert the values
				if ( $_SESSION['HasQualifications'] ) // update
				{
					$this->manager->updateQualifications($this->section2control,$this->checks['completed_edition']);
				}
				else // new
				{
					$this->manager->addQualifications($this->checks['completed_edition']); // Create the qualifications with the data from the 'profiles_etc' section
				}
			}
			else
			{
				$this->checks['result'] = "suggestions";
			}
		}
	}


	private function prepareData4View()
	{
		// Save the section values in the $data variable

		switch($this->section2control)
		{
			case 'profiles_etc':
				$this->data['ProfessionalExperienceSinceYear'] = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';

				$this->data['ProductProfileList'] = isset($_POST['ProductProfileList']) ?  $_POST['ProductProfileList'] : array();
				$this->data['ProfessionalProfileList'] = isset($_POST['ProfessionalProfileList']) ? $_POST['ProfessionalProfileList'] : array();
				$this->data['FieldProfileList'] = isset($_POST['FieldProfileList']) ? $_POST['FieldProfileList'] : array();
			break;

			case 'academic':
				// Clean empty rows and the one marked to be deleted
				$count = count($_POST['AcademicLevelList']);
				for( $i=0,$j=0; $i < $count; $i++)
				{
					if ( ( trim($_POST['DegreeList'][$i]) == '' and trim($_POST['AcademicLevelList'][$i]) == '' and
					       trim($_POST['DegreeGrantedList'][$i]) == '' and trim($_POST['StartDateList'][$i]) == '' and trim($_POST['FinishDateList'][$i]) == '' and
					       trim($_POST['InstitutionList'][$i]) == '' and trim($_POST['InstitutionURIList'][$i]) == '' and trim($_POST['ShortCommentList'][$i]) == '') or
					     ( isset($_POST['DeleteAcademicList']) and in_array("$i",$_POST['DeleteAcademicList']) ) )
					{
					}
					else
					{
						$_POST['DegreeList'][$j] = $_POST['DegreeList'][$i];
						$_POST['AcademicLevelList'][$j] = $_POST['AcademicLevelList'][$i];
						$_POST['DegreeGrantedList'][$j] = $_POST['DegreeGrantedList'][$i];
						$_POST['StartDateList'][$j] = $_POST['StartDateList'][$i];
						$_POST['FinishDateList'][$j] = $_POST['FinishDateList'][$i];
						$_POST['InstitutionList'][$j] = $_POST['InstitutionList'][$i];
						$_POST['InstitutionURIList'][$j] = $_POST['InstitutionURIList'][$i];
						$_POST['ShortCommentList'][$j] = $_POST['ShortCommentList'][$i];
						$j++;
					}
				}

				for( $i=$j; $i < $count; $i++)
				{
					unset( $_POST['DegreeList'][$i] );
					unset( $_POST['AcademicLevelList'][$i] );
					unset( $_POST['DegreeGrantedList'][$i] );
					unset( $_POST['StartDateList'][$i] );
					unset( $_POST['FinishDateList'][$i] );
					unset( $_POST['InstitutionList'][$i] );
					unset( $_POST['InstitutionURIList'][$i] );
					unset( $_POST['ShortCommentList'][$i] );
				}

				// Now, copy to the $data variable
				$this->data['DegreeList'] = isset($_POST['DegreeList']) ? $_POST['DegreeList'] : array();
				$this->data['AcademicLevelList'] = isset($_POST['AcademicLevelList']) ? $_POST['AcademicLevelList'] : array();
				$this->data['DegreeGrantedList'] = isset($_POST['DegreeGrantedList']) ? $_POST['DegreeGrantedList'] : array();
				$this->data['StartDateList'] = isset($_POST['StartDateList']) ? $_POST['StartDateList'] : array();
				$this->data['FinishDateList'] = isset($_POST['FinishDateList']) ? $_POST['FinishDateList'] : array();
				$this->data['InstitutionList'] = isset($_POST['InstitutionList']) ? $_POST['InstitutionList'] : array();
				$this->data['InstitutionURIList'] = isset($_POST['InstitutionURIList']) ? $_POST['InstitutionURIList'] : array();
				$this->data['ShortCommentList'] = isset($_POST['ShortCommentList']) ? $_POST['ShortCommentList'] : array();
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

						$_POST['SkillList'][$j] = trim($_POST['SkillList'][$i]);
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
				// Clean empty rows and the one marked to be deleted
				$count = count($_POST['ContributionsListProject']);
				for( $i=0,$j=0; $i < $count; $i++)
				{
					if ( ( $_POST['ContributionsListProject'][$i] == '' and $_POST['ContributionsListDescription'][$i] == '' and ( $_POST['ContributionsListURI'][$i] == '' or $_POST['ContributionsListURI'][$i] == 'http://' ) ) or
					     ( isset($_POST['DeleteContributionsList']) and in_array("$i",$_POST['DeleteContributionsList']) ) ) // DeleteContributionsList is not saved at $data variable
					{
					}
					else
					{
						$_POST['ContributionsListProject'][$j] = $_POST['ContributionsListProject'][$i];
						$_POST['ContributionsListDescription'][$j] = $_POST['ContributionsListDescription'][$i];
						$_POST['ContributionsListURI'][$j] = $_POST['ContributionsListURI'][$i];
						$j++;
					}
				}

				for( $i=$j; $i < $count; $i++)
				{
					unset( $_POST['ContributionsListProject'][$i] );
					unset( $_POST['ContributionsListDescription'][$i] );
					unset( $_POST['ContributionsListURI'][$i] );
				}

				// Now, copy to the $data variable
				$this->data['ContributionsListProject'] = isset($_POST['ContributionsListProject']) ? $_POST['ContributionsListProject'] : array();
				$this->data['ContributionsListDescription'] = isset($_POST['ContributionsListDescription']) ? $_POST['ContributionsListDescription'] : array();
				$this->data['ContributionsListURI'] = isset($_POST['ContributionsListURI']) ? $_POST['ContributionsListURI'] : array();
			break;

			case 'location':
				if (isset($_POST['AvailableToTravel']) and $_POST['AvailableToTravel']=='on')
					$this->data['AvailableToTravel'] = "true";
				else
					$this->data['AvailableToTravel'] = "false";

				if (isset($_POST['AvailableToChangeResidence']) and $_POST['AvailableToChangeResidence']=='on')
					$this->data['AvailableToChangeResidence'] = "true";
				else
					$this->data['AvailableToChangeResidence'] = "false";
			break;

			case 'contract':
				$this->data['DesiredContractType'] = isset($_POST['DesiredContractType']) ? $_POST['DesiredContractType'] : '';
				$this->data['DesiredWageRank'] = isset($_POST['DesiredWageRank']) ? $_POST['DesiredWageRank'] : '';
				$this->data['WageRankCurrency'] = isset($_POST['WageRankCurrency']) ? $_POST['WageRankCurrency'] : '';
				$this->data['WageRankByPeriod'] = isset($_POST['WageRankByPeriod']) ? $_POST['WageRankByPeriod'] : '';

				$this->data['CurrentEmployability'] = isset($_POST['CurrentEmployability']) ? $_POST['CurrentEmployability'] : '';
			break;

			default:
				$error = "<p>".gettext("ERROR: Unexpected condition")."</p>";
				throw new Exception($error,false);
		}
	}


	private function checkQualificationsForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		// Note that the POST values has been saved in $data before calling this method. We use $data instead POST due to they have the isset check done, and we want to avoid to repeat it.  :P

		// Set the marks of non-required sections. The user has already viewed them in the previous edition when she set the EntityId.
		if ( $_GET['EntityId'] != '')
		{
			$_SESSION['VisitedQualifications_academic'] = true;
			$_SESSION['VisitedQualifications_skills'] = true;
			$_SESSION['VisitedQualifications_certifications'] = true;
			$_SESSION['VisitedQualifications_projects'] = true;
			$_SESSION['VisitedQualifications_location'] = true;
		}


		// Some field can not be empty


		// 'profiles_etc' section
		$this->checkresults['profiles_etc'] = "pass";

		if ( $this->data['ProfessionalExperienceSinceYear']=='' )
		{
			$this->checkresults['profiles_etc'] = "fail";

			if ( $this->section2control == 'profiles_etc' )
			{
				$this->checks['result'] = "fail";
				$this->checks['ProfessionalExperienceSinceYear'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['ProfessionalProfileList'] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
		}


		// 'academic' section
		if ( $this->section2control == 'academic' )
			$_SESSION['VisitedQualifications_academic'] = true; // Mark we have visited this section

		if ( $_GET['EntityId'] != '' or ($_GET['EntityId'] == '' and $_SESSION['EntityId'] != '' and $_SESSION['VisitedQualifications_academic'] == true) )
			$this->checkresults['academic'] = "pass";

		// Check all dates
		for( $i=0; $i < count($_POST['DegreeList']); $i++)
		{
			// StartDate
			if ( $this->data['StartDateList'][$i]=='' )
			{
			}
			else
			{
				// Date format
				if (// PostgreSQL: ISO date format
				    ( !preg_match('/^(\d\d\d\d)\-(\d{1,2})\-(\d{1,2})$/',trim($this->data['StartDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) ) and
				    ( !preg_match('/^(\d\d\d\d)\/(\d{1,2})\/(\d{1,2})$/',trim($this->data['StartDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) ) and
				    // PostgreSQL: MDY date format
				    ( !preg_match('/^(\d{1,2})\-(\d{1,2})\-(\d\d\d\d)$/',trim($this->data['StartDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
				    ( !preg_match('/^(\d{1,2})\/(\d{1,2})\/(\d\d\d\d)$/',trim($this->data['StartDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) )
				{
					$this->checkresults['academic'] = "fail";

					if ( $this->section2control == 'academic' )
					{
						$this->checks['result'] = "fail";
						$this->checks['StartDateList'][$i] = gettext('Incorrect date format.').' '.gettext('The format could be for example').': yyyy-mm-dd , mm/dd/yyyy';
					}
				}
				else
				{
					$this->checks['StartDateList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
				}
			}

			// FinishDate
			if ( $this->data['FinishDateList'][$i]=='' )
			{
			}
			else
			{
				// Date format
				if (// PostgreSQL: ISO date format
				    ( !preg_match('/^(\d\d\d\d)\-(\d{1,2})\-(\d{1,2})$/',trim($this->data['FinishDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) ) and
				    ( !preg_match('/^(\d\d\d\d)\/(\d{1,2})\/(\d{1,2})$/',trim($this->data['FinishDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[2],$res[3],$res[1]) ) and
				    // PostgreSQL: MDY date format
				    ( !preg_match('/^(\d{1,2})\-(\d{1,2})\-(\d\d\d\d)$/',trim($this->data['FinishDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) and
				    ( !preg_match('/^(\d{1,2})\/(\d{1,2})\/(\d\d\d\d)$/',trim($this->data['FinishDateList'][$i]),$res) || count($res) < 4 || !checkdate($res[1],$res[2],$res[3]) ) )
				{
					$this->checkresults['academic'] = "fail";

					if ( $this->section2control == 'academic' )
					{
						$this->checks['result'] = "fail";
						$this->checks['FinishDateList'][$i] = gettext('Incorrect date format.').' '.gettext('The format could be for example').': yyyy-mm-dd , mm/dd/yyyy';
					}
				}
				else
				{
					$this->checks['FinishDateList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
				}
			}
		}


		// 'skills' section
		if ( $this->section2control == 'skills' )
			$_SESSION['VisitedQualifications_skills'] = true; // Mark we have visited this section

		if ( $_GET['EntityId'] != '' or ($_GET['EntityId'] == '' and $_SESSION['EntityId'] != '' and $_SESSION['VisitedQualifications_skills'] == true) )
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
				$this->checks['SkillList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
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
				$this->checks['SkillKnowledgeLevelList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
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
				$this->checks['SkillExperienceLevelList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
			}
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
					$this->checks['LanguageList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
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
					$this->checks['LanguageSpokenLevelList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
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
					$this->checks['LanguageWrittenLevelList'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
				}
			}
		}


		// 'certifications' section
		if ( $this->section2control == 'certifications' )
			$_SESSION['VisitedQualifications_certifications'] = true; // Mark we have visited this section

		if ( $_GET['EntityId'] != '' or ($_GET['EntityId'] == '' and $_SESSION['EntityId'] != '' and $_SESSION['VisitedQualifications_certifications'] == true) )
			$this->checkresults['certifications'] = "pass";


		// 'projects' section
		if ( $this->section2control == 'projects' )
			$_SESSION['VisitedQualifications_projects'] = true; // Mark we have visited this section

		$this->checkresults['projects'] = "pass";

		if ( count($this->data['ContributionsListProject']) < 1 )
		{
			if ( $_GET['EntityId'] != '' or ($_GET['EntityId'] == '' and $_SESSION['EntityId'] != '' and $_SESSION['VisitedQualifications_projects'] == true) )
			{
				$this->checkresults['projects'] = "pass";
			}
			else // XXX Improve this logic
			{
				$this->checkresults['projects'] = "fail";

				if ( $this->section2control == 'projects' )
				{
					$this->checks['result'] = "fail";
				}
			}
		}
		else
		{
			// Check all the 3xN matrix,  3 = (Project,Description,URI)
			for( $i=0; $i < count($this->data['ContributionsListProject']); $i++)
			{
				if ( $this->data['ContributionsListProject'][$i] == '' )
				{
					$this->checkresults['projects'] = "fail";

					if ( $this->section2control == 'projects' )
					{
						$this->checks['result'] = "fail";
						$this->checks['ContributionsListProject'][$i] = gettext('Please fill in here');
					}
				}
				else
				{
					$this->checks['ContributionsListProject'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
				}

				if ( $this->data['ContributionsListURI'][$i] == '' or $this->data['ContributionsListURI'][$i] == 'http://' )
				{
					$this->checkresults['projects'] = "fail";

					if ( $this->section2control == 'projects' )
					{
						$this->checks['result'] = "fail";
						$this->checks['ContributionsListURI'][$i] = gettext('Please fill in here');
					}
				}
				else
				{
					$this->checks['ContributionsListURI'][$i] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
				}
			}
		}

		// 'location' section
		if ( $this->section2control == 'location' )
			$_SESSION['VisitedQualifications_location'] = true; // Mark we have visited this section

		if ( $_GET['EntityId'] != '' or ($_GET['EntityId'] == '' and $_SESSION['EntityId'] != '' and $_SESSION['VisitedQualifications_location'] == true) )
			$this->checkresults['location'] = "pass";


		// 'contract' section
		$this->checkresults['contract'] = "pass";

		if ( $_SESSION['LoginType']=='Person' and $this->data['DesiredContractType']=='' )
		{
			$this->checkresults['contract'] = "fail";

			if ( $this->section2control == 'contract' )
			{
				$this->checks['result'] = "fail";
				$this->checks['DesiredContractType'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['DesiredContractType'] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
		}

		if ( $_SESSION['LoginType']=='Person' and  ( $this->data['DesiredWageRank']=='' or $this->data['WageRankCurrency']=='' or $this->data['WageRankByPeriod']=='' ) )
		{
			$this->checkresults['contract'] = "fail";

			if ( $this->section2control == 'contract' )
			{
				$this->checks['result'] = "fail";
				$this->checks['DesiredWageRank'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['DesiredWageRank'] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
		}

		if ( $_SESSION['LoginType']=='Person' and $this->data['CurrentEmployability']=='' )
		{
			$this->checkresults['contract'] = "fail";

			if ( $this->section2control == 'contract' )
			{
				$this->checks['result'] = "fail";
				$this->checks['CurrentEmployability'] = gettext('Please fill in here');
			}
		}
		else
		{
			$this->checks['CurrentEmployability'] = ''; // Reset possible value set by the checkQualificationsForm() of loadQualificationsForm().
		}


		if ( $this->checkresults['profiles_etc'] == "pass" and $this->checkresults['academic'] == "pass" and $this->checkresults['skills'] == "pass" and $this->checkresults['languages'] == "pass" and
		     $this->checkresults['projects'] == "pass" and $this->checkresults['location'] == "pass" and
		     ( $_SESSION['LoginType'] != 'Person' or ( $_SESSION['LoginType'] == 'Person' and $this->checkresults['contract'] == "pass" ) ) )
			$this->checks['completed_edition'] = "true";
		else
			$this->checks['completed_edition'] = "false";
	}


	private function manageSuggestions()
	{
		$can_save = true; // Default value

		switch($this->section2control)
		{
			case 'profiles_etc':
				// There are no suggestions for this section
				return $can_save;
			break;

			case 'academic':
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
				$error = "<p>".gettext("ERROR: Unexpected condition")."</p>";
				throw new Exception($error,false);
		}
	}


	private function loadQualificationsForm()
	{
		// We load the data of all the sections, but only process and show one of them.

		$result = $this->manager->getQualificationsForEntity($_SESSION['EntityId']);

		if ( count($result[0]) !=1 )
			return false;

		// Qualifications table

		$this->data['ProfessionalExperienceSinceYear'] = $result[0][0];

		// Only for Person entity
		$this->data['DesiredContractType'] = $result[2][0];
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


		// Qualification Academic table
		$this->data['DegreeList'] = $result[40];
		$this->data['AcademicLevelList'] = $result[41];
		$this->data['DegreeGrantedList'] = $result[42];
		$this->data['StartDateList'] = $result[43];
		$this->data['FinishDateList'] = $result[44];
		$this->data['InstitutionList'] = $result[45];
		$this->data['InstitutionURIList'] = $result[46];
		$this->data['ShortCommentList'] = $result[47];

		// Qualification Profiles tables
		$this->data['ProductProfileList'] = $result[20];
		$this->data['ProfessionalProfileList'] = $result[21];
		$this->data['FieldProfileList'] = $result[22];

		// Qualification Certifications table
		$this->data['CertificationsList'] = $result[23];
		$this->data['CertificationsStateList'] = $result[24];

		// Qualification Contributions/FreeSoftwareExperiences table
		$this->data['ContributionsListProject'] = $result[25];
		$this->data['ContributionsListDescription'] = $result[26];
		$this->data['ContributionsListURI'] = $result[27];

		// Qualification Languages table
		$this->data['LanguageList'] = $result[28];
		$this->data['LanguageSpokenLevelList'] = $result[29];
		$this->data['LanguageWrittenLevelList'] = $result[30];

		// Qualification Skills table
		$this->data['SkillList'] = $result[31];
		$this->data['SkillKnowledgeLevelList'] = $result[32];
		$this->data['SkillExperienceLevelList'] = $result[33];

		// The POST sort is different than the data base sort, $result[34], so we search and set the sort of the $this->data['CheckList'] array according to the POST sort
		if (isset($_POST['SkillList'][0]))
		{
			foreach ($result[34] as $i => $value)
			{
				$this->data['CheckList'][$i] = $result[34][ array_search($_POST['SkillList'][$i],$this->data['SkillList']) ];
			}
		}
		else
		{
			// There is not need to sort due to all come from the data base
			$this->data['CheckList'] = $result[34];
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


		// Set the check marks
		$this->checkQualificationsForm();


		return true;
	}


	private function Microsoft_InternetExplorer_workaround() // IE 6.0 and IE 7.0 workaround,  $_POST['jump']  value conversion.
	{
		// IE does not work with <button>s as the specification expose [1]
		//   [1] http://www.w3.org/TR/REC-html40/interact/forms.html#edef-BUTTON
		//
		// It's supposed to submit the value attribute, as any other browser does following
		// the specification, but it instead submits the contents of the element!
		//
		// It is even worse, IE sends _always_ the content of _all_ <button>s, even if
                // buttons have not been clicked!

		// Work around: Use <input> instead of <button> when a IE browser is detected.


		// To support the code which we developed previously, we do in this method 'value='
		// conversion, from the $_POST['jump'] <input> values to the expected <button> values:

		switch($_POST['jump'])
		{
			case gettext("Profiles"): $_POST['jump'] = 'profiles_etc'; break;
			case gettext("Academic"): $_POST['jump'] = 'academic'; break;
			case gettext("Skills"): $_POST['jump'] = 'skills'; break;
			case gettext("Languages"): $_POST['jump'] = 'languages'; break;
			case gettext("Certifications"): $_POST['jump'] = 'certifications'; break;
			case gettext("FS projects"): $_POST['jump'] = 'projects'; break;
			case gettext("Location"): $_POST['jump'] = 'location'; break;
			case gettext("Contract"): $_POST['jump'] = 'contract'; break;

			default:
				$error = "<p>".gettext("ERROR: Unexpected condition")."</p>";
				throw new Exception($error,false);
		}
	}
}
?>
