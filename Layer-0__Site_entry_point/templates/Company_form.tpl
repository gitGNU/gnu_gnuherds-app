{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>

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

<form name="companyForm" method="post" action="Company.php">

<table align="center">

{if $smarty.session.Logged != '1' }
<tr align="center"> <td colspan="2" align="center" class="mainsection">{t}NEW COMPANY{/t}</td> </tr>
<tr> <td colspan="2">&nbsp;</td> </tr>
{/if}

{if $smarty.session.Logged == '1' }
<tr align="center"> <td colspan="2" align="center" class="mainsection">{t}UPDATE COMPANY DATA{/t}</td> </tr>
<tr> <td colspan="2">&nbsp;</td> </tr>
{/if}

<tr> <td colspan="2" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="2">&nbsp;</td> </tr>
<tr> <td colspan="2" class="subsection">{t}ACCOUNT IDENTIFICATION{/t}</td> </tr>
<!-- Account identification -->
<tr>
<td align="right"><span class="must">*</span>email : </td>
<td> <input type="text" name="Email" size="60" maxlength="60" class="required" value="{$smarty.session.Email}"> </td>
</tr>
<tr>
<td align="right"><span class="must">*</span>{t}Password{/t} : </td>
<td> <input type="password" name="Password" size="20" maxlength="20" class="required" value="{$smarty.session.Password}"> </td>
</tr>
<tr>
<td align="right"><span class="must">*</span>{t}Retype Password{/t} : </td>
<td> <input type="password" name="RetypePassword" size="20" maxlength="20" class="required" value="{$smarty.session.Password}"> </td>
</tr>

<tr> <td colspan="2">&nbsp;</td> </tr>
<tr> <td colspan="2" class="subsection">{t}COMPANY{/t}</td> </tr>
<!-- Name -->
<tr>
<td align="right"><span class="must">*</span>{'Company name'|gettext|strip:'&nbsp;'}&nbsp;: </td>
<td> <input type="text" name="CompanyName" size="20" maxlength="30" class="required" value="{$smarty.session.CompanyName}"> </td>
</tr>
<tr valign="top">
<td align="right">{t}Company website{/t} : </td>
<td> <input type="text" name="Website" size="20" maxlength="30" class="notRequired" value="{$smarty.session.Website}"> {t}to be linked in your Job Offers. Full URL, ie.{/t}: <a href="http://lwn.net/" target="_blank">http://lwn.net/</a></td>
</tr>

<tr>
<td align="right">{t}Nationality{/t} : </td>
<td>
<select name="Nationality" class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames selected=$smarty.session.Nationality}
</select>
</td>
</tr>

<tr> <td colspan="2">&nbsp;</td> </tr>
<tr> <td colspan="2" class="subsection">{t}ADDRESS{/t}</td> </tr>
<!-- Address -->
<tr>
<td align="right">{t}Street{/t} : </td>
<td> <input type="text" name="Street" size="60" maxlength="80" class="notRequired" value="{$smarty.session.Street}"> </td>
</tr>
<tr>
<td align="right">{t}Suite{/t} : </td>
<td> <input type="text" name="Suite" size="10" maxlength="10" class="notRequired" value="{$smarty.session.Suite}"> </td>
</tr>
<tr>
<td align="right">{t}City{/t} : </td>
<td> <input type="text" name="City" size="30" maxlength="30" class="notRequired" value="{$smarty.session.City}"> </td>
</tr>
<tr>
<td align="right">{t}State / Province{/t} : </td>
<td> <input type="text" name="StateProvince" size="30" maxlength="30" class="notRequired" value="{$smarty.session.StateProvince}"> </td>
</tr>
<tr>
<td align="right">{t}Postal code{/t} : </td>
<td> <input type="text" name="PostalCode" size="15" maxlength="15" class="notRequired" value="{$smarty.session.PostalCode}"> </td>
</tr>
<tr>
<td align="right"><span class="must">*</span>{t}Country{/t} : </td>
<td>
<select name="CountryCode" class="required">
{html_options values=$countryTwoLetter output=$countryNames selected=$smarty.session.CountryCode}
</select>
</td>
</tr>

<tr> <td colspan="2">&nbsp;</td> </tr>

<tr> <td colspan="2" class="subsection">{t}INTERACTIVE COMMUNICATION MEDIAS{/t}</td> </tr>

<tr>
<td align="right">{'IP phone or videophone'|gettext|strip:'&nbsp;'}&nbsp;: </td>
<td> <input type="text" name="IpPhoneOrVideo" size="60" maxlength="255" class="notRequired" value="{$smarty.session.IpPhoneOrVideo}"> </td>
</tr>
<tr>
<td align="right">{t}Landline{/t} : </td>
<td> <input type="text" name="Landline" size="30" maxlength="30" class="notRequired" value="{$smarty.session.Landline}"> </td>
</tr>
<tr>
<td align="right">{t}Mobile phone{/t} : </td>
<td> <input type="text" name="MobilePhone" size="30" maxlength="30" class="notRequired" value="{$smarty.session.MobilePhone}"> </td>
</tr>

<tr> <td colspan="2">&nbsp;</td> </tr> 
<tr> <td colspan="2">&nbsp;</td> </tr> 
<tr> <td colspan="2">&nbsp;</td> </tr> 
<tr> <td colspan="2">&nbsp;</td> </tr> 

<tr align="center">
<td colspan="2" align="center">
<input type="reset" name="reset" value="{t}Reset form{/t}">
<input type="submit" name="cancel" value="{t}Cancel{/t}">
<input type="submit" name="save" value="{t}Save{/t}">

{if $smarty.session.Logged == '1' } <!-- update -->
<br><br>
<input type="submit" name="delete" value="{t}Delete me{/t}">
{/if}

</td>
</tr>
</table>

</form>
