{*
Authors: Davi Leal

Copyright (C) 2008, 2009 Davi Leal <davi at leals dot com>

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

<h3>{t}My subscriptions{/t}</h3>


<ul id="tablist">
<li><a {if $smarty.get.section eq '' or $smarty.get.section eq 'offers'} class="current" {/if}
	href="applications?owner=me&section=offers">{t}Job offers{/t}</a></li>
<li><a {if $smarty.get.section eq 'pledges'} class="current" {/if}
	href="applications?owner=me&section=pledges">{t}Pledges{/t}</a></li>
</ul>

<div id="tab">
{if $smarty.get.section eq '' or $smarty.get.section eq 'offers'}
	{include file="View_Job_Applications_State_job_offer_form.tpl"}
{elseif $smarty.get.section eq 'pledges'}
	{include file="View_Job_Applications_State_donation_pledge_group_form.tpl"}
{else}
	{t}ERROR: Unexpected condition{/t}
{/if}
</div>
