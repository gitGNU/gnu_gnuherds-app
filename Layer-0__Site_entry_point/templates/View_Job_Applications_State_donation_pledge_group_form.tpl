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

<table border="0">

<tr>
{if count($jobOfferId) != 0 }
<td class="tdTitle"></td>
{/if}
<td class="tdTitle"><strong>{'Donation pledge group title'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Last update'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Donations'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
</tr>


{if count($jobOfferId) == 0 }

<tr>
<td colspan="3" class="tdDark center">
{t}There are no entries{/t}
</td>
</tr>


{else}


{foreach from=$jobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<img src="/themes/red_Danijel/images/donations.tiny.png" alt="{t}icon{/t}">
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="pledges?id={$Id}">{$vacancyTitle[$i]}</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$offerDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
${$donations[$i]} USD
</td>

</tr>

{/foreach}
{/if}

</table>
