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

<form name="dataForm" method="post" action="resume?action=edit&id={$smarty.get.EntityId}">

<table align="center">

{if $smarty.session.HasQualifications eq '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE QUALIFICATIONS DATA{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW QUALIFICATIONS{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4">
{include file="Qualifications_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}LOCATION{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $smarty.session.LoginType neq 'Person' }
<tr> <td colspan="4"><p>{t}Staff:{/t}<p></td> </tr>
{/if}

<tr valign="bottom">
<td align="right"> <input type="checkbox" name="AvailableToTravel" id="AvailableToTravel" class="notRequired" {if $data.AvailableToTravel eq 'true'} checked {/if} > </td>
<td colspan="3"> <label for="AvailableToTravel">{t}Available to travel{/t}</label> </td>
</tr>

<tr valign="bottom">
<td align="right"> <input type="checkbox" name="AvailableToChangeResidence" id="AvailableToChangeResidence" class="notRequired" {if $data.AvailableToChangeResidence eq 'true'} checked {/if} > </td>
<td colspan="3"> <label for="AvailableToChangeResidence">{'Available to change residence'|gettext|strip:'&nbsp;'}</label> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.HasQualifications eq '1' }
<a href="resume?id={$smarty.session.EntityId}">{t}Check qualifications view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section">

{if $smarty.session.LoginType eq 'Person' }
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section">
{else}
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section" disabled>
{/if}

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="projects">

{if $smarty.session.LoginType eq 'Person' }
<input type="hidden" name="jump2next" value="contract">
{/if}

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>
