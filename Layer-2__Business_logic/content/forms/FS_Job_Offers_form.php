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


		// Job Offers table

		$this->data['JobOffers'] = $manager->getJobOffers(" AND ( J1_OfferType='Job offer' OR J1_OfferType='Job offer (post faster)' ) ORDER BY J1_OfferDate DESC "); // Default ORDER BY, to stand out the last updated or added entries.  //TODO: XXX: Allow ORDER BY other fields via GET parameters.


		$smarty->assign('data', $this->data);

		if ( $_GET['format'] == 'rss' )
		{
			// Set the Language session variable
			$language = new LanguageForm();
			$language->processForm();

			ob_end_clean(); // Clean the output buffer to discart previous garbage, that is to say, the empty lines at page top.
			ob_start(); // Turn on output buffering again to avoid webapp error.

			$smarty->display("FS_Job_Offers_RSS.tpl");
		}
		else
		{
			$smarty->display("FS_Job_Offers_form.tpl");
		}
	}
}
