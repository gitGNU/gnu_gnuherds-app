{*
Authors: Davi Leal, Victor Engmark, Sameer Naik

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
              2007, 2008, 2009 Victor Engmark <victor dot engmark at gmail dot com>
              2007, 2008, 2009 Sameer Naik <sameer AT damagehead DOT com>

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

<form name="LogForm" method="post" action="https://{$smarty.server.SERVER_NAME}/login" class="marginA">
<div>

<!-- XXX:TODO: Savannah users' integration.
<label for="LoginEmail"><a href="http://savannah.gnu.org/" title="Savannah">Savannah</a> or GNU Herds identity:</label><br>
<br>
-->
<input type="text" name="LoginEmail" id="LoginEmail" class="in u_icon" onblur="if(this.value=='') this.value='email';" onfocus="if(this.value=='email') this.value='';" >
<br>
<input type="password" name="LoginPassword" class="in k_icon">
<br>

{if $checks.result neq '' }
<p class="must">{$checks.result}</p>
{/if}

<br>
<input type="submit" name="login" class="pos" value="{t}Log in{/t}">
<br>
<br>
<a href="password" class="pos">{t}Lost password?{/t}</a>

</div>
</form>

<p>&nbsp;</p>

</td>
</tr>
</table>
