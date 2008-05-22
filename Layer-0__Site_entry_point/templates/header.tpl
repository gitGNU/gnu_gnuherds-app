{*
Authors: Neal Coombes, Davi Leal, Victor Engmark, Sameer Naik

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008 Neal Coombes <Neal.Coombes at attbi dot com>
              2002, 2003, 2004, 2005, 2006, 2007, 2008 Davi Leal <davi at leals dot com>
              2007, 2008 Victor Engmark <victor dot engmark at gmail dot com>
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
*}

<div class="locale">
<ul>
{assign var='cleanURI' value=$smarty.server.REQUEST_URI|regex_replace:"/.language=.._../":""}

{if strpos($cleanURI,"?") !== false}
	{assign var='startParameter' value='&amp;'}
{else}
	{assign var='startParameter' value='?'}
{/if}

{* {if $smarty.session.Language eq 'de_DE'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=de_DE" lang="de_DE" hreflang="de_DE" title="{t}Change language{/t}">Deutsch</a></li> *}
{if $smarty.session.Language eq 'en_US'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=en_US" lang="en_US" hreflang="en_US" title="{t}Change language{/t}">English</a></li>
{if $smarty.session.Language eq 'es_ES'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=es_ES" lang="es_ES" hreflang="es_ES" title="{t}Change language{/t}">Español</a></li>
{* {if $smarty.session.Language eq 'fr_FR'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=fr_FR" lang="fr_FR" hreflang="fr_FR" title="{t}Change language{/t}">Français</a></li> *}
{if $smarty.session.Language eq 'it_IT'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=it_IT" lang="it_IT" hreflang="it_IT" title="{t}Change language{/t}">Italiano</a></li>
{if $smarty.session.Language eq 'pt_PT'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=pt_PT" lang="pt_PT" hreflang="pt_PT" title="{t}Change language{/t}">Português</a></li>
{if $smarty.session.Language eq 'ru_RU'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=ru_RU" lang="ru_RU" hreflang="ru_RU" title="{t}Change language{/t}">Русский</a></li>
</ul>
</div>

<div class="header">

<div class="logo">
{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/Home.php" and $smarty.server.REQUEST_URI neq "/index.php"}
<a href="/">
{/if}
<img src="/themes/red_Danijel/images/logo.png" alt="{t}GNU Herds' logo (red theme){/t}">
{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/Home.php" and $smarty.server.REQUEST_URI neq "/index.php"}
</a>
{/if}
</div>

<div id="header_title">
{t}Free Software Association{/t}
</div>

<div class="notes">
<p><a href="http://www.fsf.org/licensing/licenses/agpl-3.0.html"><img src="themes/red_Danijel/images/agplv3-155x51.png" alt="GNU Affero GPL v3"></a><br>{t escape='no'
  1='<a href="gnuherds-online.tar.gz">'
  2='</a>'
}%1Download the project source code!%2{/t}</p>
</div>

</div>

