<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008 Davi Leal <davi at leals dot com>
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


class SkillsForm
{
	protected $manager;
	protected $checks;
	protected $data;


	function __construct()
	{
		$this->manager = new DBManager();
	}


	// Common methods -- Reference: http://www.php.net/manual/en/language.oop5.abstract.php

	protected function getSuggestedSkillsLists($skillList)
	{
		$skills = $this->manager->getTaggedSkillsList(); // We normalize both Free and Non-Free skills, but only show to the public the Free and Unknow ones

		$suggestions = array(); // Initialization
		$extracted_skills = array(); // Initialization

		foreach ($skillList as $i => $value)
		{
			// Expert system based on rules

			$letters = array('/');
			$escape = array('\/');
			$skillList_ = strtolower( str_replace($letters,$escape,quotemeta(trim($skillList[$i]))) );


			// Static rules. They can be a problem to the maintenance

			if ( preg_match("/^".$skillList_."$/", "linux") )//   Static rule: /^linux$/
			{
				$suggestions[$i][ "Linux kernel" ] = "Linux kernel";
				$suggestions[$i][ "GNU/Linux" ] = "GNU/Linux";
				continue;
			}

			if ( preg_match("/^".$skillList_."$/", "bsd") )//   Static rule: /^bsd$/
			{
				$suggestions[$i][ "FreeBSD kernel" ] = "FreeBSD kernel";
				$suggestions[$i][ "NetBSD kernel" ] = "NetBSD kernel";
				$suggestions[$i][ "OpenBSD kernel" ] = "OpenBSD kernel";
				$suggestions[$i][ "FreeBSD" ] = "FreeBSD";
				$suggestions[$i][ "NetBSD" ] = "NetBSD";
				$suggestions[$i][ "OpenBSD" ] = "OpenBSD";
				continue;
			}

			if ( preg_match("/^".$skillList_."$/", "gimp") )//   Static rule: /^gimp$/
			{
				$suggestions[$i][ "The Gimp" ] = "The Gimp";
			}


			// Dynamic rules

			for ($j=0; $j<count($skills['LI_Id']); $j++)
			{
				$skills_ = strtolower( $skills['LI_Id'][$j] );

				if ( empty($skillList_) or !preg_match("/^".$skillList_."$/", $skills_) )//   /^text$/
				{
				}
				else
				{
					$suggestions[$i][ $skills['LI_Id'][$j] ] = $skills['LI_Id'][$j];
					break;
				}
			}
			if ( count($suggestions[$i]) > 0 )
				continue;

			for ($j=0; $j<count($skills['LI_Id']); $j++)
			{
				$skills_ = strtolower( $skills['LI_Id'][$j] );

				if ( strlen($skillList_)<2 or !preg_match("/^.+\(".$skillList_."\)$/", $skills_) )//   /^.+\(text\)$/
				{
				}
				else
				{
					$suggestions[$i][ $skills['LI_Id'][$j] ] = $skills['LI_Id'][$j];
				}
			}
			if ( count($suggestions[$i]) > 0 )
				continue;

			for ($j=0; $j<count($skills['LI_Id']); $j++)
			{
				$skills_ = strtolower( $skills['LI_Id'][$j] );

				if ( strlen($skillList_)<3 or !preg_match("/^(.*) ".$skillList_."$/", $skills_) or ( preg_match("/^(.*) ".$skillList_."$/", $skills_, $matches) and substr_count($matches[1],' ') > 0 ) )//   /^.* text$/
				{
				}
				else
				{
					$suggestions[$i][ $skills['LI_Id'][$j] ] = $skills['LI_Id'][$j];
				}
			}
			if ( count($suggestions[$i]) >= 2 )
			{
				unset( $suggestions[$i] );

				// New skill without any suggestion

				// Take note to be inserted in the data base before saving the entity skills
				$_POST['SkillsToInsert'][$i] = trim($skillList[$i]);

				// Update the shadow mark
				$_POST['ShadowSkillList'][$i] = $_POST['SkillList'][$i];

				continue;
			}
			elseif ( count($suggestions[$i]) == 1 )
			{
				continue;
			}
			// else == 0

			for ($j=0; $j<count($skills['LI_Id']); $j++)
			{
				$skills_ = strtolower( $skills['LI_Id'][$j] );

				if ( strlen($skillList_)<3 or !preg_match("/^".$skillList_." \(.+\)$/", $skills_) )//   /^text[ \(.+\)]$/
				{
				}
				else
				{
					$suggestions[$i][ $skills['LI_Id'][$j] ] = $skills['LI_Id'][$j];
				}
			}
			if ( count($suggestions[$i]) >= 2 )
			{
				unset( $suggestions[$i] );

				// New skill without any suggestion

				// Take note to be inserted in the data base before saving the entity skills
				$_POST['SkillsToInsert'][$i] = trim($skillList[$i]);

				// Update the shadow mark
				$_POST['ShadowSkillList'][$i] = $_POST['SkillList'][$i];

				continue;
			}
			elseif ( count($suggestions[$i]) == 1 )
			{
				continue;
			}
			// else == 0

			for ($j=0; $j<count($skills['LI_Id']); $j++)
			{
				$skills_ = strtolower( $skills['LI_Id'][$j] );

				if ( strlen($skillList_)<3 or !preg_match("/^(.*) ".$skillList_." \(.+\)$/", $skills_) or ( preg_match("/^(.*) ".$skillList_." \(.+\)$/", $skills_, $matches) and substr_count($matches[1],' ') > 0 ) )//   /^.* text[ \(.+\)]$/
				{
					if ( $j == count($skills['LI_Id']) -1 and count($suggestions[$i]) == 0 )
					{
						// New skill without any suggestion

						// Take note to be inserted in the data base before saving the entity skills
						$_POST['SkillsToInsert'][$i] = trim($skillList[$i]);

						// Update the shadow mark
						$_POST['ShadowSkillList'][$i] = $_POST['SkillList'][$i];
					}
				}
				else
				{
					$suggestions[$i][ $skills['LI_Id'][$j] ] = $skills['LI_Id'][$j];
				}
			}
			if ( count($suggestions[$i]) >= 2 )
			{
				unset( $suggestions[$i] );

				// New skill without any suggestion

				// Take note to be inserted in the data base before saving the entity skills
				$_POST['SkillsToInsert'][$i] = trim($skillList[$i]);

				// Update the shadow mark
				$_POST['ShadowSkillList'][$i] = $_POST['SkillList'][$i];

				continue;
			}
			elseif ( count($suggestions[$i]) == 1 )
			{
				continue;
			}
			// else == 0


			// extractor rule // Try to extract skills list

			$boundaries = array(',','/','-',';',':','(',')','[',']','{','}');

			$splitted_string = explode(' ', ereg_replace(' +',' ',str_replace($boundaries,' ',trim($skillList[$i])) ) );
			$splitted_count = count($splitted_string);

			if  ($splitted_count >= 2 )
			{
				// Process each extracted string and take note if it matches with a known skill
				for ($e=0; $e < $splitted_count; $e++)
				{
					$letters = array('/');
					$escape = array('\/');
					$extracted = strtolower( str_replace($letters,$escape,quotemeta(trim($splitted_string[$e]))) );

					$rule_matches = false; // Flag initialization
					for ($j=0; $j<count($skills['LI_Id']); $j++)
					{
						$skills_ = strtolower( $skills['LI_Id'][$j] );

						if ( empty($extracted) or !preg_match("/^".$extracted."$/", $skills_) )//   /^text$/
						{
						}
						else
						{
							$extracted_skills[ $skillList[$i] ][ $skills['LI_Id'][$j] ][ $skills['LI_Id'][$j] ] = $skills['LI_Id'][$j];
							$rule_matches = true; // Set flag
							break;
						}
					}
					if ( $rule_matches == true )
						continue;

					for ($j=0; $j<count($skills['LI_Id']); $j++)
					{
						$skills_ = strtolower( $skills['LI_Id'][$j] );

						if ( strlen($extracted)<2 or !preg_match("/^.+\(".$extracted."\)$/", $skills_) )//   /^.+\(text\)$/
						{
						}
						else
						{
							$extracted_skills[ $skillList[$i] ][ $splitted_string[$e] ][ $skills['LI_Id'][$j] ] = $skills['LI_Id'][$j];
							// Follow processing the skill list to check if there are more than one match.
							// If there is more than one match we offer suggestions.
							//break;
						}
					}
				}

				// If there are not 2 o more matches for this skill entry, then we rule out these skill-extractions and keep the original string,
				// else we use the extracted skills and rule out the non-recognized splitted strings. The user can add the non-recognized strings individually if he wants to do it anyway.
				if ( count($extracted_skills[ $skillList[$i] ]) < 2 )
				{
					unset( $extracted_skills[ $skillList[$i] ] );
				}
			}
		}

		// Clean suggestions of skills which are flagged as unknown or pending of evaluation
		for ($i=0; $i<count($suggestions); $i++)
		{
			if (is_array($suggestions[$i]))
			{
				foreach ($suggestions[$i] as $value)
				{
					$k = array_search($value, $skills['LI_LH_Id']);
					if ( $skills['LI_LH_Id'][$k] == 'Unknown' or $skills['LI_LH_Id'][$k] == 'Pending' )
					{
						unset( $suggestions[$k] );
					}
				}
			}
		}

		// If there are 'extracted-skills' re-build the '_POST', 'suggestions' and 'checks' arrays
		if ( count($extracted_skills) > 0 )
		{
			// expand the extracted skills, etc. at the right position
			for( $i=0,$j=0; $i < count($_POST['SkillList']); $i++ )
			{
				// Find the position
				if ( in_array( $_POST['SkillList'][$i], array_keys($extracted_skills) ) ) // This is one of the extracted skills
				{
					foreach ( $extracted_skills[ $_POST['SkillList'][$i] ]  as $key => $value )
					{
						if ( count($value) >= 2 ) // suggestions which have to be chosen by the webapp user
						{
							$checkList_aux[$j] = ''; // CheckList is reset due to we do not know yet what type of skill it is

							$skillList_aux[$j] = $key;
							$shadowSkillList_aux[$j] = '';
							$skillsToInsert_aux[$j] = '';
							$skillKnowledgeLevelList_aux[$j] = $_POST['SkillKnowledgeLevelList'][$i];
							$skillExperienceLevelList_aux[$j] = $_POST['SkillExperienceLevelList'][$i];

							// There are not '$checks' for extracted skills

							foreach ( $value as $k => $v )
								$suggestions_aux[$j][$k] = $v;
						}
						else // <= 2  so no suggestions
						{
							foreach ($value as $k)
								;

							$checkList_aux[$j] = ''; // CheckList is reset due to we do not know yet what type of skill it is

							$skillList_aux[$j] = $k;
							$shadowSkillList_aux[$j] = $k;
							$skillsToInsert_aux[$j] = '';
							$skillKnowledgeLevelList_aux[$j] = $_POST['SkillKnowledgeLevelList'][$i];
							$skillExperienceLevelList_aux[$j] = $_POST['SkillExperienceLevelList'][$i];

							// There are not '$checks' for extracted skills

							// There are not '$suggestions' if we only have one option to choose
						}

						$j++;
					}
				}
				else // It is not an extracted skill. So leave as is.
				{
					$checkList_aux[$j] = $this->data['CheckList'][$i];

					$skillList_aux[$j] = $_POST['SkillList'][$i];
					$shadowSkillList_aux[$j] = $_POST['ShadowSkillList'][$i];
					$skillsToInsert_aux[$j] = $_POST['SkillsToInsert'][$i];
					$skillKnowledgeLevelList_aux[$j] = $_POST['SkillKnowledgeLevelList'][$i];
					$skillExperienceLevelList_aux[$j] = $_POST['SkillExperienceLevelList'][$i];

					if ( isset($this->checks['SkillList'][$i]) )
						$checks['SkillList'][$j] = $this->checks['SkillList'][$i];
					if ( isset($this->checks['SkillKnowledgeLevelList'][$i]) )
						$checks['SkillKnowledgeLevelList'][$j] = $this->checks['SkillKnowledgeLevelList'][$i];
					if ( isset($this->checks['SkillExperienceLevelList'][$i]) )
						$checks['SkillExperienceLevelList'][$j] = $this->checks['SkillExperienceLevelList'][$i];

					if ( isset($suggestions[$i]) )
						$suggestions_aux[$j] = $suggestions[$i];

					$j++;
				}
			}

			$this->data['CheckList'] = $checkList_aux;

			$_POST['SkillList'] = $skillList_aux;
			$_POST['ShadowSkillList'] = $shadowSkillList_aux;
			$_POST['SkillsToInsert'] = $skillsToInsert_aux;
			$_POST['SkillKnowledgeLevelList'] = $skillKnowledgeLevelList_aux;
			$_POST['SkillExperienceLevelList'] = $skillExperienceLevelList_aux;

			$this->checks['SkillList'] = $checks['SkillList'];
			$this->checks['SkillKnowledgeLevelList'] = $checks['SkillKnowledgeLevelList'];
			$this->checks['SkillExperienceLevelList'] = $checks['SkillExperienceLevelList'];

			$suggestions = $suggestions_aux;
		}

		return $suggestions;
	}
}
?>
