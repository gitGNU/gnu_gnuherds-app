{*
Authors: Davi Leal

Copyright (C) 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>

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

<tr valign="top">
<th>{'Vacancy title'|gettext|strip:'&nbsp;'}</th>
<th>{'Location'|gettext|strip:'&nbsp;'}</th>
<th>{'Offer date'|gettext|strip:'&nbsp;'}</th>
<th>{'Offered by'|gettext|strip:'&nbsp;'}</th>
</tr>

{if count($data.JobOffers.JobOfferId) == 0 }
<tr valign="top">
<td colspan="4" class="tdDark center">
{t}There are no active job offers{/t}
</td>
</tr>
{else}

{foreach from=$data.JobOffers.JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="offers?id={$Id}">
{$data.JobOffers.VacancyTitle[$i]}
</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $data.JobOffers.OfferType[$i] eq 'Job offer'}
{if trim($data.JobOffers.City[$i]) eq '' and trim($data.JobOffers.StateProvince[$i]) eq '' and trim($data.JobOffers.Country[$i]) eq ''}
<strong>{t domain='database'}Any{/t}</strong>, {t}telework{/t}
{else}
{if trim($data.JobOffers.Country[$i]) neq ''}
<strong>{t domain='iso_3166'}{$data.JobOffers.Country[$i]}{/t}</strong>{if $data.JobOffers.StateProvince[$i]}, {$data.JobOffers.StateProvince[$i]}{/if}{if $data.JobOffers.City[$i]}, {$data.JobOffers.City[$i]}{/if}
{else}
{if trim($data.JobOffers.StateProvince[$i]) neq ''}
{$data.JobOffers.StateProvince[$i]}{if $data.JobOffers.City[$i]}, {$data.JobOffers.City[$i]}{/if}
{else}
{$data.JobOffers.City[$i]}
{/if}
{/if}
{/if}
{else}-{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.JobOffers.OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $data.JobOffers.EntityType[$i] eq 'Person'}<strong>{t}Person{/t}</strong>: {/if}
{if $data.JobOffers.EntityType[$i] eq 'Cooperative'}<strong>{t}Cooperative{/t}</strong>: {/if}
{if $data.JobOffers.EntityType[$i] eq 'Company'}<strong>{t}Company{/t}</strong>: {/if}
{if $data.JobOffers.EntityType[$i] eq 'non-profit Organization'}<strong>{t}non-profit Organization{/t}</strong>: {/if}

{if $data.JobOffers.EntityType[$i] eq 'Person' and trim($data.JobOffers.Blog[$i]) neq ''}<a href="{$data.JobOffers.Blog[$i]}">{else}{if trim($data.JobOffers.Website[$i]) neq ''}<a href="{$data.JobOffers.Website[$i]}">{/if}{/if}


{if $data.JobOffers.Email[$i]}

{if $data.JobOffers.EntityType[$i] eq 'Person'}
{if $data.JobOffers.LastName[$i] or $data.JobOffers.FirstName[$i] or $data.JobOffers.MiddleName[$i]}
{$data.JobOffers.LastName[$i]}{if $data.JobOffers.LastName[$i] and ($data.JobOffers.FirstName[$i] or $data.JobOffers.MiddleName[$i])},{/if} {$data.JobOffers.FirstName[$i]} {$data.JobOffers.MiddleName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{if $data.JobOffers.EntityType[$i] eq 'Cooperative'}
{if $data.JobOffers.CooperativeName[$i]}
{$data.JobOffers.CooperativeName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{if $data.JobOffers.EntityType[$i] eq 'Company'}
{if $data.JobOffers.CompanyName[$i]}
{$data.JobOffers.CompanyName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{if $data.JobOffers.EntityType[$i] eq 'non-profit Organization'}
{if $data.JobOffers.OrganizationName[$i]}
{$data.JobOffers.OrganizationName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{else}
{t}Email not verified!{/t}
{/if}


{if ($data.JobOffers.EntityType[$i] eq 'Person' and trim($data.JobOffers.Blog[$i]) neq '') or trim($data.JobOffers.Website[$i]) neq ''}</a>{/if}
</td>

</tr>

{/foreach}

{/if}
