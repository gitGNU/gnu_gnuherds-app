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


class ProfessionalProfiles
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getProfessionalProfilesList()
	{
		$professionalProfilesIdList = $this->getProfessionalProfilesIdList();
		$professionalProfiles = array_combine($professionalProfilesIdList, $professionalProfilesIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$professionalProfiles = $this->translator->t_array($professionalProfiles, 'database');
		// asort($professionalProfiles);  Note: The 'Id' is sort from the DataBase so we do not need sort this list after translate it.

		return $professionalProfiles;
	}

	public function getProfessionalProfilesIdList()
	{
		$sqlQuery = "SELECT LP_Id FROM LP_ProfessionalProfiles";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getProfessionalProfilesForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R22_LP_Id FROM R22_Qualification2ProfessionalProfiles WHERE R22_Q1_E1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setProfessionalProfilesForEntity()
	{
		// clear
		$this->delProfessionalProfilesForEntity();

		// set
		for( $i=0; $i < count($_POST['ProfessionalProfileList']); $i++)
		{
			$professionalProfile = isset($_POST['ProfessionalProfileList'][$i]) ? trim($_POST['ProfessionalProfileList'][$i]) : '';
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R22_Qualification2ProfessionalProfiles (R22_Q1_E1_Id,R22_LP_Id) VALUES ($1,$2);  EXECUTE query('$_SESSION[EntityId]','$professionalProfile');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delProfessionalProfilesForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R22_Qualification2ProfessionalProfiles WHERE R22_Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		return $this->postgresql->execute($sqlQuery,1);
	}


	public function getProfessionalProfilesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R12_LP_Id FROM R12_JobOffer2ProfessionalProfiles WHERE R12_J1_Id=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setProfessionalProfilesForJobOffer($Id)
	{
		// clear
		$this->delProfessionalProfilesForJobOffer($Id);

		// set
		for( $i=0; $i < count($_POST['ProfessionalProfileList']); $i++)
		{
			$professionalProfile = isset($_POST['ProfessionalProfileList'][$i]) ? trim($_POST['ProfessionalProfileList'][$i]) : '';
			$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO R12_JobOffer2ProfessionalProfiles (R12_J1_Id,R12_LP_Id) VALUES ($1,$2);  EXECUTE query('$Id','$professionalProfile');";
			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delProfessionalProfilesForJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R12_JobOffer2ProfessionalProfiles WHERE R12_J1_Id='$Id';  EXECUTE query('$Id');";
		return $this->postgresql->execute($sqlQuery,1);
	}


	public function entityHasThisProfessionalProfile($EntityId,$ProfileId)
	{
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT R22_Q1_E1_Id FROM R22_Qualification2ProfessionalProfiles WHERE R22_Q1_E1_Id=$1 AND R22_LP_Id=$2;  EXECUTE query('$EntityId','$ProfileId');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( count($result) == 1 )
			return true;
		else
			return false;
	}
}
?> 
