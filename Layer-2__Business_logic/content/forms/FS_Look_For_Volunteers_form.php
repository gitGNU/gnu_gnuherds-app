<?php
// Authors: Davi Leal
//
// Copyright (C) 2008, 2009 Davi Leal <davi at leals dot com>
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


class FSLookForVolunteersForm
{
	public function processForm()
	{
	}


	public function printOutput()
	{
		$this->printFSLookForVolunteersForm();
	}


	private function printFSLookForVolunteersForm()
	{
		$manager = new DBManager();
		$smarty = new Smarty;


		// Job Offers

		$result = $manager->getJobOffers(" AND J1_OfferType='Looking for volunteers' ORDER BY J1_OfferDate DESC "); // Default ORDER BY, to stand out the last updated or added entries.  //TODO: XXX: Allow ORDER BY other fields via GET parameters.

		$smarty->assign('JobOfferId', $result[0]);

		$smarty->assign('Telework', $result[1]);

		$smarty->assign('CountryName', $result[2]);
		$smarty->assign('StateProvince', $result[3]);
		$smarty->assign('City', $result[4]);

		$smarty->assign('OfferDate', $result[5]);

		$smarty->assign('EntityId', $result[6]);
		$smarty->assign('EntityType', $result[7]);

		$smarty->assign('Blog', $result[8]);
		$smarty->assign('Website', $result[9]);

		$smarty->assign('EP_FirstName', $result[10]);
		$smarty->assign('EP_LastName', $result[11]);
		$smarty->assign('EP_MiddleName', $result[12]);

		$smarty->assign('EC_CooperativeName', $result[20]);
		$smarty->assign('EC_CompanyName', $result[13]);
		$smarty->assign('EO_OrganizationName', $result[14]);

		$smarty->assign('VacancyTitle', $result[15]);


		if ( $_GET['format'] == 'rss' )
		{
			// Set the Language session variable
			$language = new LanguageForm();
			$language->processForm();

			ob_end_clean(); // Clean the output buffer to discart previous garbage, that is to say, the empty lines at page top.
			ob_start(); // Turn on output buffering again to avoid webapp error.

			$smarty->display("FS_Look_For_Volunteers_RSS.tpl");
		}
		else
		{
			$smarty->display("FS_Look_For_Volunteers_form.tpl");
		}
	}
}
