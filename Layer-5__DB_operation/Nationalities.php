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


class Nationalities
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getNationalityList()
	{
		$nationalityTwoLetter = $this->getNationalityTwoLetterList();
		$nationalityNames = $this->getNationalityNameList();
		$nationalities = array_combine($nationalityTwoLetter, $nationalityNames);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$nationalities = $this->translator->t_array($nationalities, 'nationalities');
		asort($nationalities); // Note After translate it, we sort this ComboBox.

		return $nationalities;
	}

	private function getNationalityTwoLetterList()
	{
		$sqlQuery = "SELECT LN_LO_TwoLetter FROM LN_Nationalities";
		return $this->postgresql->getOneField($sqlQuery,0);
	}

	private function getNationalityNameList()
	{
		$sqlQuery = "SELECT LN_Name FROM LN_Nationalities";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getNationalitiesForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT E3_LN_Id FROM E3_Nationalities WHERE E3_E1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setNationalitiesForEntity()
	{
		// clear
		$this->deleteNationalitiesForEntity();

		// set
		for( $i=0; $i < count($_POST['NationalityList']); $i++)
		{
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO E3_Nationalities (E3_E1_Id,E3_LN_Id) VALUES ($1,$2);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($_POST['NationalityList'][$i])."');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function deleteNationalitiesForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM E3_Nationalities WHERE E3_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
?> 
