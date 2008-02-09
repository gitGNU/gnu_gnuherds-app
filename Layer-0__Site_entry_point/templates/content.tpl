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

<table id="content" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td>

{if $smarty.post.login != '' }{* The user is asking for testing him/her account-password. *}
	{* Show the result of the logForm processing to the user *}
	{if $smarty.session.Logged eq '1' }
		<p>{t}Log in successful!{/t}</p>
		<p>{t}Now, you can go to the account menu to manage your data.{/t}</p>
	{else}
		<p class="error">{t}Log in unsuccessful!{/t}</p>
		<p>{t}Invalid user or password, or some problem with the data base.{/t}</p>
	{/if}
{else}
	{if $smarty.post.logout != '' }
		<p>{t}Log out successful.{/t}</p> {* XXX: This is not being used. We redirect to the home page. *}
	{else}
		{* Show the standard page content *}
		{if $webpage->contentExceptionOutput eq '' }
			{php} $GLOBALS[webPage]->content->printOutput(); {/php}
		{else}
			{*echo $GLOBALS[webPage]->contentExceptionOutput;*}
			{$webpage->contentExceptionOutput}
		{/if}
	{/if}
{/if}

</td>
</tr>
{include file="foot.tpl"}
</table>
