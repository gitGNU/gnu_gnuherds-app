{*
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
*}

<table width="100%" style="border: 0;">
<!-- XXX -->
<!-- cellpadding="0" cellspacing="0" rules="none" -->
<!-- Replace with proper XHTML -->
<!-- -- David -->
<tr valign="top">
<td width="160" style="background: url('{$webpage->theme->headBackgroundImage}');"><a href="/images/gnus-desc.html" target="_top"><img src="/images/gnus_90.jpg" align="left" alt="" style="border: 0; position: relative; left: 0; top: 0;" /></a></td>
<td style="background: url('{$webpage->theme->headBackgroundImage}');">
<table>
<tr valign="top">
<td>
<h1>GNU Herds</h1>
<h2>{$webpage->theme->headSubtitle|gettext|strip:'&nbsp;'}</h2>
</td>
<td width="100%"></td>
<td>
{assign var='cleanURI' value=$smarty.server.REQUEST_URI|regex_replace:"/.language=.._../":""}
{if strpos($cleanURI,"?") !== false}
	{assign var='startParameter' value='&'}
{else}
	{assign var='startParameter' value='?'}
{/if}
{'Languages'|gettext}:
<br />
<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=en_US" lang="en" title="{'English'|gettext}">English</a>,
<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=es_ES" lang="es" title="{'Spanish'|gettext}">Espa&#x00f1;ol</a>,
<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=it_IT" lang="it" title="{'Italian'|gettext}">Italiano</a>,
<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=pt_PT" lang="pt" title="{'Portuguese'|gettext}">Portugu&#x0ea;s</a>
<br />
<span class="hidden2">______________________________</span>
<br />
{t}Project state{/t}: Beta
</td>
</tr>
</table>
</td>
</tr>
</table>
