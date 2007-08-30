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

<form name="dataForm" method="post" action="resume?action=edit&id={$smarty.get.EntityId}">

<table align="center">

{if $smarty.session.HasQualifications eq '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE JOB OFFER{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW JOB OFFER{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4">
{include file="Qualifications_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $smarty.session.LoginType neq 'Person' }
<tr> <td colspan="4">{t}Staff:{/t}</td> </tr>
{/if}

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
{if $smarty.session.HasQualifications eq '1' }
<a href="resume?id={$smarty.session.EntityId}">{t}Check qualifications view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section">
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="languages">
<input type="hidden" name="jump2next" value="projects">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>

