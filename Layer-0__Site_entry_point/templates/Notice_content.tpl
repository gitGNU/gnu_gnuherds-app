{*
Authors: Davi Leal

Copyright (C) 2009 Davi Leal <davi at leals dot com>

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

<h3>{t}Post offer{/t}</h3>


<p>
{t escape='no'
  1='<a href="offers?action=edit&amp;id=">'
  2='<a href="pledges?action=edit&amp;id=">'
  3='<a href="volunteers?action=edit&amp;id=">'
  4='</a>'
}Are you posting a %1paid job%4, making a donation %2pledge%4, or looking for %3volunteers%4?{/t}
</p>

<br>

<table class="center">
<tr>

<td><div class="spacerB"></div></td>

<td>
<a href="offers?action=edit&amp;id=">
<img src="/themes/red_Danijel/images/contracts.png" alt="{t}FS job offers{/t}"><br>
</a>
<a href="offers?action=edit&amp;id=">
{t}job offers{/t}
</a>
</td>

<td><div class="spacerB"></div></td>

<td>
<a href="pledges?action=edit&amp;id=">
<img src="/themes/red_Danijel/images/donations.png" alt="{t}FS pledges{/t}"><br>
</a>
<a href="pledges?action=edit&amp;id=">
{t}pledges{/t}
</a>
</td>

<td><div class="spacerB"></div></td>

<td>
<a href="volunteers?action=edit&amp;id=">
<img src="/themes/red_Danijel/images/volunteers.png" alt="{t}FS volunteers{/t}"><br>
</a>
<a href="volunteers?action=edit&amp;id=">
{t}volunteers{/t}
</a>
</td>

<tr>
</table>

<br>
<br>
<br>
<br>
<br>
<br>


<table class="marginB">
{include file="button-to-create-job-offer.tpl"}

<!-- {include file="button-to-create-donation-pledge-group.tpl"} -->
<tr valign="top">
<td>
<a href="pledges?action=edit&amp;id=">
<img src="/themes/red_Danijel/images/donations.tiny.png" alt="{t}icon{/t}">
</a>
</td>
<td>
<form name="newDonationPledgeGroupForm" method="post" action="pledges?action=edit&amp;id=">
<input type="submit" name="new" value="{t}New donation pledge group{/t}">
</form>
</td>
</tr>

{include file="button-to-create-look-for-volunteers.tpl"}
</table>
