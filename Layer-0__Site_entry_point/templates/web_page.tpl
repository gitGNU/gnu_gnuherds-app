<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
Authors: Neal Coombes, Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Neal Coombes <Neal.Coombes at attbi dot com>
              2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>

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
<title>GNU Herds - {'Free Software Association'|gettext}</title>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<link rel="icon" href="/images/icons/gh-icon.png" type="image/png">
<link rel="stylesheet" type="text/css" href="/css/gh-main.css">
<style type="text/css">
	{literal} body { background: {/literal}{$webpage->theme->pageBGcolor}{literal} } {/literal}
</style>
</head>


<body OnLoad="if ('InitializationOnLoad' in window) InitializationOnLoad();">

{if !isset($smarty.get.heading)}
{include file="header.tpl"}
{/if}

<table width="100%" cellpadding="5" cellspacing="0" rules="none" border="0">
<tr valign="top">

{if !isset($smarty.get.menu) or !isset($smarty.get.loging_box)}
<td align="center" bgcolor="{$webpage->theme->pageBGcolor}" width="1"> <!-- Note: The bgcolor could be omitted -->
{/if}

{if !isset($smarty.get.menu)}
{include file="menu.tpl"}
{/if}

{if !isset($smarty.get.loging_box)}
&nbsp;

{if $smarty.session.Logged == '1' }
{include file="log_out_box.tpl"}
{else}
{include file="log_in_box.tpl"}
{/if}

{/if}

{if !isset($smarty.get.menu) or !isset($smarty.get.loging_box)}
</td>
{/if}

{include file="content.tpl"}

</tr>
</table>

</body>


</html>

