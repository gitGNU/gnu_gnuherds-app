<?php
// Authors: Davi Leal
//
// Copyright (C) 2007, 2008 Davi Leal <davi at leals dot com>
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


class Alerts
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function initAlertsForEntity($E1_Id)
	{
		$sqlQuery = "PREPARE query(integer,bool,bool,bool) AS  INSERT INTO A1_Alerts (A1_E1_Id,A1_NewJobOffer,A1_NewDonationPledgeGroup,A1_NewLookForVolunteers) VALUES ($1,$2,$3,$4);  EXECUTE query('$E1_Id','true','false','false');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function getAlertsForEntity()
	{
		// The row have to be present in the data base, else we can be sure the data base is corrupted.
		$sqlQuery = "PREPARE query(integer) AS  SELECT A1_NewJobOffer,A1_NewDonationPledgeGroup,A1_NewLookForVolunteers FROM A1_Alerts WHERE A1_E1_Id=$1;  EXECUTE query('{$_SESSION['EntityId']}');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array['NewJobOffer'] = pg_fetch_all_columns($result, 0);
		$array['NewDonationPledgeGroup'] = pg_fetch_all_columns($result, 1);
		$array['NewLookForVolunteers'] = pg_fetch_all_columns($result, 2);

		return $array;
	}

	public function saveAlertsForEntity()
	{
		// The row have to be present in the data base, else we can be sure the data base is corrupted.
		$sqlQuery = "PREPARE query(bool,bool,bool,integer) AS  UPDATE A1_Alerts SET A1_NewJobOffer=$1,A1_NewDonationPledgeGroup=$2,A1_NewLookForVolunteers=$3 WHERE A1_E1_Id=$4;  EXECUTE query('{$_POST['NewJobOffer']}','{$_POST['NewDonationPledgeGroup']}','{$_POST['NewLookForVolunteers']}','{$_SESSION['EntityId']}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function deleteAlertsForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM A1_Alerts WHERE A1_E1_Id=$1;  EXECUTE query('{$_SESSION['EntityId']}');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
?> 
