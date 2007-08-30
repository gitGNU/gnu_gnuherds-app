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

<tr> <td colspan="4" class="subsection">{t}GENERAL{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"><span class="must">*</span>{t}Allow applications from{/t}</td>
<td colspan="3"> <input type="checkbox" name="AllowPersonApplications" id="AllowPersonApplications" class="required" {if $data.AllowPersonApplications eq 'true'} checked {/if} onChange="evalAcademicQualificationDisplay();"><label for="AllowPersonApplications">{t}Persons{/t}</label></td>
</tr>
<tr valign="top">
<td></td>
<td colspan="3"> <input type="checkbox" name="AllowCompanyApplications" id="AllowCompanyApplications" class="required" {if $data.AllowCompanyApplications eq 'true'} checked {/if} onChange="evalAcademicQualificationDisplay();"><label for="AllowCompanyApplications">{t}Companies{/t}</label></td>
</tr>
<tr valign="top">
<td></td>
<td colspan="3"> <input type="checkbox" name="AllowOrganizationApplications" id="AllowOrganizationApplications" class="required" {if $data.AllowOrganizationApplications eq 'true'} checked {/if} onChange="evalAcademicQualificationDisplay();"><label for="AllowOrganizationApplications">{t}non-profit Organizations{/t}</label></td>
</tr>

{if $checks.AllowApplications neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.AllowApplications}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="Vacancies">{t}Vacancies{/t}</label></td>
<td colspan="3"> <input type="text" name="Vacancies" id="Vacancies" size="3" maxlength="3" class="required" value="{$data.Vacancies}"> </td>
</tr>

{if $checks.Vacancies neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.Vacancies}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="ExpirationDate" class="raisePopUp" title="{t}The format could be for example{/t} 'dd/mm/yyyy'">{t}Expiration date{/t}</label></td>
<td colspan="3"> <input type="text" name="ExpirationDate" id="ExpirationDate" class="required" value="{$data.ExpirationDate}"> </td>
</tr>

{if $checks.ExpirationDate neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.ExpirationDate}</p></td>
</tr>
{/if}

<tr valign="top">
<td align="right"><label for="Closed">{t}The offer is closed{/t}</label></td>
<td colspan="3"> <input type="checkbox" name="Closed" id="Closed" {if $data.Closed eq 'true'} checked {/if} > </td>
</tr>

{* This is commented due to, although it is already developed, hiding the job offer employer is not good practice.
<tr valign="top">
<td align="right"><label for="HideEmployer">{t}Hide employer{/t}</label></td>
<td colspan="3"> <input type="checkbox" name="HideEmployer" id="HideEmployer" {if $data.HideEmployer eq 'true'} checked {/if} > </td>
</tr>
*}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"><label for="EmployerJobOfferReference">{t}Your offer reference{/t}</label></td>
<td colspan="3"> <input type="text" name="EmployerJobOfferReference" id="EmployerJobOfferReference" class="notRequired" value="{$data.EmployerJobOfferReference}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.JobOfferId neq ''}
<a href="offers?id={$smarty.session.JobOfferId}">{t}Check offer view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section" disabled>
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2next" value="profiles_etc">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or $checkresults.contract neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

