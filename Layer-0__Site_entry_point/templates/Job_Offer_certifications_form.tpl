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

<form name="dataForm" method="post" action="offers?action=edit&id={$smarty.get.JobOfferId}">

<table>

{if $smarty.get.JobOfferId }
<tr> <td colspan="4" align="center" class="mainsection">{t}Update job offer{/t}</td> </tr>
{else}
<tr> <td colspan="4" align="center" class="mainsection">{t}New job offer{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="center">
{include file="Job_Offer_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Technical{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $certificationsList[0]|@count >= 1}
{if $data.AllowPersonApplications eq 'true' or $data.AllowCompanyApplications eq 'true' or $data.AllowOrganizationApplications eq 'true'}

<tr valign="top">
<td align="right"><label for="CertificationsList">{t}Certifications{/t}</label><br> </td>
<td colspan="3">

<table cellspacing="0" cellpadding="0">
{foreach from=$certificationsList[0] item=certification key=i}
	{if  ( $data.AllowPersonApplications eq 'true'       and $certificationsList[1][$i] eq 't' )
	  or ( $data.AllowCompanyApplications eq 'true'      and $certificationsList[2][$i] eq 't' )
	  or ( $data.AllowOrganizationApplications eq 'true' and $certificationsList[3][$i] eq 't' )
	}
		{if is_array($data.CertificationsList) and in_array($certification, $data.CertificationsList) }
			<tr> <td> <input type="checkbox" name="CertificationsList[]" id="CertificationsList" value="{$certification}" class="notRequired" checked>{$certification}</td> </tr>
		{else}
			<tr> <td> <input type="checkbox" name="CertificationsList[]" id="CertificationsList" value="{$certification}" class="notRequired">{$certification}</td> </tr>
		{/if}
	{/if}
{/foreach}
</table>

</td>
</tr>

{/if}
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.JobOfferId neq ''}
<a href="offers?id={$smarty.session.JobOfferId}">{t}Check offer view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="{t}Save and move to the previous section{/t}">
<input type="submit" name="next" value="{t}Next{/t}" title="{t}Save and move to the next section{/t}">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="languages">
<input type="hidden" name="jump2next" value="projects">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.general neq 'pass' or $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or $checkresults.contract neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>
