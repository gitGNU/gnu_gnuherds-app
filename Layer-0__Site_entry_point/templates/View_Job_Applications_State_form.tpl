{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

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

<h3>{t}Job applications{/t}</h3>
{if count($jobOfferId) == 0 }
	<p>&nbsp;</p>
	<p>{t}You do not have your application subscribed to any open job offer.{/t}</p>
	<p>&nbsp;</p>
{else}
<table border="0">
<tr valign="top">
<td class="tdTitle"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong></td>
<td></td>
<td class="tdTitle">{'Subscription state'|gettext|strip:'&nbsp;'}</td>
</tr>
{foreach from=$jobOfferId item=Id key=i}
<tr valign="top">
<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="offers?id={$Id}">
{$vacancyTitle[$i]}
</a>
</td>
<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$offerDate[$i]}
</td>
<td></td>
<td class="
{if $state[$i] eq 'Received'}{if $i % 2}tdDark{else}tdLight{/if}{/if}
{if $state[$i] eq 'In process'}blueApplicationState{/if}
{if $state[$i] eq 'Ruled out'}redApplicationState{/if}
{if $state[$i] eq 'Finalist'}almostGreenApplicationState{/if}
{if $state[$i] eq 'Selected'}greenApplicationState{/if}
">
{t domain='database'}{$state[$i]}{/t}
{*
'Received'	without color
'In process'	blue
'Ruled out'	red
'Finalist' 	almost green
'Selected'	green
*}
</td>
</tr>
{/foreach}
</table>
{/if}
