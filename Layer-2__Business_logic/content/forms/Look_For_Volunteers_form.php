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


require_once "../Layer-2__Business_logic/content/forms/Skills_form.php";

// Methods take the values from the global $_POST[] array.


class LookForVolunteersForm
{
	protected $manager;
	protected $checks;
	protected $data;


	function __construct()
	{
		$this->manager = new DBManager();
	}


	public function processForm()
	{
		// Process each button event
		if ( $_POST['save'] != '' ) // new or update
		{
			$this->saveLookForVolunteersForm();
		}
		elseif ( $_GET['JobOfferId'] == '') // new
		{
		}
		elseif ( $_GET['JobOfferId'] != '') // update
		{
			$this->loadLookForVolunteersForm();
		}
		elseif ( isset($_GET['language']) ) // change language
		{
			// GET request: Submit from the language change form
		}
		else
		{
			$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
			throw new Exception($error,false);
		}
	}


	public function printOutput()
	{
		if ( $this->checks['result'] == "pass" )
		{
			header('Location: /volunteers?id='.$_GET['JobOfferId']); // We reditect to the view-OfferType web page
			exit;
		}
		else
		{
			$this->printLookForVolunteersForm();
		}
	}


	private function printLookForVolunteersForm()
	{
		$smarty = new Smarty;

		// This function draw the form, with its controls. Note that the specific values of form controls are set via the $data array.
		// The $data array is loaded from the Data Base:
		//   1. It is in the Data Base.
		//   2. It is in $data array.
		//   3. It is set in the smarty templates.

		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);
		$smarty->display("Look_For_Volunteers_form.tpl");
	}


	private function saveLookForVolunteersForm()
	{
		// Prepare data for view: $this->data  and  $_POST  array.
		$this->prepareData4View();

		// Set the check marks
		$this->checkLookForVolunteersForm();

		if ( $this->checks['result'] == "pass" )
		{
			$completedEdition = "true";
			$_POST['ExpirationDate'] = date("Y/m/d", mktime(0, 0, 0, date("m")+1, date("d"), date("Y")) ); // '+1' means the look-for-volunteers notice will expire in one month.  XXX: TODO: cronjob to clean expired entries.

			// Update or insert the values
			if ( $_GET['JobOfferId'] != '' ) // update
			{
				$section = "general";
				$this->manager->updateJobOffer($_GET['JobOfferId'],$section,$completedEdition);
			}
			else // new
			{
				// Make the 'magic' flag.  The 'magic' is needed if the entity is not registered yet.
				$magic = md5( rand().rand().rand().rand().rand().rand().rand().rand().rand().rand().rand() );

				$offerType = 'Looking for volunteers';
				$_GET['JobOfferId'] = $this->manager->addJobOffer($offerType,$completedEdition,$magic); // Add a new job offer with the data from the 'general' section
			}
		}

	}


	private function prepareData4View()
	{
		// Save the section values in the $data variable

		$this->data['VacancyTitle'] = isset($_POST['VacancyTitle']) ? trim($_POST['VacancyTitle']) : '';
		$this->data['Description'] = isset($_POST['Description']) ? trim($_POST['Description']) : '';
		$this->data['Email'] = isset($_POST['Email']) ? trim($_POST['Email']) : '';
	}


	private function checkLookForVolunteersForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		// Note that the POST values has been saved in $data before calling this method. We use $data instead POST due to they have the isset check done, and we want to avoid to repeat it.  :P


		// Some field can not be empty

		if ( $this->data['VacancyTitle']=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['VacancyTitle'] = gettext('Please fill in here');
		}

		if ( $this->data['Description']=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['Description'] = gettext('Please fill in here');
		}

		if ( $_GET['JobOfferId'] == '' ) // new
		{
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
					if (!preg_match("/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/", $this->data['Email']))
					{
						$this->checks['result'] = "fail";
						$this->checks['Email'] = gettext('Invalid email address');
					}
				}
			}
		}
	}


	private function loadLookForVolunteersForm()
	{
		// We load the data of all the sections, but only process and show one of them.

		$result = $this->manager->getJobOffer($_GET['JobOfferId']);


		// JobOffers table

		$this->data['VacancyTitle'] = trim($result[60][0]);
		$this->data['Description'] = trim($result[61][0]);
	}
}
?>
