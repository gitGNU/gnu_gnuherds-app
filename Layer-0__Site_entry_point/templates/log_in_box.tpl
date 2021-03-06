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

<div id="logbox">
<form name="LogForm" method="post" action="https://{$smarty.server.SERVER_NAME}/">
<div>
<input type="text" name="LoginEmail" class="in u_icon" onblur="if(this.value=='') this.value='email';" onfocus="if(this.value=='email') this.value='';" >
<br>
<input type="password" name="LoginPassword" class="in k_icon">
<input type="submit" name="login" class="pos" value="{t}Log in{/t}">
<a href="password" class="pos">{t}Lost password?{/t}</a>
</div>
</form>
</div>

<div class="quicks">
<p>
<a href="person">{t}Register person{/t}</a><br>
<a href="cooperative">{t}Register cooperative{/t}</a><br>
<a href="company">{t}Register company{/t}</a><br>
<a href="nonprofit">{t}Register non-profit{/t}</a>
</p>
</div>
