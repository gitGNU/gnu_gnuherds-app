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

<form name="dataForm" method="post" action="resume?action=edit&id={$smarty.get.EntityId}">

<table>

{if $smarty.session.HasQualifications eq '1' }
<tr> <td colspan="4" align="center" class="mainsection">{t}Update qualifications data{/t}</td> </tr>
{else}
<tr> <td colspan="4" align="center" class="mainsection">{t}New qualifications{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="center">
{include file="Qualifications_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Location{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $smarty.session.LoginType neq 'Person' }
<tr> <td colspan="4"><p>{t}Staff with the below characteristic:{/t}<p></td> </tr>
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

<input type="submit" name="previous" value="{t}Previous{/t}" title="{t}Save and move to the previous section{/t}">

{if $smarty.session.LoginType eq 'Person' }
<input type="submit" name="next" value="{t}Next{/t}" title="{t}Save and move to the next section{/t}">
{else}
<input type="submit" name="next" value="{t}Next{/t}" title="{t}Save and move to the next section{/t}" disabled>
{/if}

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="projects">

{if $smarty.session.LoginType eq 'Person' }
<input type="hidden" name="jump2next" value="contract">
{/if}

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>
