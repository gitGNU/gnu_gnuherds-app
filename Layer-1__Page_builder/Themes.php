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


class Theme
{
	// default values

	public $headBackgroundImage	= '/images/themes/cyclical-green-sky.png';
	public $headSubtitle		= 'Free Software Association';
	public $headNoticeStyle		= 'hidden1';
	public $headNotice		= ' '; // This and other properties can be overwritten in each web page.

	public $borderLeftUpImage 	= '/images/themes/1--left-up.png';
	public $borderRightUpImage 	= '/images/themes/1--right-up.png';
	public $borderLeftDownImage 	= '/images/themes/1--left-down.png';
	public $borderRightDownImage 	= '/images/themes/1--right-down.png';

	public $pageBGcolor		= '#ddddaa';
	public $menuBGcolor		= '#d0c482';
	public $contentBGcolor		= '#e8eecb';

	public $loginBoxBGcolor		= '#d0d0a0';
}

// A common theme for the site:
//   The three sets of sections using the default values.
//   You could overwrite it to personalize each section set.
$initialTheme	= new Theme();
$resourcesTheme	= new Theme();
$SIGTheme	= new Theme();
?>
