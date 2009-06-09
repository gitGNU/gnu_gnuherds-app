<?php
// Authors: Davi Leal
//
// Copyright (C) 2007, 2008, 2009 Davi Leal <davi at leals dot com>
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
require_once "../lib/PHP_Tools.php";


class AlertsForm
{
	private $manager;
	private $processingResult;
	private $data;


	function __construct()
	{
		$this->manager = new DBManager();
		$this->processingResult = '';
	}


	public function processForm()
	{
		$phpTools = new PHPTools();

		// Check the log in state
		if ( $_SESSION['Logged'] != '1' )
		{
			return;
		}

		// Process each button event
		if ( isset($_POST['save']) and $_POST['save'] != '' )
			$this->saveAlertsForm();
		else
			$this->loadAlertsForm();
	}


	public function printOutput()
	{
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_POST['save'] != '' )
				echo $this->processingResult;
			else
				$this->printAlertsForm();
		}
		else
		{
			echo "<p>".gettext('To access this section you have to login first.')."</p><p>&nbsp;</p>";

			$smarty = new Smarty;
			$smarty->display("Access_form.tpl");
		}
	}


	private function printAlertsForm()
	{
		$smarty = new Smarty;

		$smarty->assign('data', $this->data);
		$smarty->display("Alerts_form.tpl");
	}


	private function saveAlertsForm()
	{
		if (isset($_POST['NewJobOffer']) and $_POST['NewJobOffer']=='on')
			$_POST['NewJobOffer'] = "true";
		else
			$_POST['NewJobOffer'] = "false";

		if (isset($_POST['NewDonationPledgeGroup']) and $_POST['NewDonationPledgeGroup']=='on')
			$_POST['NewDonationPledgeGroup'] = "true";
		else
			$_POST['NewDonationPledgeGroup'] = "false";

		if (isset($_POST['NewLookForVolunteers']) and $_POST['NewLookForVolunteers']=='on')
			$_POST['NewLookForVolunteers'] = "true";
		else
			$_POST['NewLookForVolunteers'] = "false";

		if (isset($_POST['AlertMeOnMyOwnNotices']) and $_POST['AlertMeOnMyOwnNotices']=='on')
			$_POST['AlertMeOnMyOwnNotices'] = "true";
		else
			$_POST['AlertMeOnMyOwnNotices'] = "false";

		$this->manager->saveAlertsForEntity();
		$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p><p>&nbsp;</p>\n";
	}


	private function loadAlertsForm()
	{
		$result = $this->manager->getAlertsForEntity();

		if ($result['NewJobOffer'][0]=='t')
			$this->data['NewJobOffer'] = "true";
		else
			$this->data['NewJobOffer'] = "false";

		if ($result['NewDonationPledgeGroup'][0]=='t')
			$this->data['NewDonationPledgeGroup'] = "true";
		else
			$this->data['NewDonationPledgeGroup'] = "false";

		if ($result['NewLookForVolunteers'][0]=='t')
			$this->data['NewLookForVolunteers'] = "true";
		else
			$this->data['NewLookForVolunteers'] = "false";

		if($result['AlertMeOnMyOwnNotices'][0]=='t')
			$this->data['AlertMeOnMyOwnNotices'] = "true";
		else
			$this->data['AlertMeOnMyOwnNotices'] = "false";

		return true;
	}
}
