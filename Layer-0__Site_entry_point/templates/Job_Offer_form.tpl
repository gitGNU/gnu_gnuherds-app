{*
Authors: Davi Leal

Copyright (C) 2006 Davi Leal <davi at leals dot com>

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

{literal}
<style type="text/css">
    #pup { position:absolute; visibility:hidden; z-index:200; width:130; }
</style>

<script type="text/javascript" src="scripts/job_offer.js"></script>
<script type="text/javascript" src="scripts/job_offer_Skills.js"></script>
<script type="text/javascript" src="scripts/job_offer_Languages.js"></script>
<script type="text/javascript" src="scripts/job_offer_Address.js"></script>
<script type="text/javascript" src="scripts/job_offer_VacancyTitle.js"></script>
<script type="text/javascript" src="scripts/popup.js"></script>
{/literal}


<table align="center">

{if $smarty.post.JobOfferId }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE JOB OFFER{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW JOB OFFER{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="4" class="footnote">{t}To demand any form reorganization: the addition to the lists, update, deletion of a profile, skill, etc., you can send an email to{/t} {mailto address='form-options@gnuherds.org'}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<form name="jobOfferForm" method="post" action="Job_Offer.php">
<input type="hidden" name="JobOfferId" value="{$smarty.post.JobOfferId}">

<tr> <td colspan="4" class="subsection">{t}GENERAL{/t}</td> </tr>

<tr valign="top">
<td align="right">{t}Vacancy title{/t} : </td>
<td colspan="3"> <input type="text" name="VacancyTitle" size="65" maxlength="100" value="{t}Filled automatically{/t}" disabled> </td>
</tr>

<tr valign="top">
<td align="right">{t}Your offer reference{/t} : </td>
<td colspan="3"> <input type="text" name="EmployerJobOfferReference" class="notRequired" value="{$smarty.session.jEmployerJobOfferReference}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><a href="javascript://" OnMouseOver="popup('{t}The format could be for example{/t} \'dd/mm/yyyy\'.','lightyellow',300);" OnMouseOut="kill()">{t}Expiration date{/t}</a> : </td> <!-- XXX: It should be checked that the format is one of the accepted formats by de Data Base. 2007-12-12 seems to be accepted too. -->
<td colspan="3"> <input type="text" name="ExpirationDate" class="required" value="{$smarty.session.jExpirationDate}"> </td>
</tr>

<tr valign="top">
<td align="right">{t}The offer is closed{/t} : </td>
<td colspan="3"> <input type="checkbox" name="Closed" {if $smarty.session.jClosed eq 'true'} checked {/if} > </td>
</tr>

{* This is commented due to, although it is already developed, hiding the job offer employer is not good practice.
<tr valign="top">
<td align="right">{t}Hide employer{/t} : </td>
<td colspan="3"> <input type="checkbox" name="HideEmployer" {if $smarty.session.jHideEmployer eq 'true'} checked {/if} > </td>
</tr>
*}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"><span class="must">*</span>{t}Allow applications from{/t} : </td>
<td colspan="3"> <input type="checkbox" name="AllowPersonApplications" class="required" {if $smarty.session.jAllowPersonApplications eq 'true'} checked {/if} onChange="SelectAllItems(); jobOfferForm.submit();">{t}Persons{/t}</td>
</tr>
<tr valign="top">
<td></td>
<td colspan="3"> <input type="checkbox" name="AllowCompanyApplications" class="required" {if $smarty.session.jAllowCompanyApplications eq 'true'} checked {/if} onChange="SelectAllItems(); jobOfferForm.submit();">{t}Companies{/t}</td>
</tr>
<tr valign="top">
<td></td>
<td colspan="3"> <input type="checkbox" name="AllowOrganizationApplications" class="required" {if $smarty.session.jAllowOrganizationApplications eq 'true'} checked {/if} onChange="SelectAllItems(); jobOfferForm.submit();">{t}non-profit Organizations{/t}</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span>{t}Vacancies{/t} : </td>
<td colspan="3"> <input type="text" name="Vacancies" size="3" maxlength="3" class="required" value="{$smarty.session.jVacancies}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">{t}CONTRACT{/t}</td> </tr>

<tr>
<td align="right"><span class="must">*</span>{t}Contract type{/t} : </td>
<td colspan="3">
<select name="ContractType" class="required">
{html_options values=$contractTypesId output=$contractTypesIdTranslated selected=$smarty.session.jContractType}
</select>
</td>
</tr>

<tr valign="top">
<td align="right"><span class="must">*</span><a href="javascript://" OnMouseOver="popup('{t}The format has to be: Minimum-Optimum. For example:{/t} 18000-30000','lightyellow',300);" OnMouseOut="kill()">{t}Wage rank{/t}</a> : </td>
<td colspan="3">
<input type="text" name="WageRank" size="15" maxlength="30" class="required" value="{$smarty.session.jWageRank}">
<select name="WageRankCurrency" class="required">
{html_options values=$currenciesThreeLetter output=$currenciesName selected=$smarty.session.jWageRankCurrency}
</select>
<select name="WageRankByPeriod" class="required">
{html_options values=$byPeriodId output=$byPeriodName selected=$smarty.session.jWageRankByPeriod}
</select>
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

<tr>
<td align="right">{'Professional experience since'|gettext|strip:'&nbsp;'}&nbsp;: </td>
<td colspan="3">
{if $smarty.session.jProfessionalExperienceSinceYear eq ''}
	{assign var=ProfessionalExperienceSinceYear value='--'}
{else}
	{assign var=ProfessionalExperienceSinceYear value="01-01-`$smarty.session.jProfessionalExperienceSinceYear`"}
{/if}
{html_select_date prefix="ProfessionalExperienceSince" time="$ProfessionalExperienceSinceYear" start_year="-33" end_year="+0" display_days=false display_months=false year_empty="" year_extra="class=notRequired"}
</td>
</tr>

{if $smarty.session.jAllowPersonApplications eq 'true'}
<tr>
<td align="right">{t}Academic qualification{/t} : </td>
<td colspan="3">
<select name="AcademicQualification" class="notRequired">
{html_options values=$academicQualificationsId output=$academicQualificationsIdTranslated selected=$smarty.session.jAcademicQualification}
</select>
</td>
</tr>
{/if}

<tr valign="top">
<td align="right"><span class="must">*</span><a href="javascript://" OnMouseOver="popup('{t}Press Ctrl key to choose more than one Profile{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Profiles{/t}</a> : </td>

<td>{t}Product profiles{/t}<br>
<select name="ProductProfileList[]" size="{$productProfiles|@count}" multiple="true" class="notRequired">
{html_options values=$productProfiles output=$productProfiles selected=$smarty.session.jProductProfileList}
</select>
</td>

<td>{t}Professional profiles{/t}<br>
<select name="ProfessionalProfileList[]" id="ProfessionalProfileList" size="{$professionalProfilesId|@count}" multiple="true" class="required" onChange="UpdateVacancyTitle();">
{html_options values=$professionalProfilesId output=$professionalProfilesName selected=$smarty.session.jProfessionalProfileList}
</select>
</td>

<td>{t}Field profiles{/t}<br>
<select name="FieldProfileList[]" id="FieldProfileList" size="{$fieldProfilesId|@count}" multiple="true" class="notRequired" onChange="UpdateVacancyTitle();">
{html_options values=$fieldProfilesId output=$fieldProfilesName selected=$smarty.session.jFieldProfileList}
</select>
</td>

</tr>

<tr valign="top">
<td align="right"><a href="javascript://" OnMouseOver="popup('{t escape='no'
  1='<br> <br>'
  2='<strong>'
  3='</strong>'
}Choose any skill in one of the combo-boxes and then select the knowledge and experience levels.%1 The skill and levels will arise in the right box. Repeat this operation with each skill you know.%1 If you want to delete some entry, select it in the right box and click %2Delete%3.{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Skills{/t}</a> : </td>
<td colspan="3">

<table cellpadding="0" cellspacing="0" width="100%">
{foreach from=$skillsBySets item=skillIds key=skillSetTypeId}
<tr>
<td>
{$skillSetTypeId|gettext|strip:'&nbsp;'}:&nbsp;
</td>
<td>
<select name="Skill_{$skillSetTypeId|strip:'_'}" class="notRequired" onChange="{foreach from=$skillsBySets item=s key=setId}{if $setId neq $skillSetTypeId} document.jobOfferForm.Skill_{$setId|strip:'_'}.value=''; {/if}{/foreach} document.jobOfferForm.Skill.value = document.jobOfferForm.Skill_{$skillSetTypeId|strip:'_'}.value; ResetSkillLevels();"> <!-- We raise it here due it is not automatically raised with the previous line ^ -->
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
{t}Knowledge level{/t}:
<select name="skillKnowledgeLevel" class="notRequired" disabled onChange="UpdateSkill(); UpdateVacancyTitle();">
{html_options values=$skillKnowledgeLevelsId output=$skillKnowledgeLevelsName}
</select><br>

{t}Experience level{/t}:
<select name="skillExperienceLevel" class="notRequired" disabled onChange="UpdateSkill(); UpdateVacancyTitle();">
{html_options values=$skillExperienceLevelsId output=$skillExperienceLevelsName}
</select> <br>
<br>
</td>

<td align="center">

<select name="ViewSkillList[]" id="ViewSkillList" size="3" multiple="true" class="notRequired" OnClick="document.jobOfferForm.skillKnowledgeLevel.focus(); document.jobOfferForm.ViewSkillList.focus(); {foreach from=$skillsBySets item=s key=setId} document.jobOfferForm.Skill_{$setId|strip:'_'}.value=''; {/foreach} {foreach from=$skillsBySets item=s key=setId} document.jobOfferForm.Skill_{$setId|strip:'_'}.value=document.jobOfferForm.SkillList[document.jobOfferForm.ViewSkillList.selectedIndex].value; {/foreach}  UpdateWithSelectedSkill(true);">
</select><br>
<a href="javascript://" OnClick="DeleteSkill(document.jobOfferForm.ViewSkillList.selectedIndex); UpdateVacancyTitle();"><strong>{t}Delete{/t}</strong></a>

<div id="SkillLists" style="display:none">
<select name="SkillList[]" id="SkillList" size="4" multiple="true"> <!-- Note: Commented due to it only raise the event if the new Object is selected.  onChange="UpdateVacancyTitle();"> -->
{html_options values=$smarty.session.jSkillList output=$smarty.session.jSkillList}
</select><br>
<select name="SkillKnowledgeLevelList[]" id="SkillKnowledgeLevelList" size="4" multiple="true">
{html_options values=$smarty.session.jSkillKnowledgeLevelList output=$smarty.session.jSkillKnowledgeLevelList}
</select><br>
<select name="SkillExperienceLevelList[]" id="SkillExperienceLevelList" size="4" multiple="true">
{html_options values=$smarty.session.jSkillExperienceLevelList output=$smarty.session.jSkillExperienceLevelList}
</select><br>
</div>

</td>

</tr>
</table>

</td>
</tr>

<tr valign="top">
<td align="right"><span class="must">*</span><a href="javascript://" OnMouseOver="popup('{t escape='no'
  1='<br> <br>'
  2='<strong>'
  3='</strong>'
}Choose any idiom in the first combo-box and then select the spoken and written levels.%1 The idiom and levels will arise in the right box. Repeat this operation with each idiom you know.%1 If you want to delete some entry, select it in the right box and click %2Delete%3.{/t}','lightyellow',300);" OnMouseOut="kill()">{t}Required languages{/t}</a> : </td>
<td colspan="3">
<table cellpadding="0" cellspacing="0" width="100%">
<tr valign="top">
<td>

<select name="Language" class="required" onChange="ResetLevels();">
{html_options values=$languagesName output=$languagesNameTranslated}
</select><br>

{t}Spoken level{/t}:
<select name="languageSpokenLevel" class="required" disabled onChange="UpdateIdiom(); UpdateVacancyTitle();">
{html_options values=$languagesSpokenLevelsId output=$languagesSpokenLevelsName}
</select><br>

{t}Written level{/t}:
<select name="languageWrittenLevel" class="required" disabled onChange="UpdateIdiom(); UpdateVacancyTitle();">
{html_options values=$languagesWrittenLevelsId output=$languagesWrittenLevelsName}
</select>

</td>

<td align="center">
<select name="ViewLanguageList[]" id="ViewLanguageList" size="4" multiple="true" class="required" OnClick="UpdateWithSelectedItem(true);">
</select><br>
<a href="javascript://" OnClick="DeleteItem(document.jobOfferForm.ViewLanguageList.selectedIndex); UpdateVacancyTitle();"><strong>{t}Delete{/t}</strong></a>

<div id="LanguageLists" style="display:none">
<select name="LanguageList[]" id="LanguageList" size="4" multiple="true">
{html_options values=$smarty.session.jLanguageList output=$smarty.session.jLanguageList}
</select><br>
<select name="LanguageSpokenLevelList[]" id="LanguageSpokenLevelList" size="4" multiple="true">
{html_options values=$smarty.session.jLanguageSpokenLevelList output=$smarty.session.jLanguageSpokenLevelList}
</select><br>
<select name="LanguageWrittenLevelList[]" id="LanguageWrittenLevelList" size="4" multiple="true">
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
<td align="right">Certifications : <br> </td>
<td colspan="3">

<table cellspacing="0" cellpadding="0">
{foreach from=$certificationsList[0] item=certification key=i}
	{if  ( $smarty.session.jAllowPersonApplications eq 'true'       and $certificationsList[1][$i] eq 't' )
	  or ( $smarty.session.jAllowCompanyApplications eq 'true'      and $certificationsList[2][$i] eq 't' )
	  or ( $smarty.session.jAllowOrganizationApplications eq 'true' and $certificationsList[3][$i] eq 't' )
	}
		{if is_array($smarty.session.jCertificationsList) and in_array($certification, $smarty.session.jCertificationsList) }
			<tr> <td> <input type="checkbox" name="CertificationsList[]" value="{$certification}" class="notRequired" checked>{$certification}</td> </tr>
		{else}
			<tr> <td> <input type="checkbox" name="CertificationsList[]" value="{$certification}" class="notRequired">{$certification}</td> </tr>
		{/if}
	{/if}
{/foreach}
</table>

</td>
</tr>

{/if}
{/if}

<tr valign="top">
<td align="right">{'Experience with FS projects'|gettext|strip:'&nbsp;'}&nbsp;: <br> </td>
<td colspan="3"> <input type="text" name="FreeSoftwareExperiences" size="66" maxlength="60" class="notRequired" value="{$smarty.session.jFreeSoftwareExperiences}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">{t}RESIDENCE LOCATION{/t}</td> </tr>

<tr valign="top">
<td align="right"><span class="must">*</span>{t}Telework{/t} : </td>
<td colspan="3"> <input type="checkbox" name="Telework" class="required" {if $smarty.session.jTelework eq 'true'} checked {/if}  onChange="ViewAddress();"> </td>
</tr>

<tr>
<td align="right">{t}City{/t} : </td>
<td colspan="3"> <input type="text" name="City" size="30" maxlength="30" value="{$smarty.session.jCity}" class="notRequired" {if $smarty.session.jTelework eq 'true'} disabled {/if} > </td>
</tr>
<tr>
<td align="right">{t}State / Province{/t} : </td>
<td colspan="3"> <input type="text" name="StateProvince" size="30" maxlength="30" value="{$smarty.session.jStateProvince}" class="notRequired" {if $smarty.session.jTelework eq 'true'} disabled {/if} > </td>
</tr>
<tr>
<td align="right"><span class="must">*</span>{t}Country{/t} : </td>
<td colspan="3">
<select name="CountryCode" class="required" {if $smarty.session.jTelework eq 'true'} disabled {/if} >
{html_options values=$countryTwoLetter output=$countryNames selected=$smarty.session.jCountryCode}
</select>
</td>
</tr>

<tr valign="top">
<td align="right">{t}Available to travel{/t} : </td>
<td colspan="3"> <input type="checkbox" name="AvailableToTravel" class="notRequired" {if $smarty.session.jAvailableToTravel eq 'true'} checked {/if} > </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 
<tr> <td colspan="4">&nbsp;</td> </tr> 
<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr align="center">
<td colspan="4" align="center">
<input type="reset" name="reset" value="{t}Reset form{/t}">
<input type="submit" name="save" value="{t}Save{/t}" OnClick="SelectAllItems();">
</td>
</tr>

</form>

{if $smarty.post.JobOfferId } <!-- update -->
<tr align="center">
<td colspan="4" align="center">
<br>
<form name='viewMyJobOffer' method='post' action='View_Job_Offer.php'>
<input type="hidden" name="ViewJobOfferId" value="{$smarty.post.JobOfferId}">
<input type="hidden" name="ViewEntityId" value="{$smarty.session.EntityId}">
<input type="submit" name="view" value="{t}Check job offer view{/t}">
</form>
</td>
</tr>
{/if}

</table>

