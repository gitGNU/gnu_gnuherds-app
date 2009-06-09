{*
Authors: Neal Coombes, Davi Leal, Victor Engmark, Sameer Naik

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Neal Coombes <Neal.Coombes at attbi dot com>
              2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
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

<div id="header"> 

<div id="logo">
{if $smarty.server.REQUEST_URI neq "/about" and $smarty.server.REQUEST_URI neq "/About.php"}
<a href="/about">
{/if}
<img src="/themes/red_Danijel/images/logo.beta.png" alt="{t}GNU Herds' logo{/t}">
{if $smarty.server.REQUEST_URI neq "/about" and $smarty.server.REQUEST_URI neq "/About.php"}
</a>
{/if}
</div>

<div id="header_title">
{t escape='no'
  1='<br>'
}Free Software%1Association{/t}
</div>

<div id="access">
<ul>
{if $smarty.session.Logged == '1' }
<li><a href="logout">{'Log out'|gettext|strip:'&nbsp;'}</a></li>
{else}
<li><a href="login">{'Log in'|gettext|strip:'&nbsp;'}</a></li>
<li><a href="register">{'Register'|gettext|strip:'&nbsp;'}</a></li>
{/if}
</ul>
</div>

<div id="float_center">
<div id="buttons">
<ul>
<li><a href="notices">{'List offers'|gettext|strip:'&nbsp;'}</a></li>
<li><a href="notices?action=edit">{'Post offer'|gettext|strip:'&nbsp;'}</a></li>
</ul>
</div>
</div>

</div>

