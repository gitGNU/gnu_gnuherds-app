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

<table width="100%" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr valign="top">
<td width="160" background="{$webpage->theme->headBackgroundImage}"><a href="/images/gnus-desc.html" target="_top"><img src="/images/gnus_90.jpg" align="left" alt="" border="0" hspace="0" vspace="0"></a></td>

<td background="{$webpage->theme->headBackgroundImage}">

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

{if $smarty.session.Language eq 'en_US'}<strong>{/if}<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=en_US" lang="en" title="{'English'|gettext}">English</a>{if $smarty.session.Language eq 'en_US'}</strong>{/if},

{if $smarty.session.Language eq 'es_ES'}<strong>{/if}<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=es_ES" lang="es" title="{'Spanish'|gettext}">Espa&#x00f1;ol</a>{if $smarty.session.Language eq 'es_ES'}</strong>{/if},

{if $smarty.session.Language eq 'fr_FR'}<strong>{/if}<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=fr_FR" lang="fr" title="{'French'|gettext}">Fran&#x00e7;ais</a>{if $smarty.session.Language eq 'fr_FR'}</strong>{/if},

{if $smarty.session.Language eq 'it_IT'}<strong>{/if}<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=it_IT" lang="it" title="{'Italian'|gettext}">Italiano</a>{if $smarty.session.Language eq 'it_IT'}</strong>{/if},

{if $smarty.session.Language eq 'pt_PT'}<strong>{/if}<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=pt_PT" lang="pt" title="{'Portuguese'|gettext}">Portugu&#x0ea;s</a>{if $smarty.session.Language eq 'pt_PT'}</strong>{/if},

{if $smarty.session.Language eq 'ru_RU'}<strong>{/if}<a href="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$cleanURI}{$startParameter}language=ru_RU" lang="ru" title="{'Russian'|gettext}">&#x0420;&#x0443;&#x0441;&#x0441;&#x043a;&#x0438;&#x0439;</a>{if $smarty.session.Language eq 'ru_RU'}</strong>{/if}

<br>
<span class="hidden2">______________________________</span>
<br>
{t}Project state{/t}: Beta
</td>

</tr>
</table>

</td>
</tr>
</table>
