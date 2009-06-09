{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>

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

<form enctype="multipart/form-data" name="companyForm" method="post" action="company">

<table>

<tr> <td colspan="3" align="center" class="mainsection">{t}Update company data{/t}</td> </tr>

<tr> <td colspan="3">&nbsp;</td> </tr>

{if $checks.result eq 'fail' }
<tr> <td colspan="3" class="footnote"><span class="must">{t}Some fields does not match.{/t} {t}Please try again.{/t}</span></span></td> </tr>
{/if}

<tr> <td colspan="3" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="3">&nbsp;</td> </tr>

<tr> <td colspan="3" class="subsection">{t}Account identification{/t}</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="Email" class="raisePopUp" title="{t}Change the account email{/t}">{t}Email{/t}</label></td>
<td colspan="2"> <input type="text" name="Email" id="Email" maxlength="60" class="required" value="{$data.Email}">
{if $smarty.session.WantEmail neq ''}<strong>[</strong>{$smarty.session.WantEmail}<strong>]</strong>{/if}
</td>
</tr>

{if $checks.Email neq '' }
<tr>
<td></td>
<td colspan="2"><p class="must">{$checks.Email}</p></td>
</tr>
{/if}

<tr>
<td align="right"><label for="Password" class="raisePopUp" title="{t}Change the account password{/t}">{t}Password{/t}</label></td>
<td colspan="2"> <input type="password" name="Password" id="Password" size="20" maxlength="20" class="notRequired" value=""> </td>
</tr>
<tr>
<td align="right"><label for="RetypePassword" class="raisePopUp" title="{t}Change the account password{/t}">{t}Retype Password{/t}</label></td>
<td colspan="2"> <input type="password" name="RetypePassword" id="RetypePassword" size="20" maxlength="20" class="notRequired" value=""> </td>
</tr>

{if $checks.Password neq '' }
<tr>
<td></td>
<td colspan="2"><p class="must">{$checks.Password}</p></td>
</tr>
{/if}

<tr> <td colspan="3">&nbsp;</td> </tr>

<tr> <td colspan="3" class="subsection">{t}Company{/t}</td> </tr>

<tr>
<td align="right"><label for="CompanyName">{t}Name{/t}</label></td>
<td> <input type="text" name="CompanyName" id="CompanyName" size="40" maxlength="80" class="notRequired" value="{$data.CompanyName}"> </td>
<th rowspan="5" valign="top" align="center">
{if $data.ViewPhotoOrLogo eq 'true' }
	<img src="photo?acl=me&id={$smarty.session.EntityId}" alt="{t}Photo or logo{/t}" class="frame">
{else}
	<img src="/themes/red_Danijel/images/company_or_non-profit.default.png" width="110" height="80" alt="{t}Photo or logo{/t}" class="frame">
{/if}
<br>
{if $data.ViewPhotoOrLogo eq 'true' }
	<a href="photo?action=delete"><strong>{t}Delete{/t}</strong></a>
{/if}
</th>
</tr>

<tr valign="top">
<td align="right"><label for="Website">{t}Web site{/t}</label></td>
<td> <input type="text" name="Website" id="Website" size="20" maxlength="30" class="notRequired" value="{$data.Website}"> </td>
</tr>

<tr>
<td align="right"><label for="PhotoOrLogo" class="raisePopUp" title="{t}Default image size{/t}: 180x120">{t}Photo or logo{/t}</label></td>
<td> <input type="file" name="PhotoOrLogo" id="PhotoOrLogo" class="notRequired" value="{$data.PhotoOrLogo}"> </td>
</tr>


<tr>
<td align="right" {if $data.NationalityList|@count >= 1}valign="top"{/if}><label for="Nationality">{t}ISO Nationalities{/t}</label></td>
<td {if $data.NationalityList|@count >= 1}class="box"{/if}>

{if $data.NationalityList|@count >= 1}

<table>
<tr>
<td colspan="2">
<label>{t}Mark to delete{/t}</label>
</td>
</tr>

{foreach from=$data.NationalityList item=Nationality key=i}
<tr valign="top">
<td align="right">
<input type="checkbox" name="DeleteNationalityList[]" value="{$i}">
</td>
<td>
<select name="NationalityList[]" {if $i == 0}id="Nationality"{/if} class="notRequired">
{html_options values=$nationalityTwoLetter output=$nationalityNames selected=$data.NationalityList[$i]}
</select>
</td>
</tr>
{/foreach}

<tr valign="top">
<td>
</td>
<td>
<select name="NationalityList[]" class="notRequired">
{html_options values=$nationalityTwoLetter output=$nationalityNames}
</select>
</td>
</tr>

<tr>
<td colspan="2" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="{t}Save and or delete and stay here to add more{/t}">
</td>
</tr>
</table>

{else}

<select name="NationalityList[]" id="Nationality" class="notRequired">
{html_options values=$nationalityTwoLetter output=$nationalityNames}
</select>
<input type="submit" name="more" value="{t}More{/t}" title="{t}Save and or delete and stay here to add more{/t}">

{/if}

</td>
</tr>


<tr>
<td align="right" {if $data.JobLicenseAtList|@count >= 1}valign="top"{/if}><label for="JobLicenseAt" class="raisePopUp" title="{t}Besides the inferred from the ISO nationalities fields{/t}">{t}License to work at{/t}</label></td>
<td {if $data.JobLicenseAtList|@count >= 1}class="box"{/if}>

{if $data.JobLicenseAtList|@count >= 1}

<table>
<tr>
<td colspan="2">
<label>{t}Mark to delete{/t}</label>
</td>
</tr>

{foreach from=$data.JobLicenseAtList item=JobLicenseAt key=i}
<tr valign="top">
<td align="right">
<input type="checkbox" name="DeleteJobLicenseAtList[]" value="{$i}">
</td>
<td>
<select name="JobLicenseAtList[]" {if $i == 0}id="JobLicenseAt"{/if} class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames selected=$data.JobLicenseAtList[$i]}
</select>
</td>
</tr>
{/foreach}

