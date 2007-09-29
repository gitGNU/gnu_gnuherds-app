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


class ManageJobOffersForm
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

		// Process each button event
		if ( $_POST['delete'] != '' )
		{
			if ( count($_POST['DeleteJobOffers']) >= 1 )
			{
				$this->manager->deleteSelectedJobOffers();
				$this->processingResult .= "<p>&nbsp;</p><p>".gettext('The selected job offers has been deleted from the data base.')."<p>\n";
			}
			else
			{
				$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Offers to delete have not been selected. Try again.')."<p>\n";
			}
		}
	}


	public function printOutput()
	{
		if ( $_POST['delete'] != '' )
			echo $this->processingResult;
		else
			$this->printManageJobOffersForm();
	}


	private function printManageJobOffersForm()
	{
		$smarty = new Smarty;


		// Job Offers

		$result = $this->manager->getJobOffersForEntity();

		$this->data['JobOfferId'] = $result[0];
		$this->data['OfferDate'] = $result[1];
		$this->data['ExpirationDate'] = $result[2];
		$this->data['Closed'] = $result[3];
		$this->data['VacancyTitle'] = isset($result[4]) ? $result[4] : '';


		// Meters

		$receivedMeter = array();
		$inProcessMeter = array();
		$ruledOutMeter = array();
		$finalistMeter = array();
		$selectedMeter = array();

		for ($i=0; $i < count($result[0]); $i++)
		{
			$receivedMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Received' );
			$inProcessMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'In process' );
			$ruledOutMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Ruled out' );
			$finalistMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Finalist' );
			$selectedMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Selected' );
		}

		$smarty->assign('ReceivedMeter', $receivedMeter);
		$smarty->assign('InProcessMeter', $inProcessMeter);
		$smarty->assign('RuledOutMeter', $ruledOutMeter);
		$smarty->assign('FinalistMeter', $finalistMeter);
		$smarty->assign('SelectedMeter', $selectedMeter);


		$smarty->assign('data', $this->data);
		$smarty->display("Manage_Job_Offers_form.tpl");
	}
}
?> 
