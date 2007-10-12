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


require_once "../Layer-5__DB_operation/PostgreSQL.php";


class Skills
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
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


	public function getSkillKnowledgeLevelsList()
	{
		$skillKnowledgeLevelsId = $this->getSkillKnowledgeLevelsIdList();
		$skillKnowledgeLevels = array_combine($skillKnowledgeLevelsId, $skillKnowledgeLevelsId);

		// This method is used to fill the combo box in the forms, so we sort it according to the skill using gettext().
		while (current($skillKnowledgeLevels))
		{
			$skillKnowledgeLevels[key($skillKnowledgeLevels)] = gettext( trim( current($skillKnowledgeLevels) ) );
			next($skillKnowledgeLevels);
		}

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
		while (current($skillExperienceLevels))
		{
			$skillExperienceLevels[key($skillExperienceLevels)] = gettext( trim( current($skillExperienceLevels) ) );
			next($skillExperienceLevels);
		}

		// asort($skillExperienceLevels); // Note: The 'Id' is sort from the Data Base so we do not need sort this list after translate it.

		return $skillExperienceLevels;
	}

	private function getSkillExperienceLevelsIdList()
	{
		$sqlQuery = "SELECT LN_Id FROM LN_ExperienceLevel";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function addSkill($skill)
	{
		$sqlQuery = "PREPARE query(text) AS  INSERT INTO LI_Skills (LI_Id,LI_LH_Id) VALUES ($1,'Pending');  EXECUTE query('$skill');";
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
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO R24_Qualification2Skills (R24_Q1_E1_Id,R24_LI_Id,R24_LG_Id,R24_LN_Id) VALUES ($1,$2,$3,$4);  EXECUTE query('$_SESSION[EntityId]','$skillList','$skillKnowledgeLevelList','$skillExperienceLevelList');";
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
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO R14_JobOffer2Skills (R14_J1_Id,R14_LI_Id,R14_LG_Id,R14_LN_Id) VALUES ($1,$2,$3,$4);  EXECUTE query('$Id','$skillList','$skillKnowledgeLevelList','$skillExperienceLevelList');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delSkillsForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R14_JobOffer2Skills WHERE R14_J1_Id=$1;  EXECUTE query('$Id');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
?> 
