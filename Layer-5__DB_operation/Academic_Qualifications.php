<?php
// Authors: Davi Leal
//
// Copyright (C) 2006 Davi Leal <davi at leals dot com>
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


class AcademicQualifications
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getAcademicQualificationsList()
	{
		$academicQualificationsIdList = $this->getAcademicQualificationsIdList();
		$academicQualifications = array_combine($academicQualificationsIdList, $academicQualificationsIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		while (current($academicQualifications))
		{
			$academicQualifications[key($academicQualifications)] = gettext( trim( current($academicQualifications) ) );
			next($academicQualifications);
		}

		// asort($professionalProfiles);  Note: The 'Id' is sort from the DataBase so we do not need sort this list after translate it.

		return $academicQualifications;
	}

	public function getAcademicQualificationsIdList()
	{
		$sqlQuery = "SELECT LA_Id FROM LA_AcademicQualifications";
		return $this->postgresql->getOneField($sqlQuery, 0);
	}

	public function getAcademicQualificationsLevelList()
	{
		$sqlQuery = "SELECT LA_Level FROM LA_AcademicQualifications";
		return $this->postgresql->getOneField($sqlQuery, 0);
	}


	public function getAcademicQualificationsEqualOrBetterThan($Qualification)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT LA_Id FROM LA_AcademicQualifications WHERE LA_Level >= (SELECT LA_Level FROM LA_AcademicQualifications WHERE LA_Id=$1);  EXECUTE query('$Qualification');";
		return $this->postgresql->getOneField($sqlQuery, 1);
	}
}
?> 
