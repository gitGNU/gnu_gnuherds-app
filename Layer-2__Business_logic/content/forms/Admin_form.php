<?php
// Authors: Davi Leal
//
// Copyright (C) 2007, 2008 Davi Leal <davi at leals dot com>
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


require_once "../Layer-2__Business_logic/content/forms/Skills_form.php";
require_once "../Layer-4__DBManager_etc/DB_Manager.php";


class AdminForm extends SkillsForm
{
	function __construct()
	{
		$this->manager = new DBManager();
	}


	public function processForm()
	{
		$phpTools = new PHPTools();

		// Check the log in state and load the data
		if ( $_SESSION['Logged'] != '1' )
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( $_GET['section'] =='classify_skills' or $_GET['section'] == '' )
		{
			if ( isset($_POST['save']) and $_POST['save'] != '' )
			{
				$this->saveAdminForm();
			}
			elseif ( isset($_POST['show']) and $_POST['show'] != '' )
			{
				$this->loadAdminForm();
				$this->data['Skill2Process'] = isset($_POST['Skill2Process']) ? $_POST['Skill2Process'] : $_POST['ShadowSkill2Process'];
			}
			else
			{
				$this->loadAdminForm();
			}
		}
		elseif ( $_GET['section'] =='reclassify_skills' )
		{
			if ( isset($_POST['save']) and $_POST['save'] != '' )
			{
				$this->saveAdminForm();
			}
			elseif ( isset($_POST['search']) and $_POST['search'] != '' )
			{
				if ( $this->manager->isSkillAlreadyInDataBase($_POST['Skill2Process']) == true )
					$this->loadAdminForm();
			}
		}
		elseif ( $_GET['section'] =='add_skills' )
		{
			if ( isset($_POST['save']) and $_POST['save'] != '' )
			{
				$this->saveAdminForm();
			}
		}
	}


	public function printOutput()
	{
		// This page does not report to the webapp user (Skills administrator) operation success. It just report if the operation does _not_ success.

		$this->printAdminForm();
	}


