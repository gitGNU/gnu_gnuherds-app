<?php
// Authors: Davi Leal
//
// Copyright (C) 2007 Davi Leal <davi at leals dot com>
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

		// Check the log in state and load the data
		if ( $_SESSION['Logged'] != '1' )
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( isset($_POST['save']) and $_POST['save'] != '' )
			$this->saveAlertsForm();
		else
			$this->loadAlertsForm();
	}


	public function printOutput()
	{
		if ( $_POST['save'] != '' )
			echo $this->processingResult;
		else
			$this->printAlertsForm();
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

		$this->manager->saveAlertsForEntity();
		$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p><p>&nbsp;</p>\n";
	}


	private function loadAlertsForm()
	{
		$result = $this->manager->getAlertsForEntity();

		if ($result[0][0]=='t')
			$this->data['NewJobOffer'] = "true";
		else
			$this->data['NewJobOffer'] = "false";

		return true;
	}
}
?> 
