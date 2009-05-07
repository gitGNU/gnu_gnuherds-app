{*
Authors: Davi Leal

Copyright (C) 2007, 2008, 2009 Davi Leal <davi at leals dot com>

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

<h3>{t}Settings{/t}</h3>

<form name="formLogin" method="post" action="settings">

<p>{t}Alerts via email on:{/t}</p>

<table class="marginA">

<tr>
<td>

<label>
<input type="checkbox" name="NewJobOffer" id="NewJobOffer" class="notRequired" {if $data.NewJobOffer eq 'true'} checked {/if}>
{t}any new job offer{/t}
</label>
<br>

{* XXX: DELAYED
<label>
<input type="checkbox" name="MyQualifications" id="MyQualifications" class="notRequired" {if $data.MyQualifications eq 'true'} checked {/if} disabled>
<span class="strike">{t}any new job offer which fits my qualifications{/t}</span>
</label>
<br>
*}

<label>
<input type="checkbox" name="NewDonationPledgeGroup" id="NewDonationPledgeGroup" class="notRequired" {if $data.NewDonationPledgeGroup eq 'true'} checked {/if}>
{t}any new donation pledge group{/t}
</label>
<br>

<label>
<input type="checkbox" name="NewLookForVolunteers" id="NewLookForVolunteers" class="notRequired" {if $data.NewLookForVolunteers eq 'true'} checked {/if}>
{t}any new look-for-volunteers notice{/t}
</label>
<br>

</td>
</tr>

</table>

<br>

<p>{t}Alerts behavior:{/t}</p>

<table class="marginA">

<tr>
<td>

<label>
<input type="checkbox" name="AlertMeOnMyOwnNotices" id="AlertMeOnMyOwnNotices" class="notRequired" {if $data.AlertMeOnMyOwnNotices eq 'true'} checked {/if}>
{t}alert me on my own notices{/t}
</label>
<br>

</td>
</tr>

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>

<tr align="center">
<td colspan="4" align="center">
<input type="submit" name="save" value="{t}Save{/t}">
</td>
</tr>

</table>

</form>

