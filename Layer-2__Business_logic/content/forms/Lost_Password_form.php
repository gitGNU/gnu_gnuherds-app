<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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


class LostPassword
{
	private $manager;
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
		if ( $_POST['send'] == gettext('Send') )
		{
			if ( $this->manager->lookForEntity() == true )
			{
				// Make the 'magic' flag
				$magic = md5( rand().rand().rand().rand().rand().rand().rand().rand().rand().rand().rand() );

				// Keep the 'magic' in the data base
				$this->manager->saveMagicForEntity($magic);

				// Send the email
				$message = gettext("For security reasons, GNU Herds does not send passwords by electronic mail.")."\n\n";

				$message .= gettext("To get your new password follow the below link:")."\n\n";

				if ( !$_SERVER['HTTPS'] or $_SERVER['HTTPS'] != 'on' )
					$message .= "http://";
				else	$message .= "https://";

				$message .= $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']."?email=".$_POST['Email']."&magic=".$magic;

				$message .= "\n\n";
				$message .= gettext("If you have not asked for a new password, ignore it and your password will not be changed.")."\n\n";

				mail($_POST['Email'], "GNU Herds: Lost password", "$message", "From: association@gnuherds.org");

				// Report to the user
				$this->processingResult .= "<p>&nbsp;</p><p>".gettext('An email has been sent to such address with the instructions to change the password.')."<p>\n";
			}
			else
			{
				$this->processingResult .= "<p>&nbsp;</p><p>".gettext('There is not member with that email!. Try again.')."</p>";
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
		if ( $_POST['send'] == gettext('Send') and $this->manager->lookForEntity() == true )
		{
			// Show just the processingResult
		}
		elseif ( isset($_GET['email']) and $_GET['email'] != '' )
		{
			// Show just the processingResult
		}
		elseif( ( $_POST['send'] == gettext('Send') and $this->manager->lookForEntity() == false ) or count($_POST)==0 )
		{
			// Show the form and the processingResult
			$this->printPersonForm();
		}
		elseif( isset($_GET['language']) )
		{
			// POST request: Submit from the language change form.

			// Show the form
			$this->printPersonForm();
		}

		if ( $_POST['send'] == gettext('Send') or $_GET['email'] != '' )
			echo $this->processingResult;
	}


	private function printPersonForm()
	{
		$smarty = new Smarty;
		$smarty->display("Lost_Password_form.tpl");
	}
}
?> 
