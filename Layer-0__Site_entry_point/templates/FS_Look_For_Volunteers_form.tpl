{*
Authors: Davi Leal

Copyright (C) 2008 Davi Leal <davi at leals dot com>

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
</tr>

{if count($JobOfferId) == 0 }
<tr valign="top">
<td colspan="3" class="tdDark center">
{t}There are no entries{/t}
</td>
</tr>
{else}

{foreach from=$JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="volunteers?id={$Id}">
{$VacancyTitle[$i]}
</a>
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

{/if}

</table>

