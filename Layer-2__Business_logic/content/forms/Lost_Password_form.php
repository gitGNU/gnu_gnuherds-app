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

// Methods take the values from the global $_POST[] array.


class LostPassword
{
	private $manager;
	private $checks;
	private $processingResult;


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
			$error = "<p>".gettext("You are already logged!. So we suppose you know your password. Anyway, log out and ask for it again if you want we send it to you.")."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( $_POST['send'] != '' )
		{
			// Checks
			$this->checkLostPasswordForm();

			if ($this->checks['result'] == "pass" )
			{
				if ( $this->manager->lookForEntity($_POST['Email']) == true )
				{
					// Check to avoid spam
					// If we do not send the email, to avoid possible spam, we do not add the 'magic' to the data base because of without that email the user will not be able to use the 'magic' to get a new password.
					if ( $this->manager->allowLostPasswordEmail($_POST['Email']) == true )
					{
						// Make the 'magic' flag
						$magic = md5( rand().rand().rand().rand().rand().rand().rand().rand().rand().rand().rand() );

						// Keep the 'magic' in the data base
						$this->manager->saveLostPasswordMagicForEntity($magic);

						// Send the email
						$message = gettext("For security reasons, GNU Herds does not send passwords by electronic mail.")."\n\n";

						$message .= gettext("To get your new password follow the below link.")." ".gettext("That link will expire in 30 minutes:")."\n\n";

						$message .= "https://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']."?email=".$_POST['Email']."&magic=".$magic;

						$message .= "\n\n";
						$message .= gettext("If you have not asked for a new password, ignore it and your password will not be changed.")."\n\n";

						mail($_POST['Email'], "GNU Herds: ".gettext("Lost password?"), "$message", "From: association@gnuherds.org");
					}
				}

				// Report to the user
				$this->processingResult .= "<p>&nbsp;</p><p>".vsprintf(gettext('An email has been sent to %s with the instructions to change the password.'),"<span class='must'>{$_POST['Email']}</span>")."<p>\n";
			}
		}
		elseif ( isset($_GET['email']) and $_GET['email'] != '' )
		{
			// Get and set a new password for the Entity who has that email
			$new_password = $this->manager->setNewPasswordForEntity();

			if ( $new_password != false )
			{
				// Show the new password
				$this->processingResult .= "<p>&nbsp;</p>\n";
				$this->processingResult .= "<p>&nbsp; &nbsp; &nbsp; &nbsp; ".gettext("Your new password is:")." <strong>".$new_password."</strong></p>\n";
				$this->processingResult .= "<p>&nbsp; &nbsp; &nbsp; &nbsp; ".gettext("To improve your security, you should change your password after loging in.")."</p>";
			}
		}
	}


	public function printOutput()
	{
		if ( $_POST['send'] != '' )
		{
			// Show the form
			$this->printPersonForm();
		}
		elseif ( isset($_GET['email']) and $_GET['email'] != '' )
		{
			// Show just the processingResult
		}
		elseif( isset($_GET['language']) )
		{
			// GET request from the language change form.

			// Show the form
			$this->printPersonForm();
		}
		else
		{
			// Show the form
			$this->printPersonForm();
		}

		if ( ( $_POST['send'] != '' and $this->checks['result'] == "pass" )  or $_GET['email'] != '' )
			echo $this->processingResult;
	}


	private function printPersonForm()
	{
		$smarty = new Smarty;

		$smarty->assign('checks', $this->checks);

		$smarty->display("Lost_Password_form.tpl");
	}


	private function checkLostPasswordForm()
	{
		$this->checks['result'] = "pass"; // By default the checks pass

		if ( trim($_POST['Email'])=='' )
		{
			$this->checks['result'] = "fail";
			$this->checks['Email'] = gettext('Please fill in here');
		}
		else
		{
			// The Email field have to keep the right syntax
			if (!preg_match("/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/", $_POST["Email"]))
			{
				$this->checks['result'] = "fail";
				$this->checks['Email'] = gettext('Invalid email address');
			}
		}
	}
}
?>
