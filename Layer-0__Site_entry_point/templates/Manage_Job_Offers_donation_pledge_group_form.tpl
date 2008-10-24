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

<form name="deleteJobOffersForm" method="post" action="{$smarty.server.REQUEST_URI}">

<table border="0">

<tr>
{if count($data.MyDonations.DonationId) != 0 }
<td class="tdTitle"></td>
{/if}
<td class="tdTitle"><strong>{'Donation pledge group title'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Last update'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Expiration date'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Donations'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td></td>
<td class="tdTitle">{'My donation'|gettext|strip:'&nbsp;'}</td>
</tr>


{if count($data.MyDonations.DonationId) == 0 }

<tr>
<td colspan="4" class="tdDark center">
{t}There are no entries{/t}
</td>
</tr>


{else}


{assign var='x' value=0}

{foreach from=$data.MyDonations.DonationId item=DonationId key=i}

<tr>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<img src="/themes/red_Danijel/images/donations.tiny.png" alt="{t}icon{/t}">
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="pledges?id={$data.MyDonations.DonationPledgeGroupId[$i]}">{$data.VacancyTitle[$i]}</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.ExpirationDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
${$data.Donations[$i]} USD
</td>


<td>
</td>


<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<input type="hidden" name="JobOfferId[]" value="{$data.MyDonations.DonationPledgeGroupId[$i]}"> {* Delete its DonationPledgeGroup if we cancel its last donation. *}
<input type="hidden" name="DonationId[]" value="{$data.MyDonations.DonationId[$i]}">
<input type="checkbox" name="CancelDonations[]" value="{$x}">
${$data.MyDonations.Donation[$i]} USD
</td>

</tr>

{assign var='x' value=`$x+1`}

{/foreach}

<tr align="right">
<td colspan="7">
<input type="submit" name="delete" value="{t}Cancel selected donations{/t}">
</td>
</tr>

{/if}

</table>

</form>
