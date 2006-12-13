<?php
// Authors: Davi Leal
// 
// Copyright (C) 2006 Davi Leal <davi at leals dot com>
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


// My solution to use SSL for password encryption, because the password is sent to web server as plain text.
// Insert the following code snipet into the top of secure page.
if ( !isset($_SERVER['HTTPS']) || $_SERVER['HTTPS']!="on" )
{
	$error = "<p>".gettext('The request to this URI have to use HTTPS.')."</p>";
	throw new Exception($error,false);

	// Note we can not do a Location due to we would lost the $_POST data.
	// header("Location: https://$_SERVER[SERVER_NAME]$_SERVER[REQUEST_URI]");

	exit;
}


session_start();

require_once "../Layer-1__Page_builder/Themes.php";
require_once "../Layer-1__Page_builder/Web_Page.php";

require_once "../Layer-2__Business_logic/content/forms/View_Qualifications_form.php";
$viewQualificationsForm = new ViewQualificationsForm();

$webPage = new WebPage($resourcesTheme,$viewQualificationsForm);
$webPage->processPage();
$webPage->printPage();
?>
