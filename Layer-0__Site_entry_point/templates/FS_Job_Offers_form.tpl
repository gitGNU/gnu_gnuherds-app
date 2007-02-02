{*
Authors: Davi Leal

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>

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

<h3>{t}FS Job Offers{/t}</h3>


{if count($JobOfferId) == 0 }
	<p>&nbsp;</p>
	<p>{t}There are not active job offers{/t}.</p><p>&nbsp;</p>
{else}

<table align="center" border="0" width="100%">

<tr valign="top">
<td class="tdTitle"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Location'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Employer'|gettext|strip:'&nbsp;'}</strong></td>
</tr>

{foreach from=$JobOfferId item=Id key=i}

<form name="viewFSJobOfferForm{$Id}" id="viewFSJobOfferForm{$Id}" method="post" action="View_Job_Offer.php">
<input type="hidden" name="ViewJobOfferId" value="{$Id}">
<input type="hidden" name="ViewEntityId" value="{$EntityId[$i]}">
</form>

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="javascript:document.getElementById('viewFSJobOfferForm{$Id}').submit();">
{$VacancyTitle[$i]}
</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if trim($CountryName[$i]) eq ''}
<strong>{t}Any{/t}</strong>, {t}telework{/t}
{else}
<strong>{t}{$CountryName[$i]}{/t}</strong>{if $StateProvince[$i]}, {$StateProvince[$i]}{/if}{if $City[$i]}, {$City[$i]}{/if}
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $EP_FirstName[$i]}<strong>{t}Person{/t}</strong>: {/if}
{if $EC_CompanyName[$i]}<strong>{t}Company{/t}</strong>: {/if}
{if $EO_OrganizationName[$i]}<strong>{t}non-profit Organization{/t}</strong>: {/if}
{if trim($Website[$i]) neq ''}<a href="{$Website[$i]}" target="_top">{/if}
{if $EP_FirstName[$i]}{$EP_LastName[$i]} {$EP_MiddleName[$i]}{if $EP_LastName[$i] or $EP_MiddleName[$i]},{/if} {$EP_FirstName[$i]}{/if}
{if $EC_CompanyName[$i]}{$EC_CompanyName[$i]}{/if}
{if $EO_OrganizationName[$i]}{$EO_OrganizationName[$i]}{/if}
{if trim($Website[$i]) neq ''}</a>{/if}
</td>

</tr>

{/foreach}

</table>

{/if}

