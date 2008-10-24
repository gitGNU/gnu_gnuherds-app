{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007, 2008 Davi Leal <davi at leals dot com>
              2007, 2008 Victor Engmark <victor dot engmark at gmail dot com>

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

<h3>{t}My notices{/t}</h3>


<ul id="tablist">
<li><a {if $smarty.get.section eq '' or $smarty.get.section eq 'offers'} class="current" {/if}
	href="offers?owner=me&section=offers">{t}FS job offers{/t}</a></li>
<li><a {if $smarty.get.section eq 'pledges'} class="current" {/if}
	href="offers?owner=me&section=pledges">{t}FS pledges{/t}</a></li>
<li><a {if $smarty.get.section eq 'volunteers'} class="current" {/if}
	href="offers?owner=me&section=volunteers">{t}FS volunteers{/t}</a></li>
</ul>

<div id="tab">
{if $smarty.get.section eq '' or $smarty.get.section eq 'offers'}
	{include file="Manage_Job_Offers_job_offer_form.tpl"}
{elseif $smarty.get.section eq 'pledges'}
	{include file="Manage_Job_Offers_donation_pledge_group_form.tpl"}
{elseif $smarty.get.section eq 'volunteers'}
	{include file="Manage_Job_Offers_look_for_volunteers_form.tpl"}
{else}
	{t}ERROR: Unexpected condition{/t}
{/if}
</div>

<br>
<br>
<br>


<table id="new_offer">

<tr valign="top">
<td>
<a href="offers?action=edit&amp;id=&amp;section=general">
<img src="/themes/red_Danijel/images/contracts.tiny.png" alt="{t}icon{/t}">
</a>
</td>
<td>
<form name="newJobOfferForm" method="post" action="offers?action=edit&amp;id=&amp;section=general">
<input type="submit" name="new" value="{t}New job offer{/t}">
</form>
</td>
</tr>

<tr valign="top">
<td>
<a href="pledges?action=edit&amp;id=">
<img src="/themes/red_Danijel/images/donations.tiny.png" alt="{t}icon{/t}">
</a>
</td>
<td>
<form name="newDonationPledgeGroupForm" method="post" action="pledges?action=edit&amp;id=">
<input type="submit" name="new" value="{t}New donation pledge group{/t}">
</form>
</td>
</tr>

<tr valign="top">
<td>
<a href="volunteers?action=edit&amp;id=">
<img src="/themes/red_Danijel/images/volunteers.tiny.png" alt="{t}icon{/t}">
</a>
</td>
<td>
<form name="newLookForVolunteerForm" method="post" action="volunteers?action=edit&amp;id=">
<input type="submit" name="new" value="{t}New look for volunteers{/t}">
</form>
</td>
</tr>

</table>
