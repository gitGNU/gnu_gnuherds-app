{*
Authors: Davi Leal, Victor Engmark, Sameer Naik

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
              2007, 2008, 2009 Victor Engmark <victor dot engmark at gmail dot com>
              2007, 2008, 2009 Sameer Naik <sameer AT damagehead DOT com>

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

{if $smarty.session.Logged eq '1'}
<h4>{t}Account{/t}</h4>
<ul>

{if $smarty.session.LoginType eq 'Person' }
<li><a href="person">{t}My personal profile{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq 'Cooperative' }
<li><a href="cooperative">{t}Our cooperative{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq 'Company' }
<li><a href="company">{t}Our company{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq 'non-profit Organization' }
<li><a href="nonprofit">{t}Our non-profit{/t}</a></li>
{/if}

{if $smarty.session.HasQualifications eq '1' }
	{assign var="url" value="resume?id=`$smarty.session.EntityId`"}
{else}
	{assign var="url" value="resume?action=edit&id=&section=profiles_etc"}
{/if}

{if $smarty.session.LoginType eq "Person" }
<li><a href="{$url}">{t}My qualifications{/t}</a></li>
{else}
<li><a href="{$url}">{t}Our qualifications{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq "Person" }
<li><a href="offers?owner=me">{t}My notices{/t}</a></li>
{else}
<li><a href="offers?owner=me">{t}Our notices{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq "Person" }
<li><a href="applications">{t}My subscriptions{/t}</a></li>
{else}
<li><a href="applications">{t}Our subscriptions{/t}</a></li>
{/if}

<li><a href="settings">{t}Settings{/t}</a></li>

{if $smarty.session.Logged eq '1' and $smarty.session.SkillsAdmin == true }
<li><a href="admin">{t}Administration{/t}</a></li>
{/if}

</ul>
{/if}
