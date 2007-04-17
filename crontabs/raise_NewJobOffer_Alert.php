<?php
// Authors: Davi Leal
// 
// Copyright (C) 2007 Davi Leal <davi at leals dot com>
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


require_once "../Layer-2__Business_logic/others/Language_form.php";
require_once "../Layer-4__DBManager_etc/DB_Manager.php";


function raiseNewJobOfferAlerts() // Alerts on any NewJobOffer
{
	$manager = new DBManager();
	$languageForm = new LanguageForm();

	// Before do anything, check if there are NewJobOffer alerts to raise.
	if ( $manager->pendingNewJobOfferAlerts() == false )
		return;

	// Get the language set (E1_LL_Locale). Only for the entities who has this alert activated. If there are no any entity, we do nothing in the next 'for' loop.
	$languages = $manager->getNewJobOfferAlertsLocales();

	// For each E1_LL_Locale:
	for ( $i=0; $i < count($languages); $i++ )
	{
		// Set the locale
		$languageForm->setLocale($languages[$i]);

		// Get the email set (E1_Email) for entities using that (E1_Locale)
		$emails = $manager->getNewJobOfferAlertsEmails($languages[$i]);

		// Get the array which describe the job offers, with some parts already localized
		$result = $manager->getNewJobOffers();

		// Write the email
		$message = "";
		for ( $j=0; $j < count($result[0]); $j++ )
		{
			// Create the email text
			$message .= gettext("Vacancy title").": ".$result[14][$j]."\n";

			$message .= gettext("Location").": ";
			if ( trim($result[2][$j]) == '' )
			{
				$message .= gettext("Any").", ".gettext("telework");
			}
			else
			{
				$message .= gettext($result[2][$j]);
				if ($result[3][$j] != '') $message .= ", ".$result[3][$j];
				if ($result[4][$j] != '') $message .= ", ".$result[4][$j];
			}
			$message .= "\n";

			//XXX-remove-this-line:  $message .= gettext("Offer date").": ";
			//XXX-remove-this-line:  $message .= $result[5][$j]."\n";

			$message .= gettext("Employer").": ";
			if ($result[9][$j] != '') $message .= gettext("Person").": ";
			if ($result[12][$j] != '') $message .= gettext("Company").": ";
			if ($result[13][$j] != '') $message .= gettext("non-profit Organization").": ";

			if ($result[9][$j] != '')
			{
				$message .= $result[10][$j].$result[11][$j];
				if ($result[10][$j] != '' or $result[11][$j] != '') $message .= ",";
				$message .= $result[9][$j]."\n";
			}
			if ($result[12][$j] != '') $message .= $result[12][$j]."\n";
			if ($result[13][$j] != '') $message .= $result[13][$j]."\n";

			$message .= "\n";

			$message .= "  https://www.gnuherds.org/View_Job_Offer.php?JobOfferId=".$result[0][$j]."\n";

			$message .= "\n";
			$message .= "\n";
		}

		// Send emails
		for ( $j=0; $j < count($emails); $j++ )
			mail($emails[$j], "GNU Herds: ".gettext("Alert on new job offers"), "$message", "From: association@gnuherds.org\r\nContent-Type: Text/plain; \r\nContent-Transfer-Encoding: 8bit\r\n"); //XXX Add UTF-8 support to the subject.

	}
}


// Raise the alerts
raiseNewJobOfferAlerts();
?> 
