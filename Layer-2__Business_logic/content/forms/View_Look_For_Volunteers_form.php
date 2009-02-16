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


class ViewLookForVolunteersForm
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
			$error = "<p>".gettext('ERROR: The identifier to show has not been specified!')."</p>";
			throw new Exception($error,false);
		}
		else
			$this->loadLookForVolunteersForm();

		// Process each button event
		   // No buttons to process
	}


	public function printOutput()
	{
		$this->printViewLookForVolunteersForm();
	}


	private function printViewLookForVolunteersForm()
	{
		// This function draw the form, with its controls. Note that the specific values of form controls are set via the $data array.
		// The $data array is loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in $data array.
		//   3. It is set in the smarty templates.

		$smarty = new Smarty;

		$smarty->assign('data', $this->data);
		$smarty->display("View_Look_For_Volunteers_form.tpl");
	}


	private function loadLookForVolunteersForm()
	{
		$result = $this->manager->getJobOffer($_GET['JobOfferId']);


		// If it is not the right notice type for this viewer then redirect to the right one.
		switch($result[62][0])
		{
			case 'Job offer':
				header('Location: /offers?id='.$_GET['JobOfferId']);
				exit;
			break;

			case 'Donation pledge group':
				header('Location: /pledges?id='.$_GET['JobOfferId']);
				exit;
			break;

			case 'Looking for volunteers':
			break;

			default:
				$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
				throw new Exception($error,false);
		}


		// J1_JobOffers table

		$this->data['EntityId'] = $result[26][0];

		$this->data['OfferDate'] = trim($result[1][0]);

		$this->data['VacancyTitle'] = ereg_replace("[[:alpha:]]+://[^<>[:space:]]+[[:alnum:]/]", "<a href=\"\\0\">\\0</a>", nl2br($result[60][0]) ); // Inserts HTML line breaks before all newlines and replace URLs with links
		$this->data['Description'] = ereg_replace("[[:alpha:]]+://[^<>[:space:]]+[[:alnum:]/]", "<a href=\"\\0\">\\0</a>", nl2br($result[61][0]) ); // Inserts HTML line breaks before all newlines and replace URLs with links


		// Entity table

		$result = $this->manager->getEntity($this->data['EntityId']);

		$this->data['Email'] = $result[0][0];
	}
}
?> 
