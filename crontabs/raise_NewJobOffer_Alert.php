<?php
// Authors: Davi Leal
// 
// Copyright (C) 2007, 2008 Davi Leal <davi at leals dot com>
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
			$message .= gettext("Vacancy title").":  ".$result[15][$j]."\n";

			$message .= gettext("Location").":  ";
			if ( trim($result[2][$j]) == '' )
			{
				$message .= dgettext('database', "Any").", ".gettext("telework");
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

			$message .= gettext("Employer").":  ";
			if ($result[10][$j] != '') $message .= gettext("Person").": ";
			if ($result[13][$j] != '') $message .= gettext("Company").": ";
			if ($result[14][$j] != '') $message .= gettext("non-profit Organization").": ";

			if ($result[10][$j] != '')
			{
				$message .= $result[11][$j].$result[12][$j];
				if ($result[11][$j] != '' or $result[12][$j] != '') $message .= ", ";
				$message .= $result[10][$j]."\n";
			}
			if ($result[13][$j] != '') $message .= $result[13][$j]."\n";
			if ($result[14][$j] != '') $message .= $result[14][$j]."\n";

			$message .= "\n";

			$message .= "  http://gnuherds.org/offers?id=".$result[0][$j]."\n";

			$message .= "\n";
			$message .= "\n";
		}
		$message .= "--\n";
		$message .= vsprintf(gettext('You can disable this type of alerts at  %s'),"http://gnuherds.org/settings \n");

		// Send emails
		mb_language("uni"); //XXX: Add support to Japanese, etc.  Reference: http://es.php.net/manual/en/function.mb-language.php
		for ( $j=0; $j < count($emails); $j++ )
			mb_send_mail($emails[$j], "GNU Herds: ".gettext("Alert on new job offers"), "$message", "From: association@gnuherds.org");
	}

	// We disable the NewJoOffer alerts due to they are already been processed
	$manager->resetNewJobOfferAlerts();
}


// Raise the alerts
raiseNewJobOfferAlerts();
?> 
