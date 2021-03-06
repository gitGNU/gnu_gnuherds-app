<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
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


require_once 'Smarty.class.php';
require_once "../Layer-2__Business_logic/others/Language_form.php";
require_once "../Layer-2__Business_logic/others/Log_form.php";


// This class is a template according which the web pages are printed.
class WebPage
{
	public $logForm;
	public $content;
	public $contentExceptionOutput;
	public $contentExceptionCode;

	function __construct($content)
	{
		$this->content = $content;
		$this->contentExceptionOutput = '';
		$this->contentExceptionCode = 0;
	}

	public function processPage()
	{
		// The beaviour of this web app is simple. Each URI is processed by a PHP file which is inside the Layer-0 directory, which is the site entry point. Such PHP files keep two phases:
		// Phase 1.  Check and processing of the forms which the page keeps, for example: the LanguageForm, the LogForm and the PersonForm.
		// Phase 2.  Send the result page to the client browser.

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
			$this->contentExceptionCode = $e->getCode();
		}

		// logForm: Create and process the LogForm object, which depend on the Language and the content form processing.
		$this->logForm = new LogForm();
		$this->logForm->processForm();
	}

	public function printPage()
	{
		ob_end_clean(); // Clean the output buffer to discart previous garbage, that is to say, the empty lines at page top.
		ob_start(); // Turn on output buffering again to avoid webapp error.

		$smarty = new Smarty;
		$smarty->assign('webpage', $this);
		$smarty->display("web_page.tpl");
	}
}
