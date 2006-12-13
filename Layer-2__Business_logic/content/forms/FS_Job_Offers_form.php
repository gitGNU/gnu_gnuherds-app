<?php
// Authors: Davi Leal
//
// Copyright (C) 2006 Davi Leal <davi at leals dot com>
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


class FSJobOffersForm
{
	public function processForm()
	{
	}


	public function printOutput()
	{
		$this->printFSJobOffersForm();
	}


	private function printFSJobOffersForm()
	{
		$manager = new DBManager();
		$smarty = new Smarty;


		// Job Offers

		$result = $manager->getJobOffers();

		$smarty->assign('JobOfferId', $result[0]);

		$smarty->assign('Telework', $result[1]);

		$smarty->assign('CountryName', $result[2]);
		$smarty->assign('StateProvince', $result[3]);
		$smarty->assign('City', $result[4]);

		$smarty->assign('OfferDate', $result[5]);

		$smarty->assign('EntityId', $result[6]);
		$smarty->assign('EntityType', $result[7]);

		$smarty->assign('Website', $result[8]);

		$smarty->assign('EP_FirstName', $result[9]);
		$smarty->assign('EP_LastName', $result[10]);
		$smarty->assign('EP_MiddleName', $result[11]);

		$smarty->assign('EC_CompanyName', $result[12]);
		$smarty->assign('EO_OrganizationName', $result[13]);

		$smarty->assign('VacancyTitle', $result[14]);


		$smarty->display("FS_Job_Offers_form.tpl");
	}
}
?> 
