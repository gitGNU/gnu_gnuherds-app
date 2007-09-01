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

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match. Please try again.{/t}</span></span></td> </tr>
{/if}

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

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

{if $smarty.session.LoginType eq 'Person' }
<tr valign="top">
<td align="right"><label for="AcademicQualification">{t}Academic qualification{/t}</label></td>
<td colspan="3">
<select name="AcademicQualification" id="AcademicQualification" class="notRequired">
{html_options values=$academicQualificationsId output=$academicQualificationsIdTranslated selected=$data.AcademicQualification}
</select> <br>
<label for="AcademicQualificationDescription">{t}Description{/t} </label><input type="text" name="AcademicQualificationDescription" id="AcademicQualificationDescription" size="35" maxlength="80" value="{$data.AcademicQualificationDescription}" class="notRequired">
</td>
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

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section" disabled>
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2next" value="skills">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>
