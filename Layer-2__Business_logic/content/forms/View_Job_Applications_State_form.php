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

		$result = $this->manager->getJobApplicationsForEntity();

		$smarty->assign('jobOfferId', $result[0]);
		$smarty->assign('entityId', $result[1]);

		$smarty->assign('offerDate', $result[2]);
		$smarty->assign('state', $result[3]);

		if ( isset($result[4]) )
			$smarty->assign('vacancyTitle', $result[4]);


		$smarty->display("View_Job_Applications_State_form.tpl");
	}
}
?> 
