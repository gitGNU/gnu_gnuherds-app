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

<form name="dataForm" method="post" action="resume?action=edit&id={$smarty.get.EntityId}">

<table align="center">

{if $smarty.session.HasQualifications eq '1' }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE QUALIFICATIONS DATA{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW QUALIFICATIONS{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4">
{include file="Qualifications_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match. Please try again.{/t}</span></span></td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="right">

{if $smarty.session.LoginType neq 'Person' }
<p>{t}URIs which prove your contritutions to Free Software projects. That is to say, links to web pages: CVS web, emails which contribute patches or advices accessible from web mail listing archives, etc.{/t}</p>
{/if}

<table>
<tr>
<td>
{if $data.ContributionsListProject|@count >= 1}
<label for="DeleteContributionsList">{'Mark to delete'|gettext|strip:'&nbsp;'}</label>
{/if}
</td>
<td><label for="ContributionsListProject">{t}Project{/t}</label></td>
<td>
<label for="ContributionsListDescription">{t}Description{/t}</label>
</td>
<td>
<label for="ContributionsListURI">{t}URI{/t}</label>
</td>
</tr>


{foreach from=$data.ContributionsListProject item=Contribution key=i}

<tr valign="top">
<td align="right">
{if $data.ContributionsListProject|@count >= 1}
<input type="checkbox" name="DeleteContributionsList[]" id="DeleteContributionsList" value="{$i}">
{/if}
</td>

<td>
<input type="text" name="ContributionsListProject[]" id="ContributionsListProject" size="15" maxlength="30" value="{$data.ContributionsListProject[$i]}" class="notRequired">
{if $checks.ContributionsListProject[$i] neq '' }
<br>
<span class="must">{$checks.ContributionsListProject[$i]}</span>
{/if}
</td>

<td>
<input type="text" name="ContributionsListDescription[]" id="ContributionsListDescription" size="40" maxlength="60" value="{$data.ContributionsListDescription[$i]}" class="notRequired">
</td>

<td>
<input type="text" name="ContributionsListURI[]" id="ContributionsListURI" size="30" maxlength="255" value="{$data.ContributionsListURI[$i]}" class="notRequired">
{if $checks.ContributionsListURI[$i] neq '' }
<br>
<span class="must">{$checks.ContributionsListURI[$i]}</span>
{/if}
</td>
</tr>

{/foreach}


{if $checkresults.projects eq 'pass' or $data.ContributionsListProject|@count < 1 }

<tr valign="top">
<td>
</td>

<td>
<input type="text" name="ContributionsListProject[]" id="ContributionsListProject" size="15" maxlength="30" value="" class="notRequired">
</td>

<td>
<input type="text" name="ContributionsListDescription[]" id="ContributionsListDescription" size="40" maxlength="60" value="" class="notRequired">
</td>

<td>
<input type="text" name="ContributionsListURI[]" id="ContributionsListURI" size="30" maxlength="255" value="http://" class="notRequired">
</td>
</tr>

{/if}


<tr>
<td colspan="4" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="Save and or delete and stay here to add more languages">
</td>
</tr>
</table>

</td>
</tr>

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

{* The certifications feature is disabled
<input type="hidden" name="jump2previous" value="certifications"> *}
<input type="hidden" name="jump2previous" value="languages">
<input type="hidden" name="jump2next" value="location">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.location neq 'pass' or ( $smarty.session.LoginType eq 'Person' and $checkresults.contract neq 'pass' ) }disabled{/if}>
</td>
</tr>

</table>

</form>

