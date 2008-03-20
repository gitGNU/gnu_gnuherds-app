<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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


class LogForm
{
	public function processForm()
	{
		// We process the LogForm only if there is a submit, else nothing is done.
		if ( isset($_POST['login']) && $_POST['login'] != '' ) // The user is asking for testing him/her account-password.
			$this->logIn();
  		else if ( isset($_POST['logout']) && $_POST['logout'] != '' ) // The user is asking for closing the session.
			$this->logOut();
	}


	public function logIn()
	{
		$manager = new DBManager();
		$phpTools = new PHPTools();

		$array = array();
		$array = $manager->authenticateEntity(); // Methods take the values from the global $_POST[] array.
		$_SESSION['EntityId'] = $array[0];
		$_SESSION['LoginType'] = $array[1];
		$_SESSION['LoginEmail'] = $_POST['Email'];
		$_SESSION['SkillsAdmin'] = $array[2];

		if ($_SESSION['LoginType'] == false)
		{
			$_SESSION['Logged'] = false;
			$phpTools->resetPHPsession();
		}
		else
		{
			$_SESSION['Logged'] = '1';

			// We always save the last locale used by the entity, to be used to translate the Alert emails
			$manager->updateEntityLocale();

			// Set the "has/do-not-has qualifications" flag in a SESSION variable. It is used to build the menu at menu.tpl
			$result = $manager->getQualificationsForEntity($_SESSION['EntityId']);

			if ( count($result[0]) == 1 )
				$_SESSION['HasQualifications'] = true;
			else
				$_SESSION['HasQualifications'] = false;
		}
	}


	private function logOut()
	{
		$phpTools = new PHPTools();
		$phpTools->resetPHPsession();

		header("Location: http://$_SERVER[SERVER_NAME]/"); // We reditect to the home page
		exit;
	}
}
?>
