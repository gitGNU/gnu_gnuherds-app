{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>

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

<h3>{t}Lost password?{/t}</h3>

<p>{t}Write your email and click the Send button.{/t}</p>

<form name="formLogin" method="post" action="password">

<p>
&nbsp; &nbsp; &nbsp; &nbsp; <label for="Email">{t}Email{/t}</label>
<input type="text" name="Email" id="Email" size="40">
<input type=submit name="send" value="{t}Send{/t}">
</p>

{if $checks.Email neq '' }
<p class="must">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; {$checks.Email}
</p>
{/if}

</form>

