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
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Cooperative' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
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
		if ( !isset($_GET['JobOfferId']) or trim($_GET['JobOfferId']) == '' )
		{
			$error = "<p>".gettext('ERROR: The identifier to show has not been specified!')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( $_POST['save'] != '' )
		{
			for( $i=0; $i < count($_POST['ApplicationState']); $i++)
				$this->manager->setApplicationState($_GET['JobOfferId'],$_POST['ApplicationState'][$i],$_POST['EntityId'][$i]);
		}
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


		$result = $this->manager->getJobOfferApplications($_GET['JobOfferId']);

		$smarty->assign('vacancyTitle', $result['VacancyTitle']);

		$smarty->assign('entityId', $result['EntityId']);
		$smarty->assign('entityType', $result['EntityType']);

		$smarty->assign('street', $result['Street']);
		$smarty->assign('city', $result['City']);
		$smarty->assign('stateProvince', $result['StateProvince']);

		$smarty->assign('website', $result['Website']);

		$smarty->assign('firstName', $result['FirstName']);
		$smarty->assign('lastName', $result['LastName']);
		$smarty->assign('middleName', $result['MiddleName']);

		$smarty->assign('cooperativeName', $result['CooperativeName']);
		$smarty->assign('companyName', $result['CompanyName']);
		$smarty->assign('nonprofitName', $result['NonprofitName']);

		$smarty->assign('countryName', $result['CountryName']);
		$smarty->assign('professionalExperienceSinceYear', $result['ProfessionalExperienceSinceYear']);

		$smarty->assign('applicationState', $result['ApplicationState']);


		$smarty->display("Manage_Job_Offer_Applications_form.tpl");
	}
}
?> 
