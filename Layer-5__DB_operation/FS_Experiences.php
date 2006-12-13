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
		for( $i=0; $i < count($_SESSION['ContributionsListProject']); $i++)
		{
			$contributionProject = trim($_SESSION['ContributionsListProject'][$i]);
			$contributionDescrition = trim($_SESSION['ContributionsListDescription'][$i]);
			$contributionURI = trim($_SESSION['ContributionsListURI'][$i]);
			$sqlQuery = "PREPARE query(integer,text,text,text) AS  INSERT INTO E2_EntityFreeSoftwareExperiences (E2_E1_Id,E2_Project,E2_Description,E2_URI) VALUES ($1,$2,$3,$4);  EXECUTE query('$_SESSION[EntityId]','$contributionProject','$contributionDescrition','$contributionURI');";
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
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT E2_E1_Id FROM E2_EntityFreeSoftwareExperiences WHERE E2_E1_Id=$1 AND E2_Project=$2;  EXECUTE query('$EntityId','$FSProject');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( count($result) == 1 )
			return true;
		else
			return false;
	}
}
?> 
