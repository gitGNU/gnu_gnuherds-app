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

<table align="center">

{if $smarty.get.EntityId eq $smarty.session.EntityId and $smarty.session.ViewCompletedEdition eq 'f' }
	<tr align="center">
	<td colspan="5" align="center"><span class="modification">{t}The edition of these qualifications is not finished! It does not comply the minimum requisites to allow it subscribe to offers.{/t}</span></td>
	</tr>

	<tr> <td colspan="5">&nbsp;</td> </tr> 
	<tr> <td colspan="5">&nbsp;</td> </tr> 
{/if}

<tr valign="top">
<td>
{if $smarty.session.ViewPhotoOrLogo eq 'true' }
		<img src="photo?acl=resume&id={$smarty.get.EntityId}" align="left" alt="" border="1" hspace="0" vspace="0">
{else}
	{if $smarty.session.ViewEntityType eq 'Person' }
		<img src="/images/default/Person.png" width="90" height="120" align="left" alt="" border="1" hspace="0" vspace="0">
	{else}
		<img src="/images/default/Company_or_non-profit_Organization.png" width="180" height="120" align="left" alt="" border="1" hspace="0" vspace="0">
	{/if}
{/if}
</td>
<td colspan="3">

{t}{$smarty.session.ViewEntityType}{/t}:

{if $smarty.session.ViewEntityType eq 'Person' }
	<!-- Person's name -->
	<strong>
	{if trim($smarty.session.ViewLastName) neq '' or trim($smarty.session.ViewMiddleName) neq '' }
		{$smarty.session.ViewLastName} {$smarty.session.ViewMiddleName},
	{/if}
	{$smarty.session.ViewFirstName}
	</strong>
	<br>

	<!-- Person's birth year -->
	{if trim($smarty.session.ViewBirthYear) neq ''}
		{t}been born in{/t} <strong>{$smarty.session.ViewBirthYear}</strong><br>
	{/if}
{/if}

{if $smarty.session.ViewEntityType eq 'Company' }
	<!-- Company's name -->
	<strong>{$smarty.session.ViewCompanyName}</strong><br>
{/if}

{if $smarty.session.ViewEntityType eq 'non-profit Organization' }
	<!-- non-profit Organization's name -->
	<strong>{$smarty.session.ViewNonprofitName}</strong><br>
{/if}

{if trim($smarty.session.ViewNationality) neq ''}
	<!-- Nationality -->
	{t}Nationality{/t} <strong>{t}{$smarty.session.ViewNationalityName}{/t}</strong><br>
{/if}

<br>

<!-- Address -->
{$smarty.session.ViewStreet}{if trim($smarty.session.ViewStreet) neq '' and trim($smarty.session.ViewSuite) neq ''}, {/if}{$smarty.session.ViewSuite}<br>

{$smarty.session.ViewPostalCode}
{if trim($smarty.session.ViewPostalCode) neq '' and trim($smarty.session.ViewCity) neq ''} - {/if}
{$smarty.session.ViewCity}
{if trim($smarty.session.ViewPostalCode) neq '' or  trim($smarty.session.ViewCity) neq ''} <br> {/if}

{$smarty.session.ViewStateProvince}{if trim($smarty.session.ViewStateProvince) neq ''}, {/if}<strong>{t}{$smarty.session.ViewCountryName}{/t}</strong><br>

<br>

<!-- Other contact information -->

{mailto address=$smarty.session.ViewEmail}<br>

{if trim($smarty.session.ViewWebsite) neq ''}
	{t}web site{/t} <a href="{$smarty.session.ViewWebsite}">{$smarty.session.ViewWebsite}</a><br>
{/if}


<br>

{if trim($smarty.session.ViewLandline) neq ''}
	<strong>{t}Landline{/t}</strong>: {$smarty.session.ViewLandline}<br>
{/if}

{if trim($smarty.session.ViewMobilePhone) neq ''}
	<strong>{t}Mobile phone{/t}</strong>: {$smarty.session.ViewMobilePhone}<br>
{/if}

