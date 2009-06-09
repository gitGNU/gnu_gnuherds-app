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


class JobOffer
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getJobOffersForEntity($extra_condition = '')
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT J1_Id,J1_OfferDate,J1_ExpirationDate,J1_Closed,J1_VacancyTitle,J1_OfferType,J1_Visits FROM J1_JobOffers WHERE J1_E1_Id=$1 ".$extra_condition.";  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);
		$array = array();
		$array[0] = pg_fetch_all_columns($result, 0);
		$array[1] = pg_fetch_all_columns($result, 1);
		$array[2] = pg_fetch_all_columns($result, 2);
		$array[3] = pg_fetch_all_columns($result, 3);

		$array[4] = pg_fetch_all_columns($result, 4);

		for( $i=0; $i < count($array[0]); $i++)
			if ( $array[4][$i] == '' )
				$array[4][$i] = $this->makeUp_VacancyTitle($array[0][$i]);

		$array[5] = pg_fetch_all_columns($result, 5);
		$array[6] = pg_fetch_all_columns($result, 6);

		return $array;
	}

	public function getJobOffers($extra_condition = '')
	{
		$sqlQuery = "SELECT J1_Id, J1_LO_Country,J1_StateProvince,J1_City, J1_OfferType,J1_OfferDate, E1_Id,E1_EntityType, E1_Blog, E1_Website, EP_FirstName,EP_LastName,EP_MiddleName, EC_CooperativeName, EC_CompanyName, EO_OrganizationName, J1_VacancyTitle, E1_Email,E1_WantEmail FROM J1_JobOffers,E1_Entities WHERE J1_E1_Id=E1_Id AND J1_CompletedEdition='t' AND J1_Closed='f' AND J1_ExpirationDate > 'now' AND J1_CreationMagic IS NULL ".$extra_condition;
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

		$array['JobOfferId'] = pg_fetch_all_columns($result, 0);

		$array['Country'] = pg_fetch_all_columns($result, 1);
		for( $i=0; $i < count($array['Country']); $i++)
		{
			if ( trim($array['Country'][$i]) != '' )
			{
				$e1_lo_country = $array['Country'][$i];
				$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e1_lo_country'";
				$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($loResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($loResult) == '1' )
				{
					$row = pg_fetch_object($loResult, 0);
					$array['Country'][$i] = trim($row->lo_name);
				}
			}
			else
				$array['Country'][$i] = '';
		}

		$array['StateProvince'] = pg_fetch_all_columns($result, 2);
		$array['City'] = pg_fetch_all_columns($result, 3);

		$array['OfferType'] = pg_fetch_all_columns($result, 4);
		$array['OfferDate'] = pg_fetch_all_columns($result, 5);

		$array['EntityId'] = pg_fetch_all_columns($result, 6);
		$array['EntityType'] = pg_fetch_all_columns($result, 7);

		$array['Email'] = pg_fetch_all_columns($result, 17);
		$array['WantEmail'] = pg_fetch_all_columns($result, 18);

		$array['Blog'] = pg_fetch_all_columns($result, 8);
		$array['Website'] = pg_fetch_all_columns($result, 9);

		$array['FirstName'] = pg_fetch_all_columns($result, 10);
		$array['LastName'] = pg_fetch_all_columns($result, 11);
		$array['MiddleName'] = pg_fetch_all_columns($result, 12);

		$array['CooperativeName'] = pg_fetch_all_columns($result, 13);
		$array['CompanyName'] = pg_fetch_all_columns($result, 14);
		$array['OrganizationName'] = pg_fetch_all_columns($result, 15);

		$array['VacancyTitle'] = pg_fetch_all_columns($result, 16);

		for( $i=0; $i < count($array['JobOfferId']); $i++)
			if ( $array['VacancyTitle'][$i] == '' )
				$array['VacancyTitle'][$i] = $this->makeUp_VacancyTitle($array['JobOfferId'][$i]);

		return $array;
	}


	public function getJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT J1_EmployerJobOfferReference,J1_OfferDate,J1_ExpirationDate,J1_Closed,J1_HideEmployer,J1_AllowPersonApplications,J1_AllowCompanyApplications,J1_AllowOrganizationApplications,J1_Vacancies,J1_LK_ContractType,J1_WageRank,J1_LU_Currency,J1_LB_WageRankByPeriod,J1_ProfessionalExperienceSinceYear,J1_LA_Id,J1_FreeSoftwareProjects,J1_City,J1_StateProvince,J1_LO_Country,J1_AvailableToTravel,J1_LO_JobLicenseAt,J1_EstimatedEffort,J1_LM_TimeUnit,J1_E1_Id,J1_CompletedEdition,J1_Deadline,J1_VacancyTitle,J1_Description,J1_OfferType,J1_AllowCooperativeApplications,J1_Negotiable FROM J1_JobOffers WHERE J1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array = array();

		$array[26] = pg_fetch_all_columns($result, 23); // J1_E1_Id
		$array[27] = pg_fetch_all_columns($result, 24); // J1_CompletedEdition

		$array[0] = pg_fetch_all_columns($result, 0); // J1_EmployerJobOfferReference
		$array[1] = pg_fetch_all_columns($result, 1); // J1_OfferDate
		$array[2] = pg_fetch_all_columns($result, 2); // J1_ExpirationDate
		$array[3] = pg_fetch_all_columns($result, 3); // J1_Closed
		$array[4] = pg_fetch_all_columns($result, 4); // J1_HideEmployer

		$array[5] = pg_fetch_all_columns($result, 5); // J1_AllowPersonApplications
		$array[55]= pg_fetch_all_columns($result,29); // J1_AllowCooperativeApplications
		$array[6] = pg_fetch_all_columns($result, 6); // J1_AllowCompanyApplications
		$array[7] = pg_fetch_all_columns($result, 7); // J1_AllowOrganizationApplications

		$array[8] = pg_fetch_all_columns($result, 8); // J1_Vacancies

		$array[9] = pg_fetch_all_columns($result, 9); // J1_LK_ContractType
		$array[10] = pg_fetch_all_columns($result, 10); // J1_WageRank

		$array[11] = pg_fetch_all_columns($result, 11); // J1_LU_Currency

		if ( trim($array[11][0]) != '' )
		{
			$j1_lu_currency = $array[11][0];
			$sqlQuery = "SELECT LU_PluralName FROM LU_Currencies WHERE LU_ThreeLetter='$j1_lu_currency'";
			$luResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

			$numrows = pg_num_rows($luResult);
			if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

			if ( pg_num_rows($luResult) == '1' )
			{
				$row = pg_fetch_object($luResult, 0);
				$array[12][0] = trim($row->lu_pluralname); // LU_PluralName
			}
		}
		else
			$array[12][0] = '';

		$array[13] = pg_fetch_all_columns($result, 12); // J1_LB_WageRankByPeriod
		$array[23] = pg_fetch_all_columns($result, 21); // J1_EstimatedEffort
		$array[24] = pg_fetch_all_columns($result, 22); // J1_LM_TimeUnit
		$array[28] = pg_fetch_all_columns($result, 25); // J1_Deadline
		$array[130] = pg_fetch_all_columns($result, 30); // J1_Negotiable

		$array[14] = pg_fetch_all_columns($result, 13); // J1_ProfessionalExperienceSinceYear
		$array[15] = pg_fetch_all_columns($result, 14); // J1_LA_Id
		$array[16] = pg_fetch_all_columns($result, 15); // J1_FreeSoftwareProjects

		$array[18] = pg_fetch_all_columns($result, 16); // J1_City
		$array[19] = pg_fetch_all_columns($result, 17); // J1_StateProvince
		$array[20] = pg_fetch_all_columns($result, 18); // J1_LO_Country

		$array[21] = pg_fetch_all_columns($result, 19); // J1_AvailableToTravel

		$array[22] = pg_fetch_all_columns($result, 20); // J1_LO_JobLicenseAt

		for( $i=0; $i < count($array[20]); $i++) // LO_Name
		{
			if ( trim($array[20][$i]) != '' )
			{
				$e1_lo_country = $array[20][$i];
				$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e1_lo_country'";
				$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($loResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($loResult) == '1' )
				{
					$row = pg_fetch_object($loResult, 0);
					$array[25][$i] = trim($row->lo_name);
				}
			}
			else
				$array[25][$i] = '';
		}


		// Profiles

		$productProfiles = new ProductProfiles();
		$array[30] = $productProfiles->getProductProfilesForJobOffer($Id);

		$professionalProfiles = new ProfessionalProfiles();
		$array[31] = $professionalProfiles->getProfessionalProfilesForJobOffer($Id);

		$fieldProfiles = new FieldProfiles();
		$array[32] = $fieldProfiles->getFieldProfilesForJobOffer($Id);

		// Certifications
		$certifications = new Certifications();
		$array[50] = $certifications->getCertificationsForJobOffer($Id);

		// Languages table
		$languages = new Languages();
		$arrayLL = $languages->getLanguagesForJobOffer($Id);
		$array[40] = $arrayLL[0];
		$array[41] = $arrayLL[1];
		$array[42] = $arrayLL[2];

		// Skills table
		$skills = new Skills();
		$arrayLS = $skills->getSkillsForJobOffer($Id);
		$array[43] = $arrayLS[0];
		$array[44] = $arrayLS[1];
		$array[45] = $arrayLS[2];
		$array[46] = $arrayLS[3];

		$array[60] = pg_fetch_all_columns($result, 26); // J1_VacancyTitle

		if ( $array[60][0] == '' )
			$array[60][0] = $this->makeUp_VacancyTitle($Id);

		$array[61] = pg_fetch_all_columns($result, 27); // J1_Description

		$array[62] = pg_fetch_all_columns($result, 28); // J1_OfferType

		return $array;
	}

	public function increaseVisits($JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer) AS  UPDATE J1_JobOffers SET J1_Visits=J1_Visits+1 WHERE J1_Id=$1;  EXECUTE query('$JobOfferId');";
		$result = $this->postgresql->execute($sqlQuery,1);
	}


	public function addJobOffer($offerType,$completedEdition,$magic='')
	{
		// As there are several tables involved, we use a transaction to be sure, all operations are done, or nothing is done.


		// J1_JobOffers table

		$entity = new Entity();
		$EntityId = isset($_SESSION['EntityId']) ? trim($_SESSION['EntityId']) : $entity->getEntityId(trim($_POST['Email']),'REQUEST_TO_ADD_NOTICE',$offerType,$magic); // It registers the email and send the verification email if it is needed

		$EmployerJobOfferReference = isset($_POST['EmployerJobOfferReference']) ? trim($_POST['EmployerJobOfferReference']) : '';

		$ExpirationDate = isset($_POST['ExpirationDate']) ? trim($_POST['ExpirationDate']) : '';

		if (isset($_POST['Closed']) and $_POST['Closed'] == 'on')
			$Closed = 'true';
		else	$Closed = 'false';

		if (isset($_POST['HideEmployer']) and $_POST['HideEmployer'] == 'on')
			$HideEmployer = 'true';
		else	$HideEmployer = 'false';

		if (isset($_POST['AllowPersonApplications']) and $_POST['AllowPersonApplications'] == 'on')
			$AllowPersonApplications = 'true';
		else	$AllowPersonApplications = 'false';

		if (isset($_POST['AllowCooperativeApplications']) and $_POST['AllowCooperativeApplications'] == 'on')
			$AllowCooperativeApplications = 'true';
		else	$AllowCooperativeApplications = 'false';

		if (isset($_POST['AllowCompanyApplications']) and $_POST['AllowCompanyApplications'] == 'on')
			$AllowCompanyApplications = 'true';
		else	$AllowCompanyApplications = 'false';

		if (isset($_POST['AllowOrganizationApplications']) and $_POST['AllowOrganizationApplications'] == 'on')
			$AllowOrganizationApplications = 'true';
		else	$AllowOrganizationApplications = 'false';

		$Vacancies = isset($_POST['Vacancies']) ? trim($_POST['Vacancies']) : '';

		$VacancyTitle = isset($_POST['VacancyTitle']) ? trim($_POST['VacancyTitle']) : '';
		$Description = isset($_POST['Description']) ? trim($_POST['Description']) : '';


		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);


		// If the user is logged in then the notice creation is already confirmed; else, we set the confirmation fields
		if ( $_SESSION['Logged'] == '1' )
		{
			// Logged in
			$magic_aux = 'NULL';
			$expire = 'NULL';
		}
		else
		{
			// Not logged in
			$magic_aux = "'$magic'";
			$expire = "now() + '7 days'::interval";
		}

		$sqlQuery = "PREPARE query(integer,text,date,bool,bool,bool,bool,bool,bool,text,text,text,text,bool,text,timestamp) AS  INSERT INTO J1_JobOffers (J1_E1_Id,J1_EmployerJobOfferReference,J1_OfferDate,J1_ExpirationDate,J1_Closed,J1_HideEmployer,J1_AllowPersonApplications,J1_AllowCooperativeApplications,J1_AllowCompanyApplications,J1_AllowOrganizationApplications,J1_Vacancies,J1_VacancyTitle,J1_Description,J1_OfferType,J1_CompletedEdition,J1_CreationMagic,J1_CreationMagicExpire) VALUES ($1,$2,'now',$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16);  EXECUTE query('$EntityId','".pg_escape_string($EmployerJobOfferReference)."','".pg_escape_string($ExpirationDate)."','$Closed','$HideEmployer','$AllowPersonApplications','$AllowCooperativeApplications','$AllowCompanyApplications','$AllowOrganizationApplications','".pg_escape_string($Vacancies)."','".pg_escape_string($VacancyTitle)."','".pg_escape_string($Description)."','$offerType','$completedEdition',$magic_aux,$expire);";
		$this->postgresql->getPostgreSQLObject($sqlQuery,1);


		// Get the Id of the insert to the J1_JobOffers table // Ref.: http://www.postgresql.org/docs/current/static/functions-sequence.html
		$sqlQuery = "SELECT currval('J1_JobOffers_j1_id_seq')";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);
		$array = pg_fetch_all_columns($result,0);
		$J1_Id = $array[0];

		// Saving only the first section. It is not need to update the J1_CompletedEdition flag due to it is 'false' by default.
		// When adding Donation Pledges or Look For Volunteers entries we have to set $completedEdition to 'true'


		$this->postgresql->execute("COMMIT",0);


		if ( $offerType == 'Donation pledge group' )
		{
			$donation = new Donation();
			$donation->addDonation($J1_Id,$magic,$EntityId );
		}

		return $J1_Id;
	}


	public function confirmJobOffer($email,$magic)
	{
		$sqlQuery = "PREPARE query(text,text) AS  SELECT J1_Id FROM J1_JobOffers,E1_Entities WHERE J1_E1_Id=E1_Id AND E1_Email=$1 AND J1_CreationMagic=$2 AND J1_CreationMagicExpire > 'now';  EXECUTE query('$email','$magic');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 1);

		$array = pg_fetch_all_columns($result, 0);
		$numrows = count($array);

		if ($numrows == 1)
		{
			$sqlQuery = "PREPARE query(text) AS  UPDATE J1_JobOffers SET J1_CreationMagic=NULL, J1_CreationMagicExpire=NULL WHERE J1_CreationMagic=$1;  EXECUTE query('$magic');";
			$this->postgresql->execute($sqlQuery,1);

			return true;
		}
		else
		{
			return false;
		}
	}


	public function delNonConfirmedJobOffers()
	{
		// This is done to clean non-confirmed notices (JobOffers) whose time-window to confirm has expired.

		$sqlQuery = "SELECT J1_Id FROM J1_JobOffers WHERE J1_CreationMagicExpire IS NOT NULL  AND  J1_CreationMagicExpire < 'now'   AND  J1_OfferType='Job offer (post faster)';";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 0);

		$array = pg_fetch_all_columns($result, 0);
		foreach ( $array as $J1_Id )
		{
			$this->deleteJobOffer($J1_Id);
		}
	}


	public function deleteJobOffer($J1_Id)
	{
		// Delete the subscribed applicants
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1;  EXECUTE query('$J1_Id');";
		$result = $this->postgresql->execute($sqlQuery,1);

		// Certifications
		$certifications = new Certifications();
		$certifications->delCertificationsForJobOffer($J1_Id);

		// Profiles
		$productProfiles = new ProductProfiles();
		$productProfiles->delProductProfilesForJobOffer($J1_Id);

		$professionalProfiles = new ProfessionalProfiles();
		$professionalProfiles->delProfessionalProfilesForJobOffer($J1_Id);

		$fieldProfiles = new FieldProfiles();
		$fieldProfiles->delFieldProfilesForJobOffer($J1_Id);

		// Languages table
		$languages = new Languages();
		$languages->delLanguagesForJobOffer($J1_Id);

		// Skills table
		$skills = new Skills();
		$skills->delSkillsForJobOffer($J1_Id);

		// J1_JobOffers table
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM J1_JobOffers WHERE J1_Id=$1;  EXECUTE query('$J1_Id');";
		$result = $this->postgresql->execute($sqlQuery,1);
	}


	public function deleteSelectedJobOffers()
	{
		for ($i=0; $i < count($_POST['DeleteJobOffers']); $i++)
		{
			$this->deleteJobOffer( $_POST['DeleteJobOffers'][$i] );
		}
	}


	public function deleteEmptyDonationPledgeGroups()
	{
		$sqlQuery = "SELECT J1_Id from J1_JobOffers WHERE J1_OfferType='Donation pledge group' AND J1_Id NOT IN (SELECT DISTINCT D1_J1_Id FROM D1_Donations2JobOffers);";
		$donationPledgeGroups = $this->postgresql->getOneField($sqlQuery,0);

		foreach ($donationPledgeGroups as $donationPledgeGroup)
		{
			$this->deleteJobOffer($donationPledgeGroup);
		}
	}


	public function deleteJobOffersForEntity()
	{
		// We get the Job Offers for the logged Entity. Therefore the Access Control List (ACL) check is implicit.
		// Note this method is not at the DB_Manager.php due to is only used at this layer by the Entity.php class.

		$joboffers = $this->getJobOffersForEntity();

		foreach ( $joboffers[0] as $J1_Id )
		{
			$this->deleteJobOffer( $J1_Id );
		}
	}


	public function updateJobOffer($J1_Id,$section,$completedEdition)
	{
		// As there are several tables involved, we use a transaction to be sure, all operations are done, or nothing is done.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);


		switch($section)
		{
			case 'general':
				// J1_JobOffers table

				$EmployerJobOfferReference = isset($_POST['EmployerJobOfferReference']) ? trim($_POST['EmployerJobOfferReference']) : '';

				$ExpirationDate = isset($_POST['ExpirationDate']) ? trim($_POST['ExpirationDate']) : '';

				if (isset($_POST['Closed']) and $_POST['Closed'] == 'on')
					$Closed = 'true';
				else	$Closed = 'false';

				if (isset($_POST['HideEmployer']) and $_POST['HideEmployer'] == 'on')
					$HideEmployer = 'true';
				else	$HideEmployer = 'false';

				if (isset($_POST['AllowPersonApplications']) and $_POST['AllowPersonApplications'] == 'on')
					$AllowPersonApplications = 'true';
				else	$AllowPersonApplications = 'false';

				if (isset($_POST['AllowCooperativeApplications']) and $_POST['AllowCooperativeApplications'] == 'on')
					$AllowCooperativeApplications = 'true';
				else	$AllowCooperativeApplications = 'false';

				if (isset($_POST['AllowCompanyApplications']) and $_POST['AllowCompanyApplications'] == 'on')
					$AllowCompanyApplications = 'true';
				else	$AllowCompanyApplications = 'false';

				if (isset($_POST['AllowOrganizationApplications']) and $_POST['AllowOrganizationApplications'] == 'on')
					$AllowOrganizationApplications = 'true';
				else	$AllowOrganizationApplications = 'false';

				$Vacancies = isset($_POST['Vacancies']) ? trim($_POST['Vacancies']) : '';

				$VacancyTitle = isset($_POST['VacancyTitle']) ? trim($_POST['VacancyTitle']) : '';
				$Description = isset($_POST['Description']) ? trim($_POST['Description']) : '';

				$sqlQuery = "PREPARE query(text,date,bool,bool,bool,bool,bool,bool,text,text,text,bool,integer) AS  UPDATE J1_JobOffers SET J1_EmployerJobOfferReference=$1,J1_OfferDate='now',J1_ExpirationDate=$2,J1_Closed=$3,J1_HideEmployer=$4,J1_AllowPersonApplications=$5,J1_AllowCooperativeApplications=$6,J1_AllowCompanyApplications=$7,J1_AllowOrganizationApplications=$8,J1_Vacancies=$9,J1_VacancyTitle=$10,J1_Description=$11,J1_CompletedEdition=$12 WHERE J1_Id=$13;  EXECUTE query('".pg_escape_string($EmployerJobOfferReference)."','".pg_escape_string($ExpirationDate)."','$Closed','$HideEmployer','$AllowPersonApplications','$AllowCooperativeApplications','$AllowCompanyApplications','$AllowOrganizationApplications','".pg_escape_string($Vacancies)."','".pg_escape_string($VacancyTitle)."','".pg_escape_string($Description)."','$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'profiles_etc':
				$ProfessionalExperienceSinceYear = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';
				$AcademicLevel = isset($_POST['AcademicLevel']) ? trim($_POST['AcademicLevel']) : '';

				$sqlQuery = "PREPARE query(text,text,bool,integer) AS  UPDATE J1_JobOffers SET J1_ProfessionalExperienceSinceYear=$1,J1_LA_Id=$2,J1_CompletedEdition=$3 WHERE J1_Id=$4;  EXECUTE query('".pg_escape_string($ProfessionalExperienceSinceYear)."','".pg_escape_string($AcademicLevel)."','$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);

				// Profiles
				$productProfiles = new ProductProfiles();
				$productProfiles->setProductProfilesForJobOffer($J1_Id);

				$professionalProfiles = new ProfessionalProfiles();
				$professionalProfiles->setProfessionalProfilesForJobOffer($J1_Id);

				$fieldProfiles = new FieldProfiles();
				$fieldProfiles->setFieldProfilesForJobOffer($J1_Id);
			break;

			case 'skills':
				// Skills table
				$skills = new Skills();
				$result = $skills->setSkillsForJobOffer($J1_Id);

				// Update the J1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE J1_JobOffers SET J1_CompletedEdition=$1 WHERE J1_Id=$2;  EXECUTE query('$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'languages':
				// Languages table
				$languages = new Languages();
				$languages->setLanguagesForJobOffer($J1_Id);

				// Update the J1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE J1_JobOffers SET J1_CompletedEdition=$1 WHERE J1_Id=$2;  EXECUTE query('$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'certifications':
				// Certifications
				$certifications = new Certifications();
				$certifications->setCertificationsForJobOffer($J1_Id);

				// Update the J1_CompletedEdition flag
				$sqlQuery = "PREPARE query(bool,integer) AS  UPDATE J1_JobOffers SET J1_CompletedEdition=$1 WHERE J1_Id=$2;  EXECUTE query('$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'projects':
				$FreeSoftwareExperiences = isset($_POST['FreeSoftwareExperiences']) ? trim($_POST['FreeSoftwareExperiences']) : '';

				$sqlQuery = "PREPARE query(text,bool,integer) AS  UPDATE J1_JobOffers SET J1_FreeSoftwareProjects=$1,J1_CompletedEdition=$2 WHERE J1_Id=$3;  EXECUTE query('".pg_escape_string($FreeSoftwareExperiences)."','$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'location':
				$City = isset($_POST['City']) ? trim($_POST['City']) : '';
				$StateProvince = isset($_POST['StateProvince']) ? trim($_POST['StateProvince']) : '';
				$CountryCode = isset($_POST['CountryCode']) ? trim($_POST['CountryCode']) : '';

				if (isset($_POST['AvailableToTravel']) and $_POST['AvailableToTravel'] == 'on')
					$AvailableToTravel = 'true';
				else	$AvailableToTravel = 'false';

				$sqlQuery = "PREPARE query(text,text,text,bool,bool,integer) AS  UPDATE J1_JobOffers SET J1_City=$1,J1_StateProvince=$2,J1_LO_Country=$3,J1_AvailableToTravel=$4,J1_CompletedEdition=$5 WHERE J1_Id=$6;  EXECUTE query('".pg_escape_string($City)."','".pg_escape_string($StateProvince)."','".pg_escape_string($CountryCode)."','$AvailableToTravel','$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			case 'contract':
				$ContractType = isset($_POST['ContractType']) ? trim($_POST['ContractType']) : '';
				$WageRank = isset($_POST['WageRank']) ? trim($_POST['WageRank']) : '';
				$WageRankCurrency = isset($_POST['WageRankCurrency']) ? trim($_POST['WageRankCurrency']) : '';
				$WageRankByPeriod = isset($_POST['WageRankByPeriod']) ? trim($_POST['WageRankByPeriod']) : '';
				$EstimatedEffort = isset($_POST['EstimatedEffort']) ? trim($_POST['EstimatedEffort']) : '';
				$TimeUnit = isset($_POST['TimeUnit']) ? trim($_POST['TimeUnit']) : '';
				$Deadline = ( isset($_POST['Deadline']) and trim($_POST['Deadline']) != '' ) ? "'".trim($_POST['Deadline'])."'" : 'null';

				if ($_POST['Negotiable'] == 'Yes')
					$Negotiable = 'true';
				elseif ($_POST['Negotiable'] == 'No')
					$Negotiable = 'false';
				else
					$Negotiable = 'null';

				$sqlQuery = "PREPARE query(text,text,text,text,text,text,date,bool,bool,integer) AS  UPDATE J1_JobOffers SET J1_LK_ContractType=$1,J1_WageRank=$2,J1_LU_Currency=$3,J1_LB_WageRankByPeriod=$4,J1_EstimatedEffort=$5,J1_LM_TimeUnit=$6,J1_Deadline=$7,J1_Negotiable=$8,J1_CompletedEdition=$9 WHERE J1_Id=$10;  EXECUTE query('$ContractType','".pg_escape_string($WageRank)."','".pg_escape_string($WageRankCurrency)."','$WageRankByPeriod','".pg_escape_string($EstimatedEffort)."','$TimeUnit',$Deadline,$Negotiable,'$completedEdition','$J1_Id');";
				$this->postgresql->execute($sqlQuery,1);
			break;

			default:
				$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
				throw new Exception($error,false);
		}


		$this->postgresql->execute("COMMIT",0);
	}


	public function getApplicationsMeterForJobOffer($Id, $meter)
	{
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT count(R0_E1_Id) FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1 AND R0_State=$2;  EXECUTE query('$Id','$meter');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		return $result[0];
	}

	public function subscribeApplication($EntityId,$JobOfferId,$magic='')
	{
		// If the user is logged in then the subscription is already confirmed; else, we set the confirmation fields
		if(isset($_SESSION['EntityId']))
		{
			// Logged in
			$sqlQuery = "PREPARE query(integer,integer) AS  INSERT INTO R0_Qualifications2JobOffersJoins (R0_J1_Id,R0_State,R0_E1_Id,R0_SubscriptionMagic,R0_SubscriptionMagicExpire) VALUES ($1,'Received',$2,NULL,NULL);  EXECUTE query('$JobOfferId','$EntityId');";
		}
		else
		{
			// Not logged in
			$sqlQuery = "PREPARE query(integer,integer,text) AS  INSERT INTO R0_Qualifications2JobOffersJoins (R0_J1_Id,R0_State,R0_E1_Id,R0_SubscriptionMagic,R0_SubscriptionMagicExpire) VALUES ($1,'Received',$2,$3,now() + '7 days'::interval);  EXECUTE query('$JobOfferId','$EntityId','$magic');";
		}
		$this->postgresql->execute($sqlQuery,1);
	}

	public function confirmApplication($email,$magic)
	{
		$sqlQuery = "PREPARE query(text,text) AS  SELECT R0_E1_Id FROM R0_Qualifications2JobOffersJoins,E1_Entities WHERE R0_E1_Id=E1_Id AND E1_Email=$1 AND R0_SubscriptionMagic=$2 AND R0_SubscriptionMagicExpire > 'now';  EXECUTE query('$email','$magic');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 1);

		$array = pg_fetch_all_columns($result, 0);
		$numrows = count($array);

		if ($numrows == 1)
		{
			$sqlQuery = "PREPARE query(text) AS  UPDATE R0_Qualifications2JobOffersJoins SET R0_SubscriptionMagic=NULL, R0_SubscriptionMagicExpire=NULL WHERE R0_SubscriptionMagic=$1;  EXECUTE query('$magic');";
			$this->postgresql->execute($sqlQuery,1);

			return true;
		}
		else
		{
			return false;
		}
	}

	public function delNonConfirmedApplications()
	{
		// This is done to clean non-confirmed application-subscriptions whose time-window to confirm has expired.

		$sqlQuery = "DELETE FROM R0_Qualifications2JobOffersJoins WHERE R0_SubscriptionMagicExpire IS NOT NULL  AND  R0_SubscriptionMagicExpire < 'now' ;";
		$this->postgresql->execute($sqlQuery,0);
	}

	public function IsAlreadySubscribed($EntityId,$JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  SELECT R0_J1_Id FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1 AND R0_E1_Id=$2;  EXECUTE query('$JobOfferId','$EntityId');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( is_array($result) and count($result)==1 )
			return true;
		else
			return false;
	}

	public function getJobOfferApplications($JobOfferId)
	{
		$array['VacancyTitle'] = $this->makeUp_VacancyTitle($JobOfferId);
		$array[0] = $this->makeUp_VacancyTitle($JobOfferId); //XXX: Temporal workaround.

		$entities = $this->getEntitiesSubscribed($JobOfferId);
		if ( is_array($entities) and count($entities)>0 )
		{
			$array['Count'] = count($entities); // XXX: Duplicated 3 count() call.

			for ($i=0; $i<count($entities); $i++)
			{
				$array['EntityId'][$i] = $entities[$i];

				$entity = new Entity();
				$arrayEN = $entity->getEntity($entities[$i]);

				$array['Email'][$i] = $arrayEN[0][0];
				$array['WantEmail'][$i] = $arrayEN[20][0];
				$array['EntityType'][$i] = $arrayEN[2][0];

				$array['Street'][$i] = $arrayEN[3][0];
				$array['City'][$i] = $arrayEN[5][0];
				$array['StateProvince'][$i] = $arrayEN[6][0];

				$array['Website'][$i] = $arrayEN[14][0];

				$array['FirstName'][$i] = $arrayEN[15][0];
				$array['LastName'][$i] = $arrayEN[16][0];
				$array['MiddleName'][$i] = $arrayEN[17][0];

				$array['CooperativeName'][$i] = $arrayEN[40][0];
				$array['CompanyName'][$i] = $arrayEN[18][0];
				$array['NonprofitName'][$i] = $arrayEN[19][0];

				$array['CountryName'][$i] = $arrayEN[30][0];

				$qualifications = new Qualifications();
				$arrayQA = $qualifications->getQualificationsForEntity($entities[$i]);

				$array['ProfessionalExperienceSinceYear'][$i] = $arrayQA[0][0];

				$arraySS = $this->getApplicationState($JobOfferId,$entities[$i]);
				$array['ApplicationState'][$i] = $arraySS[0];

			}
		}

		return $array;
	}

	public function getEntitiesSubscribed($JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R0_E1_Id FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1;  EXECUTE query('$JobOfferId');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	private function getApplicationState($JobOfferId,$EntityId)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  SELECT R0_State FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1 AND R0_E1_Id=$2;  EXECUTE query('$JobOfferId','$EntityId');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setApplicationState($JobOfferId,$State,$EntityId)
	{
		$sqlQuery = "PREPARE query(text,integer,integer) AS  UPDATE R0_Qualifications2JobOffersJoins SET R0_State=$1 WHERE R0_J1_Id=$2 AND R0_E1_Id=$3;  EXECUTE query('$State','$JobOfferId','$EntityId');";
		return $this->postgresql->execute($sqlQuery,1);
	}


	public function getJobApplicationsForEntity($extra_condition = '')
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT J1_Id,J1_E1_Id,J1_OfferDate,R0_State,J1_VacancyTitle,J1_OfferType FROM J1_JobOffers,R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=J1_Id AND R0_E1_Id=$1 ".$extra_condition.";  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);
		$array = array();
		$array[0] = pg_fetch_all_columns($result, 0);
		$array[1] = pg_fetch_all_columns($result, 1);
		$array[2] = pg_fetch_all_columns($result, 2);
		$array[3] = pg_fetch_all_columns($result, 3);

		$array[4] = pg_fetch_all_columns($result, 4);

		for( $i=0; $i < count($array[0]); $i++)
			if ( $array[4][$i] == '' )
				$array[4][$i] = $this->makeUp_VacancyTitle($array[0][$i]);

		$array[5] = pg_fetch_all_columns($result, 5);

		return $array;
	}


	private function isJobOfferOwnerTrusted($J1_Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT E1_Trusted FROM E1_Entities,J1_JobOffers WHERE E1_Id=J1_E1_Id AND J1_Id=$1;  EXECUTE query('$J1_Id');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( $result[0] == 't' )
			return true;
		else
			return false;
	}

	private function makeUp_VacancyTitle($J1_Id)
	{
		$professionalProfiles = new ProfessionalProfiles();
		$arrayLP = $professionalProfiles->getProfessionalProfilesForJobOffer($J1_Id);

		$fieldProfiles = new FieldProfiles();
		$arrayLF = $fieldProfiles->getFieldProfilesForJobOffer($J1_Id);

		$skills = new Skills();
		$arrayLS = $skills->getSkillsForJobOffer($J1_Id);

		$languages = new Languages();
		$arrayLL = $languages->getLanguagesForJobOffer($J1_Id);

		$VacancyTitle = '';

		if ( trim($arrayLP[0]) != '')
			$VacancyTitle .= dgettext('database',$arrayLP[0]);

		for( $i=1; $i < count($arrayLP); $i++)
			if ( trim($arrayLP[$i]) != '')
				$VacancyTitle .= ", ".dgettext('database',$arrayLP[$i]);

		for( $i=0; $i < count($arrayLF); $i++)
			if ( trim($arrayLF[$i]) != '')
				$VacancyTitle .= ", ".dgettext('database',$arrayLF[$i]);

		$trusted = $this->isJobOfferOwnerTrusted($J1_Id);

		for( $i=0; $i < count($arrayLS[0]); $i++)
			if ( trim($arrayLS[0][$i]) != '' and ( ( $arrayLS[3][$i] != 'Non-Free Software' and $arrayLS[3][$i] != 'Pending' ) or $trusted == true ) )
			{
				if ( preg_match("/^.+ \((.+)\)$/", $arrayLS[0][$i], $matches ) )//   /^.+ (.+)$/
				{
					$VacancyTitle .= ", ".$matches[1];
				}
				else
				{
					$VacancyTitle .= ", ".$arrayLS[0][$i];
				}
			}

		for( $i=0; $i < count($arrayLL[0]); $i++)
			if ( trim($arrayLL[0][$i]) != '')
				$VacancyTitle .= ", ".dgettext('iso_639',$arrayLL[0][$i]);

		if ( $VacancyTitle == '')
			$VacancyTitle = gettext("not specified");

		if (strlen($VacancyTitle) > 100)
			return substr($VacancyTitle,0,97)."...";
		else
			return $VacancyTitle;
	}


	// methods to check the Access Control List

	// Check if the request comes from the JobOffer owner
	public function isOwner($E1_Id)
	{
		if ( $_SESSION['EntityId'] == $E1_Id )  // There is not need to query the Data Base  :-)
			return true;
		else
			return false;
	}

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

	// Check if the logged entity is subscribed to some of the job offers owned by the E1_Id entity, even if such job offers are not active
	public function isApplicant($E1_Id)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  SELECT count(*) FROM R0_Qualifications2JobOffersJoins,J1_JobOffers WHERE R0_J1_Id=J1_Id AND J1_E1_Id=$1 AND R0_E1_Id=$2;  EXECUTE query('$E1_Id','$_SESSION[EntityId]');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( intval($result[0]) >= 1 )
			return true;
		else
			return false;
	}


	public function isJobOfferActive($J1_Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT count(*) FROM J1_JobOffers WHERE J1_Id=$1 AND J1_Closed='f' AND J1_ExpirationDate > 'now';  EXECUTE query('$J1_Id');";
		$result = $this->postgresql->getOneField($sqlQuery,1);

		if ( intval($result[0]) >= 1 )
			return true;
		else
			return false;
	}


	public function pendingAlerts($alert_type)
	{
		$sqlQuery = "SELECT count(*) FROM J1_JobOffers WHERE J1_CompletedEdition='t' AND J1_Closed='f' AND J1_ExpirationDate > 'now' AND J1_{$alert_type}Alert='t';";
		$result = $this->postgresql->getOneField($sqlQuery,0);

		if ( intval($result[0]) >= 1 )
			return true;
		else
			return false;
	}

	public function resetAlerts($alert_type)
	{
		$sqlQuery = "UPDATE J1_JobOffers SET J1_{$alert_type}Alert='f' WHERE J1_CompletedEdition='t' AND J1_Closed='f' AND J1_ExpirationDate > 'now' AND J1_{$alert_type}Alert='t';";
		$this->postgresql->execute($sqlQuery,0);
	}
}
