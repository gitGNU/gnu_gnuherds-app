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


class Certifications
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getRequestedCertificationsForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R26_LC_Name, R26_State FROM R26_Qualification2Certifications WHERE R26_Q1_E1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );

		return $array;
	}

	public function setRequestedCertificationsForEntity()
	{
		for( $i=0; $i < count($_POST['NotYetRequestedCertificationsList']); $i++)
		{
			$certification = isset($_POST['NotYetRequestedCertificationsList'][$i]) ? trim($_POST['NotYetRequestedCertificationsList'][$i]) : '';
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R26_Qualification2Certifications (R26_Q1_E1_Id,R26_LC_Name,R26_State) VALUES ($1,$2,'Pending');  EXECUTE query('$_SESSION[EntityId]','$certification');";
			$this->postgresql->getPostgreSQLObject($sqlQuery,1);
		}
	}

	public function delRequestedCertificationsForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R26_Qualification2Certifications WHERE R26_Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		return $this->postgresql->getPostgreSQLObject($sqlQuery,1);
	}


	public function getNotYetRequestedCertificationsForEntity()
	{
		if ( $_SESSION['LoginType'] == 'Person' )
			$sqlQuery = "PREPARE query(integer) AS  SELECT LC_Name FROM LC_Certifications WHERE LC_Apply2Person=true AND LC_Name NOT IN ( SELECT R26_LC_Name FROM R26_Qualification2Certifications WHERE R26_Q1_E1_Id=$1 );  EXECUTE query('$_SESSION[EntityId]');";

		if ( $_SESSION['LoginType'] == 'Cooperative' )
			$sqlQuery = "PREPARE query(integer) AS  SELECT LC_Name FROM LC_Certifications WHERE LC_Apply2Cooperative=true AND LC_Name NOT IN ( SELECT R26_LC_Name FROM R26_Qualification2Certifications WHERE R26_Q1_E1_Id=$1 );  EXECUTE query('$_SESSION[EntityId]');";

		if ( $_SESSION['LoginType'] == 'Company' )
			$sqlQuery = "PREPARE query(integer) AS  SELECT LC_Name FROM LC_Certifications WHERE LC_Apply2Company=true AND LC_Name NOT IN ( SELECT R26_LC_Name FROM R26_Qualification2Certifications WHERE R26_Q1_E1_Id=$1 );  EXECUTE query('$_SESSION[EntityId]');";

		if ( $_SESSION['LoginType'] == 'non-profit Organization' )
			$sqlQuery = "PREPARE query(integer) AS  SELECT LC_Name FROM LC_Certifications WHERE LC_Apply2Organization=true AND LC_Name NOT IN ( SELECT R26_LC_Name FROM R26_Qualification2Certifications WHERE R26_Q1_E1_Id=$1 );  EXECUTE query('$_SESSION[EntityId]');";

		return $this->postgresql->getOneField($sqlQuery,1);
	}


	public function getCertificationsList()
	{
		$sqlQuery = "SELECT LC_Name,LC_Apply2Person,LC_Apply2Cooperative,LC_Apply2Company,LC_Apply2Organization FROM LC_Certifications";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

		$array = array();
		$array[0] = pg_fetch_all_columns($result, 0);
		$array[1] = pg_fetch_all_columns($result, 1);
		$array[2] = pg_fetch_all_columns($result, 2);
		$array[3] = pg_fetch_all_columns($result, 3);
		$array[4] = pg_fetch_all_columns($result, 4);
		
		return $array;
	}


	public function getCertificationsForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R16_LC_Name FROM R16_JobOffer2Certifications WHERE R16_J1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setCertificationsForJobOffer($Id)
	{
		// clear
		$this->delCertificationsForJobOffer($Id);

		// set
		for( $i=0; $i < count($_POST['CertificationsList']); $i++)
		{
			$certification = trim($_POST['CertificationsList'][$i]);
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R16_JobOffer2Certifications (R16_J1_Id,R16_LC_Name) VALUES ($1,$2);  EXECUTE query('$Id','$certification');";
			$this->postgresql->getPostgreSQLObject($sqlQuery,1);
		}
	}

	public function delCertificationsForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R16_JobOffer2Certifications WHERE R16_J1_Id=$1;  EXECUTE query('$Id');";
		$this->postgresql->getPostgreSQLObject($sqlQuery,1);
	}


	public function entityHasThisCertification($EntityId,$Certification)
	{
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT R26_Q1_E1_Id FROM R26_Qualification2Certifications WHERE R26_Q1_E1_Id=$1 AND R26_LC_Name=$2 AND R26_State='Accepted';  EXECUTE query('$EntityId','$Certification');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( count($result) == 1 )
			return true;
		else
			return false;
	}
}
