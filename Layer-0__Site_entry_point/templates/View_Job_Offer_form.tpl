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

{if $smarty.session.IsAlreadySubscribed eq 't'}
		<tr align="center">
		<td colspan="5" align="center"><span class="modification">{t}Your application has been subscribed to this job offer{/t}</span></td>
		</tr>

		<tr> <td colspan="5">&nbsp;</td> </tr> 
		<tr> <td colspan="5">&nbsp;</td> </tr> 
{else}
	{if $smarty.session.ViewEntityId eq $smarty.session.EntityId and $smarty.session.ViewCompletedEdition eq 'f' }
		<tr align="center">
		<td colspan="5" align="center"><span class="modification">{t}The edition of this offer is not finished! It is not ready to be published.{/t}</span></td>
		</tr>

		<tr> <td colspan="5">&nbsp;</td> </tr> 
		<tr> <td colspan="5">&nbsp;</td> </tr> 
	{/if}
{/if}


<tr valign="top">
<td>
{if $smarty.session.ViewPhotoOrLogo eq 'true' }
		<img src="photo?acl=offers&id={$smarty.session.ViewEntityId}" align="left" alt="" border="1" hspace="0" vspace="0">
{else}
	{if $smarty.session.ViewEntityType eq 'Person' }
		<img src="/images/default/Person.png" width="90" height="120" align="left" alt="" border="1" hspace="0" vspace="0">
	{else}
		<img src="/images/default/Company_or_non-profit_Organization.png" width="180" height="120" align="left" alt="" border="1" hspace="0" vspace="0">
	{/if}
	<br>
{/if}
</td>
<td colspan="3">

{t}{$smarty.session.ViewEntityType}{/t}:

{if $smarty.session.ViewEntityType eq 'Person' }
	<!-- Person's name -->
	<strong>
	{if trim($smarty.session.ViewWebsite) neq ''}<a href="{$smarty.session.ViewWebsite}">{/if}
	{if trim($smarty.session.ViewLastName) neq '' or trim($smarty.session.ViewMiddleName) neq ''}
		{$smarty.session.ViewLastName} {$smarty.session.ViewMiddleName},
	{/if}
	{$smarty.session.ViewFirstName}{if trim($smarty.session.ViewWebsite) neq ''}</a>{/if}
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

{if trim($smarty.session.ViewEntityNationality) neq ''}
	<!-- Nationality -->
	{t}Nationality{/t} <strong>{t}{$smarty.session.ViewEntityNationalityName}{/t}</strong><br>
{/if}

{*
<br>

{if $smarty.post.ViewContactInformation eq 't'}

	<!-- Address -->
	{$smarty.session.ViewEntityStreet}{if trim($smarty.session.ViewEntityStreet) neq '' and trim($smarty.session.ViewEntitySuite) neq ''}, {/if}{$smarty.session.ViewEntitySuite}<br>

	{$smarty.session.ViewEntityPostalCode}
	{if trim($smarty.session.ViewEntityPostalCode) neq '' and trim($smarty.session.ViewEntityCity) neq ''} - {/if}
	{$smarty.session.ViewEntityCity}
	{if trim($smarty.session.ViewEntityPostalCode) neq '' or  trim($smarty.session.ViewEntityCity) neq ''} <br> {/if}

	{$smarty.session.ViewEntityStateProvince}{if trim($smarty.session.ViewEntityStateProvince) neq ''}, {/if}<strong>{$smarty.session.ViewEntityCountryName}</strong><br>

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
		<strong>{t}IP phone or videophone{/t}</strong>: {$smarty.session.ViewIpPhoneOrVideo}
	{/if}

{else}
	<a href="XXX">{t}View contact information{/t}</a>
{/if}
*}

</td>

{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}

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
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td colspan="4" class="subsection">{t}IS LOOKING FOR{/t}</td>

