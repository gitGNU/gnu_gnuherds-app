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

<div class="menu">

<ul>
<li>{if $smarty.server.SCRIPT_URL neq "/about"}<a href="about">{/if}{t}About GNU Herds{/t}{if $smarty.server.SCRIPT_URL neq "/about"}</a>{/if}</li>
<li>{if $smarty.server.SCRIPT_URL neq "/charter"}<a href="charter">{/if}{t}Charter (draft){/t}{if $smarty.server.SCRIPT_URL neq "/charter"}</a>{/if}</li>
<li>{if $smarty.server.SCRIPT_URL neq "/development"}<a href="development">{/if}{t}Coders' guide{/t}{if $smarty.server.SCRIPT_URL neq "/development"}</a>{/if}</li>
<li>{if $smarty.server.SCRIPT_URL neq "/faq"}<a href="faq">{/if}{t}FAQ{/t}{if $smarty.server.SCRIPT_URL neq "/faq"}</a>{/if}</li>
</ul>

{if $smarty.session.Logged eq '1'}
<h4>{t}Account{/t}</h4>
<ul>

{if $smarty.session.Logged neq '1'}
<li>{if $smarty.server.SCRIPT_URL neq "/login"}<a href="login">{/if}{t}Log in{/t}{if $smarty.server.SCRIPT_URL neq "/login"}</a>{/if}</li>
<li><a href="register" {if $smarty.server.SCRIPT_URL eq "/register"}id="current"{/if}>{t}Register{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq 'Person' or not isset($smarty.session.LoginType) }
<li><a href="person" {if $smarty.server.SCRIPT_URL eq "/person"}id="current"{/if}>{t}My personal profile{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq 'Cooperative' }
<li><a href="cooperative" {if $smarty.server.SCRIPT_URL eq "/cooperative"}id="current"{/if}>{t}Our cooperative{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq 'Company' }
<li><a href="company" {if $smarty.server.SCRIPT_URL eq "/company"}id="current"{/if}>{t}Our company{/t}</a></li>
{/if}

{if $smarty.session.LoginType eq 'non-profit Organization' }
<li><a href="nonprofit" {if $smarty.server.SCRIPT_URL eq "/nonprofit"}id="current"{/if}>{t}Our non-profit{/t}</a></li>
{/if}

{if $smarty.session.HasQualifications eq '1' or not isset($smarty.session.LoginType) }
	{assign var="url" value="resume?id=`$smarty.session.EntityId`"}
{else}
	{assign var="url" value="resume?action=edit&id=&section=profiles_etc"}
{/if}

{if $smarty.session.LoginType eq "Person" or not isset($smarty.session.LoginType) }
<li>{if not ($smarty.server.SCRIPT_URL eq "/resume" and $smarty.get.EntityId eq $smarty.session.EntityId) }<a href="{$url}">{/if}{t}My qualifications{/t}{if not ($smarty.server.SCRIPT_URL eq "/resume" and $smarty.get.EntityId eq $smarty.session.EntityId) }</a>{/if}</li>
{else}
<li>{if not ($smarty.server.SCRIPT_URL eq "/resume" and $smarty.get.EntityId eq $smarty.session.EntityId) }<a href="{$url}">{/if}{t}Our qualifications{/t}{if not ($smarty.server.SCRIPT_URL eq "/resume" and $smarty.get.EntityId eq $smarty.session.EntityId) }</a>{/if}</li>
{/if}

{if $smarty.session.LoginType eq "Person" or not isset($smarty.session.LoginType) }
<li>
{if not ($smarty.server.SCRIPT_URL eq "/offers" and $smarty.get.owner eq "me") }
<a href="offers?owner=me"
{if $smarty.server.SCRIPT_URL eq "/applications" and $smarty.get.JobOfferId neq '' }id="current"{/if}
>
{/if}
{t}My notices{/t}
{if not ($smarty.server.SCRIPT_URL eq "/offers" and $smarty.get.owner eq "me") and not ($smarty.server.SCRIPT_URL eq "/applications" and $smarty.get.JobOfferId neq '') }
</a>
{/if}
</li>
{else}
<li>{if not ($smarty.server.SCRIPT_URL eq "/offers" and $smarty.get.owner eq "me") and not ($smarty.server.SCRIPT_URL eq "/applications" and $smarty.get.JobOfferId neq '') }<a href="offers?owner=me">{/if}{t}Our notices{/t}{if not ($smarty.server.SCRIPT_URL eq "/offers" and $smarty.get.owner eq "me") and not ($smarty.server.SCRIPT_URL eq "/applications" and $smarty.get.JobOfferId neq '') }</a>{/if}</li>
{/if}

{if $smarty.session.LoginType eq "Person" or not isset($smarty.session.LoginType) }
<li>{if not ($smarty.server.SCRIPT_URL eq "/applications" and not isset($smarty.get.JobOfferId)) }<a href="applications">{/if}{t}My subscriptions{/t}{if not ($smarty.server.SCRIPT_URL eq "/applications" and not isset($smarty.get.JobOfferId)) }</a>{/if}</li>
{else}
<li>{if not ($smarty.server.SCRIPT_URL eq "/applications" and not isset($smarty.get.JobOfferId)) }<a href="applications">{/if}{t}Our subscriptions{/t}{if not ($smarty.server.SCRIPT_URL eq "/applications" and not isset($smarty.get.JobOfferId)) }</a>{/if}</li>
{/if}

<li>{if $smarty.server.SCRIPT_URL neq "/settings"}<a href="settings">{/if}{t}Settings{/t}{if $smarty.server.SCRIPT_URL neq "/settings"}</a>{/if}</li>

{if $smarty.session.Logged eq '1' and $smarty.session.SkillsAdmin == true }
<li>{if $smarty.server.SCRIPT_URL neq "/admin"}<a href="admin">{/if}{t}Administration{/t}{if $smarty.server.SCRIPT_URL neq "/admin"}</a>{/if}</li>
{/if}

</ul>
{/if}

<h4>{t}Resources{/t}</h4>
<ul>
<li>{if not ($smarty.server.SCRIPT_URL eq "/notices" and not isset($smarty.get.action)) and $smarty.server.SCRIPT_URL neq "/" and $smarty.server.SCRIPT_URL neq "/index.php" }<a href="notices">{/if}{t}List offers{/t}{if not ($smarty.server.SCRIPT_URL eq "/notices" and not isset($smarty.get.action)) and $smarty.server.SCRIPT_URL neq "/" and $smarty.server.SCRIPT_URL neq "/index.php" }</a>{/if}</li>
<li>{if not ($smarty.server.SCRIPT_URL eq "/notices" and $smarty.get.action eq "edit") }<a href="notices?action=edit">{/if}{t}Post offer{/t}{if not ($smarty.server.SCRIPT_URL eq "/notices" and $smarty.get.action eq "edit") }</a>{/if}</li>
<li><a href="offers" {if $smarty.server.SCRIPT_URL eq "/offers" and not isset($smarty.get.owner) }id="current"{/if}>{t}FS job offers{/t}</a></li>
<li><a href="pledges" {if $smarty.server.SCRIPT_URL eq "/pledges"}id="current"{/if}>{t}FS pledges{/t}</a></li>
<li><a href="volunteers" {if $smarty.server.SCRIPT_URL eq "/volunteers"}id="current"{/if}>{t}FS volunteers{/t}</a></li>
</ul>

</div>