{if trim($smarty.session.ViewIpPhoneOrVideo) neq ''}
	<strong>{t}IP phone or videophone{/t}</strong>: {$smarty.session.ViewIpPhoneOrVideo}<br>
{/if}

</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}

{if $smarty.session.LoginType eq 'Person' }
	{assign var="Entity" value="person"}
{/if}
{if $smarty.session.LoginType eq 'Company' }
	{assign var="Entity" value="company"}
{/if}
{if $smarty.session.LoginType eq 'non-profit Organization' }
	{assign var="Entity" value="nonprofit"}
{/if}

<td class="edit"><a href="{$Entity}" title="{t}Edit section{/t}: {t}{$smarty.session.ViewEntityType}{/t}">{t}edit{/t}</a></td>

{/if}

</tr>


<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}TECHNICAL{/t}</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=profiles_etc" title="{t}Edit section{/t}: {t}TECHNICAL{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{'Professional experience since'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">{$smarty.session.ViewProfessionalExperienceSinceYear}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=profiles_etc" title="{t}Edit section{/t}: {t}Professional experience since{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if $smarty.session.ViewEntityType eq 'Person' }
<tr>
<td align="right"><strong>{t}Academic qualification{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{if trim($smarty.session.ViewAcademicQualification) neq '' or trim($smarty.session.ViewAcademicQualificationDescription) neq ''}
	{t}{$smarty.session.ViewAcademicQualification}{/t}{if trim($smarty.session.ViewAcademicQualificationDescription) neq ''}, ({$smarty.session.ViewAcademicQualificationDescription}){/if}
{else}
	{t}none{/t}
{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=profiles_etc" title="{t}Edit section{/t}: {t}Academic qualification{/t}">{t}edit{/t}</a></td>
{/if}
</tr>
{/if}

<tr valign="top">
<td align="right"><strong>{t}Profiles{/t}</strong> : </td>

<td class="greenLight"><u>{'Product profiles'|gettext|strip:'&nbsp;'}</u><br>
{if not is_array($smarty.session.ViewProductProfileList) or count($smarty.session.ViewProductProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$smarty.session.ViewProductProfileList item=profile}
		{$profile|gettext|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

<td class="greenLight"><u>{'Professional profiles'|gettext|strip:'&nbsp;'}</u><br>
{if not is_array($smarty.session.ViewProfessionalProfileList) or count($smarty.session.ViewProfessionalProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$smarty.session.ViewProfessionalProfileList item=profile}
		{$profile|gettext|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

<td class="greenLight"><u>{'Field profiles'|gettext|strip:'&nbsp;'}</u><br>
{if not is_array($smarty.session.ViewFieldProfileList) or count($smarty.session.ViewFieldProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$smarty.session.ViewFieldProfileList item=profile}
		{$profile|gettext|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=profiles_etc" title="{t}Edit section{/t}: {t}Profiles{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

<tr valign="top">
<td align="right"><strong>{t}Skills{/t}</strong> : </td>

{if not is_array($smarty.session.ViewSkillList) or count($smarty.session.ViewSkillList) == 0}
	<td class="greenDark">{t}none{/t}</td> <td class="greenDark"></td> <td class="greenDark"></td>
{else}
<td class="greenDark"><u>{t}Skill{/t}</u><br>
{foreach from=$smarty.session.ViewSkillList item=skill}
	{$skill|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenDark"><u>{'Knowledge level'|gettext|strip:'&nbsp;'}</u><br>
{foreach from=$smarty.session.ViewKnowledgeLevelList item=knowledgeLevel}
	{$knowledgeLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenDark"><u>{'Experience level'|gettext|strip:'&nbsp;'}</u><br>
{foreach from=$smarty.session.ViewExperienceLevelList item=experienceLevel}
	{$experienceLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=skills" title="{t}Edit section{/t}: {t}Skills{/t}">{t}edit{/t}</a></td>
{/if}

{/if}

</tr>

<tr valign="top">
<td align="right"><strong>{t}Languages{/t}</strong> : </td>

<td class="greenLight"><u>{t}Language{/t}</u><br>
{foreach from=$smarty.session.ViewLanguageList item=language}
	{$language|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenLight"><u>{'Spoken level'|gettext|strip:'&nbsp;'}</u><br>
{foreach from=$smarty.session.ViewLanguageSpokenLevelList item=spokenLevel}
	{$spokenLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenLight"><u>{'Written level'|gettext|strip:'&nbsp;'}</u><br>
{foreach from=$smarty.session.ViewLanguageWrittenLevelList item=writtenLevel}
	{$writtenLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=languages" title="{t}Edit section{/t}: {t}Languages{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

{* The certifications feature is disabled
<tr valign="top">
<td align="right"><strong>{t}Certifications{/t}</strong> : <br> </td>
<td colspan="3" class="greenDark">
{if is_array($smarty.session.ViewCertificationsList) and count($smarty.session.ViewCertificationsList) > 0}
	{foreach from=$smarty.session.ViewCertificationsList item=certification key=i}
		{if $smarty.session.ViewCertificationsStateList[$i] eq 'Accepted'}
			{$certification}<br>
			{assign var="HasSomeCertification" value="Yes"}
		{/if}
	{/foreach}
{/if}
{if $HasSomeCertification neq 'Yes'}
	{t}none{/t}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=certifications" title="{t}Edit section{/t}: {t}Certifications{/t}">{t}edit{/t}</a></td>
{/if}

</tr>
*}

<tr valign="top">
<td align="right"><strong>{'Contributions to FS projects'|gettext|strip:'&nbsp;'}</strong>&nbsp;: <br> </td>
<td colspan="3" class="greenDark">
{if is_array($smarty.session.ViewContributionsListProject) and count($smarty.session.ViewContributionsListProject) > 0 }
	{foreach from=$smarty.session.ViewContributionsListProject item=project key=i}
		<a href="{$smarty.session.ViewContributionsListURI[$i]}">{$project}</a>{if $smarty.session.ViewContributionsListDescription[$i] neq ''}: {$smarty.session.ViewContributionsListDescription[$i]}{/if}<br>
	{/foreach}
{else}
	{t}none{/t}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=projects" title="{t}Edit section{/t}: {t}Contributions to FS projects{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

{if $smarty.session.ViewEntityType eq 'Person' }

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr>
<td colspan="4" class="subsection">{t}CONTRACT{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=contract" title="{t}Edit section{/t}: {t}CONTRACT{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Desired contract type{/t}</strong> : </td>
<td colspan="3" class="greenLight">{t}{$smarty.session.ViewDesiredContractType}{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Desired wage rank{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{$smarty.session.ViewDesiredWageRank}
({t}{$smarty.session.ViewWageRankCurrencyName}{/t})
{t}{$smarty.session.ViewWageRankByPeriod}{/t}{if trim($smarty.session.ViewDesiredWageRank) neq ''}. [{t}Minimum{/t}-{t}Optimum{/t}]{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Current employability{/t}</strong> : </td>
<td colspan="3" class="greenLight">{t}{$smarty.session.ViewCurrentEmployability}{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}LOCATION{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&id={$smarty.get.EntityId}&section=location" title="{t}Edit section{/t}: {t}LOCATION{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{t}Available to travel{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{if $smarty.session.ViewAvailableToTravel eq 'false'}
{t}No{/t}
{else}
{t}Yes{/t}
{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{'Available to change residence'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">
{if $smarty.session.ViewAvailableToChangeResidence eq 'false'}
{t}No{/t}
{else}
{t}Yes{/t}
{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

{/if}


{if $smarty.get.EntityId eq $smarty.session.EntityId }
		<tr> <td colspan="5">&nbsp;</td> </tr> 
		<tr> <td colspan="5">&nbsp;</td> </tr> 

		<tr align="center">
		<td colspan="5" align="center">
		<form name="deleteQualificationsForm" method="post" action="resume?id={$smarty.get.EntityId}">
		<input type="submit" name="delete" value="{t}Delete qualifications{/t}" title="{t}Delete qualifications from the data base{/t}">
		</form>
		</td>
		</tr>
{/if}

</table>

