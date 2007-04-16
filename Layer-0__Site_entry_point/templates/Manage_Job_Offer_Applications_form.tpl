{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

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

<h3>{t}Manage the Job Offer applications{/t}</h3>

<p class="footnote"><strong>{t}Offer title{/t}</strong>: {$vacancyTitle}</p>

{if count($entityId) == 0 }
	<p>&nbsp;</p>
	<p>{t}There are not any application subscribed to this job offer{/t}.</p><p>&nbsp;</p>
{else}

<table align="center" border="0" width="100%">

<tr valign="top">
<td class="tdTitle"><strong>{t}Applicant{/t}</strong></td>
<td class="tdTitle"><strong>{t}Location{/t}</strong></td>
<td class="tdTitle"><strong>{t}Experience since{/t}</strong></td>
<td class="tdTitle"><strong>{t}Subscription state{/t}</strong></td>
</tr>

{foreach from=$entityId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<strong>{t}{$entityType[$i]}{/t}</strong>

<a href="/View_Qualifications.php?EntityId={$Id}">
{if $firstName[$i]}{$lastName[$i]} {$middleName[$i]}{if $lastName[$i] or $middleName[$i]},{/if} {$firstName[$i]}{/if}
{if $companyName[$i]}{$companyName[$i]}{/if}
{if $organizationName[$i]}{$organizationName[$i]}{/if}
</a>

</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<strong>{t}{$countryName[$i]}{/t}</strong>{if $stateProvince[$i]}, {$stateProvince[$i]}{/if}{if $city[$i]}, {$city[$i]}{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$professionalExperienceSinceYear[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<form name="changeApplicationStateForm{$Id}" id="changeApplicationStateForm{$Id}" method="post" action="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}">
<input type="hidden" name="EntityId" value="{$Id}">
<select name="ApplicationState" onChange="javascript:document.getElementById('changeApplicationStateForm{$Id}').submit();">
{html_options values=$applicationStatesId output=$applicationStatesIdTranslated selected=$applicationState[$i]}
</select>
</form>
</td>

</tr>

{/foreach}

</table>

{/if}

