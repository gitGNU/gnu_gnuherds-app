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

<table cellpadding="0" rules="none" border="0">

{if $smarty.get.EntityId eq $smarty.session.EntityId and $data.CompletedEdition eq 'f' }
	<tr align="center">
	<td colspan="5" align="center"><span class="modification">{t}The edition of these qualifications is not finished! It does not comply the minimum requisites to allow it subscribe to offers.{/t}</span></td>
	</tr>

	<tr> <td colspan="5">&nbsp;</td> </tr> 
	<tr> <td colspan="5">&nbsp;</td> </tr> 
{/if}

<tr valign="top">
{if $data.PhotoOrLogo eq 'true' }
<td><img src="photo?acl=resume&amp;id={$smarty.get.EntityId}" alt="{t}Photo or logo{/t}" class="frame"></td>
{/if}
<td colspan="3">

{t}{$data.EntityType}{/t}:

{if $data.EntityType eq 'Person' }
	<!-- Person's name -->
	<strong>
	{if trim($data.LastName) neq '' or trim($data.MiddleName) neq '' }
		{$data.LastName} {$data.MiddleName},
	{/if}
	{$data.FirstName}
	</strong>
	<br>

	<!-- Person's birth year -->
	{if trim($data.BirthYear) neq ''}
		{t}Born{/t}: <strong>{$data.BirthYear}</strong><br>
	{/if}
{/if}

{if $data.EntityType eq 'Company' and trim($data.CompanyName) neq ''}
	<!-- Company's name -->
	<strong>{$data.CompanyName}</strong><br>
{/if}

{if $data.EntityType eq 'non-profit Organization' and trim($data.NonprofitName) neq ''}
	<!-- non-profit Organization's name -->
	<strong>{$data.NonprofitName}</strong><br>
{/if}

{if trim($data.Nationality) neq ''}
	<!-- Nationality -->
	{t}Nationality{/t}: <strong>{t}{$data.NationalityName}{/t}</strong><br>
{/if}

<br>

<!-- Address -->
{if trim($data.Street) neq ''}{$data.Street}{if trim($data.Street) neq '' and trim($data.Suite) neq ''}, {/if}{$data.Suite}<br>{/if}

{if trim($data.PostalCode) neq ''}{$data.PostalCode}{/if}
{if trim($data.PostalCode) neq '' and trim($data.City) neq ''} - {/if}
{if trim($data.City) neq ''}{$data.City}{/if}
{if trim($data.PostalCode) neq '' or  trim($data.City) neq ''} <br> {/if}

{if trim($data.StateProvince) neq ''}{$data.StateProvince}{if trim($data.StateProvince) neq ''}, {/if}{if trim($data.CountryName) neq ''}<strong>{t}{$data.CountryName}{/t}</strong><br>{/if}{/if}

<br>

<!-- Other contact information -->

{mailto address=$data.Email}<br>

{if trim($data.Website) neq ''}
	{t}web site{/t} <a href="{$data.Website}">{$data.Website}</a><br>
{/if}


<br>

{if trim($data.Landline) neq ''}
	<strong>{t}Landline{/t}</strong>: {$data.Landline}<br>
{/if}

{if trim($data.MobilePhone) neq ''}
	<strong>{t}Mobile phone{/t}</strong>: {$data.MobilePhone}<br>
{/if}

{if trim($data.IpPhoneOrVideo) neq ''}
	<strong>{t}IP phone or videophone{/t}</strong>: {$data.IpPhoneOrVideo}<br>
{/if}

</td>

{if $data.PhotoOrLogo neq 'true' }
<td>&nbsp;</td>
{/if}

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

<td class="edit"><a href="{$Entity}" title="{t}Edit section{/t}: {t}{$data.EntityType}{/t}">{t}edit{/t}</a></td>

{/if}

</tr>


