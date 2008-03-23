{*
Authors: Davi Leal

Copyright (C) 2007, 2008 Davi Leal <davi at leals dot com>

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

<table>

<tr>
<td>

<label>
<input type="checkbox" name="NewJobOffer" id="NewJobOffer" class="notRequired" {if $data.NewJobOffer eq 'true'} checked {/if}>
{t}any new job offer{/t}
</label>
<br>

<label>
<input type="checkbox" name="MyQualifications" id="MyQualifications" class="notRequired" {if $data.MyQualifications eq 'true'} checked {/if} disabled>
<span class="strike">{t}any new job offer which fits my qualifications{/t}</span>
</label>
<br>

</td>
</tr>

<tr> <td>&nbsp;</td> </tr>

<tr align="center">
<td colspan="4" align="center">
<input type="submit" name="save" value="{t}Save{/t}">
</td>
</tr>

</table>

</form>

