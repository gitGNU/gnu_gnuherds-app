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


class ViewJobApplicationsStateForm
{
	private $manager;


	function __construct()
	{
		$this->manager = new DBManager();
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
	}


	public function printOutput()
	{
		$this->printViewJobApplicationsStateForm();
	}


	private function printViewJobApplicationsStateForm()
	{
		$smarty = new Smarty;


		// Job Applications

		switch ($_GET["section"]) {
			case "": case "offers":
				$offerType = "Job offer";
				break;

			case "pledges":
				$offerType = "Donation pledge group";
				break;

			case "volunteers":
				$offerType = "Looking for volunteers";
				break;

			default:
				$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
				throw new Exception($error,false);
		}
		$result = $this->manager->getJobApplicationsForEntity(" AND J1_OfferType='".$offerType."' ");

		$smarty->assign('jobOfferId', $result[0]);
		$smarty->assign('entityId', $result[1]);

		$smarty->assign('offerDate', $result[2]);
		$smarty->assign('state', $result[3]);

		if ( isset($result[4]) )
			$smarty->assign('vacancyTitle', $result[4]);

		$smarty->assign('offerType', $result[5]);


		if ( $offerType == "Donation pledge group" )
		{
			for ($i=0; $i < count($result[0]); $i++)
			{
				$donations[$i] = $this->manager->getDonationsForPledgeGroup( $result[0][$i] );
			}
			$smarty->assign('donations', $donations);
		}


		$smarty->display("View_Job_Applications_State_form.tpl");
	}
}
