<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
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


require_once "../Layer-5__DB_operation/PostgreSQL.php";
require_once "../lib/Translator.php";


class Skills
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getSkillsListsBySets()
	{
		foreach ($this->getSkillSetTypesIdList() as $setId)
			$array[$setId] = array_merge( array(""), array_values($this->getSkillsIdListForSet($setId)) );

		return $array;
	}

	public function getSkillSetTypesIdList()
	{
		$sqlQuery = "SELECT LT_Id FROM LT_SkillSetTypes ORDER BY LT_Order";
		return $this->postgresql->getOneField($sqlQuery,0);
	}

	public function getSkillsIdListForSet($setId)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT LI_Id FROM LI_Skills WHERE LI_LT_Id=$1 ORDER BY LI_Id;  EXECUTE query('$setId');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}


	public function getSkillsList()
	{
		$sqlQuery = "SELECT LI_Id FROM LI_Skills";
		return $this->postgresql->getOneField($sqlQuery,0);
	}

	public function getTaggedSkillsList()
	{
		$sqlQuery = "SELECT LI_Id,LI_LH_Id FROM LI_Skills";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

		$array['LI_Id']    = pg_fetch_all_columns($result, 0);
		$array['LI_LH_Id'] = pg_fetch_all_columns($result, 1);

		return $array;
	}

	public function getPendingSkillsList()
	{
		$sqlQuery = "SELECT LI_Id,LI_LH_Id,LI_LT_Id,LI_LicenseName,LI_LicenseURL,LI_ClassificationRationale FROM LI_Skills WHERE LI_LH_Id='Pending'";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );
		$array[3] = pg_fetch_all_columns($result, 3 );
		$array[4] = pg_fetch_all_columns($result, 4 );
		$array[5] = pg_fetch_all_columns($result, 5 );

		return $array;
	}

	public function delNonUsedPendingSkills()
	{
		// This is done to clean non-used Skills which have not been classified, that is to say, non-used 'garbage'.

		$sqlQuery = "DELETE FROM LI_Skills WHERE LI_LH_Id='Pending' AND LI_Id NOT IN (SELECT DISTINCT R24_LI_Id FROM R24_Qualification2Skills) AND LI_Id NOT IN (SELECT DISTINCT R14_LI_Id FROM R14_JobOffer2Skills);";
		$this->postgresql->execute($sqlQuery,0);
	}

	public function getSkillSetTypesList()
	{
		$sqlQuery = "SELECT LT_Id FROM LT_SkillSetTypes";
		return $this->postgresql->getOneField($sqlQuery,0);
	}

	public function getSkillTagList()
	{
		$sqlQuery = "SELECT LH_Id FROM LH_Skills";
		$skillTagsIdList = $this->postgresql->getOneField($sqlQuery,0);

		$skillTags = array_combine($skillTagsIdList, $skillTagsIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$skillTags = $this->translator->t_array($skillTags, 'database');
		// asort($skillTags);  Note: The 'Id' is sort from the DataBase so we do not need sort this list after translate it.

		return $skillTags;
	}


	public function getSkillKnowledgeLevelsList()
	{
		$skillKnowledgeLevelsId = $this->getSkillKnowledgeLevelsIdList();
		$skillKnowledgeLevels = array_combine($skillKnowledgeLevelsId, $skillKnowledgeLevelsId);

		// This method is used to fill the combo box in the forms, so we sort it according to the skill using gettext().
		$skillKnowledgeLevels = $this->translator->t_array($skillKnowledgeLevels, 'database');
		// asort($skillKnowledgeLevels); // Note: The 'Id' is sort from the Data Base so we do not need sort this list after translate it.

		return $skillKnowledgeLevels;
	}

	private function getSkillKnowledgeLevelsIdList()
	{
		$sqlQuery = "SELECT LG_Id FROM LG_KnowledgeLevel";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getSkillExperienceLevelsList()
	{
		$skillExperienceLevelsId = $this->getSkillExperienceLevelsIdList();
		$skillExperienceLevels = array_combine($skillExperienceLevelsId, $skillExperienceLevelsId);

		// This method is used to fill the combo box in the forms, so we sort it according to the skill using gettext().
		$skillExperienceLevels = $this->translator->t_array($skillExperienceLevels, 'database');
		// asort($skillExperienceLevels); // Note: The 'Id' is sort from the Data Base so we do not need sort this list after translate it.

		return $skillExperienceLevels;
	}

	private function getSkillExperienceLevelsIdList()
	{
		$sqlQuery = "SELECT LN_Id FROM LN_ExperienceLevel";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function isSkillAlreadyInDataBase($skill)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT count(*) FROM LI_Skills WHERE LI_Id=$1;  EXECUTE query('".pg_escape_string($skill)."');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( intval($result[0]) >= 1 )
			return true;
		else
			return false;
	}

	public function getSkill($skill)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT LI_Id,LI_LH_Id,LI_LT_Id,LI_LicenseName,LI_LicenseURL,LI_ClassificationRationale FROM LI_Skills WHERE LI_Id=$1;  EXECUTE query('".pg_escape_string($skill)."');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );
		$array[3] = pg_fetch_all_columns($result, 3 );
		$array[4] = pg_fetch_all_columns($result, 4 );
		$array[5] = pg_fetch_all_columns($result, 5 );

		return $array;
	}

	public function addSkill($skill)
	{
		// We already knows that this Skill is not kept at the data base yet, so we do not have to check it  here again.
		if ($_POST['SkillName'] != '' )
		{
			$sqlQuery = "PREPARE query(text,text,text,text,text,text) AS  INSERT INTO LI_Skills (LI_Id,LI_LH_Id,LI_LT_Id,LI_LicenseName,LI_LicenseURL,LI_ClassificationRationale) VALUES ($1,$2,$3,$4,$5,$6);  EXECUTE query('".pg_escape_string($_POST['SkillName'])."','".$_POST['SkillTag']."','".$_POST['SkillType']."','".pg_escape_string($_POST['SkillLicenseName'])."','".pg_escape_string($_POST['SkillLicenseURL'])."','".pg_escape_string($_POST['SkillClassificationRationale'])."');";
			$this->postgresql->execute($sqlQuery,1);
		}
		else
		{
			$sqlQuery = "PREPARE query(text) AS  INSERT INTO LI_Skills (LI_Id,LI_LH_Id) VALUES ($1,'Pending');  EXECUTE query('".pg_escape_string($skill)."');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delSkill($skill)
	{
		$sqlQuery = "PREPARE query(text) AS  DELETE FROM LI_Skills WHERE LI_Id=$1;  EXECUTE query('".pg_escape_string($skill)."');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function updateSkill($skill,$force=false)
	{
		// If the skill towards we are going to rename is already present at the data base, we could rename the current in process and silently change the properties of the previous one. That could raise Skills classification regressions.
		// 1) Just reporting to the Skill administrator about it has been overwritten, and maybe good information have been lost ..., it not a solution.
		// 2) Asking for confirmation complicates the webpage, due to besides asking for confirmation we should expose both the old information a the new one so the skills administrator could choose, for each property, which one is the best to finally kept it at the data base.
		// 3) Another possibility is never overwrite, as a security measure against Skills classification regressions, (exception) but taking the opportunity to fill the fields if some of them are empty at the data base. This is a compromise.
	  
		// Exception: The above rule (3) will be applied at the "classifying section", but at the "reclassifying" section we will force the overwrite of all properties due to the old ones are being showed to the user. Note the case of changing the skill name will not be usual at the "reclassifying" section due to the skills there are already classified with their right names.

		// We only overwrite properties if the property value kept at the database is empty or NULL. Else the Skills administrator can use the Reclassify feature to force overwrite improving the information kept at the Skill properties.

		// This property is not overwritten if it kept already a value, except we are reclassifying instead of classifying the first time.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE LI_Skills SET LI_ClassificationRationale=$1 WHERE LI_Id=$2";
		if ($force==false) $sqlQuery .= " AND (LI_ClassificationRationale='' OR LI_ClassificationRationale IS NULL)";
		$sqlQuery .= ";  EXECUTE query('".pg_escape_string(trim($_POST['SkillClassificationRationale']))."','".pg_escape_string($skill)."');";
		$this->postgresql->execute($sqlQuery,1);

		// This property is not overwritten if it kept already a value, except we are reclassifying instead of classifying the first time.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE LI_Skills SET LI_LicenseURL=$1 WHERE LI_Id=$2";
		if ($force==false) $sqlQuery .= " AND (LI_LicenseURL='' OR LI_LicenseURL IS NULL)";
		$sqlQuery .= ";  EXECUTE query('".pg_escape_string(trim($_POST['SkillLicenseURL']))."','".pg_escape_string($skill)."');";
		$this->postgresql->execute($sqlQuery,1);

		// This property is not overwritten if it kept already a value, except we are reclassifying instead of classifying the first time.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE LI_Skills SET LI_LicenseName=$1 WHERE LI_Id=$2";
		if ($force==false) $sqlQuery .= " AND (LI_LicenseName='' OR LI_LicenseName IS NULL)";
		$sqlQuery .= ";  EXECUTE query('".pg_escape_string(trim($_POST['SkillLicenseName']))."','".pg_escape_string($skill)."');";
		$this->postgresql->execute($sqlQuery,1);

		// This property is not overwritten if it kept already a value, except we are reclassifying instead of classifying the first time.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE LI_Skills SET LI_LT_Id=$1 WHERE LI_Id=$2";
		if ($force==false) $sqlQuery .= " AND (LI_LT_Id='' OR LI_LT_Id IS NULL)";
		$sqlQuery .= ";  EXECUTE query('".pg_escape_string($_POST['SkillType'])."','".pg_escape_string($skill)."');";
		$this->postgresql->execute($sqlQuery,1);

		// This property is overwritten even if it kept already a value. Obviously we have to overwrite this field when we are classifying due to it keeps the classification tag.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE LI_Skills SET LI_LH_Id=$1 WHERE LI_Id=$2;  EXECUTE query('".pg_escape_string($_POST['SkillTag'])."','".pg_escape_string($skill)."');";
		$this->postgresql->execute($sqlQuery,1);

		// This property is overwritten even if it kept already a value.
		if ( $_POST['SkillName'] != $skill ) // Do not update if the name is the same to avoid the PostgreSQL error: "update or delete on 'li_skills' violates foreign key constraint 'r24_qualification2skills_r24_li_id_fkey' on ..."
		{
			$sqlQuery = "PREPARE query(text,text) AS  UPDATE LI_Skills SET LI_Id=$1 WHERE LI_Id=$2;  EXECUTE query('".pg_escape_string(trim($_POST['SkillName']))."','".pg_escape_string($skill)."');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function renameJobOffersAndQualificationsSkills($from,$to)
	{
		// Qualifications
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE R24_Qualification2Skills SET R24_LI_Id=$1 WHERE R24_LI_Id=$2;  EXECUTE query('".pg_escape_string($to)."','".pg_escape_string($from)."');";
		$this->postgresql->execute($sqlQuery,1);

		// JobOffers
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE R14_JobOffer2Skills SET R14_LI_Id=$1 WHERE R14_LI_Id=$2;  EXECUTE query('".pg_escape_string($to)."','".pg_escape_string($from)."');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function getSkillsForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R24_LI_Id,R24_LG_Id,R24_LN_Id,LI_LH_Id FROM R24_Qualification2Skills,LI_Skills WHERE R24_Q1_E1_Id=$1 AND R24_LI_Id=LI_Id;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );
		$array[3] = pg_fetch_all_columns($result, 3 );

		return $array;
	}

	public function setSkillsForEntity()
	{
		// clear
		$this->delSkillsForEntity();

		// set
		for( $i=0; $i < count($_POST['SkillList']); $i++)
		{
			$skillList = trim($_POST['SkillList'][$i]);
			$skillKnowledgeLevelList = trim($_POST['SkillKnowledgeLevelList'][$i]);
			$skillExperienceLevelList = trim($_POST['SkillExperienceLevelList'][$i]);
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO R24_Qualification2Skills (R24_Q1_E1_Id,R24_LI_Id,R24_LG_Id,R24_LN_Id) VALUES ($1,$2,$3,$4);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($skillList)."','$skillKnowledgeLevelList','$skillExperienceLevelList');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delSkillsForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R24_Qualification2Skills WHERE R24_Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function getSkillsForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R14_LI_Id,R14_LG_Id,R14_LN_Id,LI_LH_Id FROM R14_JobOffer2Skills,LI_Skills WHERE R14_J1_Id=$1 AND R14_LI_Id=LI_Id;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );
		$array[3] = pg_fetch_all_columns($result, 3 );

		return $array;
	}

	public function setSkillsForJobOffer($Id)
	{
		// clear
		$this->delSkillsForJobOffer($Id);

		// set
		for( $i=0; $i < count($_POST['SkillList']); $i++)
		{
			$skillList = trim($_POST['SkillList'][$i]);
			$skillKnowledgeLevelList = trim($_POST['SkillKnowledgeLevelList'][$i]);
			$skillExperienceLevelList = trim($_POST['SkillExperienceLevelList'][$i]);
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO R14_JobOffer2Skills (R14_J1_Id,R14_LI_Id,R14_LG_Id,R14_LN_Id) VALUES ($1,$2,$3,$4);  EXECUTE query('$Id','".pg_escape_string($skillList)."','$skillKnowledgeLevelList','$skillExperienceLevelList');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delSkillsForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R14_JobOffer2Skills WHERE R14_J1_Id=$1;  EXECUTE query('$Id');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
