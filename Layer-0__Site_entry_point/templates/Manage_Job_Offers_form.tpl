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

<h3>{t}Manage job offers{/t}</h3>


{if count($data.JobOfferId) == 0 }
	<p>&nbsp;</p>
	<p>{t}You do not have any defined job offer.{/t}</p><p>&nbsp;</p>
{else}

<form name="deleteJobOffersForm" method="post" action="{$smarty.server.REQUEST_URI}">

<table border="0">

<tr valign="top">
<td></td>
<td class="tdTitle"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Expiration date'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Closed'|gettext|strip:'&nbsp;'}</strong></td>
<td></td>
<td class="tdTitle">{'Received'|dgettext:'database'|strip:'&nbsp;'}</td>
<td class="tdTitle">{'In process'|dgettext:'database'|strip:'&nbsp;'}</td>
<td class="tdTitle">{'Ruled out'|dgettext:'database'|strip:'&nbsp;'}</td>
<td class="tdTitle">{'Finalist'|dgettext:'database'|strip:'&nbsp;'}</td>
<td class="tdTitle">{'Selected'|dgettext:'database'|strip:'&nbsp;'}</td>
</tr>

{foreach from=$data.JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<input type="checkbox" name="DeleteJobOffers[]" value="{$Id}">
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="offers?id={$Id}">{$data.VacancyTitle[$i]}</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.ExpirationDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $data.Closed[$i] eq 'f'}
{t}No{/t}
{else}
{t}Yes{/t}
{/if}
</td>

<td>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $ReceivedMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="applications?action=edit&id={$Id}">
{$ReceivedMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $InProcessMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="applications?action=edit&id={$Id}">
{$InProcessMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $RuledOutMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="applications?action=edit&id={$Id}">
{$RuledOutMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $FinalistMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="applications?action=edit&id={$Id}">
{$FinalistMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $SelectedMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="applications?action=edit&id={$Id}">
{$SelectedMeter[$i]}
</a>
{/if}
</td>

</tr>

{/foreach}

<tr>
<td colspan="5">&nbsp;</td>
</tr>

<tr>
<td colspan="5">
{if count($data.JobOfferId) > 0 }
<input type="submit" name="delete" value="{t}Delete selected offers{/t}">
{/if}
</td>
</tr>

</table>

</form>

{/if}

<form name="newJobOffersForm" method="post" action="offers?action=edit&id=&section=general">{* This could be a GET request instead of a POST one. I have used a POST to be able to use a button, due to it is near of the delete button. *}
<div><input type="submit" name="new" value="{t}New job offer{/t}"></div>
</form>

