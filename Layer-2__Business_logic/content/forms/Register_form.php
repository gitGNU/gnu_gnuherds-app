<?php
// Authors: Davi Leal
//
// Copyright (C) 2009 Davi Leal <davi at leals dot com>
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


require_once "../Layer-2__Business_logic/content/forms/Entity_form.php";

// Methods take the values from the global $_POST[] array.


class RegisterForm extends EntityForm
{
	private $data;


	public function processForm()
	{
		// Check the log in state and load the data
		if ( $_SESSION['Logged'] == '1' )
		{
			$error = "<p>".gettext('You are already logged in!')."</p>";
			throw new Exception($error,true);
		}

		// Process each button event
		if ( $_POST['register'] != '' )
		{
			$this->processRegisterForm();
		}
	}


	public function printOutput()
	{
		if ( $_POST['register'] != '' and $this->checks['result'] == "pass" )
			echo $this->processingResult;
		else
			$this->printRegisterForm();
	}


	private function printRegisterForm()
	{
		$smarty = new Smarty;
		$smarty->assign('data', $this->data);
		$smarty->assign('checks', $this->checks);
		$smarty->display("Access_form.tpl");
	}


	private function processRegisterForm()
	{
		// First check, later process

		// Checks
		$this->checkRegisterForm();

		// Save the values in $data variable
		$this->data['EntityType'] = $_POST['EntityType'];
		$this->data['Email'] = trim($_POST['Email']);

		// Update the values
		if ($this->checks['result'] == "pass" )
		{
			$this->requestRegister();
		}
	}


	private function checkRegisterForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		if ( trim($_POST['EntityType'])=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['EntityType'] = gettext('Please fill in here');
		}

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
}