{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=general" title="{t}Edit section{/t}: {t}IS LOOKING FOR{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="tdDark">{$smarty.session.ViewVacancyTitle}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr valign="top">
<td align="right"><strong>{'Entity type'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">
{if $smarty.session.ViewAllowPersonApplications eq 'true'}
	{assign var="entityTypeAAA" value="Persons"}
{/if}

{if $smarty.session.ViewAllowCompanyApplications eq 'true'}
	{if trim($entityTypeAAA) eq ''}
		{assign var="entityTypeAAA" value="Companies"}
	{else}
		{assign var="entityTypeBBB" value="Companies"}
	{/if}
{/if}

{if $smarty.session.ViewAllowOrganizationApplications eq 'true'}
	{if trim($entityTypeAAA) eq ''}
		{assign var="entityTypeAAA" value="non-profit Organizations"}
	{else}
		{if $entityTypeBBB eq ''}
			{assign var="entityTypeBBB" value="non-profit Organizations"}
		{else}
			{assign var="entityTypeCCC" value="non-profit Organizations"}
		{/if}
	{/if}
{/if}

{t}{$entityTypeAAA}{/t}{if $entityTypeBBB neq ''}{if $entityTypeCCC neq ''}, {else} {t}or{/t} {/if} {t}{$entityTypeBBB}{/t} {/if}
{if $entityTypeCCC neq ''} {t}or{/t} {t}{$entityTypeCCC}{/t}{/if}
</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Vacancies{/t}</strong> : </td>
<td colspan="3" class="greenLight">{$smarty.session.ViewVacancies}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">{$smarty.session.ViewOfferDate}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

{if $smarty.session.ViewEmployerJobOfferReference neq ''}
<tr>
<td align="right"><strong>{t}Ref.{/t}</strong> : </td>
<td colspan="3" class="greenLight">{$smarty.session.ViewEmployerJobOfferReference}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>
{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}TECHNICAL{/t}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=profiles_etc" title="{t}Edit section{/t}: {t}TECHNICAL{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if trim($smarty.session.ViewProfessionalExperienceSinceYear) neq ''}
	<tr>
	<td align="right"><strong>{'Professional experience since'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
	<td colspan="3" class="greenLight">{$smarty.session.ViewProfessionalExperienceSinceYear}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=profiles_etc" title="{t}Edit section{/t}: {t}Professional experience since{/t}">{t}edit{/t}</a></td>
{/if}
	</tr>
{/if}

{if trim($smarty.session.ViewAcademicQualification) neq ''}
	<tr>
	<td align="right"><strong>{'Academic qualification'|gettext|strip:'&nbsp;'}</strong> : </td>
	<td colspan="3" class="greenLight">{t}{$smarty.session.ViewAcademicQualification}{/t}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=profiles_etc" title="{t}Edit section{/t}: {t}Academic qualification{/t}">{t}edit{/t}</a></td>
{/if}
	</tr>
{/if}

{if ( is_array($smarty.session.ViewProductProfileList) and count($smarty.session.ViewProductProfileList) > 0 ) or
    ( is_array($smarty.session.ViewProfessionalProfileList) and count($smarty.session.ViewProfessionalProfileList) > 0 ) or
    ( is_array($smarty.session.ViewFieldProfileList) and count($smarty.session.ViewFieldProfileList) > 0 )
}
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

	{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=profiles_etc" title="{t}Edit section{/t}: {t}Profiles{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

{if is_array($smarty.session.ViewSkillList) and count($smarty.session.ViewSkillList) > 0 }
	<tr valign="top">
	<td align="right"><strong>{t}Skills{/t}</strong> : </td>

	<td class="greenLight"><u>{t}Skill{/t}</u><br>
	{foreach from=$smarty.session.ViewSkillList item=skill}
		{$skill|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	<td class="greenLight"><u>{'Knowledge level'|gettext|strip:'&nbsp;'}</u><br>
	{foreach from=$smarty.session.ViewKnowledgeLevelList item=knowledgeLevel}
		{$knowledgeLevel|gettext|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	<td class="greenLight"><u>{'Experience level'|gettext|strip:'&nbsp;'}</u><br>
	{foreach from=$smarty.session.ViewExperienceLevelList item=experienceLevel}
		{$experienceLevel|gettext|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=skills" title="{t}Edit section{/t}: {t}Skills{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

{if is_array($smarty.session.ViewLanguageList) and count($smarty.session.ViewLanguageList) > 0 }
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

	{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=languages" title="{t}Edit section{/t}: {t}Languages{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

{* The certifications feature is disabled
{if is_array($smarty.session.ViewCertificationsList) and count($smarty.session.ViewCertificationsList) > 0}
	<tr valign="top">
	<td align="right"><strong>{t}Certifications{/t}</strong> : <br> </td>
	<td colspan="3" class="greenLight">
		{foreach from=$smarty.session.ViewCertificationsList item=certification}
			{$certification}<br>
		{/foreach}
	</td>
	{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=certifications" title="{t}Edit section{/t}: {t}Certifications{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}
*}

{if trim($smarty.session.ViewFreeSoftwareExperiences) neq ''}
	<tr valign="top">
	<td align="right"><strong>{'Experience with FS projects'|gettext|strip:'&nbsp;'}</strong> : <br> </td>
	<td colspan="3" class="greenLight">{$smarty.session.ViewFreeSoftwareExperiences}</td>
	{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=projects" title="{t}Edit section{/t}: {t}Experience with FS projects{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}RESIDENCE LOCATION{/t}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=location" title="{t}Edit section{/t}: {t}RESIDENCE LOCATION{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if trim($smarty.session.ViewJobOfferCity) eq '' and trim($smarty.session.ViewJobOfferStateProvince) eq '' and trim($smarty.session.ViewJobOfferCountryName) eq ''}
		<tr valign="top">
		<td align="right"><strong>{t}Telework{/t}</strong> : </td>
		<td colspan="3" class="greenLight">{t}any location{/t}</td>
		{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
{else}
	{if trim($smarty.session.ViewJobOfferCity) neq ''}
		<tr>
		<td align="right"><strong>{t}City{/t}</strong> : </td>
		<td colspan="3" class="greenLight">{$smarty.session.ViewJobOfferCity}</td>
		{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}

	{if trim($smarty.session.ViewJobOfferStateProvince) neq ''}
		<tr>
		<td align="right"><strong>{'State / Province'|gettext|strip:'&nbsp;'}</strong> : </td>
		<td colspan="3" class="greenLight">{$smarty.session.ViewJobOfferStateProvince}</td>
		{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}

	{if trim($smarty.session.ViewJobOfferCountryName) neq ''}
		<tr>
		<td align="right"><strong>{t}Country{/t}</strong> : </td>
		<td colspan="3" class="greenLight">{t}{$smarty.session.ViewJobOfferCountryName}{/t}</td>
		{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}

	{if $smarty.session.ViewAvailableToTravel eq 'true'}
		<tr valign="top">
		<td align="right"><strong>{'Available to travel'|gettext|strip:'&nbsp;'}</strong> : </td>
		<td colspan="3" class="greenLight">{t}required{/t}</td>
		{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}
{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}CONTRACT{/t}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&id={$smarty.get.JobOfferId}&section=contract" title="{t}Edit section{/t}: {t}CONTRACT{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if $smarty.session.ViewContractType neq ''}

<tr>
<td align="right"><strong>{'Contract type'|gettext|strip:'&nbsp;'}</strong> : </td>
<td colspan="3" class="greenLight">{t}{$smarty.session.ViewContractType}{/t}</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{'Wage rank'|gettext|strip:'&nbsp;'}</strong> : </td>
<td colspan="3" class="greenLight">
{$smarty.session.ViewWageRank}
{t}{$smarty.session.ViewWageRankCurrencyName}{/t} 
{t}{$smarty.session.ViewWageRankByPeriod}{/t}
</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

{if trim($smarty.session.ViewEstimatedEffort) neq '' and $smarty.session.ViewTimeUnit neq ''}
<tr>
<td align="right"><strong>{'Estimated effort'|gettext|strip:'&nbsp;'}</strong> : </td>
<td colspan="3" class="greenLight">
{$smarty.session.ViewEstimatedEffort}
{t}{$smarty.session.ViewTimeUnit}{/t}
</td>
{if $smarty.session.ViewEntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>
{/if}

{/if}


{if $smarty.session.ViewEntityId neq $smarty.session.EntityId and $smarty.session.IsAlreadySubscribed neq 't' }
		<tr> <td colspan="4">&nbsp;</td> </tr> 
		<tr> <td colspan="4">&nbsp;</td> </tr> 

		<tr align="center">
		<td colspan="4" align="center">
		<form name="subscriteJobOfferForm" method="post" action="offers?id={$smarty.get.JobOfferId}">
		<input type="submit" name="subscribe" value="{t}Subscribe to this job offer{/t}">
		</form>
		</td>
		</tr>
{/if}

</table>

