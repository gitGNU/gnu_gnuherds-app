{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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

<form name="LogForm" method="post" action="https://{$smarty.server.SERVER_NAME}/">

<table border="0" cellspacing="0" cellpadding="2" bgcolor="{$webpage->theme->loginBoxBGcolor}">
<tr>
<td align="center" class="login"><u>{'Manage your data'|gettext|strip:'&nbsp;'}</u><br><br></td>
</tr>

<tr>
<td nowrap align="left" class="login">
<label for="loginBox_Email">Email</label>
</td>
</tr>

<tr>
<td nowrap>
<input type="text" name="Email" id="loginBox_Email" size="22" class="loginControls"> <br>
</td>
</tr>

<tr>
<td nowrap align="left" class="login">
<label for="loginBox_Password">{'Password'|gettext}</label>
</td>
</tr>

<tr>
<td nowrap>
<input type="password" name="Password" id="loginBox_Password" size="22" class="loginControls"><br>
</td>
</tr>

<tr>
<td nowrap>
&nbsp;
</td>
</tr>

<tr>
<td align="center">
<input type="submit" name="login" value="{'Log in'|gettext}">
</td>
</tr>

<tr>
<td align="center" class="login">
<a href="password">{'Lost password?'|gettext|strip:'&nbsp;'}</a><br>
<br>
<a href="person">{'Register person'|gettext}</a><br>
<a href="company">{'Register company'|gettext}</a><br>
<a href="nonprofit">{'Register non-profit'|gettext}</a>
</td>
</tr>
</table>
</form>
