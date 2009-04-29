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

<h3>{t}Looking for volunteers{/t}</h3>


{include file="offer-type-bar.tpl"}


<p>
{t escape='no'
  1='<a href="pledges">'
  2='</a>'
  3='<i>'
  4='</i>'
}If you would like to donate something for fulfilling a task, please create it as a %1FS pledge%2 entry instead of as a %3looking for volunteers%4 one.{/t}
</p>

<!-- XXX: DELAYED: This feature is delayed.
<p>
{t escape='no'
  1='<a href="pledges">'
  2='</a>'
  3='<i>'
  4='</i>'
}You can promise your two cents to convert some of the below volunteer entries into a %1FS pledge%2. Just open it and click "%3My pledge%4".{/t}
</p>
-->

<br>

<form name="newLookForVolunteerForm" method="post" action="volunteers?action=edit&amp;id=" class="center">
<div>
<input type="submit" name="new" value="{t}New look for volunteers{/t}">
</div>
</form>

<br>
<br>
<br>


<table border="0">

<tr valign="top">
<td class="tdTitle"><strong>{'Volunteer title'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Entry date'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Created by'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
<td></td>
<td><a href="volunteers?format=rss{if $smarty.session.Language neq 'en_US'}&language={$smarty.session.Language}{/if}"><img src="themes/red_Danijel/images/rss.png" alt="RSS"></a></td>
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

</table>

