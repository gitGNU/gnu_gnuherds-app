<?php
// Authors: Davi Leal
// 
// Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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


class Theme
{
	// default values
	// Properties could be overwritten in each web page.

	public $logoBGcolor		= '#73625b';
	public $headBGcolor		= '#bd0000';

	public $headSubtitle		= 'Free Software Association';

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
?>
