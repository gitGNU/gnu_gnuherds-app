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


class Countries
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getCountryList()
	{
		$countryTwoLetter = $this->getCountryTwoLetterList();
		$countryNames = $this->getCountryNameList();
		$countries = array_combine($countryTwoLetter, $countryNames);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$countries = $this->translator->t_array($countries, 'iso_3166');
		asort($countries); // Note After translate it, we sort this ComboBox.

		return $countries;
	}

	private function getCountryTwoLetterList()
	{
		$sqlQuery = "SELECT LO_TwoLetter FROM LO_Countries";
		return $this->postgresql->getOneField($sqlQuery,0);
	}

	private function getCountryNameList()
	{
		$sqlQuery = "SELECT LO_Name FROM LO_Countries";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getJobLicenseAtForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT E4_LO_Id FROM E4_EntityJobLicenseAt WHERE E4_E1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setJobLicenseAtForEntity()
	{
		// clear
		$this->deleteJobLicenseAtForEntity();

		// set
		for( $i=0; $i < count($_POST['JobLicenseAtList']); $i++)
		{
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO E4_EntityJobLicenseAt (E4_E1_Id,E4_LO_Id) VALUES ($1,$2);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($_POST['JobLicenseAtList'][$i])."');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function deleteJobLicenseAtForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM E4_EntityJobLicenseAt WHERE E4_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
