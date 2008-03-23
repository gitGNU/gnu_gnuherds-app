<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<!--
Authors: Neal Coombes, Davi Leal, Sameer Naik

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008 Neal Coombes <Neal.Coombes at attbi dot com>
              2002, 2003, 2004, 2005, 2006, 2007, 2008 Davi Leal <davi at leals dot com>
              2007, 2008 Sameer Naik <sameer AT damagehead DOT com>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.
-->

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<title>GNU Herds - {t}Free Software Association{/t}</title>
<link rel="icon" href="/themes/red_Danijel/icons/gh-icon.png" type="image/png">
<link rel="stylesheet" type="text/css" href="/themes/red_Danijel/css/screen.css">
</head>

<body onload="if ('LoginEmail' in document.LogForm)  if(document.LogForm.LoginEmail.value=='') document.LogForm.LoginEmail.value='email';">
<div>
{include file="header.tpl"}

<div id="app">

<div class="sidebar">
{include file="menu.tpl"}

{if $smarty.session.Logged == '1' }
{include file="log_out_box.tpl"}
{else}
{include file="log_in_box.tpl"}
{/if}
</div>

{include file="content.tpl"}
</div>

</div>
</body>

</html>
