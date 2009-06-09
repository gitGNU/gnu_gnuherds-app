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
require_once "../Layer-5__DB_operation/Alerts.php";
require_once "../lib/PasswordHash.php";

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
		$sqlQuery = "PREPARE query(integer) AS  SELECT E1_Email,E1_Revoked,E1_EntityType,E1_Street,E1_Suite,E1_City,E1_StateProvince,E1_PostalCode,E1_LO_Country,E1_BirthYear,E1_IpPhoneOrVideo,E1_Landline,E1_MobilePhone,E1_Website,EP_FirstName,EP_LastName,EP_MiddleName,EC_CompanyName,EO_OrganizationName,E1_WantEmail,E1_Trusted,E1_Blog,EC_CooperativeName FROM E1_Entities WHERE E1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		// Note: Assuming only one register is got. Note that 'Id' is a master key.

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
		$array[10] = pg_fetch_all_columns($result, 9); // E1_BirthYear
		$array[11] = pg_fetch_all_columns($result, 10); // E1_IpPhoneOrVideo
		$array[12] = pg_fetch_all_columns($result, 11); // E1_Landline
		$array[13] = pg_fetch_all_columns($result, 12); // E1_MobilePhone
		$array[14] = pg_fetch_all_columns($result, 13); // E1_Website
		$array[15] = pg_fetch_all_columns($result, 14); // EP_FirstName
		$array[16] = pg_fetch_all_columns($result, 15); // EP_LastName
		$array[17] = pg_fetch_all_columns($result, 16); // EP_MiddleName
		$array[40] = pg_fetch_all_columns($result, 22); // EC_CooperativeName
		$array[18] = pg_fetch_all_columns($result, 17); // EC_CompanyName
		$array[19] = pg_fetch_all_columns($result, 18); // EO_OrganizationName
		$array[20] = pg_fetch_all_columns($result, 19); // E1_WantEmail
		$array[21] = pg_fetch_all_columns($result, 20); // E1_Trusted
		$array[22] = pg_fetch_all_columns($result, 21); // E1_Blog

		// LO_Name for E1_LO_Country
		if ( trim($array[8][0]) != '' )
		{
			$e1_lo_country = $array[8][0];
			$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e1_lo_country'";
			$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

			$numrows = pg_num_rows($loResult);
			if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

			if ( pg_num_rows($loResult) == '1' )
			{
				$row = pg_fetch_object($loResult, 0);
				$array[30][0] = trim($row->lo_name);
			}
		}
		else
			$array[30][0] = '';

		// Nationalities
		$nationalities = new Nationalities();
		$array[31] = $nationalities->getNationalitiesForEntity($Id);

		for( $i=0; $i < count($array[31]); $i++) // LN_Name for E3_E1_Id
		{
			if ( trim($array[31][$i]) != '' )
			{
				$e3_e1_id = $array[31][$i];
				$sqlQuery = "SELECT LN_Name FROM LN_Nationalities WHERE LN_LO_TwoLetter='$e3_e1_id'";
				$lnResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($lnResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($lnResult) == '1' )
				{
					$row = pg_fetch_object($lnResult, 0);
					$array[32][$i] = dgettext('nationalities', trim($row->ln_name));
				}
			}
			else
				$array[32][$i] = '';
		}

		// JobLicenseAt Country
		$countries = new Countries();
		$array[33] = $countries->getJobLicenseAtForEntity($Id);

		for( $i=0; $i < count($array[33]); $i++) // LO_Name for E4_E1_Id
		{
			if ( trim($array[33][$i]) != '' )
			{
				$e4_e1_id = $array[33][$i];
				$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e4_e1_id'";
				$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($loResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($loResult) == '1' )
				{
					$row = pg_fetch_object($loResult, 0);
					$array[34][$i] = dgettext('iso_3166', trim($row->lo_name));
				}
			}
			else
				$array[34][$i] = '';
		}

		return $array;
	}

	public function addEntity($magic,$entityType='Person')
	{
		// There are not several tables involved, however we use a transaction to be able to get the E1_Id, and to be sure the PhotoOrLogo has been saved rightly.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);

		$Email = trim($_POST['Email']);

		$sqlQuery = "PREPARE query(text,text) AS  INSERT INTO E1_Entities (E1_WantEmail,E1_EntityType) VALUES ($1,$2);  EXECUTE query('{$Email}','{$entityType}');"; //XXX: TODO: Only list the E1_Email, not the WantEmail(not yet verified)
		$this->postgresql->execute($sqlQuery,1);

		// Get the Id of the insert to the E1_Entities table // Ref.: http://www.postgresql.org/docs/current/static/functions-sequence.html
		$sqlQuery = "SELECT currval('E1_Entities_e1_id_seq')";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);
		$array = pg_fetch_all_columns($result,0);
		$E1_Id = $array[0];

		// Set the RegisterMagic
		// Security: The magic is only overriden for this entity.
		$sqlQuery = "PREPARE query(text,integer) AS  UPDATE E1_Entities SET E1_RegisterMagic=$1, E1_RegisterMagicExpire= now() + '2 days'::interval WHERE E1_Id=$2;  EXECUTE query('$magic',$E1_Id);";
		$this->postgresql->execute($sqlQuery,1);

		$this->savePhotoOrLogo($E1_Id);

		$alerts = new Alerts();
		$alerts->initAlertsForEntity($E1_Id);

		$this->postgresql->execute("COMMIT",0); // We do not commit if savePhotoOrLogo fails.

		return $E1_Id;
	}

	public function deleteEntity()
	{
		// There are not several tables involved, however we use a transaction to be able to be sure the PhotoOrLogo has been deleted rightly.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);

		// Delete its nationalities
		$nationalities = new Nationalities();
		$nationalities->deleteNationalitiesForEntity();

		// Delete its JobLicenseAt
		$countries = new Countries();
		$countries->deleteJobLicenseAtForEntity();

		// Delete its donations (for donation pledge groups)
		$donation = new Donation();
		$donation->cancelDonationsForEntity();

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

		$CooperativeName = isset($_POST['CooperativeName']) ? trim($_POST['CooperativeName']) : '';

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
		$Blog = trim($_POST['Blog']);

		if ( $_POST['Password'] != '' ) // Request change password too
		{
			$sqlQuery = "PREPARE query(text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,integer) AS  UPDATE E1_Entities SET E1_WantEmail=$1,E1_Password=$2,EP_FirstName=$3,EP_LastName=$4,EP_MiddleName=$5,E1_Street=$6,E1_Suite=$7,E1_City=$8,E1_StateProvince=$9,E1_PostalCode=$10,E1_LO_Country=$11,E1_IpPhoneOrVideo=$12,E1_Landline=$13,E1_MobilePhone=$14,E1_Blog=$15,E1_Website=$16,E1_BirthYear=$17,EC_CooperativeName=$18,EC_CompanyName=$19,EO_OrganizationName=$20 WHERE E1_Id=$21;  EXECUTE query('{$_SESSION['WantEmail']}','{$this->hasher->HashPassword($_POST['Password'])}','".pg_escape_string($FirstName)."','".pg_escape_string($LastName)."','".pg_escape_string($MiddleName)."','".pg_escape_string($Street)."','".pg_escape_string($Suite)."','".pg_escape_string($City)."','".pg_escape_string($StateProvince)."','".pg_escape_string($PostalCode)."','".pg_escape_string($CountryCode)."','".pg_escape_string($IpPhoneOrVideo)."','".pg_escape_string($Landline)."','".pg_escape_string($MobilePhone)."','".pg_escape_string($Blog)."','".pg_escape_string($Website)."','".pg_escape_string($BirthYear)."','".pg_escape_string($CooperativeName)."','".pg_escape_string($CompanyName)."','".pg_escape_string($NonprofitName)."','{$_SESSION['EntityId']}');";
		}
		else // Do not request change password, so we avoid to overwrite it with an empty string do not updating the E1_Password field
		{
			$sqlQuery = "PREPARE query(text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,integer) AS  UPDATE E1_Entities SET E1_WantEmail=$1,EP_FirstName=$2,EP_LastName=$3,EP_MiddleName=$4,E1_Street=$5,E1_Suite=$6,E1_City=$7,E1_StateProvince=$8,E1_PostalCode=$9,E1_LO_Country=$10,E1_IpPhoneOrVideo=$11,E1_Landline=$12,E1_MobilePhone=$13,E1_Blog=$14,E1_Website=$15,E1_BirthYear=$16,EC_CooperativeName=$17,EC_CompanyName=$18,EO_OrganizationName=$19 WHERE E1_Id=$20;  EXECUTE query('{$_SESSION['WantEmail']}','".pg_escape_string($FirstName)."','".pg_escape_string($LastName)."','".pg_escape_string($MiddleName)."','".pg_escape_string($Street)."','".pg_escape_string($Suite)."','".pg_escape_string($City)."','".pg_escape_string($StateProvince)."','".pg_escape_string($PostalCode)."','".pg_escape_string($CountryCode)."','".pg_escape_string($IpPhoneOrVideo)."','".pg_escape_string($Landline)."','".pg_escape_string($MobilePhone)."','".pg_escape_string($Blog)."','".pg_escape_string($Website)."','".pg_escape_string($BirthYear)."','".pg_escape_string($CooperativeName)."','".pg_escape_string($CompanyName)."','".pg_escape_string($NonprofitName)."','{$_SESSION['EntityId']}');";
		}
		$this->postgresql->execute($sqlQuery,1);

		// Nationalities
		$nationalities = new Nationalities();
		$nationalities->setNationalitiesForEntity();

		// JobLicenseAt
		$countries = new Countries();
		$countries->setJobLicenseAtForEntity();

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
			return $array[0]; // We take this opportunity to return the E1_Id instead of just 'true'. Note E1_Id will is always >=1, so it will be always 'true'.
		}
		else
		{
			$error = "<p>isThereEntity: ".gettext("ERROR: Unexpected condition")."</p>";
			throw new Exception($error,false);
		}
	}

	public function getEntityId($email,$requestOperation='',$offerType='',$magic='') // This method is used to get the EntityId, when the user is not logged in, or to create and get a EntityId when the user is even not registered (auto-registering). In the first case it also sends a confirmation email if a donation add has been requested
	{
		$E1_Id = $this->lookForEntity($email);

		if ( $E1_Id )
		{
			// Check if we have to send confirmation email for not logged users adding a donation, creating a notice or subscribing to a donation-pledge-group
			if ( $requestOperation == 'REQUEST_TO_ADD_NOTICE' or $requestOperation == 'REQUEST_TO_ADD_DONATION' or $requestOperation == 'REQUEST_TO_SUBSCRIBE_TO_NOTICE' )
			{
				// Send the email
				$message = gettext("Your email has been used to create, update or subscribe to a notice at GNU Herds.")."\n\n";

				$message .= gettext("Follow the below link to confirm.")." ".gettext("That link will expire in 48 hours.")."\n\n"; // If it is not confirmed it will be lost, and the creation or update process will have to begin again.

				if( $requestOperation == 'REQUEST_TO_ADD_NOTICE' )
					$message .= "https://".$_SERVER['HTTP_HOST']."/notices?action=create&email=".trim($_POST['Email'])."&magic=".$magic;

				if( $requestOperation == 'REQUEST_TO_ADD_DONATION' )
					$message .= "https://".$_SERVER['HTTP_HOST']."/pledges?action=donate&email=".trim($_POST['Email'])."&magic=".$magic;

				if( $requestOperation == 'REQUEST_TO_SUBSCRIBE_TO_NOTICE' )
					$message .= "https://".$_SERVER['HTTP_HOST']."/notices?action=subscribe&email=".trim($_POST['Email'])."&magic=".$magic;

				$message .= "\n\n";

				$message .= gettext("If you have not asked for it, ignore this email.")."\n\n";

				$message .= gettext("If this email is Spam for you, please let it knows to  association AT gnuherds.org")."\n\n";

				mb_language("uni");

				if( $requestOperation == 'REQUEST_TO_ADD_NOTICE' )
					mb_send_mail(trim($_POST['Email']), "GNU Herds: ".gettext("Notice confirmation"), "$message", "From: association@gnuherds.org");

				if( $requestOperation == 'REQUEST_TO_ADD_DONATION' )
					mb_send_mail(trim($_POST['Email']), "GNU Herds: ".gettext("Donation pledge confirmation"), "$message", "From: association@gnuherds.org");

				if( $requestOperation == 'REQUEST_TO_SUBSCRIBE_TO_NOTICE' )
					mb_send_mail(trim($_POST['Email']), "GNU Herds: ".gettext("Subscription confirmation"), "$message", "From: association@gnuherds.org");
			}

			return $E1_Id;
		}
		else
		{
			$E1_Id = $this->addEntity($magic);

			// Send the email -- TODO: Use an external method to send the emails. For example $emails->sendWarningEmail('REQUEST_TO_ADD_DONATION');
			$message = gettext("Your email has been used to create, update or subscribe to a notice at GNU Herds.")."\n\n";

			$message .= gettext("Follow the below link to confirm.")." ".gettext("That link will expire in 48 hours.")."\n\n"; // If it is not confirmed it will be lost, and the creation or update process will have to begin again.

			$message .= "https://".$_SERVER['HTTP_HOST']."/person?action=verify&email=".trim($_POST['Email'])."&magic=".$magic; // We assume the entity type is Person

			$message .= "\n\n";
			$message .= gettext("If you have not asked for it, ignore this email.")."\n\n";

			$message .= gettext("Note: To avoid 'Spam' you can only get this email at the most once each 48 hours.")." ".gettext("If this email is Spam for you, please let it knows to  association AT gnuherds.org")."\n\n";

			mb_language("uni");
			mb_send_mail(trim($_POST['Email']), "GNU Herds: ".gettext("Email verification"), "$message", "From: association@gnuherds.org");

			return $E1_Id;
		}
	}

	public function saveLostPasswordMagicForEntity($magic)
	{
		$email = trim($_POST['Email']);

		// Security: The magic is only overriden for the entity with that email.
		$sqlQuery = "PREPARE query(text,text) AS  UPDATE E1_Entities SET E1_LostPasswordMagic=$1, E1_LostPasswordMagicExpire= now() + '02:00'::interval WHERE E1_Email=$2;  EXECUTE query('$magic','{$email}');";
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
			$error = "<p>".gettext("ERROR: Wrong magic number!")."</p>";
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
			$error = "<p>".gettext("ERROR: Wrong magic number!")."</p>";
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
			$error = "<p>".gettext("ERROR: Wrong magic number!")."</p><p>".gettext("Is the activation link expired?")."</p>";
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
		return new Imagick("../entity_photos/".$Id);
	}

	private function savePhotoOrLogo($E1_Id)
	{
		if ( !empty($_FILES["PhotoOrLogo"]) and trim($_FILES["PhotoOrLogo"]["name"]) != '' )
		{
			if ( move_uploaded_file($_FILES["PhotoOrLogo"]["tmp_name"], "../entity_photos/".$E1_Id) == false )
			{
				$error = "<p>".gettext("ERROR: Can not save the uploaded file!")."</p>";
				throw new Exception($error,false);
			}

			$image = new Imagick("../entity_photos/".$E1_Id);

			if ( $_SESSION['EntityType'] == 'Person' ) // Suggested geometry
			{
				$hsize = 90;
				$vsize = 120;
			}
			elseif ( $_SESSION['EntityType'] == 'Cooperative' or $_SESSION['EntityType'] == 'Company' or $_SESSION['EntityType'] == 'non-profit Organization' )
			{
				$hsize = 180;
				$vsize = 120;
			}

			// Before scaling the image we check the width and height of the original image to avoid an image zoom.
			if ( $image->getImageWidth() > $hsize  or  $image->getImageHeight() > $vsize )
			{
				$image->scaleImage($hsize,$vsize,true);
			}

			$image->setImageFormat("PNG");
			$image->writeImage("../entity_photos/".$E1_Id);
		}
	}

	public function deletePhotoOrLogo()
	{
		if ( file_exists("../entity_photos/".$_SESSION['EntityId']) == true )
		{
			if ( unlink("../entity_photos/".$_SESSION['EntityId']) == false )
			{
				$error = "<p>".gettext("ERROR: Can not delete the photo or logo file!")."</p>";
				throw new Exception($error,false);
			}
		}
	}


	public function getAlertsLocales($alert_type)
	{
		$sqlQuery = "SELECT DISTINCT E1_Locale FROM E1_Entities,A1_Alerts WHERE E1_Id=A1_E1_Id AND A1_{$alert_type}='t';";
		$result = $this->postgresql->getOneField($sqlQuery,0);
		return $result;
	}


	public function getAlertsEmails($alert_type,$locale)
	{
		$sqlQuery = "SELECT E1_Email,A1_AlertMeOnMyOwnNotices FROM E1_Entities,A1_Alerts WHERE E1_Id=A1_E1_Id AND E1_Email IS NOT NULL AND A1_{$alert_type}='t' AND E1_Locale='$locale';";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

		$array['Email'] = pg_fetch_all_columns($result, 0);
		$array['AlertMeOnMyOwnNotices'] = pg_fetch_all_columns($result, 1);

		return $array;
	}


	public function getSkillsAdminsEmail()
	{
		$sqlQuery = "SELECT E1_Email FROM E1_Entities WHERE E1_SkillsAdmin='t';";
		$result = $this->postgresql->getOneField($sqlQuery,0);
		return $result;
	}
}
