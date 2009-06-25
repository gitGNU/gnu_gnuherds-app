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


<p>
{t}Post a job offer to get in contact with some of the best available Free Software experts and their companies. Solve your problems today with the best system administrators, developers, testers, documentalists, etc.{/t}
</p>

<table class="marginB">
{include file="button-to-create-job-offer.tpl"}
</table>

<br>
<br>
<br>


<p>
{t}A pledge is a promise somebody has made to donate something, for example two cents, to get some task done.{/t}
</p>

<!-- XXX: DELAYED: This maybe should go to a new FAQ question.
<p>
{t}If you like some of the ideas listed in the pledge groups below, you can join to by contributing your two cents to help get it converted into an actual job offer. You can even edit it to add your ideas or corrections.{/t}
</p>

<p>
{t escape='no'
  1='<i>'
  2='</i>'
}If you would like carry out some of the tasks below in exchange for the reported task money, just open it and click "%1I accept%2" to try it.{/t}
</p>
-->

<table class="marginB">
{include file="button-to-create-donation-pledge-group.tpl"}
</table>

<br>
<br>
<br>


<p>
{t escape='no'
  1='<i>'
  2='</i>'
}If you would like to donate something for fulfilling a task, please create it as a pledge entry instead of as a %1looking for volunteers%2 one.{/t}
</p>

<!-- XXX: DELAYED: This feature is delayed.
<p>
{t escape='no'
  1='<a href="pledges">'
  2='</a>'
  3='<i>'
  4='</i>'
}You can promise your two cents to convert some of the below volunteer entries into a %1pledge%2. Just open it and click "%3My pledge%4".{/t}
</p>
-->

<table class="marginB">
{include file="button-to-create-look-for-volunteers.tpl"}
</table>

