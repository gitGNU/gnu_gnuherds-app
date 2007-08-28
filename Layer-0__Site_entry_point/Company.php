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


// We have to use SSL for encryption of the password, PHPSESSID, etc., because else
// it is sent to the web server as plain text.
// Insert the following code snipet into the top of secure page.
if ( $_SESSION['Logged'] == '1' and ( !isset($_SERVER['HTTPS']) or $_SERVER['HTTPS'] != 'on' ) )
{
        header("Location: https://$_SERVER[SERVER_NAME]$_SERVER[REQUEST_URI]");
        exit;
}


session_start();

require_once "../Layer-1__Page_builder/Themes.php";
require_once "../Layer-1__Page_builder/Web_Page.php";

require_once "../Layer-2__Business_logic/content/forms/Company_form.php";
$companyForm = new CompanyForm();

$webPage = new WebPage($resourcesTheme,$companyForm);
$webPage->processPage();
$webPage->printPage();
?>
