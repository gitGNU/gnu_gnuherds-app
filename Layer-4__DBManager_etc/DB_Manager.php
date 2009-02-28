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


// Forms
require_once "../Layer-5__DB_operation/Authenticate.php";
require_once "../Layer-5__DB_operation/Entity.php";
require_once "../Layer-5__DB_operation/Qualifications.php";
require_once "../Layer-5__DB_operation/Job_Offer.php";
require_once "../Layer-5__DB_operation/Alerts.php";
require_once "../Layer-5__DB_operation/Donation.php";

// Lists
require_once "../Layer-5__DB_operation/Countries.php";
require_once "../Layer-5__DB_operation/Nationalities.php";
require_once "../Layer-5__DB_operation/Academic.php";
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
		// This method does not need ACL check

		$authenticate = new Authenticate();
		return $authenticate->checkLogin();
	}


	public function getEntity($Id)
	{
		// This method does not need ACL check because of it works with SESSION[EntityId],
		// or at ViewQualifications and ViewJobOffer only shows non-private information.

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

	public function getEntityId($email,$requestOperation)
	{
		// This method does not need ACL check because of we have to allow it even to not logged entities.

		$entity = new Entity();
		return $entity->getEntityId($email,$requestOperation);
	}

	public function addEntity($magic)
	{
		// This method does not need ACL check

		$entity = new Entity();
		$entity->addEntity($magic);
	}

	public function deleteEntity()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$entity = new Entity();
		$entity->deleteEntity();
	}

	public function deletePhotoOrLogo()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$entity = new Entity();
		$entity->deletePhotoOrLogo();
	}

	public function updateEntity()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$entity = new Entity();
		$entity->updateEntity();
	}

	public function updateEntityLocale()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$entity = new Entity();
		$entity->updateEntityLocale();
	}

	public function lookForEntity($email)
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->lookForEntity($email);
	}

	public function saveLostPasswordMagicForEntity($magic)
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->saveLostPasswordMagicForEntity($magic);
	}

	public function saveWantEmailMagicForEntity($magic)
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->saveWantEmailMagicForEntity($magic);
	}

	public function setNewPasswordForEntity()
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->setNewPasswordForEntity();
	}

	public function changeEmailForEntity()
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->changeEmailForEntity();
	}

	public function activateAccountForEntity()
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->activateAccountForEntity();
	}

	public function allowActivateAccountEmail($email)
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->allowActivateAccountEmail($email);
	}

	public function allowRegisterAccountDuplicatedEmail($email)
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->allowRegisterAccountDuplicatedEmail($email);
	}

	public function allowLostPasswordEmail($email)
	{
		// This method does not need ACL check

		$entity = new Entity();
		return $entity->allowLostPasswordEmail($email);
	}

	public function getAlertsLocales($alert_type)
	{
		// This method does not need ACL check because of the information that it gets is not associated to any personal information. It get an abstract of statistical information.

		$entity = new Entity();
		return $entity->getAlertsLocales($alert_type);
	}

	public function getAlertsEmails($alert_type,$locale)
	{
		//XXX: ACL: This method gets entities' emails.  Add support to check sysadmin authentication for website-frontend + DB-backend.

		$entity = new Entity();
		return $entity->getAlertsEmails($alert_type,$locale);
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

	public function addQualifications($completedEdition)
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$qualifications = new Qualifications();
		return $qualifications->addQualifications($completedEdition);
	}

	public function deleteQualifications()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$qualifications = new Qualifications();
		return $qualifications->deleteQualifications();
	}

	public function updateQualifications($section,$completedEdition)
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$qualifications = new Qualifications();
		return $qualifications->updateQualifications($section,$completedEdition);
	}


	public function getJobOffersForEntity($extra_condition)
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$jobOffer = new JobOffer();
		return $jobOffer->getJobOffersForEntity($extra_condition);
	}

	public function getJobOffers($extra_condition)
	{
		// This method does not need ACL check. It gets public information.

		$jobOffer = new JobOffer();
		return $jobOffer->getJobOffers($extra_condition);
	}

	public function getJobOffer($Id)
	{
		$acl = new AccessControlList();
		$acl->checkJobOfferAccess("READ",$Id);

		$jobOffer = new JobOffer();
		return $jobOffer->getJobOffer($Id);
	}

	public function getJobOfferPhotoOrLogoForEntity($Id)
	{
		$acl = new AccessControlList();
		$acl->checkJobOfferEntityAccess("READ",$Id);

		$entity = new Entity();
		return $entity->getEntityPhotoOrLogo($Id);
	}

	public function addJobOffer($offerType,$completedEdition)
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$jobOffer = new JobOffer();
		return $jobOffer->addJobOffer($offerType,$completedEdition);
	}

	public function deleteSelectedJobOffers()
	{
		$acl = new AccessControlList();
		for ($i=0; $i < count($_POST['DeleteJobOffers']); $i++)
			$acl->checkJobOfferAccess("WRITE",$_POST['DeleteJobOffers'][$i]);

		$jobOffer = new JobOffer();
		return $jobOffer->deleteSelectedJobOffers();
	}

	public function updateJobOffer($Id,$section,$completedEdition)
	{
		$acl = new AccessControlList();
		$acl->checkJobOfferAccess("WRITE",$Id);

		$jobOffer = new JobOffer();
		return $jobOffer->updateJobOffer($Id,$section,$completedEdition);
	}

	public function getDonators($Id)
	{
		// This method does not need ACL check. It gets public information.

		$donation = new Donation();
		return $donation->getDonators($Id);
	}

	public function getDonationsForPledgeGroup($Id)
	{
		// This method does not need ACL check. It gets public information.

		$donation = new Donation();
		return $donation->getDonationsForPledgeGroup($Id);
	}

	public function addDonation($Id)
	{
		// This method does not need ACL check. Everybody is allowed to donate.

		$donation = new Donation();
		$donation->addDonation($Id);
	}

	public function cancelSelectedDonations()
	{
		//XXX: TODO: $acl = new AccessControlList();
		//XXX: TODO: for ($i=0; $i < count($_POST['DeleteJobOffers']); $i++)
		//XXX: TODO:	 $acl->checkJobOfferAccess("WRITE",$_POST['DeleteJobOffers'][$i]);

		$donation = new Donation();
		return $donation->cancelSelectedDonations();
	}

	public function getMyDonations()
	{
		//XXX: TODO: $acl = new AccessControlList();
		//XXX: TODO: $acl->checkJobOfferAccess("WRITE",$_POST['DeleteJobOffers'][$i]);

		$donation = new Donation();
		return $donation->getMyDonations();
	}

	public function getApplicationsMeterForJobOffer($Id,$meter)
	{
		$acl = new AccessControlList();
		$acl->checkApplicationsAccess("READ",$Id);

		$jobOffer = new JobOffer();
		return $jobOffer->getApplicationsMeterForJobOffer($Id,$meter);
	}

	public function subscribeApplication($EntityId,$JobOfferId)
	{
		// With the current use of this method, it does not need ACL check.

		$jobOffer = new JobOffer();
		$jobOffer->subscribeApplication($EntityId,$JobOfferId);
	}

	public function IsAlreadySubscribed($EntityId,$JobOfferId)
	{
		// With the current use of this method, it does not need ACL check.

		$jobOffer = new JobOffer();
		return $jobOffer->IsAlreadySubscribed($EntityId,$JobOfferId);
	}

	public function IsAlreadyDonator($EntityId,$JobOfferId)
	{
		// With the current use of this method, it does not need ACL check.

		$donation = new Donation();
		return $donation->IsAlreadyDonator($EntityId,$JobOfferId);
	}

	public function getJobOfferApplications($JobOfferId)
	{
		$acl = new AccessControlList();
		$acl->checkApplicationsAccess("READ",$JobOfferId);

		$jobOffer = new JobOffer();
		return $jobOffer->getJobOfferApplications($JobOfferId);
	}

	public function setApplicationState($JobOfferId,$State,$EntityId)
	{
		$acl = new AccessControlList();
		$acl->checkApplicationsAccess("WRITE",$JobOfferId);

		$jobOffer = new JobOffer();
		return $jobOffer->setApplicationState($JobOfferId,$State,$EntityId);
	}

	public function getJobApplicationsForEntity($extra_condition)
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$jobOffer = new JobOffer();
		return $jobOffer->getJobApplicationsForEntity($extra_condition);
	}

	public function pendingAlerts($alert_type)
	{
		// This method does not need ACL check because of it works with JobOffer's public information.

		$jobOffer = new JobOffer();
		return $jobOffer->pendingAlerts($alert_type);
	}

	public function resetAlerts($alert_type)
	{
		// XXX: Add the check needed to be sure that this method is only used by the 'alerts' cron job.

		$jobOffer = new JobOffer();
		return $jobOffer->resetAlerts($alert_type);
	}


	public function getAlertsForEntity()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$alerts = new Alerts();
		return $alerts->getAlertsForEntity();
	}

	public function saveAlertsForEntity()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$alerts = new Alerts();
		return $alerts->saveAlertsForEntity();
	}


	public function getCountryList()
	{
		// This method does not need ACL check. It gets public information.

		$countries = new Countries();
		return $countries->getCountryList();
	}

	public function getNationalityList()
	{
		// This method does not need ACL check. It gets public information.

		$nationalities = new Nationalities();
		return $nationalities->getNationalityList();
	}

	public function getAcademicLevelsList()
	{
		// This method does not need ACL check. It gets public information.

		$academic = new Academic();
		return $academic->getAcademicLevelsList();
	}

	public function getProductProfilesList()
	{
		// This method does not need ACL check. It gets public information.

		$productProfiles = new ProductProfiles();
		return $productProfiles->getProductProfilesList();
	}

	public function getProfessionalProfilesList()
	{
		// This method does not need ACL check. It gets public information.

		$professionalProfiles = new ProfessionalProfiles();
		return $professionalProfiles->getProfessionalProfilesList();
	}

	public function getFieldProfilesList()
	{
		// This method does not need ACL check. It gets public information.

		$fieldProfiles = new FieldProfiles();
		return $fieldProfiles->getFieldProfilesList();
	}

	public function getSkillsListsBySets()
	{
		// This method does not need ACL check. It gets public information.

		$skills = new Skills();
		return $skills->getSkillsListsBySets();
	}

	public function getSkillsList()
	{
		// This method does not need ACL check. It gets public information.

		$skills = new Skills();
		return $skills->getSkillsList();
	}

	public function getSkillKnowledgeLevelsList()
	{
		// This method does not need ACL check. It gets public information.

		$skills = new Skills();
		return $skills->getSkillKnowledgeLevelsList();
	}

	public function getSkillExperienceLevelsList()
	{
		// This method does not need ACL check. It gets public information.

		$skills = new Skills();
		return $skills->getSkillExperienceLevelsList();
	}

	public function getTaggedSkillsList()
	{
		$acl = new AccessControlList();
		$acl->checkProperlyLogged();

		$skills = new Skills();
		return $skills->getTaggedSkillsList();
	}

	public function getPendingSkillsList()
	{
		$acl = new AccessControlList();
		$acl->checkSkillsAdminAccess();

		$skills = new Skills();
		return $skills->getPendingSkillsList();
	}

	public function delNotUsedPendingSkills()
	{
		//XXX: ACL: This method deletes skills.  Add support to check sysadmin authentication for website-frontend + DB-backend.

		$skills = new Skills();
		return $skills->delNotUsedPendingSkills();
	}

	public function getSkillSetTypesList()
	{
		$acl = new AccessControlList();
		$acl->checkProperlyLogged();

		$skills = new Skills();
		return $skills->getSkillSetTypesList();
	}

	public function getSkillTagList()
	{
		$acl = new AccessControlList();
		$acl->checkProperlyLogged();

		$skills = new Skills();
		return $skills->getSkillTagList();
	}

	public function isSkillAlreadyInDataBase($skill)
	{
		$acl = new AccessControlList();
		$acl->checkSkillsAdminAccess();

		$skills = new Skills();
		return $skills->isSkillAlreadyInDataBase($skill);
	}

	public function getSkill($skill)
	{
		$acl = new AccessControlList();
		$acl->checkSkillsAdminAccess();

		$skills = new Skills();
		return $skills->getSkill($skill);
	}

	public function addSkill($skill)
	{
		$acl = new AccessControlList();
		$acl->checkProperlyLogged();

		$skills = new Skills();
		return $skills->addSkill($skill);
	}

	public function delSkill($skill)
	{
		$acl = new AccessControlList();
		$acl->checkSkillsAdminAccess();

		$skills = new Skills();
		return $skills->delSkill($skill);
	}

	public function updateSkill($skill,$force)
	{
		$acl = new AccessControlList();
		$acl->checkSkillsAdminAccess();

		$skills = new Skills();
		return $skills->updateSkill($skill,$force);
	}

	public function renameJobOffersAndQualificationsSkills($from,$to)
	{
		$acl = new AccessControlList();
		$acl->checkSkillsAdminAccess();

		$skills = new Skills();
		return $skills->renameJobOffersAndQualificationsSkills($from,$to);
	}

	public function getRequestedCertificationsForEntity()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$certifications = new Certifications();
		return $certifications->getRequestedCertificationsForEntity();
	}

	public function getNotYetRequestedCertificationsForEntity()
	{
		// This method does not need ACL check because of it works with SESSION[EntityId]

		$certifications = new Certifications();
		return $certifications->getNotYetRequestedCertificationsForEntity();
	}

	public function getCertificationsList()
	{
		// This method does not need ACL check. It gets public information.

		$certifications = new Certifications();
		return $certifications->getCertificationsList();
	}

	public function getLanguagesList()
	{
		// This method does not need ACL check. It gets public information.

		$languages = new Languages();
		return $languages->getLanguagesList();
	}

	public function getLanguagesSpokenLevelsList()
	{
		// This method does not need ACL check. It gets public information.

		$languages = new Languages();
		return $languages->getLanguageSpokenLevelsList();
	}

	public function getLanguagesWrittenLevelsList()
	{
		// This method does not need ACL check. It gets public information.

		$languages = new Languages();
		return $languages->getLanguageWrittenLevelsList();
	}

	public function getContractTypesList()
	{
		// This method does not need ACL check. It gets public information.

		$contractTypes = new ContractTypes();
		return $contractTypes->getContractTypesList();
	}

	public function getByPeriodList()
	{
		// This method does not need ACL check. It gets public information.

		$byPeriod = new ByPeriod();
		return $byPeriod->getByPeriodList();
	}

	public function getTimeUnitsList()
	{
		// This method does not need ACL check. It gets public information.

		$timeUnits = new TimeUnits();
		return $timeUnits->getTimeUnitsList();
	}

	public function getCurrenciesList()
	{
		// This method does not need ACL check. It gets public information.

		$currencies = new Currencies();
		return $currencies ->getCurrenciesList();
	}

	public function getEmployabilityList()
	{
		// This method does not need ACL check. It gets public information.

		$employability = new Employability();
		return $employability->getEmployabilityList();
	}

	public function getApplicationStatesList()
	{
		// This method does not need ACL check. It gets public information.

		$applicationStates = new ApplicationStates();
		return $applicationStates->getApplicationStatesList();
	}
}
