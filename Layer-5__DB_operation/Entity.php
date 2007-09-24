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
require_once "../Layer-5__DB_operation/lib/PasswordHash.php";
require_once "../Layer-5__DB_operation/Alerts.php";

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
		$sqlQuery = "PREPARE query(integer) AS  SELECT E1_Email,E1_Revoked,E1_EntityType,E1_Street,E1_Suite,E1_City,E1_StateProvince,E1_PostalCode,E1_LO_Country,E1_LO_Nationality,E1_BirthYear,E1_IpPhoneOrVideo,E1_Landline,E1_MobilePhone,E1_Website,EP_FirstName,EP_LastName,EP_MiddleName,EC_CompanyName,EO_OrganizationName, E1_WantEmail FROM E1_Entities WHERE E1_Id=$1;  EXECUTE query('$Id');";
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
		$array[11] = pg_fetch_all_columns($result, 11); // E1_IpPhoneOrVideo
		$array[12] = pg_fetch_all_columns($result, 12); // E1_Landline
		$array[13] = pg_fetch_all_columns($result, 13); // E1_MobilePhone
		$array[14] = pg_fetch_all_columns($result, 14); // E1_Website
		$array[15] = pg_fetch_all_columns($result, 15); // EP_FirstName
		$array[16] = pg_fetch_all_columns($result, 16); // EP_LastName
		$array[17] = pg_fetch_all_columns($result, 17); // EP_MiddleName
		$array[18] = pg_fetch_all_columns($result, 18); // EC_CompanyName
		$array[19] = pg_fetch_all_columns($result, 19); // EO_OrganizationName
		$array[20] = pg_fetch_all_columns($result, 20); // E1_WantEmail

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

	public function addEntity($magic)
	{
		// There are not several tables involved, however we use a transaction to be able to get the E1_Id, and to be sure the PhotoOrLogo has been saved rightly.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);

		$Email = trim($_POST['Email']);

		$FirstName = isset($_POST['FirstName']) ? trim($_POST['FirstName']) : '';
		$LastName = isset($_POST['LastName']) ? trim($_POST['LastName']) : '';
		$MiddleName = isset($_POST['MiddleName']) ? trim($_POST['MiddleName']) : '';

		$CompanyName = isset($_POST['CompanyName']) ? trim($_POST['CompanyName']) : '';

		$NonprofitName = isset($_POST['NonprofitName']) ? trim($_POST['NonprofitName']) : '';

		$BirthYear = isset($_POST['BirthYear']) ? trim($_POST['BirthYear']) : '';

		$Street = trim($_POST['Street']);
		$Suite = trim($_POST['Suite']);
		$City = trim($_POST['City']);
		$StateProvince = trim($_POST['StateProvince']);
		$PostalCode = trim($_POST['PostalCode']);
		$CountryCode = trim($_POST['CountryCode']);

		$IpPhoneOrVideo = trim($_POST['IpPhoneOrVideo']);
		$Landline = trim($_POST['Landline']);
		$MobilePhone = trim($_POST['MobilePhone']);

		$Website = trim($_POST['Website']);

		$Nationality = trim($_POST['Nationality']);

		$sqlQuery = "PREPARE query(text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text) AS  INSERT INTO E1_Entities (E1_WantEmail,E1_EntityType,EP_FirstName,EP_LastName,EP_MiddleName,E1_Street,E1_Suite,E1_City,E1_StateProvince,E1_PostalCode,E1_LO_Country,E1_IpPhoneOrVideo,E1_Landline,E1_MobilePhone,E1_Website,E1_LO_Nationality,E1_BirthYear,EC_CompanyName,EO_OrganizationName) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19);  EXECUTE query('{$Email}','{$_SESSION['EntityType']}','{$FirstName}','{$LastName}','{$MiddleName}','{$Street}','{$Suite}','{$City}','{$StateProvince}','{$PostalCode}','{$CountryCode}','{$IpPhoneOrVideo}','{$Landline}','{$MobilePhone}','{$Website}','{$Nationality}','{$BirthYear}','{$CompanyName}','{$NonprofitName}');";
		$this->postgresql->execute($sqlQuery,1);

		// Get the Id of the insert to the E1_Entities table // Ref.: http://www.postgresql.org/docs/current/static/functions-sequence.html
		$sqlQuery = "SELECT currval('E1_Entities_e1_id_seq')";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);
		$array = pg_fetch_all_columns($result,0);
		$E1_Id = $array[0];

		// Set the RegisterMagic
		// Security: The magic is only overriden for this entity.
		$sqlQuery = "PREPARE query(text,integer) AS  UPDATE E1_Entities SET E1_RegisterMagic=$1, E1_RegisterMagicExpire= now() + '1 days'::interval WHERE E1_Id=$2;  EXECUTE query('$magic',$E1_Id);";
		$this->postgresql->execute($sqlQuery,1);

		$this->savePhotoOrLogo($E1_Id);

		$alerts = new Alerts();
		$alerts->initAlertsForEntity($E1_Id);

		$this->postgresql->execute("COMMIT",0); // We do not commit if savePhotoOrLogo fails.
	}

	public function deleteEntity()
	{
		// There are not several tables involved, however we use a transaction to be able to be sure the PhotoOrLogo has been deleted rightly.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);

		// Delete its job offers
		$jobOffer = new JobOffer();
		$jobOffer->deleteJobOffersForEntity();

		// Delete its qualifications
		$qualifications = new Qualifications();
		$qualifications->deleteQualifications();

		// Delete the Alerts
		$alerts = new Alerts();
		$alerts->deleteAlertsForEntity();

		// Delete the entity itself
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM E1_Entities WHERE E1_Id=$1;  EXECUTE query('{$_SESSION["EntityId"]}');";
		$this->postgresql->execute($sqlQuery,1);

		$this->deletePhotoOrLogo();

		$this->postgresql->execute("COMMIT",0); // We do not commit if deletePhotoOrLogo fails.
	}

	public function updateEntity()
	{
		// There are not several tables involved, however we use a transaction to be able to be sure the PhotoOrLogo has been saved rightly.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);

		$FirstName = isset($_POST['FirstName']) ? trim($_POST['FirstName']) : '';
		$LastName = isset($_POST['LastName']) ? trim($_POST['LastName']) : '';
		$MiddleName = isset($_POST['MiddleName']) ? trim($_POST['MiddleName']) : '';

		$CompanyName = isset($_POST['CompanyName']) ? trim($_POST['CompanyName']) : '';

		$NonprofitName = isset($_POST['NonprofitName']) ? trim($_POST['NonprofitName']) : '';

		$BirthYear = isset($_POST['BirthYear']) ? trim($_POST['BirthYear']) : '';

		$Street = trim($_POST['Street']);
		$Suite = trim($_POST['Suite']);
		$City = trim($_POST['City']);
		$StateProvince = trim($_POST['StateProvince']);
		$PostalCode = trim($_POST['PostalCode']);
		$CountryCode = trim($_POST['CountryCode']);

		$IpPhoneOrVideo = trim($_POST['IpPhoneOrVideo']);
		$Landline = trim($_POST['Landline']);
		$MobilePhone = trim($_POST['MobilePhone']);

		$Website = trim($_POST['Website']);

		$Nationality = trim($_POST['Nationality']);

		if ( $_POST['Password'] != '' ) // Request change password too
		{
			$sqlQuery = "PREPARE query(text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,integer) AS  UPDATE E1_Entities SET E1_WantEmail=$1,E1_Password=$2,EP_FirstName=$3,EP_LastName=$4,EP_MiddleName=$5,E1_Street=$6,E1_Suite=$7,E1_City=$8,E1_StateProvince=$9,E1_PostalCode=$10,E1_LO_Country=$11,E1_IpPhoneOrVideo=$12,E1_Landline=$13,E1_MobilePhone=$14,E1_Website=$15,E1_LO_Nationality=$16,E1_BirthYear=$17,EC_CompanyName=$18,EO_OrganizationName=$19 WHERE E1_Id=$20;  EXECUTE query('{$_SESSION['WantEmail']}','{$this->hasher->HashPassword($_POST['Password'])}','{$FirstName}','{$LastName}','{$MiddleName}','{$Street}','{$Suite}','{$City}','{$StateProvince}','{$PostalCode}','{$CountryCode}','{$IpPhoneOrVideo}','{$Landline}','{$MobilePhone}','{$Website}','{$Nationality}','{$BirthYear}','{$CompanyName}','{$NonprofitName}','{$_SESSION['EntityId']}');";
		}
		else // Do not request change password, so we avoid to overwrite it with an empty string do not updating the E1_Password field
		{
			$sqlQuery = "PREPARE query(text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,integer) AS  UPDATE E1_Entities SET E1_WantEmail=$1,EP_FirstName=$2,EP_LastName=$3,EP_MiddleName=$4,E1_Street=$5,E1_Suite=$6,E1_City=$7,E1_StateProvince=$8,E1_PostalCode=$9,E1_LO_Country=$10,E1_IpPhoneOrVideo=$11,E1_Landline=$12,E1_MobilePhone=$13,E1_Website=$14,E1_LO_Nationality=$15,E1_BirthYear=$16,EC_CompanyName=$17,EO_OrganizationName=$18 WHERE E1_Id=$19;  EXECUTE query('{$_SESSION['WantEmail']}','{$FirstName}','{$LastName}','{$MiddleName}','{$Street}','{$Suite}','{$City}','{$StateProvince}','{$PostalCode}','{$CountryCode}','{$IpPhoneOrVideo}','{$Landline}','{$MobilePhone}','{$Website}','{$Nationality}','{$BirthYear}','{$CompanyName}','{$NonprofitName}','{$_SESSION['EntityId']}');";
		}
		$this->postgresql->execute($sqlQuery,1);

		$this->savePhotoOrLogo($_SESSION['EntityId']);

		$this->postgresql->execute("COMMIT",0); // We do not commit if savePhotoOrLogo fails.
	}

	public function updateEntityLocale()
	{
		$sqlQuery = "PREPARE query(text,integer) AS  UPDATE E1_Entities SET E1_Locale=$1 WHERE E1_Id=$2;  EXECUTE query('{$_SESSION['Language']}','{$_SESSION['EntityId']}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function lookForEntity($email)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT E1_Id FROM E1_Entities WHERE E1_Email=$1;  EXECUTE query('$email');";
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

	public function saveLostPasswordMagicForEntity($magic)
	{
		// Security: The magic is only overriden for the entity with that email.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE E1_Entities SET E1_LostPasswordMagic=$1, E1_LostPasswordMagicExpire= now() + '00:30'::interval WHERE E1_Email=$2;  EXECUTE query('$magic','{$_POST['Email']}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function saveWantEmailMagicForEntity($magic)
	{
		// Security: The magic is only overriden for the entity with that email.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE E1_Entities SET E1_WantEmailMagic=$1, E1_WantEmailMagicExpire= now() + '7 days'::interval WHERE E1_Id=$2;  EXECUTE query('$magic','{$_SESSION['EntityId']}');";
		$this->postgresql->execute($sqlQuery,1);
	}

	public function setNewPasswordForEntity()
	{
		// Check the validity of the GET parameters
		$sqlQuery = "PREPARE query(text,text) AS  SELECT count(E1_Id) FROM E1_Entities WHERE E1_Email=$1 AND E1_LostPasswordMagic=$2 AND E1_LostPasswordMagicExpire > 'now';  EXECUTE query('{$_GET['email']}','{$_GET['magic']}');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( $result[0] == "1" )
		{
			// Make new password
			$new_password = rand(0,9999);

			// Set the new password
			$hash = $this->hasher->HashPassword($new_password);
			$sqlQuery = "PREPARE query(text,text,text) AS  UPDATE E1_Entities SET E1_Password=$1, E1_LostPasswordMagic=null WHERE E1_Email=$2 AND E1_LostPasswordMagic=$3;  EXECUTE query('$hash','{$_GET['email']}','{$_GET['magic']}');";
			$this->postgresql->execute($sqlQuery,1);

			return $new_password;
		}
		else
		{
			$error = "<p>".gettext("ERROR: Wrong magic number!.")."</p>";
			throw new Exception($error,false);
		}
	}

	public function changeEmailForEntity()
	{
		// Check the validity of the GET parameters
		$sqlQuery = "PREPARE query(text,text,text) AS  SELECT count(E1_Id) FROM E1_Entities WHERE E1_WantEmail=$1 AND E1_WantEmailMagic=$2 AND E1_WantEmailMagicExpire > 'now' AND E1_Id=$3;  EXECUTE query('{$_GET['email']}','{$_GET['magic']}','{$_SESSION['EntityId']}');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( $result[0] == "1" )
		{
			// Change the email
			$sqlQuery = "PREPARE query(text,integer) AS  UPDATE E1_Entities SET E1_Email=$1, E1_WantEmail=null, E1_WantEmailMagic=null WHERE E1_Id=$2;  EXECUTE query('{$_GET['email']}','{$_SESSION['EntityId']}');";
			$this->postgresql->execute($sqlQuery,1);

			return true;
		}
		else
		{
			$error = "<p>".gettext("ERROR: Wrong magic number!.")."</p>";
			throw new Exception($error,false);
		}
	}

	public function activateAccountForEntity()
	{
		// Check the validity of the GET parameters
		$sqlQuery = "PREPARE query(text,text) AS  SELECT count(E1_Id) FROM E1_Entities WHERE E1_WantEmail=$1 AND E1_RegisterMagic=$2 AND E1_RegisterMagicExpire > 'now';  EXECUTE query('{$_GET['email']}','{$_GET['magic']}');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( $result[0] == "1" )
		{
			// Make new password
			$new_password = rand(0,9999);

			// Set the new password
			$hash = $this->hasher->HashPassword($new_password);
			$sqlQuery = "PREPARE query(text,text,text) AS  UPDATE E1_Entities SET E1_Email=E1_WantEmail, E1_WantEmail=null, E1_Password=$1, E1_RegisterMagic=null WHERE E1_WantEmail=$2 AND E1_RegisterMagic=$3;  EXECUTE query('$hash','{$_GET['email']}','{$_GET['magic']}');";
			$this->postgresql->execute($sqlQuery,1);

			return $new_password;
		}
		else
		{
			$error = "<p>".gettext("ERROR: Wrong magic number!.")."</p>";
			throw new Exception($error,false);
		}
	}

	public function allowActivateAccountEmail($email)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT count(E1_Id) FROM E1_Entities WHERE E1_Email=$1 AND E1_ActivateAccountEmail='t';  EXECUTE query('$email');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( $result[0] == "1" )
			return true;
		else
			return false;
	}

	public function allowRegisterAccountDuplicatedEmail($email)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT count(E1_Id) FROM E1_Entities WHERE E1_Email=$1 AND E1_RegisterAccountDuplicatedEmail='t';  EXECUTE query('$email');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( $result[0] == "1" )
			return true;
		else
			return false;
	}

	public function allowLostPasswordEmail($email)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT count(E1_Id) FROM E1_Entities WHERE E1_Email=$1 AND E1_LostPasswordEmail='t';  EXECUTE query('$email');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( $result[0] == "1" )
			return true;
		else
			return false;
	}

	public function getEntityPhotoOrLogo($Id)
	{
		return imagecreatefrompng("../entity_photos/".$Id);
	}

	private function savePhotoOrLogo($E1_Id)
	{
		if ( !empty($_FILES["PhotoOrLogo"]) and trim($_FILES["PhotoOrLogo"]["name"]) != '' )
		{
			if ( move_uploaded_file($_FILES["PhotoOrLogo"]["tmp_name"], "../entity_photos/".$E1_Id) == false )
			{
				$error = "<p>".gettext("ERROR: Can not save the uploaded file!.")."</p>";
				throw new Exception($error,false);
			}

			$handle = imagick_readimage("../entity_photos/".$E1_Id);
			if ( imagick_iserror($handle) )
			{
				$reason      = imagick_failedreason($handle);
				$description = imagick_faileddescription($handle);

				$error = "<p>"."image handle failed!<BR>\nReason: $reason<BR>\nDescription: $description<BR>"."</p>";
				throw new Exception($error,false);
			}

			imagick_convert($handle,"PNG");

			if ( $_SESSION['EntityType'] == 'Person' ) // Suggested geometry
			{
				$hsize = 90;
				$vsize = 120;
			}
			elseif ( $_SESSION['EntityType'] == 'Company' or $_SESSION['EntityType'] == 'non-profit Organization' )
			{
				$hsize = 180;
				$vsize = 120;
			}

			// Before resizing we check the width and height of the original image to avoid an image zoom.

			$size = getimagesize("../entity_photos/".$E1_Id);
			$width  = $size[0];
			$height = $size[1];

			if ( $width > $hsize  or  $height > $vsize )
			{
				if ( !imagick_resize($handle,$hsize,$vsize,IMAGICK_FILTER_UNKNOWN,0) )
				{
					$reason      = imagick_failedreason($handle);
					$description = imagick_faileddescription($handle);

					$error = "<p>"."imagick_resize() failed<BR>\nReason: $reason<BR>\nDescription: $description<BR>"."</p>";
					throw new Exception($error,false);
				}
			}

			if ( !imagick_writeimage($handle,"../entity_photos/".$E1_Id) )
			{
				$reason      = imagick_failedreason($handle);
				$description = imagick_faileddescription($handle);

				$error = "<p>"."imagick_writeimage() failed<BR>\nReason: $reason<BR>\nDescription: $description<BR>"."</p>";
				throw new Exception($error,false);
			}
		}
	}

	public function deletePhotoOrLogo()
	{
		if ( file_exists("../entity_photos/".$_SESSION['EntityId']) == true )
		{
			if ( unlink("../entity_photos/".$_SESSION['EntityId']) == false )
			{
				$error = "<p>".gettext("ERROR: Can not delete the photo or logo file!.")."</p>";
				throw new Exception($error,false);
			}
		}
	}


	public function getNewJobOfferAlertsLocales()
	{
		$sqlQuery = "SELECT DISTINCT E1_Locale FROM E1_Entities,A1_Alerts WHERE E1_Id=A1_E1_Id AND A1_NewJobOffer='t';";
		$result = $this->postgresql->getOneField($sqlQuery,0);
		return $result;
	}


	public function getNewJobOfferAlertsEmails($locale)
	{
		$sqlQuery = "SELECT E1_Email FROM E1_Entities,A1_Alerts WHERE E1_Id=A1_E1_Id AND A1_NewJobOffer='t' AND E1_Locale='$locale';";
		$result = $this->postgresql->getOneField($sqlQuery,0);
		return $result;
	}
}
?> 
