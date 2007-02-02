<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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


require_once 'Smarty.class.php';
require_once "../Layer-2__Business_logic/others/Language_form.php";
require_once "../Layer-2__Business_logic/others/Log_form.php";
require_once "HTTP.php";


// This class is a template according which the web pages are printed.
class WebPage
{
	public $theme;
	public $logForm;
	public $content;
	public $contentExceptionOutput;
	public $contentExceptionCode;

	function __construct($theme,$content)
	{
		$this->theme = $theme;
		$this->content = $content;
		$this->contentExceptionOutput = '';
		$this->contentExceptionCode = 0;
	}

	public function processPage()
	{
		// The beaviour of this web app is simple. Each URI is processed by a PHP file which is inside the Layer-0 directory, which is the site entry point. Such PHP files keep two phases:
		// Phase 1.  Check and processing of the forms which the page content, for example: the LanguageForm, the LogForm and the PersonForm.
		// Phase 2.  Send the result page to the client browser.

		// If it is not set we set the Language session variable to its default value. Some PHP scripts need it to load the right language.
		// We have to load this check inside all the webapp entry points.

		if ( !isset($_SESSION["Language"]) and isset($_COOKIE['Language']) )
		{
			$_SESSION["Language"] = $_COOKIE['Language'];
		}
		else
		{
			$default_language = "en_US"; // The main and default language of this project is the English languge

			if ($_SESSION["Language"] == "en_US")
				;
			elseif ($_SESSION["Language"] == "es_ES")
				;
			elseif ($_SESSION["Language"] == "it_IT")
				;
			elseif ($_SESSION["Language"] == "pt_PT")
				;
			else // The client has not specified a language, so we try to guess the best default language according to the user browser settings.
			{
				$supported = array(
					"en" => true,
					"en_AU" => true, "en_BW" => true, "en_CA" => true, "en_DK" => true, "en_GB" => true, "en_HK" => true,
					"en_IE" => true, "en_IN" => true, "en_NZ" => true, "en_PH" => true, "en_SG" => true, "en_US" => true,
					"en_ZA" => true, "en_ZW" => true,
					"es" => true,
					"es_AD" => true, "es_AR" => true, "es_BO" => true, "es_CL" => true, "es_CO" => true, "es_CR" => true,
					"es_CU" => true, "es_DO" => true, "es_EC" => true, "es_ES" => true, "es_GI" => true, "es_GT" => true,
					"es_HN" => true, "es_MX" => true, "es_NI" => true, "es_PA" => true, "es_PE" => true, "es_PR" => true,
					"es_PY" => true, "es_SV" => true, "es_US" => true, "es_UY" => true, "es_VE" => true,
					"it" => true,
					"it_IT" => true, "it_CH" => true,
					"pt" => true,
					"pt_PT" => true, "pt_BR" => true
				);

				$chosen = HTTP::negotiateLanguage($supported);

				if ( $chosen != "" ) // Process what the user browser has chosen
				{
					if ( $chosen == "en"
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
					elseif ( $chosen == "it"
					      or $chosen == "it_IT" or $chosen == "it_CH" )
					    $this->setLanguage("it_IT");
					elseif ( $chosen == "pt"
					      or $chosen == "pt_PT" or $chosen == "pt_BR" )
					    $this->setLanguage("pt_PT");
					else
						$this->setLanguage($default_language);
				}
				else // The client has not specified a language, so we try to guess the best default language according to country code.
				{
					$country_code = apache_note("GEOIP_COUNTRY_CODE");
					if ( $country_code == "AD" or $country_code == "AR" or $country_code == "BO" or $country_code == "CL"
					  or $country_code == "CO" or $country_code == "CR" or $country_code == "CU" or $country_code == "DO" or $country_code == "EC"
					  or $country_code == "ES" or $country_code == "GI" or $country_code == "GT" or $country_code == "HN"
					  or $country_code == "MX" or $country_code == "NI" or $country_code == "PA" or $country_code == "PE" or $country_code == "PR"
					  or $country_code == "PY" or $country_code == "SV" or $country_code == "UY" or $country_code == "VE" )
						$this->setLanguage("es_ES");
					elseif ( $country_code == "US" or $country_code == "GB" )
						$this->setLanguage("en_US");
					elseif ( $country_code == "IT" )
						$this->setLanguage("it_IT");
					elseif ( $country_code == "PT" or $country_code == "BR" or $country_code == "AO" or $country_code == "CV"
					  or $country_code == "GW" or $country_code == "MZ" or $country_code == "ST"
					  or $country_code == "MO" or $country_code == "TL" ) // Co-official language. Ref.: wikipedia.org
						$this->setLanguage("pt_PT");
					else
						$this->setLanguage($default_language);
				}
			}
		}

		// languageForm: Set the Language session variable
		$languageForm = new LanguageForm();
		$languageForm->processForm();

		// contentForm: The content of some sections keeps a form, so we process it. Others do not keep any form, any way we execute the processForm method.
		try
		{
			$this->content->processForm();
		}
		catch (Exception $e) {
			$this->contentExceptionOutput = $e->getMessage();
			$this->contentExceptionCode = $e->getCode(); // getCode() is used to note if the 'Back' button must be shown or not.
		}

		// logForm: Create and process the LogForm object, which depend on the Language and the content form processing.
		$this->logForm = new LogForm();
		$this->logForm->processForm();
	}

	public function printPage()
	{
		$smarty = new Smarty;
		$smarty->assign('webpage', $this);
		$smarty->display("web_page.tpl");
	}

	private function setLanguage($language)
	{
		$_SESSION["Language"] = $language;
		setcookie("Language", $language, time()+(86400*30), '/', "gnuherds.org", false, true);
	}
}
?> 