<tr valign="top">
<td>
</td>
<td>
<select name="JobLicenseAtList[]" class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames}
</select>
</td>
</tr>

<tr>
<td colspan="2" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="{t}Save and or delete and stay here to add more{/t}">
</td>
</tr>
</table>

{else}

<select name="JobLicenseAtList[]" id="JobLicenseAt" class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames}
</select>
<input type="submit" name="more" value="{t}More{/t}" title="{t}Save and or delete and stay here to add more{/t}">

{/if}

</td>
</tr>


<tr> <td colspan="3">&nbsp;</td> </tr>

<tr> <td colspan="3" class="subsection">{t}Postal address{/t}</td> </tr>
<tr>
<td align="right"><label for="Street">{t}Street{/t}</label></td>
<td colspan="2"> <input type="text" name="Street" id="Street" size="60" maxlength="80" class="notRequired" value="{$data.Street}"> </td>
</tr>
<tr>
<td align="right"><label for="Suite">{t}Suite{/t}</label></td>
<td colspan="2"> <input type="text" name="Suite" id="Suite" size="10" maxlength="10" class="notRequired" value="{$data.Suite}"> </td>
</tr>
<tr>
<td align="right"><label for="City">{t}City{/t}</label></td>
<td colspan="2"> <input type="text" name="City" id="City" size="30" maxlength="30" class="notRequired" value="{$data.City}"> </td>
</tr>
<tr>
<td align="right"><label for="PostalCode">{t}Postal code{/t}</label></td>
<td colspan="2"> <input type="text" name="PostalCode" id="PostalCode" size="15" maxlength="15" class="notRequired" value="{$data.PostalCode}"> </td>
</tr>
<tr>
<td align="right"><label for="StateProvince">{t}State / Province{/t}</label></td>
<td colspan="2"> <input type="text" name="StateProvince" id="StateProvince" size="30" maxlength="30" class="notRequired" value="{$data.StateProvince}"> </td>
</tr>
<tr>
<td align="right"><label for="CountryCode">{t}Country{/t}</label></td>
<td colspan="2">
<select name="CountryCode" id="CountryCode" class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames selected=$data.CountryCode}
</select>
</td>
</tr>

<tr> <td colspan="3">&nbsp;</td> </tr>

<tr> <td colspan="3" class="subsection">{t}Interactive communication medias{/t}</td> </tr>

<tr>
<td align="right"><label for="IpPhoneOrVideo">{'IP phone or videophone'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="2"> <input type="text" name="IpPhoneOrVideo" id="IpPhoneOrVideo" size="60" maxlength="255" class="notRequired" value="{$data.IpPhoneOrVideo}"> </td>
</tr>
<tr>
<td align="right"><label for="Landline">{t}Landline{/t}</label></td>
<td colspan="2"> <input type="text" name="Landline" id="Landline" size="30" maxlength="30" class="notRequired" value="{$data.Landline}"> </td>
</tr>
<tr>
<td align="right"><label for="MobilePhone">{t}Mobile phone{/t}</label></td>
<td colspan="2"> <input type="text" name="MobilePhone" id="MobilePhone" size="30" maxlength="30" class="notRequired" value="{$data.MobilePhone}"> </td>
</tr>

<tr> <td colspan="3">&nbsp;</td> </tr> 
<tr> <td colspan="3">&nbsp;</td> </tr> 

<tr>
<td colspan="3" align="center">
<input type="submit" name="save" value="{t}Save{/t}">

<br><br>
<input type="submit" name="delete" value="{t}Delete me{/t}">

</td>
</tr>
</table>

</form>
