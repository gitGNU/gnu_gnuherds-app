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


abstract class EntityForm
{
	protected $manager;
	protected $checks;
	protected $processingResult;


	function __construct()
	{
		$this->manager = new DBManager();
		$this->processingResult = '';
	}


	// Force extending class to define this methods
	abstract public function processForm();
	abstract public function printOutput();


	// Common methods -- Reference: http://www.php.net/manual/en/language.oop5.abstract.php

	protected function register()
	{
		if ( $this->manager->lookForEntity($_GET['email']) == true )
		{
			// Check to avoid spam
			if ( $this->manager->allowActivateAccountEmail($_GET['email']) == true )
			{
				// Send a warning email
				$message = gettext("An attempt was made to activate a new GNU Herds account with this email address.")." ".gettext("However, you have already an active account! Follow the below link to get your lost password if it is needed:")."\n\n";

				$message .= "https://".$_SERVER['HTTP_HOST']."/password";

				$message .= "\n\n";
				$message .= gettext("If you have not asked for this new account, someone else has asked for it with your email!")."\n\n";

				mail($_GET['email'], "GNU Herds: ".gettext("Lost password?"), "$message", "From: association@gnuherds.org");
			}

			// Raise the usual error message
			$error = "<p>".gettext("ERROR: Wrong magic number!.")."</p>";
			throw new Exception($error,false);
		}
		else
		{
			// Try to activate a pending account
			$new_password = $this->manager->activateAccountForEntity();

			if ( $new_password != false )
			{
				$this->processingResult .= "<p>&nbsp;</p>\n";
				$this->processingResult .= "<p>&nbsp; &nbsp; &nbsp; &nbsp; ".gettext("Your account has been activated!")."</p>\n";

				// Show the password
				$this->processingResult .= "<p>&nbsp;</p>\n";
				$this->processingResult .= "<p>&nbsp; &nbsp; &nbsp; &nbsp; ".gettext("Your new password is:")." <strong>".$new_password."</strong></p>\n";
				$this->processingResult .= "<p>&nbsp; &nbsp; &nbsp; &nbsp; ".gettext("To improve your security, you should change your password after loging in.")."</p>";
			}
		}
	}

	protected function changeEmail()
	{
		// Try to change the account's email
		// The entity has to be logged, else it will fail at the Layer-5.
		if ( $this->manager->changeEmailForEntity() == true )
		{
			$this->processingResult .= "<p>&nbsp;</p>\n";
			$this->processingResult .= "<p>&nbsp; &nbsp; &nbsp; &nbsp; ".gettext("The email has been changed!")."</p>\n";
		}
	}

	protected function requestChangeEmail()
	{
		// Make the 'magic' flag
		$magic = md5( rand().rand().rand().rand().rand().rand().rand().rand().rand().rand().rand() );

		// Keep the 'magic' in the data base
		$this->manager->saveWantEmailMagicForEntity($magic);

		// Spam is not possible due to this operation is only raised by the entity when he/she is logged.
		// Send the email
		$message .= gettext("To change your GNU Herds account's email, first log in and then follow the below link.")." ".gettext("That link will expire in 7 days:")."\n\n";

		$message .= "https://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']."?email=".$_POST['Email']."&magic=".$magic;

		$message .= "\n\n";
		$message .= gettext("If you have not asked for it, just ignore this email.")."\n\n";

		mail($_POST['Email'], "GNU Herds: ".gettext("Change account's email"), "$message", "From: association@gnuherds.org");

		// Report to the user
		$this->processingResult .= "<p>&nbsp;</p><p>".gettext('An email has been sent to the new email address to validate it.')."<p>\n";
	}

	protected function requestRegister()
	{
		if ( $this->manager->lookForEntity($_POST['Email']) == true )
		{
			// Check to avoid spam
			if ( $this->manager->allowRegisterAccountDuplicatedEmail($_POST['Email']) == true )
			{
				$message = gettext("An attempt was made to register a new GNU Herds account with this email address.")." ".gettext("However, you have already an active account! Follow the below link to get your lost password if it is needed:")."\n\n";

				$message .= "https://".$_SERVER['HTTP_HOST']."/password";

				$message .= "\n\n";
				$message .= gettext("If you have not asked for this new account, someone else has asked for it with your email!")."\n\n";

				mail($_POST['Email'], "GNU Herds: ".gettext("Lost password?"), "$message", "From: association@gnuherds.org");
			}
		}
		else
		{
			// Make the 'magic' flag
			$magic = md5( rand().rand().rand().rand().rand().rand().rand().rand().rand().rand().rand() );

			$this->manager->addEntity($magic);

			// Send the email
			$message = gettext("Your email has been used to create an account at GNU Herds.")."\n\n";

			$message .= gettext("To activate it follow the below link.")." ".gettext("That link will expire in 24 hours:")."\n\n";

			$message .= "https://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']."?action=register&email=".$_POST['Email']."&magic=".$magic;

			$message .= "\n\n";
			$message .= gettext("If you have not asked for this new account, ignore this email.")."\n\n";

			$message .= gettext("Note: To avoid 'Spam' you can only get this email at the most once each 48 hours. If this email is Spam for you, please let it knows to  association AT gnuherds.org")."\n\n";

			mail($_POST['Email'], "GNU Herds: ".gettext("Activate account"), "$message", "From: association@gnuherds.org");
		}

		// Report to the user
		$this->processingResult .= "<p>&nbsp;</p><p>".vsprintf(gettext('Success. An email has been sent to %s with the instructions to activate the account.'),"<span class='must'>{$_POST['Email']}</span>")."<p>\n";
	}
}
?>
