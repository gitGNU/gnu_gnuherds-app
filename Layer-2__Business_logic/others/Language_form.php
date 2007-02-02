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


class LanguageForm
{
	public function processForm()
	{
		if ($_POST['language'] != '' )
			$_SESSION['Language'] = $_POST['language'];


		// We use the previously set SESSION Language to init the gettext environment

		// I18N support information here
		if ($_SESSION['Language'] == "en_US")
			$language = 'en_US.utf8';
		if ($_SESSION['Language'] == "es_ES")
			$language = 'es_ES.utf8';
		if ($_SESSION['Language'] == "it_IT")
			$language = 'it_IT.utf8';
		if ($_SESSION['Language'] == "pt_PT")
			$language = 'pt_PT.utf8';

		putenv("LANG=$language");
		setlocale(LC_ALL, $language);

		// Set the text domain as 'messages'
		$domain = 'messages';
		bindtextdomain($domain, "../locale");
		textdomain($domain);
	}
}
?>
