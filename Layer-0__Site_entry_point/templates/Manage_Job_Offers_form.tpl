{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

This program is free software; you can redistribute it and/or modify it under
the terms of the Affero General Public License as published by Affero Inc.,
either version 1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful to the Free
Software community, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
General Public License for more details.

You should have received a copy of the Affero General Public License with this
software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
Suite 225, San Francisco, CA 94107, USA
*}

<h3>{t}Manage Job Offers{/t}</h3>


{if count($smarty.session.M_JobOfferId) == 0 }
	<p>&nbsp;</p>
	<p>{t}You do not have any defined job offer.{/t}</p><p>&nbsp;</p>
{else}

<form name="deleteJobOffersForm" method="post" action="{$smarty.server.REQUEST_URI}">

<table align="center" border="0" width="100%">

<tr valign="top">
<td></td>
<td class="tdTitle"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Expiration date'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Closed'|gettext|strip:'&nbsp;'}</strong></td>
<td></td>
<td class="tdTitle">{'Received'|gettext|strip:'&nbsp;'}</td>
<td class="tdTitle">{'In process'|gettext|strip:'&nbsp;'}</td>
<td class="tdTitle">{'Ruled out'|gettext|strip:'&nbsp;'}</td>
<td class="tdTitle">{'Finalist'|gettext|strip:'&nbsp;'}</td>
<td class="tdTitle">{'Selected'|gettext|strip:'&nbsp;'}</td>
</tr>

{foreach from=$smarty.session.M_JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<input type="checkbox" name="DeleteJobOffers[]" value="{$Id}">
</td>


<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="/Job_Offer.php?JobOfferId={$Id}">{$smarty.session.M_VacancyTitle[$i]}</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$smarty.session.M_OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$smarty.session.M_ExpirationDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $smarty.session.M_Closed[$i] eq 'f'}
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
<a href="/Manage_Job_Offer_Applications.php?JobOfferId={$Id}">
{$ReceivedMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $InProcessMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="/Manage_Job_Offer_Applications.php?JobOfferId={$Id}">
{$InProcessMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $RuledOutMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="/Manage_Job_Offer_Applications.php?JobOfferId={$Id}">
{$RuledOutMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $FinalistMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="/Manage_Job_Offer_Applications.php?JobOfferId={$Id}">
{$FinalistMeter[$i]}
</a>
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $SelectedMeter[$i] eq '0'}
{t}none{/t}
{else}
<a href="/Manage_Job_Offer_Applications.php?JobOfferId={$Id}">
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
{if count($smarty.session.M_JobOfferId) > 0 }
<input type="submit" name="delete" value="{t}Delete selected offers{/t}">
{/if}
</td>
</tr>

</table>

</form>

{/if}

<form name="newJobOffersForm" method="post" action="Job_Offer.php">
<input type="submit" name="new" value="{t}New offer{/t}">
</form>

