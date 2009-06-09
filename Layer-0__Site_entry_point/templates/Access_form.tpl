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

<ul id="tablist">
<li><a {if $smarty.server.SCRIPT_URL neq "/register"} class="current" {/if} href="login">{t}Log in{/t}</a></li>
<li><a {if $smarty.server.SCRIPT_URL  eq "/register"} class="current" {/if} href="register">{t}Register{/t}</a></li>
</ul>

<div id="tab">
{if     $smarty.server.SCRIPT_URL neq "/register"} {include file="Access_log_in_form.tpl"}
{elseif $smarty.server.SCRIPT_URL  eq "/register"} {include file="Access_register_form.tpl"}
{else}
	{t}ERROR: Unexpected condition{/t}
{/if}
</div>

<br>
<br>
<br>
