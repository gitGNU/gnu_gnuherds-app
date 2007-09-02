{*
Authors: Davi Leal

Copyright (C) 2007 Davi Leal <davi at leals dot com>

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

<h3>{t}Settings{/t}</h3>

<form name="formLogin" method="post" action="settings">

<p>{t}Alerts via email on:{/t}</p>

<table align="left">

<tr>
<td>

&nbsp; &nbsp; &nbsp; &nbsp;
<label>
<input type="checkbox" name="NewJobOffer" id="NewJobOffer" class="notRequired" {if $data.NewJobOffer eq 'true'} checked {/if}>
{t}any new job offer{/t}
</label>
<br>

&nbsp; &nbsp; &nbsp; &nbsp;
<label>
<input type="checkbox" name="MyQualifications" id="MyQualifications" class="notRequired" {if $data.MyQualifications eq 'true'} checked {/if} disabled>
<STRIKE>{t}any new job offer which fits my qualifications{/t}</STRIKE>
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

