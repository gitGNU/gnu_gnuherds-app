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


session_start(); 

require_once "../Layer-1__Page_builder/Themes.php";
require_once "../Layer-1__Page_builder/Web_Page.php";

require_once "../Layer-2__Business_logic/content/forms/Skills_Guide_form.php";
$skillsGuide = new SkillsGuide();

$webPage = new WebPage($initialTheme,$skillsGuide);
$webPage->processPage();
$webPage->printPage();
?>