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


class FreeSoftwareExperiences
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getFreeSoftwareExperiencesForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT E2_Project,E2_Description,E2_URI FROM E2_EntityFreeSoftwareExperiences WHERE E2_E1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );

		return $array;
	}

	public function setFreeSoftwareExperiencesForEntity()
	{
		// clear
		$this->delFreeSoftwareExperiencesForEntity();

		// set
		for( $i=0; $i < count($_POST['ContributionsListProject']); $i++)
		{
			$contributionProject = trim($_POST['ContributionsListProject'][$i]);
			$contributionDescrition = trim($_POST['ContributionsListDescription'][$i]);
			$contributionURI = trim($_POST['ContributionsListURI'][$i]);
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO E2_EntityFreeSoftwareExperiences (E2_E1_Id,E2_Project,E2_Description,E2_URI) VALUES ($1,$2,$3,$4);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($contributionProject)."','".pg_escape_string($contributionDescrition)."','".pg_escape_string($contributionURI)."');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delFreeSoftwareExperiencesForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM E2_EntityFreeSoftwareExperiences WHERE E2_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function entityHasThisFSProjectExperience($EntityId,$FSProject)
	{
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT E2_E1_Id FROM E2_EntityFreeSoftwareExperiences WHERE E2_E1_Id=$1 AND E2_Project=$2;  EXECUTE query('$EntityId','".pg_escape_string($FSProject)."');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( count($result) == 1 )
			return true;
		else
			return false;
	}
}
