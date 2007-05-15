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


require_once "../Layer-4__DBManager_etc/DB_Manager.php";

// Methods take the values from the global $_POST[] array.


class ViewJobOfferForm
{
	private $manager;


	function __construct()
	{
		$this->manager = new DBManager();
	}


	public function processForm()
	{
		// Load the data
		if ( !isset( $_GET['JobOfferId'] ) or $_GET['JobOfferId']=='' )
		{
			$error = "<p>".gettext('ERROR: The identifier to show has not been specified!.')."</p>";
			throw new Exception($error,false);
		}
		else
			$this->loadJobOfferForm();

		// Process each button event
		$_SESSION['IsAlreadySubscribed'] = false; // Initialized. It could be overwrite later.

		if ( isset($_POST['subscribe']) and $_POST['subscribe'] == gettext('Subscribe to this job offer') )
		{
			if ( isset($_SESSION['Logged']) and $_SESSION['Logged'] == '1' )
			{
				if ( ($_SESSION['LoginType']=='Person' and $_SESSION['ViewAllowPersonApplications']=="true") or ($_SESSION['LoginType']=='Company' and $_SESSION['ViewAllowCompanyApplications']=="true") or ($_SESSION['LoginType']=='non-profit Organization' and $_SESSION['ViewAllowOrganizationApplications']=="true") )
				{
					if ($_SESSION['ViewEmail'] == $_SESSION['LoginEmail'] )
					{
						$error = "<p>".gettext("You can not subscribe to you own offer.")."</p>";
						throw new Exception($error,false);
					}
					else
					{
						$result = $this->manager->getQualificationsForEntity($_SESSION['EntityId']);
						if ( count($result[0]) ==1 )
						{
							$_SESSION['IsAlreadySubscribed'] = $this->manager->IsAlreadySubscribed( $_SESSION['EntityId'], $_GET['JobOfferId'] );

							if ( $_SESSION['IsAlreadySubscribed'] == false )
								$_SESSION['IsAlreadySubscribed'] = $this->manager->subscribeApplication( $_SESSION['EntityId'], $_GET['JobOfferId'] );
						}
						else
						{
							$error = "<p>".gettext("To be able to subscribe your application, you have to fill the Qualification form.")."<br>".gettext("See the").' <a href="faq#How_to_subscribe_to_a_job_offer?">'.gettext("FAQ")."</a>.</p>";
							throw new Exception($error,false);
						}
					}
				}
				else
				{
					$error = "<p>".gettext("Note that this job offer is not looking for a")." ".gettext($_SESSION['LoginType']).".</p>";
					throw new Exception($error,false);
				}
			}
			else
			{
				$error = "<p>".gettext("To be able to subscribe your application, you have to log in first.")."<br>".gettext("See the").' <a href="faq#How_to_subscribe_to_a_job_offer?">'.gettext("FAQ")."</a>.</p>";
				throw new Exception($error,false);
			}
		}
		else
		{
			// If the there is a user logged, check if she/he is already subscribed to this job offer.
			if ( isset($_SESSION['Logged']) and $_SESSION['Logged'] == '1' )
				$_SESSION['IsAlreadySubscribed'] = $this->manager->IsAlreadySubscribed( $_SESSION['EntityId'], $_GET['JobOfferId'] );
		}
	}


	public function printOutput()
	{
		$this->printViewJobOfferForm();
	}


	private function printViewJobOfferForm()
	{
		// This function draw the form, with its controls. Note that the specific values of form controls are set via SESSION variables.
		// The SESSION variables are loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in SESSION variables.
		//   3. It is set in the smarty templates.

		$smarty = new Smarty;
		$smarty->display("View_Job_Offer_form.tpl");
	}


