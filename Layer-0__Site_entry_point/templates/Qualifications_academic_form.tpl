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

<tr> <td colspan="4" class="subsection">{t}Academic qualification{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $smarty.session.LoginType neq 'Person' }
<tr>
<td colspan="4" align="right">
<p>{t}Staff with the below characteristic:{/t}<p>
</td>
</tr>
{/if}

{if $data.AcademicLevelList|@count >= 1}
<tr>
<td colspan="4"><label>{'Mark to delete'|gettext|strip:'&nbsp;'}</label></td>
</tr>
{/if}


{foreach from=$data.AcademicLevelList item=AcademicLevel key=i}

<tr valign="top">
<td><input type="checkbox" name="DeleteAcademicList[]" value="{$i}"></td>

<td colspan="3" class="box">
<table>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label>{'Degree'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}"><input type="text" name="DegreeList[]" size="60" maxlength="80" value="{$data.DegreeList[$i]}" class="{if $i % 2}greenDark{else}greenLight{/if}"></td>
</tr>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label>{'Academic level'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<select name="AcademicLevelList[]" class="{if $i % 2}greenDark{else}greenLight{/if}">
{html_options values=$academicLevelsId output=$academicLevelsIdTranslated selected=$data.AcademicLevelList[$i]}
</select>
</td>
</tr>

<tr><td colspan="2" class="{if $i % 2}greenDark{else}greenLight{/if}">&nbsp;</td></tr>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label>{'Degree granted'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<select name="DegreeGrantedList[]" class="{if $i % 2}greenDark{else}greenLight{/if}">
<option label="" value=""></option>
<option label="{t}No{/t}" value="No" {if $data.DegreeGrantedList[$i] eq 'No'}selected="selected"{/if}>{t}No{/t}</option>
<option label="{t}Yes{/t}" value="Yes" {if $data.DegreeGrantedList[$i] eq 'Yes'}selected="selected"{/if}>{t}Yes{/t}</option>
</select>
</td>
</tr>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label class="raisePopUp" title="{t}The format could be for example{/t}: yyyy-mm-dd , mm/dd/yyyy">{'Start date'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}"><input type="text" name="StartDateList[]" size="11" maxlength="10" value="{$data.StartDateList[$i]}" class="{if $i % 2}greenDark{else}greenLight{/if}">

{if $checks.StartDateList[$i] neq '' }
<span class="must">{$checks.StartDateList[$i]}</span>
{/if}

</td>
</tr>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label class="raisePopUp" title="{t}The format could be for example{/t}: yyyy-mm-dd , mm/dd/yyyy">{'Finish date'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}"><input type="text" name="FinishDateList[]" size="11" maxlength="10" value="{$data.FinishDateList[$i]}" class="{if $i % 2}greenDark{else}greenLight{/if}">

{if $checks.FinishDateList[$i] neq '' }
<span class="must">{$checks.FinishDateList[$i]}</span>
{/if}

</td>
</tr>

<tr><td colspan="2" class="{if $i % 2}greenDark{else}greenLight{/if}">&nbsp;</td></tr>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label class="raisePopUp" title="{t}University or education institution{/t}">{'Institution'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}"><input type="text" name="InstitutionList[]" size="60" maxlength="80" value="{$data.InstitutionList[$i]}" class="{if $i % 2}greenDark{else}greenLight{/if}"></td>
</tr>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label>{'Institution\'s URI'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}"><input type="text" name="InstitutionURIList[]" size="60" maxlength="255" value="{$data.InstitutionURIList[$i]}" class="{if $i % 2}greenDark{else}greenLight{/if}"></td>
</tr>

<tr><td colspan="2" class="{if $i % 2}greenDark{else}greenLight{/if}">&nbsp;</td></tr>

<tr>
<td align="right" class="{if $i % 2}greenDark{else}greenLight{/if}"><label>{'Short comment'|gettext|strip:'&nbsp;'}</label></td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}"><input type="text" name="ShortCommentList[]" size="60" maxlength="80" value="{$data.ShortCommentList[$i]}" class="{if $i % 2}greenDark{else}greenLight{/if}"></td>
</tr>

</table>
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{/foreach}


{if $checkresults.academic eq 'pass' or $data.AcademicLevelList|@count < 1 }

<tr valign="top">
<td></td>

<td colspan="3">
<table>

<tr>
<td align="right"><label for="DegreeList">{'Degree'|gettext|strip:'&nbsp;'}</label></td>
<td><input type="text" name="DegreeList[]" id="DegreeList" size="60" maxlength="80" class="notRequired"></td>
</tr>

<tr>
<td align="right"><label for="AcademicLevelList">{'Academic level'|gettext|strip:'&nbsp;'}</label></td>
<td>
<select name="AcademicLevelList[]" id="AcademicLevelList" class="notRequired">
{html_options values=$academicLevelsId output=$academicLevelsIdTranslated}
</select>
</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
<td align="right"><label for="DegreeGrantedList">{'Degree granted'|gettext|strip:'&nbsp;'}</label></td>
<td>
<select name="DegreeGrantedList[]" id="DegreeGrantedList" class="notRequired">
<option label="" value=""></option>
<option label="{t}No{/t}" value="No">{t}No{/t}</option>
<option label="{t}Yes{/t}" value="Yes">{t}Yes{/t}</option>
</select>
</td>
</tr>

<tr>
<td align="right"><label for="StartDateList" class="raisePopUp" title="{t}The format could be for example{/t}: yyyy-mm-dd , mm/dd/yyyy">{'Start date'|gettext|strip:'&nbsp;'}</label></td>
<td><input type="text" name="StartDateList[]" id="StartDateList" size="11" maxlength="10" value="" class="notRequired"></td>
</tr>

<tr>
<td align="right"><label for="FinishDateList" class="raisePopUp" title="{t}The format could be for example{/t}: yyyy-mm-dd , mm/dd/yyyy">{'Finish date'|gettext|strip:'&nbsp;'}</label></td>
<td><input type="text" name="FinishDateList[]" id="FinishDateList" size="11" maxlength="10" value="" class="notRequired"></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
<td align="right"><label for="InstitutionList" class="raisePopUp" title="{t}University or education institution{/t}">{'Institution'|gettext|strip:'&nbsp;'}</label></td>
<td><input type="text" name="InstitutionList[]" id="InstitutionList" size="60" maxlength="80" value="" class="notRequired"></td>
</tr>

<tr>
<td align="right"><label for="InstitutionURIList">{'Institution\'s URI'|gettext|strip:'&nbsp;'}</label></td>
<td><input type="text" name="InstitutionURIList[]" id="InstitutionURIList" size="60" maxlength="255" value="" class="notRequired"></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
<td align="right"><label for="ShortCommentList">{'Short comment'|gettext|strip:'&nbsp;'}</label></td>
<td><input type="text" name="ShortCommentList[]" id="ShortCommentList" size="60" maxlength="80" value="" class="notRequired"></td>
</tr>

</table>
</td>
</tr>

{/if}


<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="5" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="{t}Save and or delete and stay here to add more{/t}">
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

<input type="hidden" name="jump2previous" value="profiles_etc">
<input type="hidden" name="jump2next" value="skills">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>
