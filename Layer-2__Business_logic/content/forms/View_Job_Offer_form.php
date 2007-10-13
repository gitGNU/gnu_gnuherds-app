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
	private $data;


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

		if ( isset($_POST['subscribe']) and $_POST['subscribe'] != '' )
		{
			if ( isset($_SESSION['Logged']) and $_SESSION['Logged'] == '1' )
			{
				if ( ($_SESSION['LoginType']=='Person' and $this->data['AllowPersonApplications']=="true") or ($_SESSION['LoginType']=='Company' and $this->data['AllowCompanyApplications']=="true") or ($_SESSION['LoginType']=='non-profit Organization' and $this->data['AllowOrganizationApplications']=="true") )
				{
					if ($this->data['Email'] == $_SESSION['LoginEmail'] )
					{
						$error = "<p>".gettext("You can not subscribe to you own offer.")."</p>";
						throw new Exception($error,false);
					}
					else
					{
						$result = $this->manager->getQualificationsForEntity($_SESSION['EntityId']);
						if ( count($result[0]) == 1 and $result[10][0] == 't' )
						{
							$_SESSION['IsAlreadySubscribed'] = $this->manager->IsAlreadySubscribed( $_SESSION['EntityId'], $_GET['JobOfferId'] );

							if ( $_SESSION['IsAlreadySubscribed'] == false )
								$_SESSION['IsAlreadySubscribed'] = $this->manager->subscribeApplication( $_SESSION['EntityId'], $_GET['JobOfferId'] );
						}
						else
						{
							$error = "<p>".gettext("To be able to subscribe your application, you have to fill the Qualification form.")."<br>".gettext("See the").' <a href="faq#How_to_subscribe">'.gettext("FAQ")."</a>.</p>";
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
				$error = "<p>".gettext("To be able to subscribe your application, you have to log in first.")."<br>".gettext("See the").' <a href="faq#How_to_subscribe">'.gettext("FAQ")."</a>.</p>";
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
		// This function draw the form, with its controls. Note that the specific values of form controls are set via the $data array.
		// The $data array is loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in $data array.
		//   3. It is set in the smarty templates.

		$smarty = new Smarty;

		$smarty->assign('data', $this->data);
		$smarty->display("View_Job_Offer_form.tpl");
	}


	private function loadJobOfferForm()
	{
		$result = $this->manager->getJobOffer($_GET['JobOfferId']);


		// J1_JobOffers table

		$this->data['EntityId'] = $result[26][0];
		$this->data['CompletedEdition'] = $result[27][0];

		$this->data['EmployerJobOfferReference'] = trim($result[0][0]);
		$this->data['OfferDate'] = trim($result[1][0]);

		if ($result[3][0]=='t')
			$this->data['Closed'] = "true";
		else
			$this->data['Closed'] = "false";

		if ($result[4][0]=='t')
			$this->data['HideEmployer'] = "true";
		else
			$this->data['HideEmployer'] = "false";

		if ($result[5][0]=='t')
			$this->data['AllowPersonApplications'] = "true";
		else
			$this->data['AllowPersonApplications'] = "false";

		if ($result[6][0]=='t')
			$this->data['AllowCompanyApplications'] = "true";
		else
			$this->data['AllowCompanyApplications'] = "false";

		if ($result[7][0]=='t')
			$this->data['AllowOrganizationApplications'] = "true";
		else
			$this->data['AllowOrganizationApplications'] = "false";

		$this->data['Vacancies'] = trim($result[8][0]);

		$this->data['ContractType'] = $result[9][0];
		$this->data['WageRank'] = $result[10][0];
		$this->data['WageRankCurrency'] = $result[11][0];
		$this->data['WageRankCurrencyName'] = $result[12][0];
		$this->data['WageRankByPeriod'] = $result[13][0];
		$this->data['EstimatedEffort'] = $result[23][0];
		$this->data['TimeUnit'] = $result[24][0];

		$this->data['ProfessionalExperienceSinceYear'] = trim($result[14][0]);
		$this->data['AcademicQualification'] = trim($result[15][0]);

		// Profiles tables
		$this->data['ProductProfileList'] = $result[30];
		$this->data['ProfessionalProfileList'] = $result[31];
		$this->data['FieldProfileList'] = $result[32];

		// Skills tables
		$this->data['SkillList'] = $result[43];
		$this->data['KnowledgeLevelList'] = $result[44];
		$this->data['ExperienceLevelList'] = $result[45];
		$this->data['CheckList'] = $result[46];

		// Do not show Non-Free or Pending skills
		$count = count($this->data['CheckList']);
		for ($i=0,$j=0; $i < $count; $i++)
		{
			if ( $this->data['CheckList'][$i]=='Non-Free' or $this->data['CheckList'][$i]=='Pending' )
			{
			}
			else
			{
				$this->data['SkillList'][$j] = $this->data['SkillList'][$i];
				$this->data['KnowledgeLevelList'][$j] = $this->data['KnowledgeLevelList'][$i];
				$this->data['ExperienceLevelList'][$j] = $this->data['ExperienceLevelList'][$i];
				$this->data['CheckList'][$j] = $this->data['CheckList'][$i];
				$j++;
			}
		}
		for( $i=$j; $i < $count; $i++)
		{
			unset( $this->data['SkillList'][$i] );
			unset( $this->data['KnowledgeLevelList'][$i] );
			unset( $this->data['ExperienceLevelList'][$i] );
			unset( $this->data['CheckList'][$i] );
		}

		$this->data['CertificationsList'] = $result[50];

		$this->data['FreeSoftwareExperiences'] = trim($result[16][0]);

		// Languages table
		$this->data['LanguageList'] = $result[40];
		$this->data['LanguageSpokenLevelList'] = $result[41];
		$this->data['LanguageWrittenLevelList'] = $result[42];

		if ($result[17][0]=='t')
			$this->data['Telework'] = "true";
		else
			$this->data['Telework'] = "false";

		$this->data['JobOfferCity'] = $result[18][0];
		$this->data['JobOfferStateProvince'] = $result[19][0];
		$this->data['JobOfferCountryName'] = $result[25][0];

		if ($result[21][0]=='t')
			$this->data['AvailableToTravel'] = "true";
		else
			$this->data['AvailableToTravel'] = "false";

		$this->data['VacancyTitle'] = $result[60][0];


		// Entity table

		$result = $this->manager->getEntity($this->data['EntityId']); // EntityId, owner of the JobOffer, to be shown at the template.

		$this->data['Email'] = $result[0][0];

		$this->data['EntityType'] = $result[2][0];

		$this->data['EntityStreet'] = $result[3][0];
		$this->data['EntitySuite'] = $result[4][0];
		$this->data['EntityCity'] = $result[5][0];
		$this->data['EntityStateProvince'] = $result[6][0];
		$this->data['EntityPostalCode'] = $result[7][0];
		$this->data['EntityCountryCode'] = $result[8][0];

		$this->data['EntityNationality'] = $result[9][0];

		$this->data['BirthYear'] = $result[10][0];
		$this->data['PhotoOrLogo'] = '';

		$this->data['IpPhoneOrVideo'] = $result[11][0];
		$this->data['Landline'] = $result[12][0];
		$this->data['MobilePhone'] = $result[13][0];

		$this->data['Website'] = $result[14][0];

		$this->data['FirstName'] = $result[15][0];
		$this->data['LastName'] = $result[16][0];
		$this->data['MiddleName'] = $result[17][0];

		$this->data['CompanyName'] = $result[18][0];

		$this->data['NonprofitName'] = $result[19][0];

		$this->data['EntityCountryName'] = $result[30][0];
		$this->data['EntityNationalityName'] = $result[31][0];

		if ( file_exists("../entity_photos/".$this->data['EntityId']) )
			$this->data['PhotoOrLogo'] = "true";
		else
			$this->data['PhotoOrLogo'] = "false";
	}
}
?> 
