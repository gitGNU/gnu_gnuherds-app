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

<tr> <td colspan="4" class="footnote">{t escape=no 1='<span class="must">' 2='</span>'}The fields indicated with an asterisk %1*%2 are required to complete this transaction; other fields are optional.{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}CONTRACT{/t}</td> </tr>

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

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section">
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section" disabled>

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="location">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

