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
<th>{'Volunteer title'|gettext|strip:'&nbsp;'}</th>
<th>{'Entry date'|gettext|strip:'&nbsp;'}</th>
<th>{'Created by'|gettext|strip:'&nbsp;'}</th>
</tr>

{if count($data.LookForVolunteers.JobOfferId) == 0 }
<tr valign="top">
<td colspan="3" class="tdDark center">
{t}There are no entries{/t}
</td>
</tr>
{else}

{foreach from=$data.LookForVolunteers.JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="volunteers?id={$Id}">
{$data.LookForVolunteers.VacancyTitle[$i]}
</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.LookForVolunteers.OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $data.LookForVolunteers.EntityType[$i] eq 'Person'}<strong>{t}Person{/t}</strong>: {/if}
{if $data.LookForVolunteers.EntityType[$i] eq 'Cooperative'}<strong>{t}Cooperative{/t}</strong>: {/if}
{if $data.LookForVolunteers.EntityType[$i] eq 'Company'}<strong>{t}Company{/t}</strong>: {/if}
{if $data.LookForVolunteers.EntityType[$i] eq 'non-profit Organization'}<strong>{t}non-profit Organization{/t}</strong>: {/if}

{if $data.LookForVolunteers.EntityType[$i] eq 'Person' and trim($data.LookForVolunteers.Blog[$i]) neq ''}<a href="{$data.LookForVolunteers.Blog[$i]}">{else}{if trim($data.LookForVolunteers.Website[$i]) neq ''}<a href="{$data.LookForVolunteers.Website[$i]}">{/if}{/if}


{if $data.LookForVolunteers.Email[$i]}

{if $data.LookForVolunteers.EntityType[$i] eq 'Person'}
{if $data.LookForVolunteers.LastName[$i] or $data.LookForVolunteers.FirstName[$i] or $data.LookForVolunteers.MiddleName[$i]}
{$data.LookForVolunteers.LastName[$i]}{if $data.LookForVolunteers.LastName[$i] and ($data.LookForVolunteers.FirstName[$i] or $data.LookForVolunteers.MiddleName[$i])},{/if} {$data.LookForVolunteers.FirstName[$i]} {$data.LookForVolunteers.MiddleName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{if $data.LookForVolunteers.EntityType[$i] eq 'Cooperative'}
{if $data.LookForVolunteers.CooperativeName[$i]}
{$data.LookForVolunteers.CooperativeName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{if $data.LookForVolunteers.EntityType[$i] eq 'Company'}
{if $data.LookForVolunteers.CompanyName[$i]}
{$data.LookForVolunteers.CompanyName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{if $data.LookForVolunteers.EntityType[$i] eq 'non-profit Organization'}
{if $data.LookForVolunteers.OrganizationName[$i]}
{$data.LookForVolunteers.OrganizationName[$i]}
{else}
{t}Name{/t}: {t}not specified{/t}
{/if}
{/if}

{else}
{t}Email not verified!{/t}
{/if}


{if ($data.LookForVolunteers.EntityType[$i] eq 'Person' and trim($data.LookForVolunteers.Blog[$i]) neq '') or trim($data.LookForVolunteers.Website[$i]) neq ''}</a>{/if}
</td>

</tr>

{/foreach}

{/if}
