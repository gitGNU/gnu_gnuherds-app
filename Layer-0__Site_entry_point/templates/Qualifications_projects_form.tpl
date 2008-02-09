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

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match.{/t} {t}Please try again.{/t}</span></td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="note" width="620">{t}Add URIs to the work you or your staff have contributed to public Free Software projects. It is good practice add more than just the project's URI, adding too URIs to some of your best commits, or email discussion threads where you or your staff expose your knowledge, rationales, feedback, etc.{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Technical{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="right">

<table>
<tr>
<td>
{if $data.ContributionsListProject|@count >= 1}
<label>{'Mark to delete'|gettext|strip:'&nbsp;'}</label>
{/if}
</td>
<td><label>{t}Project{/t}</label></td>
<td>
<label>{t}Description{/t}</label>
</td>
<td>
<label>{t}URI{/t}</label>
</td>
</tr>


{foreach from=$data.ContributionsListProject item=Contribution key=i}

<tr valign="top">
<td align="right">
{if $data.ContributionsListProject|@count >= 1}
<input type="checkbox" name="DeleteContributionsList[]" value="{$i}">
{/if}
</td>

<td>
<input type="text" name="ContributionsListProject[]" size="15" maxlength="30" value="{$data.ContributionsListProject[$i]}" class="notRequired">
{if $checks.ContributionsListProject[$i] neq '' }
<br>
<span class="must">{$checks.ContributionsListProject[$i]}</span>
{/if}
</td>

<td>
<input type="text" name="ContributionsListDescription[]" size="40" maxlength="60" value="{$data.ContributionsListDescription[$i]}" class="notRequired">
</td>

<td>
<input type="text" name="ContributionsListURI[]" size="30" maxlength="255" value="{$data.ContributionsListURI[$i]}" class="notRequired">
{if $checks.ContributionsListURI[$i] neq '' }
<br>
<span class="must">{$checks.ContributionsListURI[$i]}</span>
{/if}
</td>
</tr>

{/foreach}


{if $checkresults.projects eq 'pass' or $data.ContributionsListProject|@count < 1 }

<tr valign="top">
<td>
</td>

<td>
<input type="text" name="ContributionsListProject[]" size="15" maxlength="30" value="" class="notRequired">
</td>

<td>
<input type="text" name="ContributionsListDescription[]" size="40" maxlength="60" value="" class="notRequired">
</td>

<td>
<input type="text" name="ContributionsListURI[]" size="30" maxlength="255" value="http://" class="notRequired">
</td>
</tr>

{/if}


<tr>
<td colspan="4" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="{t}Save and or delete and stay here to add more{/t}">
</td>
</tr>
</table>

</td>
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
<input type="submit" name="next" value="{t}Next{/t}" title="{t}Save and move to the next section{/t}">

<input type="hidden" name="section2control" value="{$section}">

{* The certifications feature is disabled
<input type="hidden" name="jump2previous" value="certifications"> *}
<input type="hidden" name="jump2previous" value="languages">
<input type="hidden" name="jump2next" value="location">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.location neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>

