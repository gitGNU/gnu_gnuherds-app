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


class ViewDonationPledgeGroupForm
{
	private $manager;
	private $state;
	private $checks;
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
			$this->loadDonationPledgeGroupForm();

		// Process each button event

		// Initialized. It could be overwrite later.
		$this->state['IsAlreadySubscribed'] = false;
		$this->state['IsAlreadyDonator'] = false;

		if ( $_POST['donate'] != '' )
		{
			// Do nothing. Let the webapp show the donation form.
		}
		elseif ( $_POST['save_donation'] != '' )
		{
			// Prepare data for view: $this->data  and  $_POST  array.
			$this->prepareData4View();

			// Set the check marks
			$this->checkDonationForm();

			if ( $this->checks['result'] == "pass" )
			{
				$this->manager->addDonation($_GET['JobOfferId']);

				$this->state['IsAlreadyDonator'] = true;

				// Load again to list too the new donation
				$this->loadDonationPledgeGroupForm();
			}
		}
		elseif ( $_POST['subscribe'] != '' )
		{
			if ( isset($_SESSION['Logged']) and $_SESSION['Logged'] == '1' )
			{
				$this->state['IsAlreadySubscribed'] = $this->manager->IsAlreadySubscribed( $_SESSION['EntityId'], $_GET['JobOfferId'] );

				if ( $this->state['IsAlreadySubscribed'] == false )
				{
					$this->manager->subscribeApplication( $_SESSION['EntityId'], $_GET['JobOfferId'] );
					$this->state['IsAlreadySubscribed'] = true;
				}

				// Load again to list too the new application
				$this->loadDonationPledgeGroupForm();
			}
			//else // show the form to fill the Email
		}
		elseif ( $_POST['register_and_subscribe'] != '' ) // The webapp user is not logged, so she is posting her Email for subscription
		{
			// Prepare data for view: $this->data  and  $_POST  array.
			$this->prepareData4View();

			// Set the check marks
			$this->checkEmailForm();

			if ( $this->checks['result'] == "pass" )
			{
				$EntityId = $this->manager->getEntityId(trim($_POST['Email']),'REQUEST_SUBSCRIBE_TO_NOTICE_OPERATION'); // It registers the email and send the verification email if it is needed

				$this->state['IsAlreadySubscribed'] = $this->manager->IsAlreadySubscribed( $EntityId, $_GET['JobOfferId'] );

				if ( $this->state['IsAlreadySubscribed'] == false )
				{
					$this->manager->subscribeApplication( $EntityId, $_GET['JobOfferId'] );
					$this->state['IsAlreadySubscribed'] = true;
				}

				// Load again to list too the new application
				$this->loadDonationPledgeGroupForm();
			}
			//else // show the form to fill the Email again
		}
		else
		{
			// If the there is a user logged, check if she/he is already subscribed or is a donator for this notice
			if ( isset($_SESSION['Logged']) and $_SESSION['Logged'] == '1' )
			{
				$this->state['IsAlreadySubscribed'] = $this->manager->IsAlreadySubscribed( $_SESSION['EntityId'], $_GET['JobOfferId'] );
				$this->state['IsAlreadyDonator'] = $this->manager->IsAlreadyDonator( $_SESSION['EntityId'], $_GET['JobOfferId'] );
			}
		}
	}


	public function printOutput()
	{
		$this->printViewDonationPledgeGroupForm();
	}


	private function printViewDonationPledgeGroupForm()
	{
		// This function draw the form, with its controls. Note that the specific values of form controls are set via the $data array.
		// The $data array is loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in $data array.
		//   3. It is set in the smarty templates.

		$smarty = new Smarty;

		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);
		$smarty->assign('state', $this->state);
		$smarty->display("View_Donation_Pledge_Group_form.tpl");
	}


	private function prepareData4View()
	{
		// Save the section values in the $data variable

		$this->data['WageRank'] = isset($_POST['WageRank']) ? trim($_POST['WageRank']) : '';
		$this->data['Email'] = isset($_POST['Email']) ? trim($_POST['Email']) : '';
	}


	private function checkDonationForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass


		// Some field can not be empty

		define("MINIMUM_DONATION_PLEDGE", 0.02 ); // TODO: DELAYED: Move these constants to a central configuration file

		if ( $this->data['WageRank']=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['WageRank'] = gettext('Please fill in here');
		}
		elseif ( (float)($this->data['WageRank']) < MINIMUM_DONATION_PLEDGE )
		{
			$this->checks['result'] = "fail";
			$this->checks['WageRank'] = vsprintf(gettext('Please fill in here numeric greater or equal to %s'), MINIMUM_DONATION_PLEDGE );
		}

		if ( $_SESSION['Logged'] != '1' )
		{
			if ( $this->data['Email']=='' )
			{
				$this->checks['result'] = "fail";
				$this->checks['Email'] = gettext('Please fill in here');
			}
			else
			{
				// The Email field have to keep the right syntax
				if (!preg_match("/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/", $this->data["Email"]))
				{
					$this->checks['result'] = "fail";
					$this->checks['Email'] = gettext('Invalid email address');
				}
			}
		}
	}


	private function checkEmailForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass


		// Some field can not be empty

		if ( trim($_POST['Email'])=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['Email'] = gettext('Please fill in here');
		}
		else
		{
			// The Email field have to keep the right syntax
			if (!preg_match("/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/", trim($_POST["Email"])))
			{
				$this->checks['result'] = "fail";
				$this->checks['Email'] = gettext('Invalid email address');
			}
		}
	}


	private function loadDonationPledgeGroupForm()
	{
		$result = $this->manager->getJobOffer($_GET['JobOfferId']);


		// If it is not the right notice type for this viewer then redirect to the right one
		switch($result[62][0])
		{
			case 'Job offer':
				header('Location: /offers?id='.$_GET['JobOfferId']);
				exit;
			break;

			case 'Donation pledge group':
			break;

			case 'Looking for volunteers':
				header('Location: /volunteers?id='.$_GET['JobOfferId']);
				exit;
			break;

			default:
				$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
				throw new Exception($error,false);
		}


		// J1_JobOffers table

		$this->data['OfferDate'] = trim($result[1][0]);

		$this->data['VacancyTitle'] = ereg_replace("[[:alpha:]]+://[^<>[:space:]]+[[:alnum:]/]", "<a href=\"\\0\">\\0</a>", $result[60][0] ); // Replace URLs with links
		$this->data['Description'] = ereg_replace("[[:alpha:]]+://[^<>[:space:]]+[[:alnum:]/]", "<a href=\"\\0\">\\0</a>", $result[61][0] ); // Replace URLs with links


		// Donators table
		$this->data['Donators'] = $this->manager->getDonators($_GET['JobOfferId']);

		// Donators table
		$this->data['Applications'] = $this->manager->getJobOfferApplications($_GET['JobOfferId']);
	}
}
?> 
