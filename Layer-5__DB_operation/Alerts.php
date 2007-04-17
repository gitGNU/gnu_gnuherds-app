<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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


class Alerts
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function initAlertsForEntity($E1_Id)
	{
		$sqlQuery = "PREPARE query(integer,bool) AS  INSERT INTO A1_Alerts (A1_E1_Id,A1_NewJobOffer) VALUES ($1,$2);  EXECUTE query('$E1_Id','false');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function getAlertsForEntity()
	{
		// The row have to be present in the data base, else we can be sure the data base is corrupted.
		$sqlQuery = "PREPARE query(integer) AS  SELECT A1_NewJobOffer FROM A1_Alerts WHERE A1_E1_Id=$1;  EXECUTE query('{$_SESSION['EntityId']}');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0); // A1_NewJobOffer

		return $array;
	}

	public function saveAlertsForEntity()
	{
		// The row have to be present in the data base, else we can be sure the data base is corrupted.
		$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE A1_Alerts SET A1_NewJobOffer=$1 WHERE A1_E1_Id=$2;  EXECUTE query('{$_SESSION['NewJobOffer']}','{$_SESSION['EntityId']}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function deleteAlertsForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM A1_Alerts WHERE A1_E1_Id=$1;  EXECUTE query('{$_SESSION['EntityId']}');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
?> 
