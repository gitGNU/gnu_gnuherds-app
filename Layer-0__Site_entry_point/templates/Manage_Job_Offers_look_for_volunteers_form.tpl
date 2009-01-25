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

<form name="deleteJobOffersForm" method="post" action="{$smarty.server.REQUEST_URI}">

<table border="0">

<tr>
{if count($data.JobOfferId) != 0 }
<td class="tdTitle" colspan="2"></td>
{/if}
<td class="tdTitle"><strong>{'Volunteer title'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Entry date'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Expiration date'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
</tr>


{if count($data.JobOfferId) == 0 }

<tr>
<td colspan="3" class="tdDark center">
{t}There are no entries{/t}
</td>
</tr>


{else}


{foreach from=$data.JobOfferId item=Id key=i}

<tr>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<input type="checkbox" name="DeleteJobOffers[]" value="{$Id}">
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<img src="/themes/red_Danijel/images/volunteers.tiny.png" alt="{t}icon{/t}">
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="volunteers?id={$Id}">{$data.VacancyTitle[$i]}</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.ExpirationDate[$i]}
</td>

</tr>

{/foreach}


<tr>
<td colspan="5">
<input type="submit" name="delete" value="{t}Delete selected entries{/t}">
</td>
</tr>

{/if}

</table>

</form>
