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


class ProductProfiles
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getProductProfilesList()
	{
		$sqlQuery = "SELECT LX_Id FROM LX_ProductProfiles";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getProductProfilesForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R23_LX_Id FROM R23_Qualification2ProductProfiles WHERE R23_Q1_E1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setProductProfilesForEntity()
	{
		// clear
		$this->delProductProfilesForEntity();

		// set
		for( $i=0; $i < count($_POST['ProductProfileList']); $i++)
		{
			$productProfile = isset($_POST['ProductProfileList'][$i]) ? trim($_POST['ProductProfileList'][$i]) : '';
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R23_Qualification2ProductProfiles (R23_Q1_E1_Id,R23_LX_Id) VALUES ($1,$2);  EXECUTE query('$_SESSION[EntityId]','$productProfile');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delProductProfilesForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R23_Qualification2ProductProfiles WHERE R23_Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function getProductProfilesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R13_LX_Id FROM R13_JobOffer2ProductProfiles WHERE R13_J1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setProductProfilesForJobOffer($Id)
	{
		// clear
		$this->delProductProfilesForJobOffer($Id);

		// set
		for( $i=0; $i < count($_POST['ProductProfileList']); $i++)
		{
			$productProfile = isset($_POST['ProductProfileList'][$i]) ? trim($_POST['ProductProfileList'][$i]) : '';
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R13_JobOffer2ProductProfiles (R13_J1_Id,R13_LX_Id) VALUES ($1,$2);  EXECUTE query('$Id','$productProfile');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delProductProfilesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R13_JobOffer2ProductProfiles WHERE R13_J1_Id=$1;  EXECUTE query('$Id');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function entityHasThisProductProfile($EntityId,$ProfileId)
	{
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT R23_Q1_E1_Id FROM R23_Qualification2ProductProfiles WHERE R23_Q1_E1_Id=$1 AND R23_LX_Id=$2;  EXECUTE query('$EntityId','$ProfileId');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( count($result) == 1 )
			return true;
		else
			return false;
	}
}
?> 
