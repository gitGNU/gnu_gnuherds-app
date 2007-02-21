<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!--
Authors: Neal Coombes, Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Neal Coombes <Neal.Coombes at attbi dot com>
              2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>

This program is free software; you can redistribute it and/or modify it under
the terms of the Affero General Public License as published by Affero Inc.,
either version 1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful to the Free
Software community, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
General Public License for more details.

You should have received a copy of the Affero General Public License with this
software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
Suite 225, San Francisco, CA 94107, USA
-->
{assign var='lang_country' value=$smarty.server.REQUEST_URI|regex_replace:"http://www\.gnuherds\.org/.*language=":""}
{assign var='lang' value=$lang_country|regex_replace:"_...*":""}
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/MarkUp/SCHEMA/xhtml11.xsd" xml:lang="{$lang}">
<head>
<title>GNU Herds - {'Free Software Association'|gettext}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="icon" href="/images/icons/gh-icon.png" type="image/png" />
<link rel="stylesheet" type="text/css" href="/css/gh-main.css" />
</head>
<body onload="if ('InitializationOnLoad' in window) InitializationOnLoad();" style="background-color: {$webpage->theme->pageBGcolor};">
{literal}
<script type="text/javascript">
	if (parent.location != this.location)
	{
		parent.location = this.location; // I hate getting stuck in someone else's frames
	}
</script>
{/literal}
{if !isset($smarty.get.heading)}
{include file="header.tpl"}
{/if}
<table width="100%" style="border: 0;">
<!-- XXX -->
<!-- cellpadding="5" cellspacing="0" rules="none" -->
<!-- these attributes are not supported in XHTML. -->
<!-- I simply don't know how to replace them.     -->
<!-- -- David                                     -->
<tr valign="top">
{if !isset($smarty.get.menu) or !isset($smarty.get.loging_box)}
<td align="center" style="background-color:{$webpage->theme->pageBGcolor}" width="1">
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
