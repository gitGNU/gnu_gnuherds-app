{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>

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

<table align="center">

{if $smarty.session.Logged != '1' }
<tr align="center"> <td colspan="4" align="center"><h3>{t}Register company{/t}</h3></td> </tr>
{/if}

{if $smarty.session.Logged == '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}Update company data{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $smarty.session.Logged == '1' }

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match. Please try again.{/t}</span></span></td> </tr>
{/if}

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4" class="subsection">{t}Account identification{/t}</td> </tr>

{/if}

<tr valign="top">
<td align="right"><span class="must">*</span><label for="Email" class="raisePopUp" title="{t}Change the account email{/t}">Email</label></td>
<td colspan="3"> <input type="text" name="Email" id="Email" size="40" maxlength="60" class="required" value="{$data.Email}">
{if $smarty.session.WantEmail neq '' and $smarty.session.Logged eq '1'}<strong>[</strong>{$smarty.session.WantEmail}<strong>]</strong>{/if}
</td>
</tr>

{if $checks.Email neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.Email}</p></td>
</tr>
{/if}

{if $smarty.session.Logged eq '1'}

<tr>
<td align="right"><label for="Password" class="raisePopUp" title="{t}Change the account password{/t}">{t}Password{/t}</label></td>
<td colspan="3"> <input type="password" name="Password" id="Password" size="20" maxlength="20" class="notRequired" value=""> </td>
</tr>
<tr>
<td align="right"><label for="RetypePassword" class="raisePopUp" title="{t}Change the account password{/t}">{t}Retype Password{/t}</label></td>
<td colspan="3"> <input type="password" name="RetypePassword" id="RetypePassword" size="20" maxlength="20" class="notRequired" value=""> </td>
</tr>

{if $checks.Password neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.Password}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4" class="subsection">{t}Company{/t}</td> </tr>
<tr>
<td align="right"><label for="CompanyName">{t}Name{/t}</label></td>
<td> <input type="text" name="CompanyName" id="CompanyName" size="20" maxlength="30" class="notRequired" value="{$data.CompanyName}"> </td>
<th rowspan="5" width="100%">
<th rowspan="5" valign="top">
{if $data.ViewPhotoOrLogo eq 'true' }
	<img src="photo?acl=me&id={$smarty.session.EntityId}" align="left" alt="" border="0" hspace="0" vspace="0">
{else}
	<img src="/images/default/Company_or_non-profit_Organization.png" width="110" height="80" align="left" alt="" border="1" hspace="0" vspace="0">
{/if}
</tr>

<tr valign="top">
<td align="right"><label for="Website">{t}Web site{/t}</label></td>
<td> <input type="text" name="Website" id="Website" size="20" maxlength="30" class="notRequired" value="{$data.Website}"> </td>
</tr>

<tr>
<td align="right"><label for="Nationality">{t}Nationality{/t}</label></td>
<td>
<select name="Nationality" id="Nationality" class="notRequired">
{html_options values=$nationalityTwoLetter output=$nationalityNames selected=$data.Nationality}
</select>
</td>
</tr>

<tr>
<td align="right"><label for="PhotoOrLogo" class="raisePopUp" title="{t}Default image size{/t}: 180x120">{t}Photo or logo{/t}</label></td>
<td> <input type="file" name="PhotoOrLogo" id="PhotoOrLogo" class="notRequired" value="{$data.PhotoOrLogo}"> </td>
</tr>

<tr>
<td height="100%">&nbsp;</td>
<td height="100%">&nbsp;</td>
</tr>

<tr>
<th colspan="3">
<td align="center">
{if $data.ViewPhotoOrLogo eq 'true' }
	<a href="photo?action=delete"><strong>{t}Delete{/t}</strong></a>
{/if}
</td>
</tr>

<tr> <td colspan="4" class="subsection">{t}Address{/t}</td> </tr>
<tr>
<td align="right"><label for="Street">{t}Street{/t}</label></td>
<td colspan="3"> <input type="text" name="Street" id="Street" size="60" maxlength="80" class="notRequired" value="{$data.Street}"> </td>
</tr>
<tr>
<td align="right"><label for="Suite">{t}Suite{/t}</label></td>
<td colspan="3"> <input type="text" name="Suite" id="Suite" size="10" maxlength="10" class="notRequired" value="{$data.Suite}"> </td>
</tr>
<tr>
<td align="right"><label for="City">{t}City{/t}</label></td>
<td colspan="3"> <input type="text" name="City" id="City" size="30" maxlength="30" class="notRequired" value="{$data.City}"> </td>
</tr>
<tr>
<td align="right"><label for="StateProvince">{t}State / Province{/t}</label></td>
<td colspan="3"> <input type="text" name="StateProvince" id="StateProvince" size="30" maxlength="30" class="notRequired" value="{$data.StateProvince}"> </td>
</tr>
<tr>
<td align="right"><label for="PostalCode">{t}Postal code{/t}</label></td>
<td colspan="3"> <input type="text" name="PostalCode" id="PostalCode" size="15" maxlength="15" class="notRequired" value="{$data.PostalCode}"> </td>
</tr>
<tr>
<td align="right"><label for="CountryCode">{t}Country{/t}</label></td>
<td colspan="3">
<select name="CountryCode" id="CountryCode" class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames selected=$data.CountryCode}
</select>
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Interactive communication medias{/t}</td> </tr>

<tr>
<td align="right"><label for="IpPhoneOrVideo">{'IP phone or videophone'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3"> <input type="text" name="IpPhoneOrVideo" id="IpPhoneOrVideo" size="60" maxlength="255" class="notRequired" value="{$data.IpPhoneOrVideo}"> </td>
</tr>
<tr>
<td align="right"><label for="Landline">{t}Landline{/t}</label></td>
<td colspan="3"> <input type="text" name="Landline" id="Landline" size="30" maxlength="30" class="notRequired" value="{$data.Landline}"> </td>
</tr>
<tr>
<td align="right"><label for="MobilePhone">{t}Mobile phone{/t}</label></td>
<td colspan="3"> <input type="text" name="MobilePhone" id="MobilePhone" size="30" maxlength="30" class="notRequired" value="{$data.MobilePhone}"> </td>
</tr>

{/if}

<tr> <td colspan="4">&nbsp;</td> </tr> 
<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr align="center">
<td colspan="4" align="center">
<input type="submit" name="save" value="{t}{if $smarty.session.Logged == '1'}Save{else}Register{/if}{/t}">

{if $smarty.session.Logged == '1' } <!-- update -->
<br><br>
<input type="submit" name="delete" value="{t}Delete me{/t}">
{/if}

</td>
</tr>
</table>

</form>
