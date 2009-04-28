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

<table cellpadding="0" rules="none" border="0">

<tr>
<td class="subsection head">
{t}Looking for volunteers{/t}
</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr valign="top">
<td>
<div class="tdDark limitWidth"><strong>{$data.VacancyTitle}</strong></div>
</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/volunteers?action=edit&amp;id={$smarty.get.JobOfferId}" title="{t}Edit section{/t}: {t}Tasks{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 


<tr valign="top">
<td>
<div class="greenLight limitWidth">{$data.Description}</div>
</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/volunteers?action=edit&amp;id={$smarty.get.JobOfferId}" title="{t}Edit section{/t}: {t}Tasks{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td align="center">{t}Contact{/t}: <a href="mailto:{$data.Email}">{if $data.Email}{$data.Email}{else}{$data.WantEmail}{/if}</a> {if not $data.Email}{t}Email not verified!{/t}{/if} </td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

</table>
