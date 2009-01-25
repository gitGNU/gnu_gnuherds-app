<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
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
require_once "../Layer-5__DB_operation/FS_Experiences.php";

// Methods take the values form the global $_POST[] array.


class Qualifications
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getQualificationsForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT Q1_ProfessionalExperienceSinceYear,QP_LK_DesiredContractType,QP_DesiredWageRank,QP_LU_WageRankCurrency,QP_LB_WageRankByPeriod,QP_CurrentEmployability,QP_AvailableToTravel,QP_AvailableToChangeResidence,Q1_CompletedEdition FROM Q1_Qualifications WHERE Q1_E1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array = array();

		$array[0] = pg_fetch_all_columns($result, 0); // Q1_ProfessionalExperienceSinceYear
		$array[2] = pg_fetch_all_columns($result, 1); // QP_LK_DesiredContractType
		$array[3] = pg_fetch_all_columns($result, 2); // QP_DesiredWageRank
		$array[4] = pg_fetch_all_columns($result, 3); // QP_LU_WageRankCurrency
		$array[5] = pg_fetch_all_columns($result, 4); // QP_LB_WageRankByPeriod
		$array[6] = pg_fetch_all_columns($result, 5); // QP_CurrentEmployability
		$array[7] = pg_fetch_all_columns($result, 6); // QP_AvailableToTravel
		$array[8] = pg_fetch_all_columns($result, 7); // QP_AvailableToChangeResidence
		$array[10] = pg_fetch_all_columns($result, 8); // Q1_CompletedEdition

 		// The curreny name.
		$currencies = new Currencies();
		if (isset($array[4][0]) )
			$array[15] = $currencies->getCurrencyName($array[4][0]);
		else
			$array[15] = '';

		// Profiles

		$productProfiles = new ProductProfiles();
		$array[20] = $productProfiles->getProductProfilesForEntity($Id);

		$professionalProfiles = new ProfessionalProfiles();
		$array[21] = $professionalProfiles->getProfessionalProfilesForEntity($Id);

		$fieldProfiles = new FieldProfiles();
		$array[22] = $fieldProfiles->getFieldProfilesForEntity($Id);

		// Academic
		$academic = new Academic();
		$arrayAC = $academic->getAcademicForEntity($Id);
		$array[40] = $arrayAC[0];
		$array[41] = $arrayAC[1];
		$array[42] = $arrayAC[2];
		$array[43] = $arrayAC[3];
		$array[44] = $arrayAC[4];
		$array[45] = $arrayAC[5];
		$array[46] = $arrayAC[6];
		$array[47] = $arrayAC[7];

		// Certifications
		$certifications = new Certifications();
		$arrayCE = $certifications->getRequestedCertificationsForEntity($Id);
		$array[23] = $arrayCE[0];
		$array[24] = $arrayCE[1];

		// Contributions, FreeSoftwareExperiences
		$freeSoftwareExperiences = new FreeSoftwareExperiences();
		$arrayEX = $freeSoftwareExperiences->getFreeSoftwareExperiencesForEntity($Id);
		$array[25] = $arrayEX[0];
		$array[26] = $arrayEX[1];
		$array[27] = $arrayEX[2];

		// Qualification Languages table
		$languages = new Languages();
		$arrayLL = $languages->getLanguagesForEntity($Id);
		$array[28] = $arrayLL[0];
		$array[29] = $arrayLL[1];
		$array[30] = $arrayLL[2];

		// Qualification Skills table
		$skills = new Skills();
		$arrayLS = $skills->getSkillsForEntity($Id);
		$array[31] = $arrayLS[0];
		$array[32] = $arrayLS[1];
		$array[33] = $arrayLS[2];
		$array[34] = $arrayLS[3];

		return $array;
	}

	public function addQualifications($completedEdition)
	{
		// As there are several tables involved, we use a transaction to be sure, all operations are done, or nothing is done.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);


		// Qualifications

		$EntityId = isset($_SESSION['EntityId']) ? trim($_SESSION['EntityId']) : '';
		$ProfessionalExperienceSinceYear = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';

		$sqlQuery = "PREPARE query(integer,text) AS  INSERT INTO Q1_Qualifications (Q1_E1_Id,Q1_ProfessionalExperienceSinceYear) VALUES ($1,$2);  EXECUTE query('$EntityId','".pg_escape_string($ProfessionalExperienceSinceYear)."');";
		$this->postgresql->execute($sqlQuery,1);


		// Profiles
		$productProfiles = new ProductProfiles();
		$productProfiles->setProductProfilesForEntity();

		$professionalProfiles = new ProfessionalProfiles();
		$professionalProfiles->setProfessionalProfilesForEntity();

		$fieldProfiles = new FieldProfiles();
		$fieldProfiles->setFieldProfilesForEntity();

		// Saving only the first section. It is not need to update the Q1_CompletedEdition flag due to it is 'false' by default.


		$this->postgresql->execute("COMMIT",0); // Note: The result is not checked, but any error is managed by the 'query' fuction.
	}

	public function deleteQualifications()
	{
		// Delete the subscriptions to job offers
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R0_Qualifications2JobOffersJoins WHERE R0_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->execute($sqlQuery,1);

		// NotYetRequestedCertifications to requested certifications
		$certifications = new Certifications();
		$certifications->delRequestedCertificationsForEntity();

		// Profiles
		$productProfiles = new ProductProfiles();
		$productProfiles->delProductProfilesForEntity();

		$professionalProfiles = new ProfessionalProfiles();
		$professionalProfiles->delProfessionalProfilesForEntity();

		$fieldProfiles = new FieldProfiles();
		$fieldProfiles->delFieldProfilesForEntity();

		// Academic table
		$academic = new Academic();
		$academic->delAcademicForEntity();

		// Contributions/FreeSoftwareExperiences
		$freeSoftwareExperiences = new FreeSoftwareExperiences();
		$freeSoftwareExperiences->delFreeSoftwareExperiencesForEntity();

		// Languages table
		$languages = new Languages();
		$languages->delLanguagesForEntity();

		// Skills table
		$skills = new Skills();
		$skills->delSkillsForEntity();

		// Qualifications
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM Q1_Qualifications WHERE Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->execute($sqlQuery,1);
	}

	public function updateQualifications($section,$completedEdition)
	{
		// As there are several tables involved, we use a transaction to be sure, all operations are done, or nothing is done.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);


		switch($section)
		{
			case 'profiles_etc':
				// Q1_Qualifications table

				$ProfessionalExperienceSinceYear = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';

				$sqlQuery = "PREPARE query(integer,bool,integer) AS  UPDATE Q1_Qualifications SET Q1_ProfessionalExperienceSinceYear=$1,Q1_CompletedEdition=$2 WHERE Q1_E1_Id=$3;  EXECUTE query('".pg_escape_string($ProfessionalExperienceSinceYear)."','$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);

				// Profiles
				$productProfiles = new ProductProfiles();
				$productProfiles->setProductProfilesForEntity();

				$professionalProfiles = new ProfessionalProfiles();
				$professionalProfiles->setProfessionalProfilesForEntity();

				$fieldProfiles = new FieldProfiles();
				$fieldProfiles->setFieldProfilesForEntity();
			break;

			case 'academic':
				// Academic table
				$academic = new Academic();
				$academic->setAcademicForEntity();

				// Update the Q1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE Q1_Qualifications SET Q1_CompletedEdition=$1 WHERE Q1_E1_Id=$2;  EXECUTE query('$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'certifications':
				// NotYetRequestedCertifications to requested certifications
				$certifications = new Certifications();
				$certifications->setRequestedCertificationsForEntity();

				// Update the Q1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE Q1_Qualifications SET Q1_CompletedEdition=$1 WHERE Q1_E1_Id=$2;  EXECUTE query('$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'projects':
				// Contributions, FreeSoftwareExperiences
				$freeSoftwareExperiences = new FreeSoftwareExperiences();
				$freeSoftwareExperiences->setFreeSoftwareExperiencesForEntity();

				// Update the Q1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE Q1_Qualifications SET Q1_CompletedEdition=$1 WHERE Q1_E1_Id=$2;  EXECUTE query('$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'languages':
				// Languages table
				$languages = new Languages();
				$languages->setLanguagesForEntity();

				// Update the Q1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE Q1_Qualifications SET Q1_CompletedEdition=$1 WHERE Q1_E1_Id=$2;  EXECUTE query('$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'skills':
				// Skills table
				$skills = new Skills();
				$skills->setSkillsForEntity();

				// Update the Q1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE Q1_Qualifications SET Q1_CompletedEdition=$1 WHERE Q1_E1_Id=$2;  EXECUTE query('$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'location':
				// Q1_Qualifications table
				if (isset($_POST['AvailableToTravel']) and $_POST['AvailableToTravel'] == 'on')
					$AvailableToTravel = 'true';
				else	$AvailableToTravel = 'false';

				if (isset($_POST['AvailableToChangeResidence']) and $_POST['AvailableToChangeResidence'] == 'on')
					$AvailableToChangeResidence = 'true';
				else	$AvailableToChangeResidence = 'false';

				$AvailableToTravel = trim($AvailableToTravel);
				$AvailableToChangeResidence = trim($AvailableToChangeResidence);

				$sqlQuery = "PREPARE query(bool,bool,bool,integer) AS  UPDATE Q1_Qualifications SET QP_AvailableToTravel=$1,QP_AvailableToChangeResidence=$2,Q1_CompletedEdition=$3 WHERE Q1_E1_Id=$4;  EXECUTE query('$AvailableToTravel','$AvailableToChangeResidence','$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'contract':
				// Q1_Qualifications table
				$DesiredContractType = isset($_POST['DesiredContractType']) ? trim($_POST['DesiredContractType']) : '';
				$DesiredWageRank = isset($_POST['DesiredWageRank']) ? trim($_POST['DesiredWageRank']) : '';
				$WageRankCurrency = isset($_POST['WageRankCurrency']) ? trim($_POST['WageRankCurrency']) : '';
				$WageRankByPeriod = isset($_POST['WageRankByPeriod']) ? trim($_POST['WageRankByPeriod']) : '';
				$CurrentEmployability = isset($_POST['CurrentEmployability']) ? trim($_POST['CurrentEmployability']) : '';

				$sqlQuery = "PREPARE query(text,text,text,text,text,bool,integer) AS  UPDATE Q1_Qualifications SET QP_LK_DesiredContractType=$1,QP_DesiredWageRank=$2,QP_LU_WageRankCurrency=$3,QP_LB_WageRankByPeriod=$4,QP_CurrentEmployability=$5,Q1_CompletedEdition=$6 WHERE Q1_E1_Id=$7;  EXECUTE query('$DesiredContractType','".pg_escape_string($DesiredWageRank)."','".pg_escape_string($WageRankCurrency)."','$WageRankByPeriod','$CurrentEmployability','$completedEdition','{$_SESSION['EntityId']}');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			default:
				$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
				throw new Exception($error,false);
		}


		$this->postgresql->execute("COMMIT",0);
	}


	// methods to check the Access Control List

	// Check if the request comes from the Qualifications owner
	public function isOwner($E1_Id)
	{
		if ( $_SESSION['EntityId'] == $E1_Id )  // There is not need to query the Data Base  :-)
			return true;
		else
			return false;
	}

	// Check if the request comes from an Entity that has a JobOffer with such Qualifications subscribed
	public function isJobOfferApplication($E1_Id)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  SELECT count(*) FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id IN ( SELECT J1_Id FROM J1_JobOffers WHERE J1_E1_Id=$1 AND J1_ExpirationDate > 'now' ) AND R0_E1_Id=$2;  EXECUTE query('$_SESSION[EntityId]','$E1_Id');"; // AND J1_Closed='f'
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( intval($result[0]) >= 1 )
			return true;
		else
			return false;
	}
}
