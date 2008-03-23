<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007, 2008 Davi Leal <davi at leals dot com>
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


class Languages
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getLanguagesList()
	{
		$languagesName = $this->getLanguagesNameList();
		$languages = array_combine($languagesName, $languagesName);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$languages = $this->translator->t_array($languages, 'iso_639');
		asort($languages); // Note after transtale it, we sort this ComboBox.

		return $languages;
	}

	private function getLanguagesNameList()
	{
		$sqlQuery = "SELECT LL_Name FROM LL_Languages";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getLanguageSpokenLevelsList()
	{
		$languagesSpokenLevelsId = $this->getLanguagesSpokenLevelsIdList();
		$languagesSpokenLevels = array_combine($languagesSpokenLevelsId, $languagesSpokenLevelsId);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$languagesSpokenLevels = $this->translator->t_array($languagesSpokenLevels, 'database');
		// asort($languagesSpokenLevels); // Note: The 'Id' is sort from the Data Base so we do not need sort this list after translate it.

		return $languagesSpokenLevels;
	}

	private function getLanguagesSpokenLevelsIdList()
	{
		$sqlQuery = "SELECT LS_Id FROM LS_SpokenLevel";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getLanguageWrittenLevelsList()
	{
		$languagesWrittenLevelsId = $this->getLanguagesWrittenLevelsIdList();
		$languagesWrittenLevels = array_combine($languagesWrittenLevelsId, $languagesWrittenLevelsId);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$languagesWrittenLevels = $this->translator->t_array($languagesWrittenLevels, 'database');
		// asort($languagesWrittenLevels); // Note: The 'Id' is sort from the Data Base so we do not need sort this list after translate it.

		return $languagesWrittenLevels;
	}

	private function getLanguagesWrittenLevelsIdList()
	{
		$sqlQuery = "SELECT LW_Id FROM LW_WrittenLevel";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getLanguagesForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R25_LL_Name,R25_LS_Id,R25_LW_Id FROM R25_Qualification2Languages WHERE R25_Q1_E1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );

		return $array;
	}

	public function setLanguagesForEntity()
	{
		// clear
		$this->delLanguagesForEntity();

		// set
		for( $i=0; $i < count($_POST['LanguageList']); $i++)
		{
			$languageList = trim($_POST['LanguageList'][$i]);
			$languageSpokenLevelList = trim($_POST['LanguageSpokenLevelList'][$i]);
			$languageWrittenLevelList = trim($_POST['LanguageWrittenLevelList'][$i]);
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO R25_Qualification2Languages (R25_Q1_E1_Id,R25_LL_Name,R25_LS_Id,R25_LW_Id) VALUES ($1,$2,$3,$4);  EXECUTE query('$_SESSION[EntityId]','$languageList','$languageSpokenLevelList','$languageWrittenLevelList');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delLanguagesForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R25_Qualification2Languages WHERE R25_Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function getLanguagesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R15_LL_Name,R15_LS_Id,R15_LW_Id FROM R15_JobOffer2Languages WHERE R15_J1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );

		return $array;
	}

	public function setLanguagesForJobOffer($Id)
	{
		// clear
		$this->delLanguagesForJobOffer($Id);

		// set
		for( $i=0; $i < count($_POST['LanguageList']); $i++)
		{
			$languageList = trim($_POST['LanguageList'][$i]);
			$languageSpokenLevelList = trim($_POST['LanguageSpokenLevelList'][$i]);
			$languageWrittenLevelList = trim($_POST['LanguageWrittenLevelList'][$i]);
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO R15_JobOffer2Languages (R15_J1_Id,R15_LL_Name,R15_LS_Id,R15_LW_Id) VALUES ($1,$2,$3,$4);  EXECUTE query('$Id','$languageList','$languageSpokenLevelList','$languageWrittenLevelList');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delLanguagesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R15_JobOffer2Languages WHERE R15_J1_Id=$1;  EXECUTE query('$Id');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
?> 
