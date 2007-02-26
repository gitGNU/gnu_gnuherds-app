{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>

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

<script type="text/javascript" src="scripts/popup.js"></script>
{/literal}


<form enctype="multipart/form-data" name="nonprofitForm" method="post" action="non-profit_Organization.php">

<table align="center">

{if $smarty.session.Logged != '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW NONPROFIT ORGANIZATION{/t}</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>
{/if}

{if $smarty.session.Logged == '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE NONPROFIT ORGANIZATION{/t}</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>
{/if}

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4" class="subsection">{t}ACCOUNT IDENTIFICATION{/t}</td> </tr>
<tr>
<td align="right"><span class="must">*</span>email : </td>
<td colspan="3"> <input type="text" name="Email" size="60" maxlength="60" class="required" value="{$smarty.session.Email}"> </td>
</tr>
<tr>
<td align="right"><span class="must">*</span>{t}Password{/t} : </td>
<td colspan="3"> <input type="password" name="Password" size="20" maxlength="20" class="required" value="{$smarty.session.Password}"> </td>
</tr>
<tr>
<td align="right"><span class="must">*</span>{t}Retype Password{/t} : </td>
<td colspan="3"> <input type="password" name="RetypePassword" size="20" maxlength="20" class="required" value="{$smarty.session.Password}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4" class="subsection">{t}NONPROFIT{/t}</td> </tr>
<tr>
<td align="right"><span class="must">*</span>{t}Name{/t} : </td>
<td> <input type="text" name="NonprofitName" size="20" maxlength="30" class="required" value="{$smarty.session.NonprofitName}"> </td>
<th rowspan="5" width="100%">
<th rowspan="5">
{if $smarty.session.ViewPhotoOrLogo eq 'true' }
	<img src="/View_Photo_or_Logo.php?Data=Me&EntityId={$smarty.session.EntityId}" align="left" alt="" border="1" hspace="0" vspace="0">
{else}
	<img src="/images/default/Company_or_non-profit_Organization.png" width="180" height="120" align="left" alt="" border="1" hspace="0" vspace="0">
{/if}
</tr>

<tr valign="top">
<td align="right">{t}Web site{/t} : </td>
<td> <input type="text" name="Website" size="20" maxlength="30" class="notRequired" value="{$smarty.session.Website}"> </td>
</tr>

<tr>
<td align="right">{t}Nationality{/t} : </td>
<td>
<select name="Nationality" class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames selected=$smarty.session.Nationality}
</select>
</td>
</tr>

<tr>
<td align="right"><a href="javascript://" OnMouseOver="popup('{t}Default image size{/t}: 180x120','lightyellow',300);" OnMouseOut="kill()">{t}Photo or logo{/t}</a> : </td>
<td> <input type="file" name="PhotoOrLogo" class="notRequired" value="{$smarty.session.PhotoOrLogo}"> </td>
</tr>

<tr>
<td height="100%">&nbsp;</td>
<td height="100%">&nbsp;</td>
</tr>

<tr>
<th colspan="3">
<td align="center">
{if $smarty.session.ViewPhotoOrLogo eq 'true' }
	<a href="/Delete_Photo_or_Logo.php"><strong>{t}Delete{/t}</strong></a>
{/if}
</td>
</tr>

<tr> <td colspan="4" class="subsection">{t}ADDRESS{/t}</td> </tr>
<tr>
<td align="right">{t}Street{/t} : </td>
<td colspan="3"> <input type="text" name="Street" size="60" maxlength="80" class="notRequired" value="{$smarty.session.Street}"> </td>
</tr>
<tr>
<td align="right">{t}Suite{/t} : </td>
<td colspan="3"> <input type="text" name="Suite" size="10" maxlength="10" class="notRequired" value="{$smarty.session.Suite}"> </td>
</tr>
<tr>
<td align="right">{t}City{/t} : </td>
<td colspan="3"> <input type="text" name="City" size="30" maxlength="30" class="notRequired" value="{$smarty.session.City}"> </td>
</tr>
<tr>
<td align="right">{t}State / Province{/t} : </td>
<td colspan="3"> <input type="text" name="StateProvince" size="30" maxlength="30" class="notRequired" value="{$smarty.session.StateProvince}"> </td>
</tr>
<tr>
<td align="right">{t}Postal code{/t} : </td>
<td colspan="3"> <input type="text" name="PostalCode" size="15" maxlength="15" class="notRequired" value="{$smarty.session.PostalCode}"> </td>
</tr>
<tr>
<td align="right"><span class="must">*</span>{t}Country{/t} : </td>
<td colspan="3">
<select name="CountryCode" class="required">
{html_options values=$countryTwoLetter output=$countryNames selected=$smarty.session.CountryCode}
</select>
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}INTERACTIVE COMMUNICATION MEDIAS{/t}</td> </tr>

<tr>
<td align="right">{'IP phone or videophone'|gettext|strip:'&nbsp;'}&nbsp;: </td>
<td colspan="3"> <input type="text" name="IpPhoneOrVideo" size="60" maxlength="255" class="notRequired" value="{$smarty.session.IpPhoneOrVideo}"> </td>
</tr>
<tr>
<td align="right">{t}Landline{/t} : </td>
<td colspan="3"> <input type="text" name="Landline" size="30" maxlength="30" class="notRequired" value="{$smarty.session.Landline}"> </td>
</tr>
<tr>
<td align="right">{t}Mobile phone{/t} : </td>
<td colspan="3"> <input type="text" name="MobilePhone" size="30" maxlength="30" class="notRequired" value="{$smarty.session.MobilePhone}"> </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 
<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr align="center">
<td colspan="4" align="center">
<input type="submit" name="save" value="{t}Save{/t}">

{if $smarty.session.Logged == '1' } <!-- update -->
<br><br>
<input type="submit" name="delete" value="{t}Delete me{/t}">
{/if}

</td>
</tr>
</table>

</form>
