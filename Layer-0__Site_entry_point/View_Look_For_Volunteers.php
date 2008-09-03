<?php
// Authors: Davi Leal
// 
// Copyright (C) 2008 Davi Leal <davi at leals dot com>
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


// We have to use SSL for encryption of the password, PHPSESSID, etc., because else
// it is sent to the web server as plain text.
// Insert the following code snippet into the top of secure page.
if ( $_SESSION['Logged'] == '1' and ( !isset($_SERVER['HTTPS']) or $_SERVER['HTTPS'] != 'on' ) )
{
	header("Location: https://$_SERVER[SERVER_NAME]$_SERVER[REQUEST_URI]");
	exit;
}


session_start();

require_once "../Layer-1__Page_builder/Web_Page.php";
require_once "../Layer-2__Business_logic/content/forms/View_Look_For_Volunteers_form.php";

$viewLookForVolunteersForm = new ViewLookForVolunteersForm();

$webPage = new WebPage($viewLookForVolunteersForm);
$webPage->processPage();
$webPage->printPage();
?>
