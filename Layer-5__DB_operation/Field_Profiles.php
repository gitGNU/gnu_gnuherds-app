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


class FieldProfiles
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getFieldProfilesList()
	{
		$fieldProfilesIdList = $this->getFieldProfilesIdList();
		$fieldProfiles = array_combine($fieldProfilesIdList, $fieldProfilesIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		while (current($fieldProfiles))
		{
			$fieldProfiles[key($fieldProfiles)] = gettext( trim( current($fieldProfiles) ) );
			next($fieldProfiles);
		}

		// asort($fieldProfiles);  Note: We do not sort this ComboBox.

		return $fieldProfiles;
	}

	public function getFieldProfilesIdList()
	{
		$sqlQuery = "SELECT LF_Id FROM LF_FieldProfiles";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getFieldProfilesForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R21_LF_Id FROM R21_Qualification2FieldProfiles WHERE R21_Q1_E1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setFieldProfilesForEntity()
	{
		// clear
		$this->delFieldProfilesForEntity();

		// set
		for( $i=0; $i < count($_POST['FieldProfileList']); $i++)
		{
			$fieldProfile = isset($_POST['FieldProfileList'][$i]) ? trim($_POST['FieldProfileList'][$i]) : '';
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R21_Qualification2FieldProfiles (R21_Q1_E1_Id,R21_LF_Id) VALUES ($1,$2);  EXECUTE query('$_SESSION[EntityId]','$fieldProfile');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delFieldProfilesForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R21_Qualification2FieldProfiles WHERE R21_Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function getFieldProfilesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R11_LF_Id FROM R11_JobOffer2FieldProfiles WHERE R11_J1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setFieldProfilesForJobOffer($Id)
	{
		// clear
		$this->delFieldProfilesForJobOffer($Id);

		// set
		for( $i=0; $i < count($_POST['FieldProfileList']); $i++)
		{
			$fieldProfile = isset($_POST['FieldProfileList'][$i]) ? trim($_POST['FieldProfileList'][$i]) : '';
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R11_JobOffer2FieldProfiles (R11_J1_Id,R11_LF_Id) VALUES ($1,$2);  EXECUTE query('$Id','$fieldProfile');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delFieldProfilesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R11_JobOffer2FieldProfiles WHERE R11_J1_Id=$1;  EXECUTE query('$Id');";
		$this->postgresql->execute($sqlQuery,1);
	}


	public function entityHasThisFieldProfile($EntityId,$ProfileId)
	{
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT R21_Q1_E1_Id FROM R21_Qualification2FieldProfiles WHERE R21_Q1_E1_Id=$1 AND R21_LF_Id=$2;  EXECUTE query('$EntityId','$ProfileId');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( count($result) == 1 )
			return true;
		else
			return false;
	}
}
?> 
