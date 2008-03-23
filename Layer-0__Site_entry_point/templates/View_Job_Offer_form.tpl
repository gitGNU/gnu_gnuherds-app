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

<table cellpadding="0" rules="none" border="0">

{if $smarty.session.IsAlreadySubscribed eq 't'}
		<tr align="center">
		<td colspan="5" align="center"><span class="modification">{t}Your application has been subscribed to this job offer{/t}</span></td>
		</tr>

		<tr> <td colspan="5">&nbsp;</td> </tr> 
		<tr> <td colspan="5">&nbsp;</td> </tr> 
{else}
	{if $data.EntityId eq $smarty.session.EntityId and $data.CompletedEdition eq 'f' }
		<tr align="center">
		<td colspan="5" align="center"><span class="modification">{t}The edition of this offer is not finished! It is not ready to be published.{/t}</span></td>
		</tr>

		<tr> <td colspan="5">&nbsp;</td> </tr> 
		<tr> <td colspan="5">&nbsp;</td> </tr> 
	{/if}
{/if}


<tr>
<td colspan="4" class="subsection head">
{t}Job offer{/t}
</td>

{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=general" title="{t}Edit section{/t}: {t}General{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td colspan="4">&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr valign="top">
<td align="right"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="tdDark">{$data.VacancyTitle}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td colspan="4">&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td align="right"><strong>{t}Vacancies{/t}</strong> : </td>
<td colspan="3" class="greenLight">{$data.Vacancies}
{if $data.AllowPersonApplications eq 'true'}
	{assign var="entityTypeAAA" value="Persons"}
{/if}

{if $data.AllowCompanyApplications eq 'true'}
	{if trim($entityTypeAAA) eq ''}
		{assign var="entityTypeAAA" value="Companies"}
	{else}
		{assign var="entityTypeBBB" value="Companies"}
	{/if}
{/if}

{if $data.AllowOrganizationApplications eq 'true'}
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

({t}{$entityTypeAAA}{/t}{if $entityTypeBBB neq ''}{if $entityTypeCCC neq ''}, {else} {t}or{/t} {/if} {t}{$entityTypeBBB}{/t} {/if}
{if $entityTypeCCC neq ''} {t}or{/t} {t}{$entityTypeCCC}{/t}{/if})
</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">{$data.OfferDate}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

{if $data.EmployerJobOfferReference neq ''}
<tr>
<td align="right"><strong>{t}Ref.{/t}</strong> : </td>
<td colspan="3" class="greenLight">{$data.EmployerJobOfferReference}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>
{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Technical{/t}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Technical{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if trim($data.ProfessionalExperienceSinceYear) neq ''}
	<tr>
	<td align="right"><strong>{'Professional experience since'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
	<td colspan="3" class="greenLight">{$data.ProfessionalExperienceSinceYear}</td>
{if $data.EntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Professional experience since{/t}">{t}edit{/t}</a></td>
{/if}
	</tr>
{/if}

{if trim($data.AcademicLevel) neq ''}
	<tr>
	<td align="right"><strong>{'Academic level'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
	<td colspan="3" class="greenLight">{t domain='database'}{$data.AcademicLevel}{/t}</td>
{if $data.EntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Academic level{/t}">{t}edit{/t}</a></td>
{/if}
	</tr>
{/if}

{if ( is_array($data.ProductProfileList) and count($data.ProductProfileList) > 0 ) or
    ( is_array($data.ProfessionalProfileList) and count($data.ProfessionalProfileList) > 0 ) or
    ( is_array($data.FieldProfileList) and count($data.FieldProfileList) > 0 )
}
	<tr valign="top">
	<td align="right"><strong>{t}Profiles{/t}</strong> : </td>

	<td class="greenLight"><span class="u">{'Product profiles'|gettext|strip:'&nbsp;'}</span><br>
	{if not is_array($data.ProductProfileList) or count($data.ProductProfileList) == 0}
		{'not specified'|gettext|strip:'&nbsp;'}
	{else}
		{foreach from=$data.ProductProfileList item=profile}
			{$profile|dgettext:'database'|strip:'&nbsp;'}<br>
		{/foreach}
	{/if}
	</td>

	<td class="greenLight"><span class="u">{'Professional profiles'|gettext|strip:'&nbsp;'}</span><br>
	{if not is_array($data.ProfessionalProfileList) or count($data.ProfessionalProfileList) == 0}
		{'not specified'|gettext|strip:'&nbsp;'}
	{else}
		{foreach from=$data.ProfessionalProfileList item=profile}
			{$profile|dgettext:'database'|strip:'&nbsp;'}<br>
		{/foreach}
	{/if}
	</td>

	<td class="greenLight"><span class="u">{'Field profiles'|gettext|strip:'&nbsp;'}</span><br>
	{if not is_array($data.FieldProfileList) or count($data.FieldProfileList) == 0}
		{'not specified'|gettext|strip:'&nbsp;'}
	{else}
		{foreach from=$data.FieldProfileList item=profile}
			{$profile|dgettext:'database'|strip:'&nbsp;'}<br>
		{/foreach}
	{/if}
	</td>

	{if $data.EntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Profiles{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

{if is_array($data.SkillList) and count($data.SkillList) > 0 }
	<tr valign="top">
	<td align="right"><strong>{t}Skills{/t}</strong> : </td>

	<td class="greenLight"><span class="u">{t}Skill{/t}</span><br>
	{foreach from=$data.SkillList item=skill}
		{$skill|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	<td class="greenLight"><span class="u">{'Knowledge level'|gettext|strip:'&nbsp;'}</span><br>
	{foreach from=$data.KnowledgeLevelList item=knowledgeLevel}
		{$knowledgeLevel|dgettext:'database'|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	<td class="greenLight"><span class="u">{'Experience level'|gettext|strip:'&nbsp;'}</span><br>
	{foreach from=$data.ExperienceLevelList item=experienceLevel}
		{$experienceLevel|dgettext:'database'|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	{if $data.EntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=skills" title="{t}Edit section{/t}: {t}Skills{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

{if is_array($data.LanguageList) and count($data.LanguageList) > 0 }
	<tr valign="top">
	<td align="right"><strong>{t}Languages{/t}</strong> : </td>

	<td class="greenLight"><span class="u">{t}Language{/t}</span><br>
	{foreach from=$data.LanguageList item=language}
		{$language|dgettext:'iso_639'|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	<td class="greenLight"><span class="u">{'Spoken level'|gettext|strip:'&nbsp;'}</span><br>
	{foreach from=$data.LanguageSpokenLevelList item=spokenLevel}
		{$spokenLevel|dgettext:'database'|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	<td class="greenLight"><span class="u">{'Written level'|gettext|strip:'&nbsp;'}</span><br>
	{foreach from=$data.LanguageWrittenLevelList item=writtenLevel}
		{$writtenLevel|dgettext:'database'|strip:'&nbsp;'}<br>
	{/foreach}
	</td>

	{if $data.EntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=languages" title="{t}Edit section{/t}: {t}Languages{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

{* The certifications feature is disabled
{if is_array($data.CertificationsList) and count($data.CertificationsList) > 0}
	<tr valign="top">
	<td align="right"><strong>{t}Certifications{/t}</strong> : <br> </td>
	<td colspan="3" class="greenLight">
		{foreach from=$data.CertificationsList item=certification}
			{$certification}<br>
		{/foreach}
	</td>
	{if $data.EntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=certifications" title="{t}Edit section{/t}: {t}Certifications{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}
*}

{if trim($data.FreeSoftwareExperiences) neq ''}
	<tr valign="top">
	<td align="right"><strong>{'Experience with FS projects'|gettext|strip:'&nbsp;'}</strong>&nbsp;:</td>
	<td colspan="3" class="greenLight">{$data.FreeSoftwareExperiences}</td>
	{if $data.EntityId eq $smarty.session.EntityId}
	<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=projects" title="{t}Edit section{/t}: {t}Experience with FS projects{/t}">{t}edit{/t}</a></td>
	{/if}
	</tr>
{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Residence location{/t}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=location" title="{t}Edit section{/t}: {t}Residence location{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if trim($data.JobOfferCity) eq '' and trim($data.JobOfferStateProvince) eq '' and trim($data.JobOfferCountryName) eq ''}
		<tr valign="top">
		<td align="right"><strong>{t}Telecommute{/t}</strong> : </td>
		<td colspan="3" class="greenLight">{t}any location{/t}</td>
		{if $data.EntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
{else}
	{if trim($data.JobOfferCity) neq ''}
		<tr>
		<td align="right"><strong>{t}City{/t}</strong> : </td>
		<td colspan="3" class="greenLight">{$data.JobOfferCity}</td>
		{if $data.EntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}

	{if trim($data.JobOfferStateProvince) neq ''}
		<tr>
		<td align="right"><strong>{'State / Province'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
		<td colspan="3" class="greenLight">{$data.JobOfferStateProvince}</td>
		{if $data.EntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}

	{if trim($data.JobOfferCountryName) neq ''}
		<tr>
		<td align="right"><strong>{t}Country{/t}</strong> : </td>
		<td colspan="3" class="greenLight">{t domain='iso_3166'}{$data.JobOfferCountryName}{/t}</td>
		{if $data.EntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}

	{if $data.AvailableToTravel eq 'true'}
		<tr valign="top">
		<td align="right"><strong>{'Available to travel'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
		<td colspan="3" class="greenLight">{t}required{/t}</td>
		{if $data.EntityId eq $smarty.session.EntityId}
		<td class="edit"></td>
		{/if}
		</tr>
	{/if}
{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Contract{/t}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/offers?action=edit&amp;id={$smarty.get.JobOfferId}&amp;section=contract" title="{t}Edit section{/t}: {t}Contract{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if $data.ContractType neq ''}

<tr>
<td align="right"><strong>{'Contract type'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">{t domain='database'}{$data.ContractType}{/t}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{'Salary'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">
{$data.WageRank}
{t domain='iso_4217'}{$data.WageRankCurrencyName}{/t} 
{t domain='database'}{$data.WageRankByPeriod}{/t}
</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

{if trim($data.EstimatedEffort) neq '' and $data.TimeUnit neq ''}
<tr>
<td align="right"><strong>{'Estimated effort'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">
{$data.EstimatedEffort}
{t domain='database'}{$data.TimeUnit}{/t}
</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>
{/if}

{if trim($data.Deadline) neq ''}
<tr>
<td align="right"><strong>{'Deadline'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">{$data.Deadline}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>
{/if}

{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

{if $smarty.session.LoginType eq 'Person' }
	{assign var="Entity" value="person"}
{/if}
{if $smarty.session.LoginType eq 'Company' }
	{assign var="Entity" value="company"}
{/if}
{if $smarty.session.LoginType eq 'non-profit Organization' }
	{assign var="Entity" value="nonprofit"}
{/if}

<tr>
<td colspan="4" class="subsection">{t}Offered by{/t} ({t}{$data.EntityType}{/t})</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="{$Entity}" title="{t}Edit section{/t}: {t}{$data.EntityType}{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr valign="top">
<td align="right">
<strong>{t}Name{/t}</strong>&nbsp;:{if trim($data.BirthYear) neq ''}<br>
<strong>{t}Born{/t}</strong> :{/if}{if count($data.NationalityNameList) > 0 }<br>
<strong>{if count($data.NationalityNameList) == 1 }{t}Nationality{/t}{else}{t}Nationalities{/t}{/if}</strong> :{/if}{if count($data.JobLicenseAtNameList) > 0 }<br>
<strong>{'Besides license to work at'|gettext|strip:'&nbsp;'}</strong>&nbsp;:{/if}
</td>

<td colspan="2" class="greenLight">
<strong>
{if $data.EntityType eq 'Person' }
	{if trim($data.Blog) neq ''}<a href="{$data.Blog}">{else} {if trim($data.Website) neq ''}<a href="{$data.Website}">{/if} {/if}
	{if trim($data.LastName) neq '' or trim($data.MiddleName) neq ''}
		{$data.LastName} {$data.MiddleName},
	{/if}
	{$data.FirstName}{if trim($data.Blog) neq '' or trim($data.Website) neq ''}</a>{/if}
{/if}

{if $data.EntityType eq 'Company' }
	{if trim($data.Website) neq ''}<a href="{$data.Website}">{/if}
	{$data.CompanyName}
	{if trim($data.Website) neq ''}</a>{/if}
{/if}

{if $data.EntityType eq 'non-profit Organization' }
	{if trim($data.Website) neq ''}<a href="{$data.Website}">{/if}
	{$data.NonprofitName}
	{if trim($data.Website) neq ''}</a>{/if}
{/if}
</strong>
{if trim($data.BirthYear) neq ''}
<br>
{$data.BirthYear}
{/if}
{if count($data.NationalityNameList) > 0 }
<br>
{if count($data.NationalityNameList) == 1 }
{$data.NationalityNameList[0]}
{else}
{foreach from=$data.NationalityNameList item=profile key=i}{if $i == 0}{$data.NationalityNameList[$i]}{else}, {$data.NationalityNameList[$i]}{/if}{/foreach}
{/if}
{/if}
{if count($data.JobLicenseAtNameList) > 0 }
<br>
{if count($data.JobLicenseAtNameList) == 1 }
{$data.JobLicenseAtNameList[0]}
{else}
{foreach from=$data.JobLicenseAtNameList item=profile key=i}{if $i == 0}{$data.JobLicenseAtNameList[$i]}{else}, {$data.JobLicenseAtNameList[$i]}{/if}{/foreach}
{/if}
{/if}
</td>

<td class="greenLight" align="right">
{if $data.PhotoOrLogo eq 'true' }
		<img src="photo?acl=offers&amp;id={$data.EntityId}" alt="{t}Photo or logo{/t}" class="frame">
{else}
		&nbsp;
{/if}

{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}

</tr>

{*
{if $smarty.post.ViewContactInformation eq 't'}

	<!-- Address -->
	{$data.EntityStreet}{if trim($data.EntityStreet) neq '' and trim($data.EntitySuite) neq ''}, {/if}{$data.EntitySuite}<br>

	{$data.EntityPostalCode}
	{if trim($data.EntityPostalCode) neq '' and trim($data.EntityCity) neq ''} - {/if}
	{$data.EntityCity}
	{if trim($data.EntityPostalCode) neq '' or  trim($data.EntityCity) neq ''} <br> {/if}

	{$data.EntityStateProvince}{if trim($data.EntityStateProvince) neq ''}, {/if}<strong>{$data.EntityCountryName}</strong><br>

	<br>

	<!-- Other contact information -->

	{mailto address=$data.Email}<br>

	{if trim($data.Website) neq ''}
		{t}Web site{/t} <a href="{$data.Website}">{$data.Website}</a><br>
	{/if}


	<br>

	{if trim($data.Landline) neq ''}
		<strong>{t}Landline{/t}</strong>: {$data.Landline}<br>
	{/if}

	{if trim($data.MobilePhone) neq ''}
		<strong>{t}Mobile phone{/t}</strong>: {$data.MobilePhone}<br>
	{/if}

	{if trim($data.IpPhoneOrVideo) neq ''}
		<strong>{t}IP phone or videophone{/t}</strong>: {$data.IpPhoneOrVideo}
	{/if}

{else}
	<a href="XXX">{t}View contact information{/t}</a>
{/if}
*}


{if $data.EntityId neq $smarty.session.EntityId and $smarty.session.IsAlreadySubscribed neq 't' }
		<tr> <td colspan="4">&nbsp;</td> </tr> 
		<tr> <td colspan="4">&nbsp;</td> </tr> 

		<tr align="center">
		<td colspan="4" align="center">
		<form name="subscriteJobOfferForm" method="post" action="offers?id={$smarty.get.JobOfferId}">
		<div><input type="submit" name="subscribe" value="{t}Subscribe to this job offer{/t}"></div>
		</form>
		</td>
		</tr>
{/if}

</table>
