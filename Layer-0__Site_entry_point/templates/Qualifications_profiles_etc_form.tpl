{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007, 2008 Davi Leal <davi at leals dot com>
              2007, 2008 Victor Engmark <victor dot engmark at gmail dot com>

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

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match.{/t} {t}Please try again.{/t}</span></td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>
{/if}

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Technical{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $smarty.session.LoginType neq 'Person' }
<tr> <td colspan="4"><p>{t}Staff with the below characteristic:{/t}<p></td> </tr>
{/if}

<tr>
<td align="right"><span class="must">*</span><label for="ProfessionalExperienceSinceYear">{'Professional experience since'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">
{if $data.ProfessionalExperienceSinceYear eq ''}
	{assign var=ProfessionalExperienceSinceYear value='--'}
{else}
	{assign var=ProfessionalExperienceSinceYear value="01-01-`$data.ProfessionalExperienceSinceYear`"}
{/if}
{html_select_date prefix="ProfessionalExperienceSince" time="$ProfessionalExperienceSinceYear" start_year="-82" end_year="+0" display_days=false display_months=false year_empty="" year_extra="id= ProfessionalExperienceSinceYear class=required"}
</td>
</tr>

{if $checks.ProfessionalExperienceSinceYear neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.ProfessionalExperienceSinceYear}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"><label class="raisePopUp" title="{t}Press Ctrl key to choose more than one Profile{/t}">{t}Profiles{/t}</label></td>

<td><label for="ProductProfileList">{'Product profiles'|gettext|strip:'&nbsp;'}</label><br>
<select name="ProductProfileList[]" id="ProductProfileList" size="{$productProfiles|@count}" multiple="multiple" class="notRequired">
{html_options values=$productProfiles output=$productProfiles selected=$data.ProductProfileList}
</select>
</td>

<td><label for="ProfessionalProfileList">{'Professional profiles'|gettext|strip:'&nbsp;'}</label><br>
<select name="ProfessionalProfileList[]" id="ProfessionalProfileList" size="{$professionalProfilesId|@count}" multiple="multiple" class="notRequired">
{html_options values=$professionalProfilesId output=$professionalProfilesName selected=$data.ProfessionalProfileList}
</select>
</td>

<td><label for="FieldProfileList">{'Field profiles'|gettext|strip:'&nbsp;'}</label><br>
<select name="FieldProfileList[]" id="FieldProfileList" size="{$fieldProfilesId|@count}" multiple="multiple" class="notRequired">
{html_options values=$fieldProfilesId output=$fieldProfilesName selected=$data.FieldProfileList}
</select>
</td>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.HasQualifications eq '1' }
<a href="resume?id={$smarty.session.EntityId}">{t}Check qualifications view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="{t}Save and move to the previous section{/t}" disabled>
<input type="submit" name="next" value="{t}Next{/t}" title="{t}Save and move to the next section{/t}">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2next" value="academic">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.academic neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>