<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Technical{/t}</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Technical{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{'Professional experience since'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">{$data.ProfessionalExperienceSinceYear}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Professional experience since{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

{if $data.EntityType eq 'Person' }
<tr>
<td align="right"><strong>{t}Academic qualification{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{if trim($data.AcademicQualification) neq '' or trim($data.AcademicQualificationDescription) neq ''}
	{if trim($data.AcademicQualification) neq ''}
		{t}{$data.AcademicQualification}{/t}{if trim($data.AcademicQualificationDescription) neq ''}, {/if}
	{/if}

	{if trim($data.AcademicQualificationDescription) neq ''}({$data.AcademicQualificationDescription}){/if}
{else}
	{t}none{/t}
{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Academic qualification{/t}">{t}edit{/t}</a></td>
{/if}
</tr>
{/if}

<tr valign="top">
<td align="right"><strong>{t}Profiles{/t}</strong> : </td>

<td class="greenLight"><span class="u">{'Product profiles'|gettext|strip:'&nbsp;'}</span><br>
{if not is_array($data.ProductProfileList) or count($data.ProductProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$data.ProductProfileList item=profile}
		{$profile|gettext|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

<td class="greenLight"><span class="u">{'Professional profiles'|gettext|strip:'&nbsp;'}</span><br>
{if not is_array($data.ProfessionalProfileList) or count($data.ProfessionalProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$data.ProfessionalProfileList item=profile}
		{$profile|gettext|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

<td class="greenLight"><span class="u">{'Field profiles'|gettext|strip:'&nbsp;'}</span><br>
{if not is_array($data.FieldProfileList) or count($data.FieldProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$data.FieldProfileList item=profile}
		{$profile|gettext|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Profiles{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

<tr valign="top">
<td align="right"><strong>{t}Skills{/t}</strong> : </td>

{if not is_array($data.SkillList) or count($data.SkillList) == 0}
	<td class="greenDark">{t}none{/t}</td> <td class="greenDark"></td> <td class="greenDark"></td>
{else}
<td class="greenDark"><span class="u">{t}Skill{/t}</span><br>
{foreach from=$data.SkillList item=skill}
	{$skill|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenDark"><span class="u">{'Knowledge level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.KnowledgeLevelList item=knowledgeLevel}
	{$knowledgeLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenDark"><span class="u">{'Experience level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.ExperienceLevelList item=experienceLevel}
	{$experienceLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

{/if}

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=skills" title="{t}Edit section{/t}: {t}Skills{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

<tr valign="top">
<td align="right"><strong>{t}Languages{/t}</strong> : </td>

<td class="greenLight"><span class="u">{t}Language{/t}</span><br>
{foreach from=$data.LanguageList item=language}
	{$language|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenLight"><span class="u">{'Spoken level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.LanguageSpokenLevelList item=spokenLevel}
	{$spokenLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenLight"><span class="u">{'Written level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.LanguageWrittenLevelList item=writtenLevel}
	{$writtenLevel|gettext|strip:'&nbsp;'}<br>
{/foreach}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=languages" title="{t}Edit section{/t}: {t}Languages{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

{* The certifications feature is disabled
<tr valign="top">
<td align="right"><strong>{t}Certifications{/t}</strong> : <br> </td>
<td colspan="3" class="greenDark">
{if is_array($data.CertificationsList) and count($data.CertificationsList) > 0}
	{foreach from=$data.CertificationsList item=certification key=i}
		{if $data.CertificationsStateList[$i] eq 'Accepted'}
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
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=certifications" title="{t}Edit section{/t}: {t}Certifications{/t}">{t}edit{/t}</a></td>
{/if}

</tr>
*}

<tr valign="top">
<td align="right"><strong>{'Contributions to FS projects'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenDark">
{if is_array($data.ContributionsListProject) and count($data.ContributionsListProject) > 0 }
	{foreach from=$data.ContributionsListProject item=project key=i}
		<a href="{$data.ContributionsListURI[$i]}">{$project}</a>{if $data.ContributionsListDescription[$i] neq ''}: {$data.ContributionsListDescription[$i]}{/if}<br>
	{/foreach}
{else}
	{t}none{/t}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=projects" title="{t}Edit section{/t}: {t}Contributions to FS projects{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

{if $data.EntityType eq 'Person' }

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Contract{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=contract" title="{t}Edit section{/t}: {t}Contract{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Desired contract type{/t}</strong> : </td>
<td colspan="3" class="greenLight">{t}{$data.DesiredContractType}{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Desired wage rank{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{$data.DesiredWageRank}
({t}{$data.WageRankCurrencyName}{/t})
{t}{$data.WageRankByPeriod}{/t}{if trim($data.DesiredWageRank) neq ''}. [{t}Minimum{/t}-{t}Optimum{/t}]{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Current employability{/t}</strong> : </td>
<td colspan="3" class="greenLight">{t}{$data.CurrentEmployability}{/t}</td>
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
<td colspan="4" class="subsection">{t}Location{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=location" title="{t}Edit section{/t}: {t}Location{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{t}Available to travel{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{if $data.AvailableToTravel eq 'false'}
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
{if $data.AvailableToChangeResidence eq 'false'}
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
		<div><input type="submit" name="delete" value="{t}Delete qualifications{/t}" title="{t}Delete qualifications from the data base{/t}"></div>
		</form>
		</td>
		</tr>
{/if}

</table>
