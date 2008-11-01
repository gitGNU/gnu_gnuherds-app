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


function raiseAlertsFor($alert_type) // Raise any alert type
{
	$manager = new DBManager();
	$languageForm = new LanguageForm();

	// Before do anything, check if there are $alert_type alerts to raise.
	if ( $manager->pendingAlerts($alert_type) == false )
		return;

	// Get the language set (E1_LL_Locale). Only for the entities who has this $alert_type alert activated. If there are no any entity, we do nothing in the next 'for' loop.
	$languages = $manager->getAlertsLocales($alert_type);

	// For each E1_LL_Locale:
	for ( $i=0; $i < count($languages); $i++ )
	{
		// Set the locale
		$languageForm->setLocale($languages[$i]);

		// Get the email set (E1_Email) for entities using that (E1_Locale)
		$emails = $manager->getAlertsEmails($alert_type,$languages[$i]);

		// Get the array which describes what we are going to alert, with some parts already localized
		$result = $manager->getAlerts($alert_type);

		if ( count($result[0]) > 0 )
		{
			// Write the email
			switch($alert_type)
			{
				case 'NewJobOffer':

					// Create the message's subject
					$subject = "GNU Herds: ".gettext("Alert on new job offers");

					// Create the message's body
					$body = "";
					for ( $j=0; $j < count($result[0]); $j++ )
					{
						$body .= gettext("Vacancy title").":  ".$result[15][$j]."\n";
						$body .= gettext("Location").":  ";
						if ( trim($result[2][$j]) == '' )
						{
							$body .= dgettext('database', "Any").", ".gettext("telework");
						}
						else
						{
							$body .= gettext($result[2][$j]);
							if ($result[3][$j] != '') $body .= ", ".$result[3][$j];
							if ($result[4][$j] != '') $body .= ", ".$result[4][$j];
						}
						$body .= "\n";

						//XXX-remove-this-line:  $body .= gettext("Offer date").": ";
						//XXX-remove-this-line:  $body .= $result[5][$j]."\n";

						$body .= gettext("Offered by").":  ";
						if ($result[10][$j] != '') $body .= gettext("Person").": ";
						if ($result[13][$j] != '') $body .= gettext("Company").": ";
						if ($result[14][$j] != '') $body .= gettext("non-profit Organization").": ";

						if ($result[10][$j] != '')
						{
							$body .= $result[11][$j].$result[12][$j];
							if ($result[11][$j] != '' or $result[12][$j] != '') $body .= ", ";
							$body .= $result[10][$j]."\n";
						}
						if ($result[13][$j] != '') $body .= $result[13][$j]."\n";
						if ($result[14][$j] != '') $body .= $result[14][$j]."\n";

						$body .= "\n";

						$body .= "  http://gnuherds.org/offers?id=".$result[0][$j]."\n";

						$body .= "\n";
						$body .= "\n";
					}

					break;

				case 'NewDonationPledgeGroup':

					// Create the message's subject
					$subject = "GNU Herds: ".gettext("Alert on new donation pledge groups");

					// Create the message's body
					$body = "";
					for ( $j=0; $j < count($result[0]); $j++ )
					{
						$body .= gettext("Vacancy title").":  ".$result[15][$j]."\n";
						$body .= gettext("Location").":  ".dgettext('database', "Any").", ".gettext("telework")."\n";

						$body .= "\n";

						$body .= "  http://gnuherds.org/pledges?id=".$result[0][$j]."\n";

						$body .= "\n";
						$body .= "\n";
					}

					break;

				case 'NewLookForVolunteers':
					// TODO: XXX
					break;

				default:
					$error = gettext("ERROR: Unexpected condition");
					throw new Exception($error,false);
			}
			$body .= "--\n";
			$body .= vsprintf(gettext('You can disable this type of alerts at  %s'),"http://gnuherds.org/settings \n");

			// Send emails
			mb_language("uni"); //XXX: Add support to Japanese, etc.  Reference: http://es.php.net/manual/en/function.mb-language.php
			for ( $j=0; $j < count($emails); $j++ )
				mb_send_mail($emails[$j], $subject, $body, "From: association@gnuherds.org");
		}
	}

	// We disable the $alert_type alerts due to they have been just processed
	$manager->resetAlerts($alert_type);
}


// Raise the alerts
raiseAlertsFor('NewJobOffer');
raiseAlertsFor('NewDonationPledgeGroup');
// TODO: raiseAlertsFor('NewLookForVolunteers');
?> 
