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


class ManageJobOfferApplicationsForm
{
	private $manager;
	private $processingResult;


	function __construct()
	{
		$this->manager = new DBManager();
		$this->processingResult = '';
	}


	public function processForm()
	{
		// Check the log in state
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

		// Check parameters
		if ( !isset($_POST['JobOfferId']) or trim($_POST['JobOfferId']) == '' )
		{
			$error = "<p>".gettext('ERROR: The identifier to show has not been specified!.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( $_POST['ApplicationState'] != '' )
			$this->manager->setApplicationState($_POST['JobOfferId'],$_POST['ApplicationState'],$_POST['EntityId']);
	}


	public function printOutput()
	{
		$this->printManageJobOfferApplicationsForm();
	}


	private function printManageJobOfferApplicationsForm()
	{
		$smarty = new Smarty;


		$applicationStates = $this->manager->getApplicationStatesList();

		$smarty->assign('applicationStatesId', array_keys($applicationStates));
		$smarty->assign('applicationStatesIdTranslated', array_values($applicationStates));


		$result = $this->manager->getJobOfferApplications($_POST['JobOfferId']);

		$smarty->assign('vacancyTitle', $result[0]);

		$smarty->assign('entityId', $result[1]);

		$smarty->assign('entityType', $result[2]);

		$smarty->assign('street', $result[3]);
		$smarty->assign('city', $result[4]);
		$smarty->assign('stateProvince', $result[5]);

		$smarty->assign('website', $result[6]);

		$smarty->assign('firstName', $result[7]);
		$smarty->assign('lastName', $result[8]);
		$smarty->assign('middleName', $result[9]);

		$smarty->assign('companyName', $result[10]);
		$smarty->assign('organizationName', $result[11]);

		$smarty->assign('countryName', $result[12]);
		$smarty->assign('professionalExperienceSinceYear', $result[13]);
		$smarty->assign('academicQualification', $result[14]);

		$smarty->assign('applicationState', $result[15]);


		$smarty->display("Manage_Job_Offer_Applications_form.tpl");
	}
}
?> 
