{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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

<h3>{t}FS job offers{/t}</h3>


<p>
{t}Get in contact with some of the best available Free Software experts and their companies. Solve your problems today with the best system administrators, developers, testers, documentalists, etc.{/t}
</p>

{if $smarty.session.Logged neq '1' }
<p>
{t}Are you a Free Software author?. You could register and add your qualifications.{/t}
</p>
{/if}


{if count($JobOfferId) == 0 }
	<p>&nbsp;</p>
	<p>{t}There are not active job offers{/t}.</p><p>&nbsp;</p>
{else}

<table border="0">

<tr valign="top">
<td class="tdTitle"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Location'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Offered by'|gettext|strip:'&nbsp;'}</strong></td>
</tr>

{foreach from=$JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="offers?id={$Id}">
{$VacancyTitle[$i]}
</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if trim($City[$i]) eq '' and trim($StateProvince[$i]) eq '' and trim($CountryName[$i]) eq ''}
<strong>{t}Any{/t}</strong>, {t}telework{/t}
{else}
{if trim($CountryName[$i]) neq ''}
<strong>{t}{$CountryName[$i]}{/t}</strong>{if $StateProvince[$i]}, {$StateProvince[$i]}{/if}{if $City[$i]}, {$City[$i]}{/if}
{else}
{if trim($StateProvince[$i]) neq ''}
{$StateProvince[$i]}{if $City[$i]}, {$City[$i]}{/if}
{else}
{$City[$i]}
{/if}
{/if}
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $EP_FirstName[$i]}<strong>{t}Person{/t}</strong>: {/if}
{if $EC_CompanyName[$i]}<strong>{t}Company{/t}</strong>: {/if}
{if $EO_OrganizationName[$i]}<strong>{t}non-profit Organization{/t}</strong>: {/if}
{if $EP_FirstName[$i] and trim($Blog[$i]) neq ''}<a href="{$Blog[$i]}">{else}{if trim($Website[$i]) neq ''}<a href="{$Website[$i]}">{/if}{/if}
{if $EP_FirstName[$i]}{$EP_LastName[$i]} {$EP_MiddleName[$i]}{if $EP_LastName[$i] or $EP_MiddleName[$i]},{/if} {$EP_FirstName[$i]}{/if}
{if $EC_CompanyName[$i]}{$EC_CompanyName[$i]}{/if}
{if $EO_OrganizationName[$i]}{$EO_OrganizationName[$i]}{/if}
{if ($EP_FirstName[$i] and trim($Blog[$i]) neq '') or trim($Website[$i]) neq ''}</a>{/if}
</td>

</tr>

{/foreach}

</table>

{/if}