	private function loadJobOfferForm()
	{
		// This function will not override the SESSION variables while the user is working in its form, because of before calling this function the 'Back' button value is checked. 

		$result = $this->manager->getJobOffer($_GET['JobOfferId']);


		// J1_JobOffers table

		$_SESSION['ViewEntityId'] = $result[26][0];

		$_SESSION['ViewEmployerJobOfferReference'] = trim($result[0][0]);
		$_SESSION['ViewOfferDate'] = trim($result[1][0]);

		if ($result[3][0]=='t')
			$_SESSION['ViewClosed'] = "true";
		else
			$_SESSION['ViewClosed'] = "false";

		if ($result[4][0]=='t')
			$_SESSION['ViewHideEmployer'] = "true";
		else
			$_SESSION['ViewHideEmployer'] = "false";

		if ($result[5][0]=='t')
			$_SESSION['ViewAllowPersonApplications'] = "true";
		else
			$_SESSION['ViewAllowPersonApplications'] = "false";

		if ($result[6][0]=='t')
			$_SESSION['ViewAllowCompanyApplications'] = "true";
		else
			$_SESSION['ViewAllowCompanyApplications'] = "false";

		if ($result[7][0]=='t')
			$_SESSION['ViewAllowOrganizationApplications'] = "true";
		else
			$_SESSION['ViewAllowOrganizationApplications'] = "false";

		$_SESSION['ViewVacancies'] = trim($result[8][0]);

		$_SESSION['ViewContractType'] = $result[9][0];
		$_SESSION['ViewWageRank'] = $result[10][0];
		$_SESSION['ViewWageRankCurrency'] = $result[11][0];
		$_SESSION['ViewWageRankCurrencyName'] = $result[12][0];
		$_SESSION['ViewWageRankByPeriod'] = $result[13][0];
		$_SESSION['ViewEstimatedEffort'] = $result[23][0];
		$_SESSION['ViewTimeUnit'] = $result[24][0];

		$_SESSION['ViewProfessionalExperienceSinceYear'] = trim($result[14][0]);
		$_SESSION['ViewAcademicQualification'] = trim($result[15][0]);

		// Profiles tables
		$_SESSION['ViewProductProfileList'] = $result[30];
		$_SESSION['ViewProfessionalProfileList'] = $result[31];
		$_SESSION['ViewFieldProfileList'] = $result[32];

		// Skills tables
		$_SESSION['ViewSkillList'] = $result[43];
		$_SESSION['ViewKnowledgeLevelList'] = $result[44];
		$_SESSION['ViewExperienceLevelList'] = $result[45];

		$_SESSION['ViewCertificationsList'] = $result[50];

		$_SESSION['ViewFreeSoftwareExperiences'] = trim($result[16][0]);

		// Languages table
		$_SESSION['ViewLanguageList'] = $result[40];
		$_SESSION['ViewLanguageSpokenLevelList'] = $result[41];
		$_SESSION['ViewLanguageWrittenLevelList'] = $result[42];

		if ($result[17][0]=='t')
			$_SESSION['ViewTelework'] = "true";
		else
			$_SESSION['ViewTelework'] = "false";

		$_SESSION['ViewJobOfferCity'] = $result[18][0];
		$_SESSION['ViewJobOfferStateProvince'] = $result[19][0];
		$_SESSION['ViewJobOfferCountryName'] = $result[25][0];

		if ($result[21][0]=='t')
			$_SESSION['ViewAvailableToTravel'] = "true";
		else
			$_SESSION['ViewAvailableToTravel'] = "false";

		$_SESSION['ViewVacancyTitle'] = $result[60][0];


		// Entity table

		$result = $this->manager->getEntity($_SESSION['ViewEntityId']); // EntityId, owner of the JobOffer, to be shown at the template.

		$_SESSION['ViewEmail'] = $result[0][0];

		$_SESSION['ViewEntityType'] = $result[2][0];

		$_SESSION['ViewEntityStreet'] = $result[3][0];
		$_SESSION['ViewEntitySuite'] = $result[4][0];
		$_SESSION['ViewEntityCity'] = $result[5][0];
		$_SESSION['ViewEntityStateProvince'] = $result[6][0];
		$_SESSION['ViewEntityPostalCode'] = $result[7][0];
		$_SESSION['ViewEntityCountryCode'] = $result[8][0];

		$_SESSION['ViewEntityNationality'] = $result[9][0];

		$_SESSION['ViewBirthYear'] = $result[10][0];
		$_SESSION['ViewPhotoOrLogo'] = '';

		$_SESSION['ViewIpPhoneOrVideo'] = $result[11][0];
		$_SESSION['ViewLandline'] = $result[12][0];
		$_SESSION['ViewMobilePhone'] = $result[13][0];

		$_SESSION['ViewWebsite'] = $result[14][0];

		$_SESSION['ViewFirstName'] = $result[15][0];
		$_SESSION['ViewLastName'] = $result[16][0];
		$_SESSION['ViewMiddleName'] = $result[17][0];

		$_SESSION['ViewCompanyName'] = $result[18][0];

		$_SESSION['ViewNonprofitName'] = $result[19][0];

		$_SESSION['ViewEntityCountryName'] = $result[30][0];
		$_SESSION['ViewEntityNationalityName'] = $result[31][0];

		if ( file_exists("../entity_photos/".$_SESSION['ViewEntityId']) )
			$_SESSION['ViewPhotoOrLogo'] = "true";
		else
			$_SESSION['ViewPhotoOrLogo'] = "false";
	}
}
?> 
