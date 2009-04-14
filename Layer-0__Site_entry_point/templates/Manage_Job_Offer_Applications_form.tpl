{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
              2007, 2008, 2009 Victor Engmark <victor dot engmark at gmail dot com>

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

<h3>{t}Manage job offer applications{/t}</h3>

<p class="footnote"><strong>{t}Offer title{/t}</strong>: <a href="offers?id={$smarty.get.JobOfferId}">{$data.Applications.VacancyTitle}</a></p>

{if count($data.Applications.EntityId) == 0 }
	<p>&nbsp;</p>
	<p>{t}There are not any application subscribed to this job offer{/t}.</p><p>&nbsp;</p>
{else}

<form name="applicationStateForm" id="applicationStateForm" method="post" action="{$smarty.server.REQUEST_URI}">
<table border="0">

<tr valign="top">
<td class="tdTitle"><strong>{t}Applicant{/t}</strong></td>
<td class="tdTitle"><strong>{t}Location{/t}</strong></td>
<td class="tdTitle"><strong>{t}Experience since{/t}</strong></td>
<td></td>
<td class="tdTitle"><strong>{t}Subscription state{/t}</strong></td>
</tr>

{foreach from=$data.Applications.EntityId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<strong>{t}{$data.Applications.EntityType[$i]}{/t}</strong>

<a href="resume?id={$Id}">
{if $data.Applications.EntityType[$i] eq 'Cooperative'}
	{if $data.Applications.CooperativeName[$i]}
		{$data.Applications.CooperativeName[$i]|gettext|strip:'&nbsp;'}
	{else}
		{t}Name{/t}:&nbsp;{'not specified'|gettext|strip:'&nbsp;'}
	{/if}
{else}
{if $data.Applications.EntityType[$i] eq 'Company'}
	{if $data.Applications.CompanyName[$i]}
		{$data.Applications.CompanyName[$i]|gettext|strip:'&nbsp;'}
	{else}
		{t}Name{/t}:&nbsp;{'not specified'|gettext|strip:'&nbsp;'}
	{/if}
{else}
{if $data.Applications.EntityType[$i] eq 'non-profit Organization'}
	{if $data.Applications.NonprofitName[$i]}
		{$data.Applications.NonprofitName[$i]|gettext|strip:'&nbsp;'}
	{else}
		{t}Name{/t}:&nbsp;{'not specified'|gettext|strip:'&nbsp;'}
	{/if}
{else}
{if $data.Applications.EntityType[$i] eq 'Person'}
	{if $data.Applications.LastName[$i] or $data.Applications.FirstName[$i] or $data.Applications.MiddleName[$i]}
		{$data.Applications.LastName[$i]}{if trim($data.Applications.LastName[$i]) neq '' and (trim($data.Applications.FirstName[$i]) neq '' or trim($data.Applications.MiddleName[$i]) neq '')},{/if}{if trim($data.Applications.FirstName[$i]) neq ''}&nbsp;{$data.Applications.FirstName[$i]}{/if}{if trim($data.Applications.MiddleName[$i]) neq ''}&nbsp;{$data.Applications.MiddleName[$i]}{/if}
	{else}
		{t}Name{/t}:&nbsp;{'not specified'|gettext|strip:'&nbsp;'}
	{/if}
{else}
	{'ERROR: Unexpected condition'|gettext|strip:'&nbsp;'}
{/if}
{/if}
{/if}
{/if}
</a>

</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<strong>{if $data.Applications.CountryName[$i]}{t domain='iso_3166'}{$data.Applications.CountryName[$i]}{/t}{/if}</strong>{if $data.Applications.StateProvince[$i]}{if $data.Applications.CountryName[$i]}, {/if}{$data.Applications.StateProvince[$i]}{/if}{if $data.Applications.City[$i]}{if $data.Applications.CountryName[$i] or $data.Applications.StateProvince[$i]}, {/if}{$data.Applications.City[$i]}{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.Applications.ProfessionalExperienceSinceYear[$i]}
</td>

<td></td>

<td align="center" class="{if $i % 2}tdDark{else}tdLight{/if}">
<div>
<input type="hidden" name="EntityId[]" value="{$Id}">
<select name="ApplicationState[]" OnChange="javascript:document.applicationStateForm.save.disabled=false;">
{html_options values=$applicationStatesId output=$applicationStatesIdTranslated selected=$data.Applications.ApplicationState[$i]}
</select>
</div>
</td>

</tr>

{/foreach}

<tr><td colspan="5">&nbsp;</td></tr>

<tr align="center">
<td colspan="4">
</td>
<td>
<input type="submit" name="save" id="save" value="{t}Save{/t}" disabled>
</td>
</tr>

</table>
</form>

{/if}
