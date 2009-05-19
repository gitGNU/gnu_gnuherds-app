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
<th>{'Donation pledge group title'|gettext|strip:'&nbsp;'}</th>
<th>{'Last update'|gettext|strip:'&nbsp;'}</th>
<th>{'Donations'|gettext|strip:'&nbsp;'}</th>
</tr>

{if count($data.DonationPledgeGroup.JobOfferId) == 0 }
<tr valign="top">
<td colspan="3" class="tdDark center">
{t}There are no entries{/t}
</td>
</tr>
{else}

{foreach from=$data.DonationPledgeGroup.JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="pledges?id={$Id}">
{$data.DonationPledgeGroup.VacancyTitle[$i]}
</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.DonationPledgeGroup.OfferDate[$i]}
</td>




<td class="{if $i % 2}tdDark{else}tdLight{/if}">
${$data.DonationPledgeGroup.Donations[$i]} USD
</td>

</tr>

{/foreach}

{/if}
