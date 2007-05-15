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

<script type="text/javascript" src="scripts/job_offer.js"></script>
<script type="text/javascript" src="scripts/job_offer_Skills.js"></script>
<script type="text/javascript" src="scripts/job_offer_Languages.js"></script>
<script type="text/javascript" src="scripts/job_offer_Address.js"></script>
<script type="text/javascript" src="scripts/job_offer_VacancyTitle.js"></script>
<script type="text/javascript" src="scripts/job_offer_evalDisplay.js"></script>
<script type="text/javascript" src="scripts/popup.js"></script>
<script type="text/javascript" src="scripts/utils.js"></script>


<form name="jobOfferForm" method="post" action="offers?action=edit&id={$smarty.get.JobOfferId}">

<table align="center">

{if $smarty.get.JobOfferId }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE JOB OFFER{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW JOB OFFER{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match. Please try again.{/t}</span></span></td> </tr>
{/if}

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

{if $checks.result neq 'fail' }
<tr> <td colspan="4" class="footnote">{t}To demand any form reorganization: the addition to the lists, update, deletion of a profile, skill, etc., you can send an email to{/t} {mailto address='form-options@gnuherds.org'}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}GENERAL{/t}</td> </tr>

<tr valign="top">
<td align="right">{t}Vacancy title{/t}</td>
<td colspan="3"> <input type="text" name="VacancyTitle" id="VacancyTitle" size="65" maxlength="100" value="{t}Filled automatically{/t}" disabled> </td>
<input type="hidden" name="VacancyTitleWarningMessage" value="{t}Empty professional profile{/t}">
</tr>

<tr valign="top">
<td align="right"><label for="EmployerJobOfferReference">{t}Your offer reference{/t}</label></td>
<td colspan="3"> <input type="text" name="EmployerJobOfferReference" id="EmployerJobOfferReference" class="notRequired" value="{$smarty.session.jEmployerJobOfferReference}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="ExpirationDate" class="raisePopUp" OnMouseOver="popup('{t}The format could be for example{/t} \'dd/mm/yyyy\'.','lightyellow',300);" OnMouseOut="kill()">{t}Expiration date{/t}</label></td> <!-- XXX: It should be checked that the format is one of the accepted formats by de Data Base. 2007-12-12 seems to be accepted too. -->
<td colspan="3"> <input type="text" name="ExpirationDate" id="ExpirationDate" class="required" value="{$smarty.session.jExpirationDate}"> </td>
</tr>

{if $checks.jExpirationDate neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.jExpirationDate}</p></td>
</tr>
{/if}

<tr valign="top">
<td align="right"><label for="Closed">{t}The offer is closed{/t}</label></td>
<td colspan="3"> <input type="checkbox" name="Closed" id="Closed" {if $smarty.session.jClosed eq 'true'} checked {/if} > </td>
</tr>

{* This is commented due to, although it is already developed, hiding the job offer employer is not good practice.
<tr valign="top">
<td align="right"><label for="HideEmployer">{t}Hide employer{/t}</label></td>
<td colspan="3"> <input type="checkbox" name="HideEmployer" id="HideEmployer" {if $smarty.session.jHideEmployer eq 'true'} checked {/if} > </td>
</tr>
*}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"><span class="must">*</span>{t}Allow applications from{/t}</td>
<td colspan="3"> <input type="checkbox" name="AllowPersonApplications" id="AllowPersonApplications" class="required" {if $smarty.session.jAllowPersonApplications eq 'true'} checked {/if} onChange="evalAcademicQualificationDisplay();"><label for="AllowPersonApplications">{t}Persons{/t}</label></td>
</tr>
<tr valign="top">
<td></td>
<td colspan="3"> <input type="checkbox" name="AllowCompanyApplications" id="AllowCompanyApplications" class="required" {if $smarty.session.jAllowCompanyApplications eq 'true'} checked {/if} onChange="evalAcademicQualificationDisplay();"><label for="AllowCompanyApplications">{t}Companies{/t}</label></td>
</tr>
<tr valign="top">
<td></td>
<td colspan="3"> <input type="checkbox" name="AllowOrganizationApplications" id="AllowOrganizationApplications" class="required" {if $smarty.session.jAllowOrganizationApplications eq 'true'} checked {/if} onChange="evalAcademicQualificationDisplay();"><label for="AllowOrganizationApplications">{t}non-profit Organizations{/t}</label></td>
</tr>

{if $checks.jAllowApplications neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.jAllowApplications}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="Vacancies">{t}Vacancies{/t}</label></td>
<td colspan="3"> <input type="text" name="Vacancies" id="Vacancies" size="3" maxlength="3" class="required" value="{$smarty.session.jVacancies}"> </td>
</tr>

{if $checks.jVacancies neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.jVacancies}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">{t}CONTRACT{/t}</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="ContractType">{t}Contract type{/t}</label></td>
<td colspan="3">
<select name="ContractType" id="ContractType" class="required">
{html_options values=$contractTypesId output=$contractTypesIdTranslated selected=$smarty.session.jContractType}
</select>
</td>
</tr>

{if $checks.jContractType neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.jContractType}</p></td>
</tr>
{/if}

<tr valign="top">
<td align="right"><span class="must">*</span><label for="WageRank" class="raisePopUp" OnMouseOver="popup('{t}The format has to be:{/t} {t}Minimum{/t}-{t}Optimum{/t}. {t}For example:{/t} 18000-30000','lightyellow',300);" OnMouseOut="kill()">{t}Wage rank{/t}</label></td>
<td colspan="3">
<input type="text" name="WageRank" id="WageRank" size="15" maxlength="30" class="required" value="{$smarty.session.jWageRank}">
<select name="WageRankCurrency" id="WageRankCurrency" class="required">
{html_options values=$currenciesThreeLetter output=$currenciesName selected=$smarty.session.jWageRankCurrency}
</select>
<select name="WageRankByPeriod" id="WageRankByPeriod" class="required" onChange="evalEstimatedEffortDisplay();">
{html_options values=$byPeriodId output=$byPeriodName selected=$smarty.session.jWageRankByPeriod}
</select>
</td>
</tr>

{if $checks.jWageRank neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.jWageRank}</p></td>
</tr>
{/if}

<tr valign="top" id="EstimatedEffortDivision" style="display:none">
<td align="right"><span class="must">*</span><label for="EstimatedEffort" class="raisePopUp" OnMouseOver="popup('{t}For example:{/t} 48-56 {t}hours{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Estimated effort{/t}</label></td>
<td colspan="3">
<input type="text" name="EstimatedEffort" id="EstimatedEffort" size="15" maxlength="30" class="required" value="{$smarty.session.jEstimatedEffort}">
<select name="TimeUnit" id="TimeUnit" class="required">
{html_options values=$timeUnitsId output=$timeUnitsName selected=$smarty.session.jTimeUnit}
</select>
</td>
</tr>

{if $checks.jEstimatedEffort neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.jEstimatedEffort}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

<tr>
<td align="right"><label for="ProfessionalExperienceSinceYear">{'Professional experience since'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">
{if $smarty.session.jProfessionalExperienceSinceYear eq ''}
	{assign var=ProfessionalExperienceSinceYear value='--'}
{else}
	{assign var=ProfessionalExperienceSinceYear value="01-01-`$smarty.session.jProfessionalExperienceSinceYear`"}
{/if}
{html_select_date prefix="ProfessionalExperienceSince" time="$ProfessionalExperienceSinceYear" start_year="-33" end_year="+0" display_days=false display_months=false year_empty="" year_extra="id=ProfessionalExperienceSinceYear class=notRequired"}
</td>
</tr>

<tr id="AcademicQualificationDivision" style="display:none">
<td align="right"><label for="AcademicQualification">{t}Academic qualification{/t}</label></td>
<td colspan="3">
<select name="AcademicQualification" id="AcademicQualification" class="notRequired">
{html_options values=$academicQualificationsId output=$academicQualificationsIdTranslated selected=$smarty.session.jAcademicQualification}
</select>
</td>
</tr>

<tr valign="top">
<td align="right"><span class="must">*</span><label class="raisePopUp" OnMouseOver="popup('{t}Press Ctrl key to choose more than one Profile{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Profiles{/t}</label></td>

<td><label for="ProductProfileList">{t}Product profiles{/t}</label><br>
<select name="ProductProfileList[]" id="ProductProfileList" size="{$productProfiles|@count}" multiple="multiple" class="notRequired">
{html_options values=$productProfiles output=$productProfiles selected=$smarty.session.jProductProfileList}
</select>
</td>

<td><label for="ProfessionalProfileList">{t}Professional profiles{/t}</label><br>
{if $checks.jProfessionalProfileList neq '' }
<span class="must">{$checks.jProfessionalProfileList}</span>
<br>
{/if}

<select name="ProfessionalProfileList[]" id="ProfessionalProfileList" size="{$professionalProfilesId|@count}" multiple="multiple" class="required" onChange="UpdateVacancyTitle();">
{html_options values=$professionalProfilesId output=$professionalProfilesName selected=$smarty.session.jProfessionalProfileList}
</select>
</td>

<td><label for="FieldProfileList">{t}Field profiles{/t}</label><br>
<select name="FieldProfileList[]" id="FieldProfileList" size="{$fieldProfilesId|@count}" multiple="multiple" class="notRequired" onChange="UpdateVacancyTitle();">
{html_options values=$fieldProfilesId output=$fieldProfilesName selected=$smarty.session.jFieldProfileList}
</select>
</td>

</tr>

<tr valign="top">
<td align="right"><label class="raisePopUp" OnMouseOver="popup('{t escape='no'
  1='<br> <br>'
  2='<strong>'
  3='</strong>'
}Choose any skill in one of the combo-boxes and then select the knowledge and experience levels.%1 The skill and levels will arise in the right box. Repeat this operation with each skill you know.%1 If you want to delete some entry, select it in the right box and click %2Delete%3.{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Skills{/t}</label><br>(<a href="javascript:openPopUp('Skills','skills',670,780);">{t}guide{/t}</a>) &nbsp; </td>
<td colspan="3">

<table cellpadding="0" cellspacing="0" width="100%">
{foreach from=$skillsBySets item=skillIds key=skillSetTypeId}
<tr>
<td>
<label for="Skill_{$skillSetTypeId|strip:'_'}">{$skillSetTypeId|gettext|strip:'&nbsp;'}&nbsp;</label>
</td>
<td>
<select name="Skill_{$skillSetTypeId|strip:'_'}" id="Skill_{$skillSetTypeId|strip:'_'}" class="notRequired" onChange="{foreach from=$skillsBySets item=s key=setId}{if $setId neq $skillSetTypeId} document.jobOfferForm.Skill_{$setId|strip:'_'}.value=''; {/if}{/foreach} document.jobOfferForm.Skill.value = document.jobOfferForm.Skill_{$skillSetTypeId|strip:'_'}.value; ResetSkillLevels();"> <!-- We raise it here due it is not automatically raised with the previous line ^ -->
{html_options values=$skillIds output=$skillIds selected=$smarty.session.jSkillList[0]}
</select><br>
</td>
<td width="100%">
</td>
</tr>
{/foreach}
</table>

<div id="Skill_not_visible" style="display:none">
<!-- XXX <select name="Skill" class="notRequired" onChange="ResetSkillLevels();"> -->
<select name="Skill" class="notRequired"> <!-- XXX: The non-direct value change does not raise this event: onChange="ResetSkillLevels();"> -->
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
<label for="skillKnowledgeLevel">{t}Knowledge level{/t}</label>
<select name="skillKnowledgeLevel" id="skillKnowledgeLevel" class="notRequired" disabled onChange="UpdateSkill(); UpdateVacancyTitle();">
{html_options values=$skillKnowledgeLevelsId output=$skillKnowledgeLevelsName}
</select><br>

<label for="skillExperienceLevel">{t}Experience level{/t}</label>
<select name="skillExperienceLevel" id="skillExperienceLevel" class="notRequired" disabled onChange="UpdateSkill(); UpdateVacancyTitle();">
{html_options values=$skillExperienceLevelsId output=$skillExperienceLevelsName}
</select> <br>
<br>
</td>

<td align="center">

<select name="ViewSkillList[]" id="ViewSkillList" size="3" multiple="multiple" class="notRequired" OnClick="document.jobOfferForm.skillKnowledgeLevel.focus(); document.jobOfferForm.ViewSkillList.focus(); {foreach from=$skillsBySets item=s key=setId} document.jobOfferForm.Skill_{$setId|strip:'_'}.value=''; {/foreach} {foreach from=$skillsBySets item=s key=setId} document.jobOfferForm.Skill_{$setId|strip:'_'}.value=document.jobOfferForm.SkillList[document.jobOfferForm.ViewSkillList.selectedIndex].value; {/foreach}  UpdateWithSelectedSkill(true);">
</select><br>
<a href="javascript://" OnClick="DeleteSkill(document.jobOfferForm.ViewSkillList.selectedIndex); UpdateVacancyTitle();"><strong>{t}Delete{/t}</strong></a>

<div id="SkillLists" style="display:none">
<select name="SkillList[]" id="SkillList" size="4" multiple="multiple"> <!-- Note: Commented due to it only raise the event if the new Object is selected.  onChange="UpdateVacancyTitle();"> -->
{html_options values=$smarty.session.jSkillList output=$smarty.session.jSkillList}
</select><br>
<select name="SkillKnowledgeLevelList[]" id="SkillKnowledgeLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.jSkillKnowledgeLevelList output=$smarty.session.jSkillKnowledgeLevelList}
</select><br>
<select name="SkillExperienceLevelList[]" id="SkillExperienceLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.jSkillExperienceLevelList output=$smarty.session.jSkillExperienceLevelList}
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
}Choose any idiom in the first combo-box and then select the spoken and written levels.%1 The idiom and levels will arise in the right box. Repeat this operation with each idiom you know.%1 If you want to delete some entry, select it in the right box and click %2Delete%3.{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Required languages{/t}</label></td>
<td colspan="3">
<table cellpadding="0" cellspacing="0" width="100%">
<tr valign="top">
<td>

<select name="Language" id="Language" class="required" onChange="ResetLevels();">
{html_options values=$languagesName output=$languagesNameTranslated}
</select><br>

<label for="languageSpokenLevel">{t}Spoken level{/t}</label>
<select name="languageSpokenLevel" id="languageSpokenLevel" class="required" disabled onChange="UpdateIdiom(); UpdateVacancyTitle();">
{html_options values=$languagesSpokenLevelsId output=$languagesSpokenLevelsName}
</select><br>

<label for="languageWrittenLevel">{t}Written level{/t}</label>
<select name="languageWrittenLevel" id="languageWrittenLevel" class="required" disabled onChange="UpdateIdiom(); UpdateVacancyTitle();">
{html_options values=$languagesWrittenLevelsId output=$languagesWrittenLevelsName}
</select>

{if $checks.jLanguageList neq '' }
<br>
<span class="must">{$checks.jLanguageList}</span>
{/if}

</td>

<td align="center">
<select name="ViewLanguageList[]" id="ViewLanguageList" size="4" multiple="multiple" class="required" OnClick="UpdateWithSelectedItem(true);">
</select><br>
<a href="javascript://" OnClick="DeleteItem(document.jobOfferForm.ViewLanguageList.selectedIndex); UpdateVacancyTitle();"><strong>{t}Delete{/t}</strong></a>

<div id="LanguageLists" style="display:none">
<select name="LanguageList[]" id="LanguageList" size="4" multiple="multiple">
{html_options values=$smarty.session.jLanguageList output=$smarty.session.jLanguageList}
</select><br>
<select name="LanguageSpokenLevelList[]" id="LanguageSpokenLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.jLanguageSpokenLevelList output=$smarty.session.jLanguageSpokenLevelList}
</select><br>
<select name="LanguageWrittenLevelList[]" id="LanguageWrittenLevelList" size="4" multiple="multiple">
{html_options values=$smarty.session.jLanguageWrittenLevelList output=$smarty.session.jLanguageWrittenLevelList}
</select><br>
</div>

</td>

</tr>
</table>
</td>
</tr>

{if $certificationsList[0]|@count >= 1}
{if $smarty.session.jAllowPersonApplications eq 'true' or $smarty.session.jAllowCompanyApplications eq 'true' or $smarty.session.jAllowOrganizationApplications eq 'true'}

<tr valign="top">
<td align="right"><label for="CertificationsList">{t}Certifications{/t}</label><br> </td>
<td colspan="3">

<table cellspacing="0" cellpadding="0">
{foreach from=$certificationsList[0] item=certification key=i}
	{if  ( $smarty.session.jAllowPersonApplications eq 'true'       and $certificationsList[1][$i] eq 't' )
	  or ( $smarty.session.jAllowCompanyApplications eq 'true'      and $certificationsList[2][$i] eq 't' )
	  or ( $smarty.session.jAllowOrganizationApplications eq 'true' and $certificationsList[3][$i] eq 't' )
	}
		{if is_array($smarty.session.jCertificationsList) and in_array($certification, $smarty.session.jCertificationsList) }
			<tr> <td> <input type="checkbox" name="CertificationsList[]" id="CertificationsList" value="{$certification}" class="notRequired" checked>{$certification}</td> </tr>
		{else}
			<tr> <td> <input type="checkbox" name="CertificationsList[]" id="CertificationsList" value="{$certification}" class="notRequired">{$certification}</td> </tr>
		{/if}
	{/if}
{/foreach}
</table>

</td>
</tr>

{/if}
{/if}

<tr valign="top">
<td align="right"><label for="FreeSoftwareExperiences">{'Experience with FS projects'|gettext|strip:'&nbsp;'}</label><br> </td>
<td colspan="3"> <input type="text" name="FreeSoftwareExperiences" id="FreeSoftwareExperiences" size="66" maxlength="60" class="notRequired" value="{$smarty.session.jFreeSoftwareExperiences}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">{t}RESIDENCE LOCATION{/t}</td> </tr>

<tr valign="top">
<td align="right"><span class="must">*</span><label for="Telework">{t}Telework{/t}</label></td>
<td colspan="3"> <input type="checkbox" name="Telework" id="Telework" class="required" {if $smarty.session.jTelework eq 'true'} checked {/if}  onChange="ViewAddress();"> </td>
</tr>

<tr>
<td align="right"><label for="City">{t}City{/t}</label></td>
<td colspan="3"> <input type="text" name="City" id="City" size="30" maxlength="30" value="{$smarty.session.jCity}" class="notRequired" {if $smarty.session.jTelework eq 'true'} disabled {/if} > </td>
</tr>
<tr>
<td align="right"><label for="StateProvince">{t}State / Province{/t}</label></td>
<td colspan="3"> <input type="text" name="StateProvince" id="StateProvince" size="30" maxlength="30" value="{$smarty.session.jStateProvince}" class="notRequired" {if $smarty.session.jTelework eq 'true'} disabled {/if} > </td>
</tr>
<tr>
<td align="right"><span class="must">*</span><label for="CountryCode">{t}Country{/t}</label></td>
<td colspan="3">
<select name="CountryCode" id="CountryCode" class="required" {if $smarty.session.jTelework eq 'true'} disabled {/if} >
{html_options values=$countryTwoLetter output=$countryNames selected=$smarty.session.jCountryCode}
</select>
</td>
</tr>

{if $checks.jLocation neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.jLocation}</p></td>
</tr>
{/if}

<tr valign="top">
<td align="right"><label for="AvailableToTravel">{t}Available to travel{/t}</label></td>
<td colspan="3"> <input type="checkbox" name="AvailableToTravel" id="AvailableToTravel" class="notRequired" {if $smarty.session.jAvailableToTravel eq 'true'} checked {/if} > </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 
<tr> <td colspan="4">&nbsp;</td> </tr> 
<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr align="center">
<td colspan="4" align="center">
<input type="submit" name="save" value="{t}Save{/t}" OnClick="SelectAllItems();">
</td>
</tr>

{if $smarty.get.JobOfferId } <!-- update -->
<tr align="center">
<td colspan="4" align="center">
<br>
<a href="offers?id={$smarty.get.JobOfferId}">{t}Check job offer view{/t}</a>
</td>
</tr>
{/if}

</table>

</form>

