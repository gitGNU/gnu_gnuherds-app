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
require_once "HTTP.php";


class LanguageForm
{
	public function processForm()
	{
		$manager = new DBManager();

		if ($_GET['language'] != '' )
			$_SESSION['Language'] = $_GET['language'];


		// If the Language session variable is not set we set it to its default value. Some PHP scripts need it to load the right language.
		// This check is loaded inside all the webapp entry points.

		if ( !isset($_SESSION["Language"]) and isset($_COOKIE['Language']) )
		{
			$_SESSION["Language"] = $_COOKIE['Language'];
		}
		else
		{
			$default_language = "en_US"; // The main and default language of this project is the English language

			if ( /* $_SESSION["Language"] == "de_DE"
			  or */ $_SESSION["Language"] == "en_US"
			  or $_SESSION["Language"] == "es_ES" /*
			  or $_SESSION["Language"] == "fr_FR" */
			  or $_SESSION["Language"] == "it_IT"
			  or $_SESSION["Language"] == "pt_PT" /*
			  or $_SESSION["Language"] == "ru_RU" */ )
			{
				$this->setLanguage($_SESSION["Language"]); // Update the validity of the language selection
			}
			else // The client has not specified a language, so we try to guess the best default language according to the user browser settings.
			{
				$supported = array( /*
					"de" => true,
					"de_AT" => true, "de_BE" => true, "de_CH" => true, "de_DE" => true, "de_LU" => true, */
					"en" => true,
					"en_AU" => true, "en_BW" => true, "en_CA" => true, "en_DK" => true, "en_GB" => true, "en_HK" => true,
					"en_IE" => true, "en_IN" => true, "en_NZ" => true, "en_PH" => true, "en_SG" => true, "en_US" => true,
					"en_ZA" => true, "en_ZW" => true,
					"es" => true,
					"es_AD" => true, "es_AR" => true, "es_BO" => true, "es_CL" => true, "es_CO" => true, "es_CR" => true,
					"es_CU" => true, "es_DO" => true, "es_EC" => true, "es_ES" => true, "es_GI" => true, "es_GT" => true,
					"es_HN" => true, "es_MX" => true, "es_NI" => true, "es_PA" => true, "es_PE" => true, "es_PR" => true,
					"es_PY" => true, "es_SV" => true, "es_US" => true, "es_UY" => true, "es_VE" => true, /*
					"fr" => true,
					"fr_BE" => true, "fr_CA" => true, "fr_CH" => true, "fr_FR" => true, "fr_LU" => true, */
					"it" => true,
					"it_IT" => true, "it_CH" => true,
					"pt" => true,
					"pt_PT" => true, "pt_BR" => true /* ,
					"ru" => true,
					"ru_RU" => true, "ru_UA" => true */
				);

				$chosen = HTTP::negotiateLanguage($supported);

				if ( $chosen != "" ) // Process what the user browser has chosen
				{
					if ( $chosen == "de"
					  or $chosen == "de_AT" or $chosen == "de_BE" or $chosen == "de_CH" or $chosen == "de_DE" or $chosen == "de_LU" )
						$this->setLanguage("de_DE");
					elseif ( $chosen == "en"
					  or $chosen == "en_AU" or $chosen == "en_BW" or $chosen == "en_CA" or $chosen == "en_DK" or $chosen == "en_GB" or $chosen == "en_HK"
					  or $chosen == "en_IE" or $chosen == "en_IN" or $chosen == "en_NZ" or $chosen == "en_PH" or $chosen == "en_SG" or $chosen == "en_US"
					  or $chosen == "en_ZA" or $chosen == "en_ZW" )
						$this->setLanguage("en_US");
					elseif ( $chosen == "es"
					      or $chosen == "es_AD" or $chosen == "es_AR" or $chosen == "es_BO" or $chosen == "es_CL" or $chosen == "es_CO" or $chosen == "es_CR"
					      or $chosen == "es_CU" or $chosen == "es_DO" or $chosen == "es_EC" or $chosen == "es_ES" or $chosen == "es_GI" or $chosen == "es_GT"
					      or $chosen == "es_HN" or $chosen == "es_MX" or $chosen == "es_NI" or $chosen == "es_PA" or $chosen == "es_PE" or $chosen == "es_PR"
					      or $chosen == "es_PY" or $chosen == "es_SV" or $chosen == "es_US" or $chosen == "es_UY" or $chosen == "es_VE" )
						$this->setLanguage("es_ES");
					elseif ( $chosen == "fr"
					      or $chosen == "fr_BE" or $chosen == "fr_CA" or $chosen == "fr_CH" or $chosen == "fr_FR" or $chosen == "fr_LU" )
					    $this->setLanguage("fr_FR");
					elseif ( $chosen == "it"
					      or $chosen == "it_IT" or $chosen == "it_CH" )
					    $this->setLanguage("it_IT");
					elseif ( $chosen == "pt"
					      or $chosen == "pt_PT" or $chosen == "pt_BR" )
					    $this->setLanguage("pt_PT");
					elseif ( $chosen == "ru"
					      or $chosen == "ru_RU" or $chosen == "ru_UA" )
					    $this->setLanguage("ru_RU");
					else
						$this->setLanguage($default_language);
				}
				else // The client browser has not specified any language preference
					$this->setLanguage($default_language);
			}
		}

		// We use the previously set SESSION Language to init the gettext environment
		$this->setLocale($_SESSION['Language']);

		// We always save the last locale used by the entity, to be used to translate the Alert emails
		if ( $_SESSION['Logged'] == '1' )
			$manager->updateEntityLocale();
	}


	public function setLocale($language)
	{
		// I18N support information here
		if ($language == "de_DE")
			$locale = 'de_DE.utf8';
		elseif ($language == "en_US")
			$locale = 'en_US.utf8';
		elseif ($language == "es_ES")
			$locale = 'es_ES.utf8';
		elseif ($language == "fr_FR")
			$locale = 'fr_FR.utf8';
		elseif ($language == "it_IT")
			$locale = 'it_IT.utf8';
		elseif ($language == "pt_PT")
			$locale = 'pt_PT.utf8';
		elseif ($language == "ru_RU")
			$locale = 'ru_RU.utf8';

		putenv("LANG=$locale");
		putenv("LANGUAGE=$locale"); // Needed when running command line tools, as the cron jobs alerts
		setlocale(LC_ALL, $locale);

		// Bind the 'messages' domain
		$domain = 'messages';
		bindtextdomain($domain, "../locale");

		// Bind the 'nationalities' domain
		$domain = 'nationalities';
		bindtextdomain($domain, "../locale");

		// Set the default text domain as 'messages'
		textdomain('messages');
	}

	private function setLanguage($language)
	{
		$_SESSION["Language"] = $language;
		setcookie("Language", $language, time()+(86400*30), '/', $_SERVER['SERVER_NAME'], false, true);
	}
}
?>
