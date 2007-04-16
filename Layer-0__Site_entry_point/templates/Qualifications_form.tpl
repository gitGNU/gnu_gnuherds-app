{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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

<script type="text/javascript" src="scripts/qualifications.js"></script>
<script type="text/javascript" src="scripts/qualifications_Skills.js"></script>
<script type="text/javascript" src="scripts/qualifications_Languages.js"></script>
<script type="text/javascript" src="scripts/qualifications_Contributions.js"></script>
<script type="text/javascript" src="scripts/popup.js"></script>


<form name="qualificationsForm" method="post" action="Qualifications.php">

<table align="center">

{if $smarty.session.HasQualifications != '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW QUALIFICATIONS{/t}</td> </tr>
{/if}

{if $smarty.session.HasQualifications == '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE QUALIFICATIONS DATA{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="4" class="footnote">{t}To demand any form reorganization: the addition to the lists, update, deletion of a profile, skill, etc., you can send an email to{/t} {mailto address='form-options@gnuherds.org'}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="ProfessionalExperienceSinceYear">{'Professional experience since'|gettext|strip:'&nbsp;'}&nbsp;: </label></td>
<td colspan="3">
{if $smarty.session.ProfessionalExperienceSinceYear eq ''}
	{assign var=ProfessionalExperienceSinceYear value='--'}
{else}
	{assign var=ProfessionalExperienceSinceYear value="01-01-`$smarty.session.ProfessionalExperienceSinceYear`"}
{/if}
{html_select_date prefix="ProfessionalExperienceSince" time="$ProfessionalExperienceSinceYear" start_year="-82" end_year="+0" display_days=false display_months=false year_empty="" year_extra="id=ProfessionalExperienceSinceYear class=required"}
</td>
</tr>

{if $smarty.session.LoginType eq 'Person' }
<tr valign="top">
<td align="right"><label for="AcademicQualification">{t}Academic qualification{/t} : </label></td>
<td colspan="3">
<select name="AcademicQualification" id="AcademicQualification" class="notRequired">
{html_options values=$academicQualificationsId output=$academicQualificationsIdTranslated selected=$smarty.session.AcademicQualification}
</select> <br>
<label for="AcademicQualificationDescription">{t}Description{/t}: </label><input type="text" name="AcademicQualificationDescription" id="AcademicQualificationDescription" size="35" maxlength="80" value="{$smarty.session.AcademicQualificationDescription}" class="notRequired">
</td>
</tr>
{/if}

<tr valign="top">
<td align="right"><label class="raisePopUp" OnMouseOver="popup('{t}Press Ctrl key to choose more than one Profile{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Profiles{/t} : </label></td>

<td><label for="ProductProfileList">{t}Product profiles{/t}</label><br>
<select name="ProductProfileList[]" id="ProductProfileList" size="{$productProfiles|@count}" multiple="multiple" class="notRequired">
{html_options values=$productProfiles output=$productProfiles selected=$smarty.session.ProductProfileList}
</select>
</td>

<td><label for="ProfessionalProfileList">{t}Professional profiles{/t}</label><br>
<select name="ProfessionalProfileList[]" id="ProfessionalProfileList" size="{$professionalProfilesId|@count}" multiple="multiple" class="notRequired">
{html_options values=$professionalProfilesId output=$professionalProfilesName selected=$smarty.session.ProfessionalProfileList}
</select>
</td>

<td><label for="FieldProfileList" >{t}Field profiles{/t}</label><br>
<select name="FieldProfileList[]" id="FieldProfileList" size="{$fieldProfilesId|@count}" multiple="multiple" class="notRequired">
{html_options values=$fieldProfilesId output=$fieldProfilesName selected=$smarty.session.FieldProfileList}
</select>
</td>

</tr>

<tr valign="top">
<td align="right"><label class="raisePopUp" OnMouseOver="popup('{t escape='no'
  1='<br> <br>'
  2='<strong>'
  3='</strong>'
}Choose any skill in one of the combo-boxes and then select the knowledge and experience levels.%1 The skill and levels will arise in the right box. Repeat this operation with each skill you know.%1 If you want to delete some entry, select it in the right box and click %2Delete%3.{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Skills{/t} : </label></td>
<td colspan="3">

<table cellpadding="0" cellspacing="0" width="100%">
{foreach from=$skillsBySets item=skillIds key=skillSetTypeId}
<tr>
<td>
<label for="Skill_{$skillSetTypeId|strip:'_'}">{$skillSetTypeId|gettext|strip:'&nbsp;'}:&nbsp;</label>
</td>
<td>
<select name="Skill_{$skillSetTypeId|strip:'_'}" id="Skill_{$skillSetTypeId|strip:'_'}" class="notRequired" onChange="{foreach from=$skillsBySets item=s key=setId}{if $setId neq $skillSetTypeId} document.qualificationsForm.Skill_{$setId|strip:'_'}.value=''; {/if}{/foreach} document.qualificationsForm.Skill.value = document.qualificationsForm.Skill_{$skillSetTypeId|strip:'_'}.value; ResetSkillLevels();"> <!-- We raise it here due it is not automatically raised with the previous line ^ -->
{html_options values=$skillIds output=$skillIds selected=$smarty.session.SkillList[0]}
</select><br>
</td>
<td width="100%">
</td>
</tr>
{/foreach}
</table>

<div id="Skill_not_visible" style="display:none">
<select name="Skill" class="notRequired"> <!-- Note: The non-direct value change does not raise this event: onChange="ResetSkillLevels();"> It have to be set as selected too to raise the event. -->
{html_options values=$skills output=$skills}
</select><br>
</div>

</td>
</tr>

<tr valign="bottom">
<td align="right"></td>
<td colspan="3">

<table cellpadding="0" cellspacing="0" width="100%">
<tr valign="bottom">
<td>
</td>

<td>
<br>
<label for="skillKnowledgeLevel">{t}Knowledge level{/t}:</label>
<select name="skillKnowledgeLevel" id="skillKnowledgeLevel" class="notRequired" disabled onChange="UpdateSkill();">
{html_options values=$skillKnowledgeLevelsId output=$skillKnowledgeLevelsName}
</select><br>

<label for="skillExperienceLevel">{t}Experience level{/t}:</label>
<select name="skillExperienceLevel" id="skillExperienceLevel" class="notRequired" disabled onChange="UpdateSkill();">
{html_options values=$skillExperienceLevelsId output=$skillExperienceLevelsName}
</select> <br>
<br>
</td>

<td align="center">

<select name="ViewSkillList[]" id="ViewSkillList" size="3" multiple="multiple" class="notRequired" OnClick="document.qualificationsForm.skillKnowledgeLevel.focus(); document.qualificationsForm.ViewSkillList.focus(); {foreach from=$skillsBySets item=s key=setId} document.qualificationsForm.Skill_{$setId|strip:'_'}.value=''; {/foreach} {foreach from=$skillsBySets item=s key=setId} document.qualificationsForm.Skill_{$setId|strip:'_'}.value=document.qualificationsForm.SkillList[document.qualificationsForm.ViewSkillList.selectedIndex].value; {/foreach}  UpdateWithSelectedSkill(true);">
</select><br>
<a href="javascript://" OnClick="DeleteSkill(document.qualificationsForm.ViewSkillList.selectedIndex);"><strong>{t}Delete{/t}</strong></a>

<div id="SkillLists" style="display:none">
<select name="SkillList[]" id="SkillList" size="4" multiple="multiple">
{html_options values=$smarty.session.SkillList output=$smarty.session.SkillList}
</select><br>
<select name="SkillKnowledgeLevelList[]" id="SkillKnowledgeLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.SkillKnowledgeLevelList output=$smarty.session.SkillKnowledgeLevelList}
</select><br>
<select name="SkillExperienceLevelList[]" id="SkillExperienceLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.SkillExperienceLevelList output=$smarty.session.SkillExperienceLevelList}
</select><br>
</div>

</td>

</tr>
</table>

</td>
</tr>

<tr valign="top">
<td align="right"><span class="must">*</span><label for="Language" class="raisePopUp" OnMouseOver="popup('{t escape='no'
  1='<br> <br>'
  2='<strong>'
  3='</strong>'
}Choose any idiom in the first combo-box and then select the spoken and written levels.%1 The idiom and levels will arise in the right box. Repeat this operation with each idiom you know.%1 If you want to delete some entry, select it in the right box and click %2Delete%3.{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Languages{/t} : </label></td>
<td colspan="3">
<table cellpadding="0" cellspacing="0" width="100%">
<tr valign="top">
<td>

<select name="Language" id="Language" class="required" onChange="ResetLevels();">
{html_options values=$languagesName output=$languagesNameTranslated}
</select><br>

<label for="languageSpokenLevel">{t}Spoken level{/t}:</label>
<select name="languageSpokenLevel" id="languageSpokenLevel" class="required" disabled onChange="UpdateIdiom();">
{html_options values=$languagesSpokenLevelsId output=$languagesSpokenLevelsName}
</select><br>

<label for="languageWrittenLevel">{t}Written level{/t}:</label>
<select name="languageWrittenLevel" id="languageWrittenLevel" class="required" disabled onChange="UpdateIdiom();">
{html_options values=$languagesWrittenLevelsId output=$languagesWrittenLevelsName}
</select>

</td>

<td align="center">
<select name="ViewLanguageList[]" id="ViewLanguageList" size="4" multiple="multiple" class="required" OnClick="UpdateWithSelectedItem(true);">
</select><br>
<a href="javascript://" OnClick="DeleteItem(document.qualificationsForm.ViewLanguageList.selectedIndex);"><strong>{t}Delete{/t}</strong></a>

<div id="LanguageLists" style="display:none">
<select name="LanguageList[]" id="LanguageList" size="4" multiple="multiple">
{html_options values=$smarty.session.LanguageList output=$smarty.session.LanguageList}
</select><br>
<select name="LanguageSpokenLevelList[]" id="LanguageSpokenLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.LanguageSpokenLevelList output=$smarty.session.LanguageSpokenLevelList}
</select><br>
<select name="LanguageWrittenLevelList[]" id="LanguageWrittenLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.LanguageWrittenLevelList output=$smarty.session.LanguageWrittenLevelList}
</select><br>
</div>

</td>

</tr>
</table>
</td>
</tr>

{if $smarty.session.CertificationsList|@count >= 1 or $notYetRequestedCertifications|@count >= 1}
<tr valign="top">
<td align="right"><label for="NotYetRequestedCertificationsList" class="raisePopUp" OnMouseOver="popup('{t}Request your certifications{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Certifications{/t} : </label><br> </td>
<td colspan="3">

<table cellspacing="0" cellpadding="0">

{foreach from=$smarty.session.CertificationsList item=certification key=i}
<tr>
	<td> <input type="checkbox" name="CertificationsList[]" id="CertificationsList" value="{$certification}" class="notRequired" disabled checked>{$certification} &nbsp; <span class="footnote">(state: {$smarty.session.CertificationsStateList[$i]})</span> </td>
</tr>
{/foreach}

{foreach from=$notYetRequestedCertifications item=certification}
<tr>
{if is_array($smarty.session.NotYetRequestedCertificationsList) and in_array($certification, $smarty.session.NotYetRequestedCertificationsList) }
	<td> <input type="checkbox" name="NotYetRequestedCertificationsList[]" id="NotYetRequestedCertificationsList" value="{$certification}" class="notRequired" checked>{$certification} </td>
{else}
	<td> <input type="checkbox" name="NotYetRequestedCertificationsList[]" id="NotYetRequestedCertificationsList" value="{$certification}" class="notRequired">{$certification} </td>
{/if}
</tr>
{/foreach}

</table>

</td>
</tr>
{/if}

<tr valign="top">
<td align="right"><label class="raisePopUp" OnMouseOver="popup('{t}URIs which prove your contritution to FS projects. For example: CVS web reference, email with patch or advices, etc.{/t}','lightyellow',300);" OnMouseOut="kill()">{'Contributions to FS projects'|gettext|strip:'&nbsp;'}&nbsp;: </label><br> </td>
<td colspan="3"> 

<table cellpadding="0" cellspacing="0">
<tr valign="middle">
<td width="63%">
<label for="ContributionProject">{t}Project{/t}: </label><input type="text" name="ContributionProject" id="ContributionProject" maxlength="20" value="" class="notRequired"><br>
<label for="ContributionDescription">{t}Description{/t}: </label><input type="text" name="ContributionDescription" id="ContributionDescription" maxlength="30" value="" class="notRequired"><br>
<label for="ContributionURI">URI: </label><input type="text" name="ContributionURI" id="ContributionURI" maxlength="255" value="http://" class="notRequired"><br>
<input type="hidden" name="ContributionErrorMessage" value="{t}The Project and URI fields are required. Please, try again.{/t}">
</td>
<td width="90%" align="center">
<a href="javascript://" OnClick="AddContributionItem();"><strong>=== {t}Add{/t} ===&gt;</strong></a>
</td>
<td width="0%" align="center">
<select name="VisibleContributionsList[]" id="VisibleContributionsList" size="4" multiple="multiple" class="notRequired"> <!-- The list of options is loaded via JavaScript. See the InitializationOnLoad() JavaScript funtion. -->
</select><br>
<a href="javascript://" OnClick="DeleteContributionItem(document.qualificationsForm.VisibleContributionsList.selectedIndex);"><strong>{t}Delete{/t}</strong></a>

<div id="ContributionLists" style="display:none">
<select name="ContributionsListProject[]" id="ContributionsListProject" size="4" multiple="multiple">
{html_options values=$smarty.session.ContributionsListProject output=$smarty.session.ContributionsListProject}
</select><br>
<select name="ContributionsListDescription[]" id="ContributionsListDescription" size="4" multiple="multiple">
{html_options values=$smarty.session.ContributionsListDescription output=$smarty.session.ContributionsListDescription}
</select><br>
<select name="ContributionsListURI[]" id="ContributionsListURI" size="4" multiple="multiple">
{html_options values=$smarty.session.ContributionsListURI output=$smarty.session.ContributionsListURI}
</select><br>
</div>

</td>
</tr>
</table>

</td>

</tr>

{if $smarty.session.LoginType eq 'Person' }

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">{t}CONTRACT{/t}</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="DesiredContractType">{t}Desired contract type{/t} : </label></td>
<td colspan="3">
<select name="DesiredContractType" id="DesiredContractType" class="required">
{html_options values=$contractTypesId output=$contractTypesIdTranslated selected=$smarty.session.DesiredContractType}
</select>
</td>
</tr>

<tr valign="top">
<td align="right"><span class="must">*</span><label for="DesiredWageRank" class="raisePopUp" OnMouseOver="popup('{t}The format has to be: Minimum-Optimum. For example:{/t} 18000-30000','lightyellow',300);" OnMouseOut="kill()">{t}Desired wage rank{/t} : </label></td>
<td colspan="3">
<input type="text" name="DesiredWageRank" id="DesiredWageRank" size="15" maxlength="30" class="required" value="{$smarty.session.DesiredWageRank}">
<select name="WageRankCurrency" class="required">
{html_options values=$currenciesThreeLetter output=$currenciesName selected=$smarty.session.WageRankCurrency}
</select>
<select name="WageRankByPeriod" class="required">
{html_options values=$byPeriodId output=$byPeriodName selected=$smarty.session.WageRankByPeriod}
</select>
</td>
</tr>

<tr>
<td align="right"><span class="must">*</span><label for="CurrentEmployability">{t}Currently you are{/t} : </label></td>
<td colspan="3">
<select name="CurrentEmployability" id="CurrentEmployability" class="required">
{html_options values=$employabilityId output=$employabilityIdTranslated selected=$smarty.session.CurrentEmployability}
</select>
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">{t}LOCATION{/t}</td> </tr>

<tr valign="bottom">
<td align="right"><label for="AvailableToTravel">{t}Available to travel{/t} : </label></td>
<td colspan="3"> <input type="checkbox" name="AvailableToTravel" id="AvailableToTravel" class="notRequired" {if $smarty.session.AvailableToTravel eq 'true'} checked {/if} > </td>
</tr>

<tr valign="bottom">
<td align="right"><label for="AvailableToChangeResidence">{'Available to change residence'|gettext|strip:'&nbsp;'}&nbsp;: </label></td>
<td colspan="3"> <input type="checkbox" name="AvailableToChangeResidence" id="AvailableToChangeResidence" class="notRequired" {if $smarty.session.AvailableToChangeResidence eq 'true'} checked {/if} > </td>
</tr>

{/if}

<tr> <td colspan="4">&nbsp;</td> </tr> 
<tr> <td colspan="4">&nbsp;</td> </tr> 

{literal}
<!--
	For all of you having problems when using php arrays in an HTML form input field name, and
	wanting to validate the form using javascript for example, it is much easier to specify
	an id for the field as well, and use this id for validation.

	Example:
		<input type="text" id="lastname" name="fields[lastname]">

	then in the javascript check:

	if(formname.lastname.value == "") {
		alert("please enter a lastname!");
	}

	This works very well. If you have any problems with it, let me know.

Reference: http://es.php.net/types.array
-->
{/literal}

<tr align="center">
<td colspan="4" align="center">
<input type="submit" name="save" value="{t}Save{/t}" OnClick="SelectAllItems();">

{if $smarty.session.HasQualifications == '1'} <!-- update -->
<br><br>
<input type="submit" name="delete" value="{t}Delete qualifications{/t}">
{/if}

</td>
</tr>

{if $smarty.session.HasQualifications == '1'} <!-- update -->
<tr align="center">
<td colspan="4" align="center">
<br>
<a href="/View_Qualifications.php?EntityId={$smarty.session.EntityId}">{t}Check qualifications view{/t}</a>
</td>
</tr>
{/if}

</table>

</form>

