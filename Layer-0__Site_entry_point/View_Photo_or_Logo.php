<?php
// Authors: Davi Leal
// 
// Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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


// We have to use SSL for encryption of the password, PHPSESSID, etc., because else
// it is sent to the web server as plain text.
// Insert the following code snipet into the top of secure page.
if ( !isset($_SERVER['HTTPS']) || $_SERVER['HTTPS']!="on" )
{
	header("Location: https://$_SERVER[SERVER_NAME]$_SERVER[REQUEST_URI]");
	exit;
}


session_start();

$viewPhotoOrLogo = new __ViewPhotoOrLogo();
$viewPhotoOrLogo->viewPhotoOrLogo();



//=============================================================================
// We have to write here the external classes due to if we load it via 'require_once' the bytes sent to the browser are not the same, maybe something is added, and therefore the browser refuses to show the PNG image. It it a pity, and will be a maintenance nighmare that we have to duplicate this source code  :P  .  If you have a better solution, please, let us know.

// Note: We use the '__' prefix here to avoid the problems which arise due to conflicts with the actual classes that use the same names.



// This class to be created at "../Layer-2__Business_logic/others/View_Photo_or_Logo.php" and loaded via 'require_once'.
class __ViewPhotoOrLogo
{
	private function checkParameters()
	{
		// Data         = Me, Qualifications or JobOffer
		// EntityId     = EntityId

		if ( ($_GET['Data'] != "Me" and $_GET['Data'] != "Qualifications" and $_GET['Data'] != "JobOffer")  or  $_GET['EntityId'] == '' )
		{
			echo "Wrong parameters";
			exit;
		}
	}

	public function viewPhotoOrLogo()
	{
		$manager = new __DBManager();

		// Check parameters and then we ask to the DB manager for the PNG image.
		$this->checkParameters();

		// Ask to the DB manager for the PNG image.
		if ( $_GET['Data'] == "Me" )
			$im = $manager->getEntityPhotoOrLogo($_SESSION['EntityId']);
		elseif ( $_GET['Data'] == "Qualifications" )
			$im = $manager->getQualificationsPhotoOrLogoForEntity($_GET['EntityId']);
		elseif ( $_GET['Data'] == "JobOffer" )
			$im = $manager->getJobOfferPhotoOrLogoForEntity($_GET['EntityId']);

		// Send the image to the web browser.
		ob_start("pngOutputHandler");
		imagepng($im,NULL);
		ob_end_flush();
	}
}

// This function have to be outside the ViewPhotoOrLogo class, else the PNG format will be wrong and the browser, at least FireFox 1.5, will not show it.
function pngOutputHandler($img)
{
	header('Content-Type: image/png');
	header('Content-Length: ' . strlen($img));
	return $img;
}


// This class is already at "../Layer-4__DBManager_etc/DB_Manager.php". It should have been loaded via 'require_once' with the below new methods added.
class __DBManager
{
	public function getEntityPhotoOrLogo($Id)
	{
		$acl = new __AccessControlList();
		$acl->checkProperlyLogged();

		$entity = new __Entity();
		return $entity->getEntityPhotoOrLogo($Id);
	}

	public function getQualificationsPhotoOrLogoForEntity($Id)
	{
		$acl = new __AccessControlList();
		$acl->checkQualificationsAccess("READ",$Id);

		$entity = new __Entity();
		return $entity->getEntityPhotoOrLogo($Id);
	}

	public function getJobOfferPhotoOrLogoForEntity($Id)
	{
		$acl = new __AccessControlList();
		$acl->checkEntityAccess("READ",$Id);

		$entity = new __Entity();
		return $entity->getEntityPhotoOrLogo($Id);
	}
}


// This class is already at "../Layer-4__DBManager_etc/Access_Control_List.php". It should have been loaded via 'require_once'.
class __AccessControlList
{
	private function granted()
	{
	}

	private function notGranted()
	{
		$error = "<p>".gettext('The access is not granted.')."</p>";
		throw new Exception($error,true);
	}