	private function printAdminForm()
	{
		$smarty = new Smarty;

		$skillTags = $this->manager->getSkillTagList();
		$smarty->assign('skillTagsId', array_merge( array(""), array_keys($skillTags) ) );
		$smarty->assign('skillTagsIdTranslated', array_merge( array(""), array_values($skillTags) ) );

		$smarty->assign('setTypesSkillId', array_merge( array(""), $this->manager->getSkillSetTypesList() ) );

		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);
		$smarty->display("Admin_form.tpl");
	}


	private function saveAdminForm()
	{
		// Prepare data for view: $this->data  and  $_POST  array.
		$this->prepareData4View();

		// Set the check marks
		$this->checkAdminForm();

		if ( $this->checks['result'] == "pass" )
		{
			$this->can_save = $this->manageSuggestions(); // Get and process new suggestions
			if ( $this->can_save )
			{
				if ( $_GET['section'] =='reclassify_skills' )
					$force = true;
				else
					$force = false;

				// Check if the skills administrator want to change the Skill Name
				if ( $_POST['ShadowSkill2Process'] != $_POST['SkillName'] )
				{
					// Check that the skill to add is not already in the data base, then add or update it.

					if ( $this->manager->isSkillAlreadyInDataBase($_POST['SkillName']) == false )
					{
						// Add the Skill
						$this->manager->addSkill($_POST['SkillName']);
					}
					else
					{
						// Update both properties and the Skill name
						// The Skill name could have been modified automatically by the suggestion motor, or by hand by the Skills administrator
						$this->manager->updateSkill($_POST['SkillName'],$force);
					}

					// Update Qualifications and JobOffers
					$this->manager->renameJobOffersAndQualificationsSkills($_POST['ShadowSkill2Process'],$_POST['SkillName']);

					$this->manager->delSkill($_POST['ShadowSkill2Process']);
				}
				else
				{
					// Just modify the Skill properties
					$this->manager->updateSkill($_POST['ShadowSkill2Process'],$force);
				}

				if ( $_GET['section'] =='classify_skills' or $_GET['section'] == '' )
				{
					// Show the next one to classify. Only if we are in the classify_skills section.
					$this->loadAdminForm();
				}
				elseif ( $_GET['section'] =='reclassify_skills' )
				{
					// Force the search of another skill to process
					$this->data['Skill2Process'] = '';
				}
				elseif ( $_GET['section'] =='add_skills' )
				{
					// Clean the form to leave it ready to add another skill
					$this->cleanAdminForm();
				}

				// This page does not report to the webapp user (Skills administrator) operation success. It just report if the operation does _not_ success.
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

		$this->data['Skill2Process'] = isset($_POST['Skill2Process']) ? $_POST['Skill2Process'] : $_POST['ShadowSkill2Process'];

		$this->data['SkillName'] = isset($_POST['SkillName']) ? trim($_POST['SkillName']) : '';
		$this->data['SkillTag'] = isset($_POST['SkillTag']) ? trim($_POST['SkillTag']) : '';
		$this->data['SkillType'] = isset($_POST['SkillType']) ? trim($_POST['SkillType']) : '';
		$this->data['SkillLicenseName'] = isset($_POST['SkillLicenseName']) ? trim($_POST['SkillLicenseName']) : '';
		$this->data['SkillLicenseURL'] = isset($_POST['SkillLicenseURL']) ? trim($_POST['SkillLicenseURL']) : '';
		$this->data['SkillClassificationRationale'] = isset($_POST['SkillClassificationRationale']) ? trim($_POST['SkillClassificationRationale']) : '';
	}


	private function checkAdminForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		// Note that the POST values has been saved in $data before calling this method. We use $data instead POST due to they have the isset check done, and we want to avoid to repeat it.  :P

		// Some field can not be empty

		if ( $this->data['SkillName']=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['SkillName'] = gettext('Please fill in here');
		}

		if ( $this->data['SkillTag']=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['SkillTag'] = gettext('Please fill in here');
		}
	}


	private function manageSuggestions()
	{
		$can_save = true; // Default value

		// If there is shadow change or the new-one-to-add is filled, then check them before saving to avoid crash
		$shadow_change = array();
		if ( $_POST['SkillName'] != $_POST['ShadowSkill2Process'] )
		{
		  $shadow_change[0] = $_POST['SkillName'];
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
					$skillList_ = strtolower( str_replace($letters,$escape,quotemeta($_POST['SkillName'])) );
					$skills_ = strtolower( $key );
					if ( count($suggestions[$i]) == 1 and ( preg_match("/^".$skillList_."$/", $skills_) or //   /^text$/
									        // preg_match("/^.+\(".$skillList_."\)$/", $skills_) or //   /^.+\(text\)$/
									        // ( preg_match("/^(.*) ".$skillList_."$/", $skills_, $matches) and substr_count($matches[1],' ') == 0 ) or //   /^.* text$/
									        preg_match("/^".$skillList_." \(.+\)$/", $skills_) // or //   /^text[ \(.+\)]$/
									        // ( preg_match("/^(.*) ".$skillList_." \(.+\)$/", $skills_, $matches) and substr_count($matches[1],' ') == 0 )//   /^.* text[ \(.+\)]$/
									      ) )
					{
						// Automatic suggestion selection

						$_POST['SkillName'] = $key; // It is $suggestions[$i][$key];

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
		if ( isset($_POST['SuggestionSet'.'0']) )
		{
			// Replace POST forms values
			if ( $_POST['SuggestionSet'.'0'] == "Keep as is" )
			{
			}
			else
			{
				$_POST['SkillName'] = $_POST['SuggestionSet'.'0'];
			}

			// Delete that suggestions set
			unset( $suggestions[0] );
			$_POST['SuggestedSkills'] = $suggestions; // copy again
		}

		// Check if, after processing the selected-suggestions, the form can be saved to the data base, that is to say, is there yet some suggestions-set which the user have to choose from
		if ( $can_save == false )
		{
			$can_save = true;
			if ( count($_POST['SuggestedSkills'][0]) > 0 )
			{
				$can_save = false;
			}
		}

		return $can_save;
	}


	private function loadAdminForm()
	{
		// Load data to be shown in the form

		if ( $_GET['section'] =='classify_skills' or $_GET['section'] == '' )
		{
			$result = $this->manager->getPendingSkillsList();

			$this->data['PendingSkillList'] = $result[0];

			// Check if there is some one already selected
			$selectedSkill = 0;
			if ( $_POST['Skill2Process'] != '' )
			{
				for ($i=0; $i<count($result[0]); $i++)
				{
					if ( $result[0][$i] == $_POST['Skill2Process'] )
					{
						$selectedSkill = $i;
						break;
					}
				}
			}

			$this->data['Skill2Process'] = $result[0][$selectedSkill];

			$this->data['SkillName'] = $result[0][$selectedSkill];
			$this->data['SkillTag'] = $result[1][$selectedSkill];
			$this->data['SkillType'] = $result[2][$selectedSkill];
			$this->data['SkillLicenseName'] = $result[3][$selectedSkill];
			$this->data['SkillLicenseURL'] = $result[4][$selectedSkill];
			$this->data['SkillClassificationRationale'] = $result[5][$selectedSkill];
		}
		elseif ( $_GET['section'] =='reclassify_skills' )
		{
			$result = $this->manager->getSkill($_POST['Skill2Process']);

			$this->data['Skill2Process'] = $result[0][0];

			$this->data['SkillName'] = $result[0][0];
			$this->data['SkillTag'] = $result[1][0];
			$this->data['SkillType'] = $result[2][0];
			$this->data['SkillLicenseName'] = $result[3][0];
			$this->data['SkillLicenseURL'] = $result[4][0];
			$this->data['SkillClassificationRationale'] = $result[5][0];
		}
		elseif ( $_GET['section'] =='add_skills' )
		{
		}

		return true;
	}


	private function cleanAdminForm()
	{
		unset( $this->data['SkillName'] );
		unset( $this->data['SkillTag'] );
		unset( $this->data['SkillType'] );
		unset( $this->data['SkillLicenseName'] );
		unset( $this->data['SkillLicenseURL'] );
		unset( $this->data['SkillClassificationRationale'] );
	}
}
?> 
