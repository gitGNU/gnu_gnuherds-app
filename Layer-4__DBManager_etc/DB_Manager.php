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


// Forms
require_once "../Layer-5__DB_operation/Authenticate.php";
require_once "../Layer-5__DB_operation/Entity.php";
require_once "../Layer-5__DB_operation/Qualifications.php";
require_once "../Layer-5__DB_operation/Job_Offer.php";

// Lists
require_once "../Layer-5__DB_operation/Countries.php";
require_once "../Layer-5__DB_operation/Academic_Qualifications.php";
require_once "../Layer-5__DB_operation/Product_Profiles.php";
require_once "../Layer-5__DB_operation/Professional_Profiles.php";
require_once "../Layer-5__DB_operation/Field_Profiles.php";
require_once "../Layer-5__DB_operation/Skills.php";
require_once "../Layer-5__DB_operation/Certifications.php";
require_once "../Layer-5__DB_operation/Languages.php";
require_once "../Layer-5__DB_operation/Contract_Types.php";
require_once "../Layer-5__DB_operation/By_Period.php";
require_once "../Layer-5__DB_operation/Time_Units.php";
require_once "../Layer-5__DB_operation/Currencies.php";
require_once "../Layer-5__DB_operation/Employability.php";
require_once "../Layer-5__DB_operation/Application_States.php";

// Access Control List (ACL)
require_once "../Layer-4__DBManager_etc/Access_Control_List.php";


class DBManager
{
	// Methods take the values form the global $_POST[] array.

	public function authenticateEntity()
	{
		$authenticate = new Authenticate();
		return $authenticate->checkLogin();
	}


	public function getEntity($Id)
	{
		$entity = new Entity();
		return $entity->getEntity($Id);
	}

	public function getEntityPhotoOrLogo($Id)
	{
		$acl = new AccessControlList();
		$acl->checkProperlyLogged();

		$entity = new Entity();
		return $entity->getEntityPhotoOrLogo($Id);
	}

	public function addEntity()
	{
		$entity = new Entity();
		$entity->addEntity();
	}

	public function deleteEntity()
	{
		$entity = new Entity();
		$entity->deleteEntity();
	}

	public function deletePhotoOrLogo()
	{
		$acl = new AccessControlList();
		$acl->checkProperlyLogged();

		$entity = new Entity();
		$entity->deletePhotoOrLogo();
	}

	public function updateEntity()
	{
		$entity = new Entity();
		$entity->updateEntity();
	}

	public function lookForEntity()
	{
		$entity = new Entity();
		return $entity->lookForEntity();
	}

	public function saveMagicForEntity($magic)
	{
		$entity = new Entity();
		return $entity->saveMagicForEntity($magic);
	}

	public function setNewPasswordForEntity()
	{
		$entity = new Entity();
		return $entity->setNewPasswordForEntity();
	}


	public function getQualificationsForEntity($Id)
	{
		$acl = new AccessControlList();
		$acl->checkQualificationsAccess("READ",$Id);

		$qualifications = new Qualifications();
		return $qualifications->getQualificationsForEntity($Id);
	}

	public function getQualificationsPhotoOrLogoForEntity($Id)
	{
		$acl = new AccessControlList();
		$acl->checkQualificationsAccess("READ",$Id);

		$entity = new Entity();
		return $entity->getEntityPhotoOrLogo($Id);
	}

	public function addQualifications()
	{
		$qualifications = new Qualifications();
		return $qualifications->addQualifications();
	}

	public function deleteQualifications()
	{
		$qualifications = new Qualifications();
		return $qualifications->deleteQualifications();
	}

	public function updateQualifications()
	{
		$qualifications = new Qualifications();
		return $qualifications->updateQualifications();
	}


	public function getJobOffersForEntity()
	{
		$jobOffer = new JobOffer();
		return $jobOffer->getJobOffersForEntity();
	}

	public function getJobOffers()
	{
		$jobOffer = new JobOffer();
		return $jobOffer->getJobOffers();
	}

	public function getJobOffer($Id)
	{
		$jobOffer = new JobOffer();
		return $jobOffer->getJobOffer($Id);
	}

	public function getJobOfferPhotoOrLogoForEntity($Id)
	{
		$acl = new AccessControlList();
		$acl->checkJobOfferAccess("READ",$Id);

		$entity = new Entity();
		return $entity->getEntityPhotoOrLogo($Id);
	}

	public function addJobOffer()
	{
		$jobOffer = new JobOffer();
		return $jobOffer->addJobOffer();
	}

