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

<form name="dataForm" method="post" action="offers?action=edit&id={$smarty.get.JobOfferId}">

<table align="center">

{if $smarty.get.JobOfferId }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE JOB OFFER{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW JOB OFFER{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4">
{include file="Job_Offer_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match. Please try again.{/t}</span></span></td> </tr>
{/if}

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="right">

<table>
<tr>
<td>
{if $data.LanguageList|@count >= 1}
<label for="DeleteLanguageList">{'Mark to delete'|gettext|strip:'&nbsp;'}</label>
{/if}
</td>
<td><span class="must">*</span><label for="LanguageList" class="raisePopUp" title="{t}Add idioms and theirs spoken and written levels{/t}">{t}Required languages{/t}</label></td>
<td>
<span class="must">*</span><label for="LanguageSpokenLevelList">{t}Spoken level{/t}</label>
</td>
<td>
<span class="must">*</span><label for="LanguageWrittenLevelList">{t}Written level{/t}</label>
</td>
</tr>


{foreach from=$data.LanguageList item=Language key=i}

<tr valign="top">
<td align="right">
{if $data.LanguageList|@count >= 1}
<input type="checkbox" name="DeleteLanguageList[]" id="DeleteLanguageList" value="{$i}">
{/if}
</td>

<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<select name="LanguageList[]" id="LanguageList" class="{if $i % 2}greenDark{else}greenLight{/if}">
{html_options values=$languagesName output=$languagesNameTranslated selected=$data.LanguageList[$i]}
</select>
{if $checks.LanguageList[$i] neq '' }
<br>
<span class="must">{$checks.LanguageList[$i]}</span>
{/if}
</td>

<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<select name="LanguageSpokenLevelList[]" id="LanguageSpokenLevelList" class="{if $i % 2}greenDark{else}greenLight{/if}">
{html_options values=$languagesSpokenLevelsId output=$languagesSpokenLevelsName selected=$data.LanguageSpokenLevelList[$i]}
</select>
{if $checks.LanguageSpokenLevelList[$i] neq '' }
<br>
<span class="must">{$checks.LanguageSpokenLevelList[$i]}</span>
{/if}
</td>

<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<select name="LanguageWrittenLevelList[]" id="LanguageWrittenLevelList" class="{if $i % 2}greenDark{else}greenLight{/if}">
{html_options values=$languagesWrittenLevelsId output=$languagesWrittenLevelsName selected=$data.LanguageWrittenLevelList[$i]}
</select>
{if $checks.LanguageWrittenLevelList[$i] neq '' }
<br>
<span class="must">{$checks.LanguageWrittenLevelList[$i]}</span>
{/if}
</td>
</tr>

{/foreach}


{if $checkresults.languages eq 'pass' or $data.LanguageList|@count < 1 }

<tr valign="top">
<td>
</td>

<td>
<select name="LanguageList[]" id="LanguageList" class="{if $data.LanguageList|@count == 0}required{else}notRequired{/if}">
{html_options values=$languagesName output=$languagesNameTranslated}
</select>
</td>

<td>
<select name="LanguageSpokenLevelList[]" id="LanguageSpokenLevelList" class="{if $data.LanguageList|@count == 0}required{else}notRequired{/if}">
{html_options values=$languagesSpokenLevelsId output=$languagesSpokenLevelsName}
</select>
</td>

<td>
<select name="LanguageWrittenLevelList[]" id="LanguageWrittenLevelList" class="{if $data.LanguageList|@count == 0}required{else}notRequired{/if}">
{html_options values=$languagesWrittenLevelsId output=$languagesWrittenLevelsName}
</select>
</td>
</tr>

{/if}


<tr>
<td colspan="4" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="Save and or delete and stay here to add more languages">
</td>
</tr>
</table>

</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.JobOfferId neq ''}
<a href="offers?id={$smarty.session.JobOfferId}">{t}Check offer view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section">
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="skills">
{* The certifications feature is disabled
<input type="hidden" name="jump2next" value="certifications"> *}
<input type="hidden" name="jump2next" value="projects">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.general neq 'pass' or $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or $checkresults.contract neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