	public function checkProperlyLogged()
	{
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>".gettext('To access this section you have to login first.')."</p>";
				throw new Exception($error,false);
			}
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
    		}
	}


	public function checkQualificationsAccess($mode,$E1_Id)
	{
		$this->checkProperlyLogged();

		$qualifications = new __Qualifications();

		switch ($mode) {
			case "READ": // Data Base operations: get
				if ( // Check if the request comes from the Qualifications owner
				     $qualifications->isOwner($E1_Id) == true
					or
				     // Check if the request comes from an Entity that has a JobOffer with such Qualifications subscribed
				     $qualifications->isJobOfferApplication($E1_Id) == true
				   )
					$this->granted();
				else
					$this->notGranted();

				break;

		//	case "WRITE": // Data Base operations: add, delete, update
		//		$this->notGranted();
		//		break;

			default:
				$this->notGranted();
		}
	}


	public function checkEntityAccess($mode,$E1_Id)
	{
		$jobOffer = new __JobOffer();

		switch ($mode) {
			case "READ": // Data Base operations: get
				if ( $jobOffer->hasJobOfferPublished($E1_Id) == true ) // Check if the E1_Id entity has some job offer published
					$this->granted();
				else
					$this->notGranted();

				break;

		//	case "WRITE": // Data Base operations: add, delete, update
		//		$this->notGranted();
		//		break;

			default:
				$this->notGranted();
		}
	}
}


// This class is already at "../Layer-5__DB_operation/Entity.php". It should have been loaded via 'require_once' with the below new methods added.
class __Entity
{
	public function getEntityPhotoOrLogo($Id)
	{
		return imagecreatefrompng("../entity_photos/".$Id);
	}
}


// This class is already at "../Layer-5__DB_operation/Qualifications.php". It should have been loaded via 'require_once' with the below new methods added.
class __Qualifications
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new __PostgreSQL();
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


// This class is already at "../Layer-5__DB_operation/Job_Offer.php". It should have been loaded via 'require_once' with the below new methods added.
class __JobOffer
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new __PostgreSQL();
	}


	// methods to check the Access Control List

	// Check if the E1_Id entity has some job offer published
	public function hasJobOfferPublished($E1_Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT count(*) FROM J1_JobOffers WHERE J1_E1_Id=$1 AND J1_Closed='f' AND J1_ExpirationDate > 'now';  EXECUTE query('$E1_Id');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( intval($result[0]) >= 1 )
			return true;
		else
			return false;
	}
}


// This class is already at "../Layer-5__DB_operation/PostgreSQL.php". It should have been loaded via 'require_once'.
class __PostgreSQL
{
	public function getOneField($sqlQuery,$prepared)
	{
		$result = $this->getPostgreSQLObject($sqlQuery,$prepared);
		return pg_fetch_all_columns($result, 0); // We do not return the PostgreSQL object result but an array ready to be used by the Smarty templates
	}

	public function execute($sqlQuery,$prepared)
	{
		$this->getPostgreSQLObject($sqlQuery,$prepared);
	}

	public function getPostgreSQLObject($sqlQuery,$prepared=0)
	{
		// Connect
		$GLOBALS["PG_CONNECT"] = pg_connect("dbname=www.gnuherds.org user=www-data");
		if (!$GLOBALS["PG_CONNECT"])
		{
			$error = "<p>ERROR: Connection to database failed.</p>\n";
			throw new Exception($error,false);
		}

		// Check the connection
		if (!$GLOBALS["PG_CONNECT"])
			return 0;

		// Launch the query
		$lev=error_reporting (8); // NO WARRING!!
		// echo $sqlQuery."  <br>";; // DEBUG
		$result = pg_query ($sqlQuery);
		error_reporting ($lev); // DEFAULT!!

		// Check for query error
		if (strlen ($r=pg_last_error ($GLOBALS["PG_CONNECT"])))
		{
			$error = "ERROR:<pre> {$sqlQuery} </pre> {$r}"; // DEBUG
			// $error = "$r"; // No DEBUG
			throw new Exception($error,true);
		}

		if ( $prepared == 1 )
		{
			// Deallocate the prepared statement
			// echo "DEALLOCATE query;  <br>"; // DEBUG
			pg_query ("DEALLOCATE query;");
			error_reporting ($lev);

			// Check for query error
			if (strlen ($r=pg_last_error ($GLOBALS["PG_CONNECT"])))
			{
				$error = "ERROR:<pre> {$sqlQuery} </pre> {$r}"; // DEBUG
				// $error = "$r"; // No DEBUG
				throw new Exception($error,true);
			}
		}

		return $result;
	}
}
?>