	public function deleteSelectedJobOffers()
	{
		$jobOffer = new JobOffer();
		return $jobOffer->deleteSelectedJobOffers();
	}

	public function updateJobOffer($Id)
	{
		$jobOffer = new JobOffer();
		return $jobOffer->updateJobOffer($Id);
	}

	public function getApplicationsMeterForJobOffer($Id,$meter)
	{
		$jobOffer = new JobOffer();
		return $jobOffer->getApplicationsMeterForJobOffer($Id,$meter);
	}

	public function subscribeApplication($EntityId,$JobOfferId)
	{
		$jobOffer = new JobOffer();
		return $jobOffer->subscribeApplication($EntityId,$JobOfferId);
	}

	public function IsAlreadySubscribed($EntityId,$JobOfferId)
	{
		$jobOffer = new JobOffer();
		return $jobOffer->IsAlreadySubscribed($EntityId,$JobOfferId);
	}

	public function getJobOfferApplications($JobOfferId)
	{
		$jobOffer = new JobOffer();
		return $jobOffer->getJobOfferApplications($JobOfferId);
	}

	public function setApplicationState($JobOfferId,$State,$EntityId)
	{
		$jobOffer = new JobOffer();
		return $jobOffer->setApplicationState($JobOfferId,$State,$EntityId);
	}

	public function getJobApplicationsForEntity()
	{
		$jobOffer = new JobOffer();
		return $jobOffer->getJobApplicationsForEntity();
	}


	public function getCountryList()
	{
		$countries = new Countries();
		return $countries->getCountryList();
	}

	public function getCountryTwoLetterList()
	{
		$countries = new Countries();
		return $countries->getCountryTwoLetterList();
	}

	public function getCountryNameList()
	{
		$countries = new Countries();
		return $countries->getCountryNameList();
	}

	public function getAcademicQualificationsList()
	{
		$academicQualifications = new AcademicQualifications();
		return $academicQualifications->getAcademicQualificationsList();
	}

	public function getProductProfilesList()
	{
		$productProfiles = new ProductProfiles();
		return $productProfiles->getProductProfilesList();
	}

	public function getProfessionalProfilesList()
	{
		$professionalProfiles = new ProfessionalProfiles();
		return $professionalProfiles->getProfessionalProfilesList();
	}

	public function getFieldProfilesList()
	{
		$fieldProfiles = new FieldProfiles();
		return $fieldProfiles->getFieldProfilesList();
	}

	public function getSkillsListsBySets()
	{
		$skills = new Skills();
		return $skills->getSkillsListsBySets();
	}

	public function getSkillsList()
	{
		$skills = new Skills();
		return $skills->getSkillsList();
	}

	public function getSkillKnowledgeLevelsList()
	{
		$skills = new Skills();
		return $skills->getSkillKnowledgeLevelsList();
	}

	public function getSkillExperienceLevelsList()
	{
		$skills = new Skills();
		return $skills->getSkillExperienceLevelsList();
	}

	public function getRequestedCertificationsForEntity()
	{
		$certifications = new Certifications();
		return $certifications->getRequestedCertificationsForEntity();
	}

	public function getNotYetRequestedCertificationsForEntity()
	{
		$certifications = new Certifications();
		return $certifications->getNotYetRequestedCertificationsForEntity();
	}

	public function getCertificationsList()
	{
		$certifications = new Certifications();
		return $certifications->getCertificationsList();
	}

	public function getLanguagesList()
	{
		$languages = new Languages();
		return $languages->getLanguagesList();
	}

	public function getLanguagesSpokenLevelsList()
	{
		$languages = new Languages();
		return $languages->getLanguageSpokenLevelsList();
	}

	public function getLanguagesWrittenLevelsList()
	{
		$languages = new Languages();
		return $languages->getLanguageWrittenLevelsList();
	}

	public function getContractTypesList()
	{
		$contractTypes = new ContractTypes();
		return $contractTypes->getContractTypesList();
	}

	public function getByPeriodList()
	{
		$byPeriod = new ByPeriod();
		return $byPeriod->getByPeriodList();
	}

	public function getTimeUnitsList()
	{
		$timeUnits = new TimeUnits();
		return $timeUnits->getTimeUnitsList();
	}

	public function getCurrenciesList()
	{
		$currencies = new Currencies();
		return $currencies ->getCurrenciesList();
	}

	public function getEmployabilityList()
	{
		$employability = new Employability();
		return $employability->getEmployabilityList();
	}

	public function getApplicationStatesList()
	{
		$applicationStates = new ApplicationStates();
		return $applicationStates->getApplicationStatesList();
	}
}
?> 
