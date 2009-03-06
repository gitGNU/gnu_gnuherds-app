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

<h3>{t}FS pledges{/t}</h3>


{include file="offer-type-bar.tpl"}


<p>
{t}A pledge is a promise somebody has made to donate something, for example two cents, to get some task done.{/t}
</p>

<p>
{t}If you like some of the ideas listed in the pledge groups below, you can join to by contributing your two cents to help get it converted into an actual job offer. You can even edit it to add your ideas or corrections.{/t}
</p>

<p>
{t escape='no'
  1='<i>'
  2='</i>'
}If you would like carry out some of the tasks below in exchange for the reported task money, just open it and click "%1I accept%2" to try it.{/t}
</p>

<br>

<form name="newDonationPledgeGroupForm" method="post" action="pledges?action=edit&amp;id=" class="center">
<div>
<input type="submit" name="new" value="{t}New donation pledge group{/t}">
<br>
<br>
{t}FAQ:{/t} <a href="faq#Payments">{t}Payments negotiation{/t}</a>
</div>
</form>

<br>
<br>
<br>


<table border="0">

<tr valign="top">
<td class="tdTitle"><strong>{'Donation pledge group title'|gettext|strip:'&nbsp;'}&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Last update'|gettext|strip:'&nbsp;'}&nbsp;</strong></td>
<td></td>
<td class="tdTitle"><strong>{'Donations'|gettext|strip:'&nbsp;'}&nbsp;</strong></td>
<td></td>
<td><a href="pledges?format=rss{if $smarty.session.Language neq 'en_US'}&language={$smarty.session.Language}{/if}"><img src="themes/red_Danijel/images/rss.png" alt="RSS"></a></td>
</tr>

{if count($JobOfferId) == 0 }
<tr valign="top">
<td colspan="4" class="tdDark center">
{t}There are no entries{/t}
</td>
</tr>
{else}

{foreach from=$JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="pledges?id={$Id}">
{$VacancyTitle[$i]}
</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$OfferDate[$i]}
</td>


<td>
</td>


<td class="{if $i % 2}tdDark{else}tdLight{/if}">
${$Donations[$i]} USD
</td>

</tr>

{/foreach}

{/if}

</table>
