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

<table>

{if $smarty.session.HasQualifications eq '1' }
<tr> <td colspan="4" align="center" class="mainsection">{t}Update qualifications data{/t}</td> </tr>
{else}
<tr> <td colspan="4" align="center" class="mainsection">{t}New qualifications{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="center">
{include file="Qualifications_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match.{/t} {t}Please try again.{/t}</span></td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>
{/if}

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Contract{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="DesiredContractType">{'Desired contract type'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">
<select name="DesiredContractType" id="DesiredContractType" class="required">
{html_options values=$contractTypesId output=$contractTypesIdTranslated selected=$data.DesiredContractType}
</select>
</td>
</tr>

{if $checks.DesiredContractType neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.DesiredContractType}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"><span class="must">*</span><label for="DesiredWageRank" class="raisePopUp" title="{t}The format has to be:{/t} {t}Minimum{/t}-{t}Optimum{/t}. {t}For example:{/t} 18000-30000">{'Desired wage rank'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">
<table cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td>
<input type="text" name="DesiredWageRank" id="DesiredWageRank" size="15" maxlength="30" class="required" value="{$data.DesiredWageRank}">
</td>
<td>
<select name="WageRankCurrency" class="required">
{html_options values=$currenciesThreeLetter output=$currenciesName selected=$data.WageRankCurrency}
</select>
</td>
<td>
<select name="WageRankByPeriod" class="required">
{html_options values=$byPeriodId output=$byPeriodName selected=$data.WageRankByPeriod}
</select>
</td>
</tr>
</table>

</td>
</tr>

{if $checks.DesiredWageRank neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.DesiredWageRank}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="CurrentEmployability">{'Currently you are'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">
<select name="CurrentEmployability" id="CurrentEmployability" class="required">
{html_options values=$employabilityId output=$employabilityIdTranslated selected=$data.CurrentEmployability}
</select>
</td>
</tr>

{if $checks.CurrentEmployability neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.CurrentEmployability}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.HasQualifications eq '1' }
<a href="resume?id={$smarty.session.EntityId}">{t}Check qualifications view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="{t}Save and move to the previous section{/t}">
<input type="submit" name="next" value="{t}Next{/t}" title="{t}Save and move to the next section{/t}" disabled>

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="location">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.profiles_etc neq 'pass' or $checkresults.academic neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

