{*
Authors: Neal Coombes, Davi Leal, Victor Engmark

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Neal Coombes <Neal.Coombes at attbi dot com>
              2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.
*}

<table width="100%" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr valign="top">

<td style="background: {$webpage->theme->logoBGcolor}">
{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/Home.php" and $smarty.server.REQUEST_URI neq "/index.php"}
<a href="/">
{/if}
<img src="/images/logo.png" align="left" alt="" border="0" hspace="0" vspace="0">
{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/Home.php" and $smarty.server.REQUEST_URI neq "/index.php"}
</a>
{/if}
</td>

<td width="10%" style="background: {$webpage->theme->headBGcolor}"></td>

<td style="background: {$webpage->theme->headBGcolor}">
<p><br></p>
<h1>{$webpage->theme->headSubtitle|gettext|strip:'&nbsp;'}</h1>
</td>

<td width="100%" style="background: {$webpage->theme->headBGcolor}"></td>

<td style="background: {$webpage->theme->headBGcolor}">
{assign var='cleanURI' value=$smarty.server.REQUEST_URI|regex_replace:"/.language=.._../":""}

{if strpos($cleanURI,"?") !== false}
	{assign var='startParameter' value='&amp;'}
{else}
	{assign var='startParameter' value='?'}
{/if}

<span class="heading">
{if $smarty.session.Language eq 'de_DE'}<strong>{else}<a href="{$cleanURI}{$startParameter}language=de_DE" lang="de_DE" hreflang="de_DE" title="{t}Change language{/t}">{/if}<span class="heading">Deutsch</span>{if $smarty.session.Language eq 'de_DE'}</strong>{else}</a>{/if},

{if $smarty.session.Language eq 'en_US'}<strong>{else}<a href="{$cleanURI}{$startParameter}language=en_US" lang="en_US" hreflang="en_US" title="{t}Change language{/t}">{/if}<span class="heading">English</span>{if $smarty.session.Language eq 'en_US'}</strong>{else}</a>{/if},

{if $smarty.session.Language eq 'es_ES'}<strong>{else}<a href="{$cleanURI}{$startParameter}language=es_ES" lang="es_ES" hreflang="es_ES" title="{t}Change language{/t}">{/if}<span class="heading">Español</span>{if $smarty.session.Language eq 'es_ES'}</strong>{else}</a>{/if},

{if $smarty.session.Language eq 'fr_FR'}<strong>{else}<a href="{$cleanURI}{$startParameter}language=fr_FR" lang="fr_FR" hreflang="fr_FR" title="{t}Change language{/t}">{/if}<span class="heading">Français</span>{if $smarty.session.Language eq 'fr_FR'}</strong>{else}</a>{/if},

{if $smarty.session.Language eq 'it_IT'}<strong>{else}<a href="{$cleanURI}{$startParameter}language=it_IT" lang="it_IT" hreflang="it_IT" title="{t}Change language{/t}">{/if}<span class="heading">Italiano</span>{if $smarty.session.Language eq 'it_IT'}</strong>{else}</a>{/if},

{if $smarty.session.Language eq 'pt_PT'}<strong>{else}<a href="{$cleanURI}{$startParameter}language=pt_PT" lang="pt_PT" hreflang="pt_PT" title="{t}Change language{/t}">{/if}<span class="heading">Português</span>{if $smarty.session.Language eq 'pt_PT'}</strong>{else}</a>{/if},

{if $smarty.session.Language eq 'ru_RU'}<strong>{else}<a href="{$cleanURI}{$startParameter}language=ru_RU" lang="ru_RU" hreflang="ru_RU" title="{t}Change language{/t}">{/if}<span class="heading">Русский</span>{if $smarty.session.Language eq 'ru_RU'}</strong>{else}</a>{/if}
</span>

<br>
<span class="heading">______________________________</span>
<br>
<span class="heading">{t}Project state{/t}: <strong>Beta</strong></span>
</td>

</tr>
</table>
