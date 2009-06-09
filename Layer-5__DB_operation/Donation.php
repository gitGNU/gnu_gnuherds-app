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
// A lot of files from the Layer-5__DB_operation directory are loaded at the Layer-4 DB_Manager.php file. So it is not needed to load it here.

// Methods take the values form the global $_POST[] array.


class Donation
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getDonators($JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT D1_Donation,E1_Email,E1_WantEmail, E1_EntityType, EP_FirstName,EP_LastName,EP_MiddleName,EC_CooperativeName,EC_CompanyName,EO_OrganizationName FROM D1_Donations2JobOffers,E1_Entities WHERE D1_E1_Id=E1_Id AND D1_J1_Id=$1 ;  EXECUTE query('$JobOfferId');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array['Donation'] = pg_fetch_all_columns($result, 0);

		$array['Email'] = pg_fetch_all_columns($result, 1);
		$array['WantEmail'] = pg_fetch_all_columns($result, 2);

		$array['EntityType'] = pg_fetch_all_columns($result, 3);

		$array['FirstName'] = pg_fetch_all_columns($result, 4);
		$array['LastName'] = pg_fetch_all_columns($result, 5);
		$array['MiddleName'] = pg_fetch_all_columns($result, 6);

		$array['CooperativeName'] = pg_fetch_all_columns($result, 7);

		$array['CompanyName'] = pg_fetch_all_columns($result, 8);

		$array['NonprofitName'] = pg_fetch_all_columns($result, 9);

		return $array;
	}


	public function getDonationsForPledgeGroup($JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT D1_Donation FROM D1_Donations2JobOffers WHERE D1_J1_Id=$1 ;  EXECUTE query('$JobOfferId');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$donations = 0;

		foreach (pg_fetch_all_columns($result,0) as $donation)
		{
			$donations = $donations + $donation;
		}

		return $donations;
	}


	public function addDonation($JobOfferId,$magic='',$EntityId='')
	{
		$WageRank = isset($_POST['WageRank']) ? trim($_POST['WageRank']) : '';

		// We do not increase the value of previous donations. We just add another donation to the notice, with the email
		// the user used.  No DELETE + INSERT, just INSERT.
		// If the user was not logged when [s]he filled the donation then [s]he have to confirm the donation clicking the
		// link sent via email.

		// If the user is logged in then the donation is already confirmed; else, we create confirmation fields.
		if ( $_SESSION['Logged'] == '1' )
		{
			// Logged in
			$EntityId = trim($_SESSION['EntityId']);

			$sqlQuery = "PREPARE query(integer,text,integer) AS  INSERT INTO D1_Donations2JobOffers (D1_J1_Id,D1_Donation,D1_E1_Id,D1_DonationMagic,D1_DonationMagicExpire) VALUES ($1,$2,$3,NULL,NULL);  EXECUTE query('$JobOfferId','".pg_escape_string($WageRank)."','$EntityId');";
		}
		else
		{
			// Not logged in.  Make the 'magic' flag if it does not already come in the $magic parameter.
			if ( $magic == '' )
			{
				$magic = md5( rand().rand().rand().rand().rand().rand().rand().rand().rand().rand().rand() );
			}

			$entity = new Entity();
			$offerType = 'Donation pledge group';

			if ( $EntityId == '' )
			{
				$EntityId = $entity->getEntityId(trim($_POST['Email']),'REQUEST_TO_ADD_DONATION',$offerType,$magic); // It registers the email or send the verification message if the address is already registered
			}

			$sqlQuery = "PREPARE query(integer,text,integer,text) AS  INSERT INTO D1_Donations2JobOffers (D1_J1_Id,D1_Donation,D1_E1_Id,D1_DonationMagic,D1_DonationMagicExpire) VALUES ($1,$2,$3,$4,now() + '7 days'::interval);  EXECUTE query('$JobOfferId','".pg_escape_string($WageRank)."','$EntityId','$magic');";
		}
		$this->postgresql->execute($sqlQuery,1);
	}


	public function confirmDonation($email,$magic)
	{
		$sqlQuery = "PREPARE query(text,text) AS  SELECT D1_Donation FROM D1_Donations2JobOffers,E1_Entities WHERE D1_E1_Id=E1_Id AND E1_Email=$1 AND D1_DonationMagic=$2 AND D1_DonationMagicExpire > 'now';  EXECUTE query('$email','$magic');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 1);

		$array = pg_fetch_all_columns($result, 0);
		$numrows = count($array);

		if ($numrows == 1)
		{
			$sqlQuery = "PREPARE query(text) AS  UPDATE D1_Donations2JobOffers SET D1_DonationMagic=NULL, D1_DonationMagicExpire=NULL WHERE D1_DonationMagic=$1;  EXECUTE query('$magic');";
			$this->postgresql->execute($sqlQuery,1);

			return true;
		}
		else
		{
			return false;
		}
	}


	public function delNonConfirmedDonations()
	{
		// This is done to clean non-confirmed donations whose time-window to confirm has expired.

		$sqlQuery = "DELETE FROM D1_Donations2JobOffers WHERE D1_DonationMagicExpire IS NOT NULL  AND  D1_DonationMagicExpire < 'now' ;";
		$this->postgresql->execute($sqlQuery,0);
	}


	public function cancelSelectedDonations()
	{
		// Cancel selected donations
		for ($i=0; $i < count($_POST['CancelDonations']); $i++)
		{
			$donationId = $_POST['DonationId'][ $_POST['CancelDonations'][$i] ];

			$sqlQuery = "PREPARE query(integer) AS  DELETE FROM D1_Donations2JobOffers WHERE D1_Id=$1;  EXECUTE query('$donationId');";
			$result = $this->postgresql->execute($sqlQuery,1);
		}

		// If after the canceling there is not any donation for a donations-pledge-group then auto-delete such donation-pledge-group
		for ($i=0; $i < count($_POST['CancelDonations']); $i++)
		{
			$jobOfferId = $_POST['JobOfferId'][ $_POST['CancelDonations'][$i] ];

			if ( $already_processed[$jobOfferId] != true ) // Avoid double-delete error
			{
				$sqlQuery = "PREPARE query(integer) AS  SELECT count(*) FROM D1_Donations2JobOffers WHERE D1_J1_Id=$1;  EXECUTE query('$jobOfferId');";
				$result = $this->postgresql->getOneField($sqlQuery,1);

				if ( intval($result[0]) == 0 )
				{
					$jobOffer = new JobOffer();
					$jobOffer->deleteJobOffer($jobOfferId); // This method tries to delete too Skills, Languages, etc. and DonationPledgeGroups do not use any of such properties. Anyway, we must not optimize this calling a custom method due to it would add duplicated source code.
				}

				$already_processed[$jobOfferId] = true;
			}
		}
	}


	public function cancelDonationsForEntity()
	{
		$donations = $this->getMyDonations();

		// Cancel donations for Entity
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM D1_Donations2JobOffers WHERE D1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->execute($sqlQuery,1);

		// If after the canceling there is not any donation for a donations-pledge-group then auto-delete such donation-pledge-group  // TODO: XXX: Almost-duplicated code. See the cancelSelectedDonations() method above.
		for ($i=0; $i < count($donations['DonationId']); $i++)
		{
			$jobOfferId = $donations['DonationPledgeGroupId'][$i];

			if ( $already_processed[$jobOfferId] != true ) // Avoid double-delete error
			{
				$sqlQuery = "PREPARE query(integer) AS  SELECT count(*) FROM D1_Donations2JobOffers WHERE D1_J1_Id=$1;  EXECUTE query('$jobOfferId');";
				$result = $this->postgresql->getOneField($sqlQuery,1);

				if ( intval($result[0]) == 0 )
				{
					$jobOffer = new JobOffer();
					$jobOffer->deleteJobOffer($jobOfferId); // This method tries to delete too Skills, Languages, etc. and DonationPledgeGroups do not use any of such properties. Anyway, we must not optimize this calling a custom method due to it would add duplicated source code.
				}

				$already_processed[$jobOfferId] = true;
			}
		}
	}


	public function getMyDonations()
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT D1_Id, D1_Donation, D1_J1_Id FROM D1_Donations2JobOffers WHERE D1_E1_Id=$1 ;  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array['DonationId'] = pg_fetch_all_columns($result, 0);
		$array['Donation'] = pg_fetch_all_columns($result, 1);
		$array['DonationPledgeGroupId'] = pg_fetch_all_columns($result, 2);

		return $array;
	}


	public function IsAlreadyDonator($EntityId,$JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  SELECT D1_J1_Id FROM D1_Donations2JobOffers WHERE D1_J1_Id=$1 AND D1_E1_Id=$2;  EXECUTE query('$JobOfferId','$EntityId');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( is_array($result) and count($result)>=1 )
			return true;
		else
			return false;
	}
}
