{*
Authors: Davi Leal

Copyright (C) 2009 Davi Leal <davi at leals dot com>

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

<table border="0">
<tr>
<td>

<p>&nbsp;</p>

<form name="registerForm" method="post" action="register" class="marginA">
<div>

<label>
<input type="radio" name="EntityType" value="Person" class="required" {if $data.EntityType eq 'Person'} checked {/if}>
{t}Person{/t}
</label>
<br>
<br>

<label>
<input type="radio" name="EntityType" value="Cooperative" class="required" {if $data.EntityType eq 'Cooperative'} checked {/if}>
{t}Cooperative{/t}
</label>
<br>
<br>

<label>
<input type="radio" name="EntityType" value="Company" class="required" {if $data.EntityType eq 'Company'} checked {/if}>
{t}Company{/t}
</label>
<br>
<br>

<label>
<input type="radio" name="EntityType" value="non-profit Organization" class="required" {if $data.EntityType eq 'non-profit Organization'} checked {/if}>
{t}non-profit Organization{/t}
</label>
<br>

{if $checks.EntityType neq '' }
<p class="must">{$checks.EntityType}</p>
{/if}

<br>
<br>
<br>
<br>

<label for="Email">{t}Email{/t}</label>
<input type="text" name="Email" id="Email" maxlength="60" class="required" value="{$data.Email}">

{if $checks.Email neq '' }
<p class="must">{$checks.Email}</p>
{/if}

<br>
<br>
<br>
<br>

<input type="submit" name="register" class="pos" value="{t}Register{/t}">

</div>
</form>

<p>&nbsp;</p>

</td>
</tr>
</table>
