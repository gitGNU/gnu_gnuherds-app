{*
Authors: Davi Leal

Copyright (C) 2008, 2009 Davi Leal <davi at leals dot com>

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

<form name="dataForm" method="post" action="volunteers?action=edit&id={$smarty.get.JobOfferId}">

<table>

{if $smarty.get.JobOfferId }
<tr> <td align="center" class="mainsection">{t}Update looking for volunteers notice{/t}</td> </tr>
{else}
<tr> <td align="center" class="mainsection">{t}New looking for volunteers notice{/t}</td> </tr>
{/if}

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>


<tr> <td class="subsection">{t}Tasks{/t}</td> </tr>

<tr> <td>&nbsp;</td> </tr>

<tr> <td><span class="must">*</span><label for="VacancyTitle">{t}Short description{/t}</label></td> </tr>
{if $checks.VacancyTitle neq '' }
<tr> <td><label for="VacancyTitle" class="must">{$checks.VacancyTitle}</label></td> </tr>
{/if}
<tr> <td><input type="text" name="VacancyTitle" size="60" maxlength="100" class="required" value="{$data.VacancyTitle}"></td> </tr>

<tr> <td>&nbsp;</td> </tr>

<tr> <td><span class="must">*</span><label for="Description">{t}Description{/t}</label></td> </tr>
{if $checks.Description neq '' }
<tr> <td><label for="Description" class="must">{$checks.Description}</label></td> </tr>
{/if}
<tr> <td><textarea name="Description" rows="10" cols="60" class="required">{$data.Description}</textarea></td> </tr>


{if $smarty.session.Logged neq '1'}

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>

<tr> <td class="subsection">{t}Contact{/t}</td> </tr>

<tr> <td>&nbsp;</td> </tr>

<tr> <td><span class="must">*</span><label for="Email">{t}Email{/t}</label></td> </tr>
{if $checks.Email neq '' }
<tr> <td><label for="Email" class="must">{$checks.Email}</label></td> </tr>
{/if}
<tr> <td><input type="text" name="Email" maxlength="60" class="required" value="{$data.Email}"></td> </tr>

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>

{if $checks.Captcha eq 'Human verified'}
<tr> <td><input type="hidden" name="Captcha" value="1983"></td> </tr>
{else}
<tr> <td><span class="must">*</span><label for="Captcha">{t}Verify you are human by solving{/t}</label></td> </tr>
{if $checks.Captcha neq '' }
<tr> <td><label class="must">{$checks.Captcha}</label></td> </tr>
{/if}
<tr> <td>{t}In what year was the GNU project announced?{/t} [<a href='http://www.gnu.org/gnu/gnu-history.html'>{t}click for a hint{/t}</a>] <input type="text" name="Captcha" value="{$data.Captcha}" size="5" maxlength="5" class="required"></td> </tr>
{/if}

{/if}


<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>

<tr align="center">
<td align="center"><input type="submit" name="save" value="{t}Save{/t}" title="{t}Save and finish the edition{/t}"></td>
</tr>

</table>

</form>

