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

<tr> <td colspan="4" class="subsection">{t}CONTRACT{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><span class="must">*</span><label for="ContractType">{'Contract type'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">
<select name="ContractType" id="ContractType" class="required">
{html_options values=$contractTypesId output=$contractTypesIdTranslated selected=$data.ContractType}
</select>
</td>
</tr>

{if $checks.ContractType neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.ContractType}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"><span class="must">*</span><label for="WageRank" class="raisePopUp" title="{t}The format has to be:{/t} {t}Minimum{/t}-{t}Optimum{/t}. {t}For example:{/t} 18000-30000">{'Wage rank'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">
<table cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td>
<input type="text" name="WageRank" id="WageRank" size="15" maxlength="30" class="required" value="{$data.WageRank}">
</td>
<td>
<select name="WageRankCurrency" id="WageRankCurrency" class="required">
{html_options values=$currenciesThreeLetter output=$currenciesName selected=$data.WageRankCurrency}
</select>
</td>
<td>
<select name="WageRankByPeriod" id="WageRankByPeriod" class="required">
{html_options values=$byPeriodId output=$byPeriodName selected=$data.WageRankByPeriod}
</select>
</td>
</tr>
</table>

</td>
</tr>

{if $checks.WageRank neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.WageRank}</p></td>
</tr>
{/if}

<tr>
<td align="right">{if $data.WageRankByPeriod eq 'by project'}<span class="must">*</span>{/if}<label for="EstimatedEffort" class="raisePopUp" title="{t}For example:{/t} 48-56 {t}hours{/t}">{'Estimated effort'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3">

<table cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td>
<input type="text" name="EstimatedEffort" id="EstimatedEffort" size="15" maxlength="30" class="{if $data.WageRankByPeriod eq 'by project'}required{else}notRequired{/if}" value="{$data.EstimatedEffort}">
</td>
<td>
<select name="TimeUnit" id="TimeUnit" class="{if $data.WageRankByPeriod eq 'by project'}required{else}notRequired{/if}">
{html_options values=$timeUnitsId output=$timeUnitsName selected=$data.TimeUnit}
</select>
</td>
</tr>
</table>

</td>
</tr>

{if $checks.EstimatedEffort neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.EstimatedEffort}</p></td>
</tr>
{/if}

<tr>
<td align="right"><label for="Deadline" class="raisePopUp" title="{t}The format could be for example{/t} 'dd/mm/yyyy'">{'Deadline'|gettext|strip:'&nbsp;'}</label></td>
<td colspan="3"> <input type="text" name="Deadline" id="Deadline" size="15" class="notRequired" value="{$data.Deadline}"> </td>
</tr>

{if $checks.Deadline neq '' }
<tr>
<td></td>
<td colspan="3"><p class="must">{$checks.Deadline}</p></td>
</tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.JobOfferId neq ''}
<a href="offers?id={$smarty.session.JobOfferId}">{t}Check offer view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section">
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section" disabled>

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="location">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.general neq 'pass' or $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

