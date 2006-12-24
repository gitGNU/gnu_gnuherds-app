<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>
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
require_once "../Layer-5__DB_operation/lib/PasswordHash.php";

// Methods take the values form the global $_POST[] array.


class Entity
{
	private $postgresql;
	private $hasher;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->hasher = new PasswordHash(8, FALSE);
	}


	public function getEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT E1_Email,E1_Revoked,E1_EntityType,E1_Street,E1_Suite,E1_City,E1_StateProvince,E1_PostalCode,E1_LO_Country,E1_LO_Nationality,E1_BirthYear,E1_IpPhoneOrVideo,E1_Landline,E1_MobilePhone,E1_Website,EP_FirstName,EP_LastName,EP_MiddleName,EC_CompanyName,EO_OrganizationName FROM E1_Entities WHERE E1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array = array();

		$array[0] = pg_fetch_all_columns($result, 0); // E1_Email
		$array[1] = pg_fetch_all_columns($result, 1); // E1_Revoked
		$array[2] = pg_fetch_all_columns($result, 2); // E1_EntityType
		$array[3] = pg_fetch_all_columns($result, 3); // E1_Street
		$array[4] = pg_fetch_all_columns($result, 4); // E1_Suite
		$array[5] = pg_fetch_all_columns($result, 5); // E1_City
		$array[6] = pg_fetch_all_columns($result, 6); // E1_StateProvince
		$array[7] = pg_fetch_all_columns($result, 7); // E1_PostalCode
		$array[8] = pg_fetch_all_columns($result, 8); // E1_LO_Country
		$array[9] = pg_fetch_all_columns($result, 9); // E1_LO_Nationality
		$array[10] = pg_fetch_all_columns($result, 10); // E1_BirthYear
		$array[12] = pg_fetch_all_columns($result, 11); // E1_IpPhoneOrVideo
		$array[13] = pg_fetch_all_columns($result, 12); // E1_Landline
		$array[14] = pg_fetch_all_columns($result, 13); // E1_MobilePhone
		$array[15] = pg_fetch_all_columns($result, 14); // E1_Website
		$array[16] = pg_fetch_all_columns($result, 15); // EP_FirstName
		$array[17] = pg_fetch_all_columns($result, 16); // EP_LastName
		$array[18] = pg_fetch_all_columns($result, 17); // EP_MiddleName
		$array[19] = pg_fetch_all_columns($result, 18); // EC_CompanyName
		$array[20] = pg_fetch_all_columns($result, 19); // EO_OrganizationName

		for( $i=0; $i < count($array[0]); $i++) // LO_Name for E1_LO_Country
		{
			if ( trim($array[8][$i]) != '' )
			{
				$e1_lo_country = $array[8][$i];
				$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e1_lo_country'";
				$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($loResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($loResult) == '1' )
				{
					$row = pg_fetch_object($loResult, 0);
					$array[30][$i] = trim($row->lo_name);
				}
			}
			else
				$array[30][$i] = '';
		}

		for( $i=0; $i < count($array[0]); $i++) // LO_Name for E1_LO_Nationality
		{
			if ( trim($array[9][$i]) != '' )
			{
				$e1_lo_nationality = $array[9][$i];
				$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e1_lo_nationality'";
				$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($loResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($loResult) == '1' )
				{
					$row = pg_fetch_object($loResult, 0);
					$array[31][$i] = trim($row->lo_name);
				}
			}
			else
				$array[31][$i] = '';
		}

		return $array;
	}

	public function addEntity()
	{
		$sqlQuery = "PREPARE query(text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text) AS  INSERT INTO E1_Entities (E1_Email,E1_Password,E1_EntityType,EP_FirstName,EP_LastName,EP_MiddleName,E1_Street,E1_Suite,E1_City,E1_StateProvince,E1_PostalCode,E1_LO_Country,E1_IpPhoneOrVideo,E1_Landline,E1_MobilePhone,E1_Website,E1_LO_Nationality,E1_BirthYear,EC_CompanyName,EO_OrganizationName) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20);  EXECUTE query('{$_POST['Email']}','{$this->hasher->HashPassword($_POST['Password'])}','{$_SESSION['EntityType']}','{$_POST['FirstName']}','{$_POST['LastName']}','{$_POST['MiddleName']}','{$_POST['Street']}','{$_POST['Suite']}','{$_POST['City']}','{$_POST['StateProvince']}','{$_POST['PostalCode']}','{$_POST['CountryCode']}','{$_POST['IpPhoneOrVideo']}','{$_POST['Landline']}','{$_POST['MobilePhone']}','{$_POST['Website']}','{$_POST['Nationality']}','{$_POST['BirthYear']}','{$_POST['CompanyName']}','{$_POST['NonprofitName']}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function deleteEntity()
	{
		// Delete its job offers
		$jobOffer = new JobOffer();
		$jobOffer->deleteJobOffersForEntity();

		// Delete its qualifications
		$qualifications = new Qualifications();
		$qualifications->deleteQualifications();

		// Delete the entity itself
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM E1_Entities WHERE E1_Id=$1;  EXECUTE query('{$_SESSION["EntityId"]}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function updateEntity()
	{
		$FirstName = isset($_POST['FirstName']) ? $_POST['FirstName'] : '';
		$LastName = isset($_POST['LastName']) ? $_POST['LastName'] : '';
		$MiddleName = isset($_POST['MiddleName']) ? $_POST['MiddleName'] : '';

		$CompanyName = isset($_POST['CompanyName']) ? $_POST['CompanyName'] : '';

		$NonprofitName = isset($_POST['NonprofitName']) ? $_POST['NonprofitName'] : '';

		$BirthYear = isset($_POST['BirthYear']) ? $_POST['BirthYear'] : '';

		$sqlQuery = "PREPARE query(text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,integer) AS  UPDATE E1_Entities SET E1_Email=$1,E1_Password=$2,EP_FirstName=$3,EP_LastName=$4,EP_MiddleName=$5,E1_Street=$6,E1_Suite=$7,E1_City=$8,E1_StateProvince=$9,E1_PostalCode=$10,E1_LO_Country=$11,E1_IpPhoneOrVideo=$12,E1_Landline=$13,E1_MobilePhone=$14,E1_Website=$15,E1_LO_Nationality=$16,E1_BirthYear=$17,EC_CompanyName=$18,EO_OrganizationName=$19 WHERE E1_Id=$20;  EXECUTE query('{$_POST['Email']}','{$this->hasher->HashPassword($_POST['Password'])}','{$FirstName}','{$LastName}','{$MiddleName}','{$_POST['Street']}','{$_POST['Suite']}','{$_POST['City']}','{$_POST['StateProvince']}','{$_POST['PostalCode']}','{$_POST['CountryCode']}','{$_POST['IpPhoneOrVideo']}','{$_POST['Landline']}','{$_POST['MobilePhone']}','{$_POST['Website']}','{$_POST['Nationality']}','{$BirthYear}','{$CompanyName}','{$NonprofitName}','{$_SESSION['EntityId']}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function lookForEntity()
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT E1_Id FROM E1_Entities WHERE E1_Email=$1;  EXECUTE query('$_POST[Email]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 1);

		$array = pg_fetch_all_columns($result, 0);
		$numrows = count($array);

		if ($numrows == 0)
		{
			return false;
		}
		elseif ($numrows == 1)
		{
			return true;
		}
		else
		{
			$error = "<p>isThereEntity: ".gettext("Unexpected error")."</p>";
			throw new Exception($error,false);
		}
	}

	public function saveMagicForEntity($magic)
	{
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE E1_Entities SET E1_Magic=$1 WHERE E1_Email=$2;  EXECUTE query('$magic','$_POST[Email]');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function setNewPasswordForEntity()
	{
		// Check the validity of the GET parameters
		$sqlQuery = "PREPARE query(text,text) AS  SELECT count(E1_Id) FROM E1_Entities WHERE E1_Email=$1 AND E1_Magic=$2;  EXECUTE query('$_GET[email]','$_GET[magic]');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( $result[0] == "1" )
		{
			// Make new password
			$new_password = rand(0,9999);

			// Set the new password
			$hash = $this->hasher->HashPassword($new_password);
			$sqlQuery = "PREPARE query(text,text,text) AS  UPDATE E1_Entities SET E1_Password=$1, E1_Magic=null WHERE E1_Email=$2 AND E1_Magic=$3;  EXECUTE query('$hash','$_GET[email]','$_GET[magic]');";
			$this->postgresql->execute($sqlQuery,1);

			return $new_password;
		}
		else
		{
			$error = "<p>".gettext("ERROR: Wrong magic number!.")."</p>";
			throw new Exception($error,false);
		}
	}
}
?> 
