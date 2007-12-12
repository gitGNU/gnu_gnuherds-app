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

<td valign="top" bgcolor="{$webpage->theme->pageBGcolor}"> <!-- The bgcolor could be omitted after checking it with all browsers: FireFox, Epiphany, Konqueror, Opera, IE, etc. -->
<table bgcolor="{$webpage->theme->contentBGcolor}" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td><img src="{$webpage->theme->borderLeftUpImage}"  width="2" height="2" align="left" alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightUpImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>
<tr>
<td valign="top" height="450" width="650"> <!-- Set the max width. Note it resizes to lower when needed. -->

{if $smarty.post.login != '' }{* The user is asking for testing him/her account-password. *}
	{* Show the result of the logForm processing to the user *}
	<p>&nbsp;</p>
	<table align="center">
	<tr>
	<td>
	{if $smarty.session.Logged eq '1' }
		<p>{t}Log in successful{/t}</p>
	{else}
		<p>{t}Log in unsuccessful: Invalid user or password, or some problem with the data base.{/t}</p>
	{/if}
	</td>
	</tr>
	</table>
{else}
	{if $smarty.post.logout != '' }
		<p>&nbsp;</p>
		<table align="center">
		<tr>
		<td>
		<p>{t}Log out successful{/t}</p>
		</td>
		</tr>
		</table>
	{else}
		{* Show the standard page content *}
		{if $webpage->contentExceptionOutput eq '' }
			{php} $GLOBALS[webPage]->content->printOutput(); {/php}
		{else}
			<p>&nbsp;</p>
			<table align="center">
			<tr>
			<td>
			{*echo $GLOBALS[webPage]->contentExceptionOutput;*}
			{$webpage->contentExceptionOutput}
			</td>
			</tr>
			</table>
		{/if}
	{/if}
{/if}

</td>
</tr>

{if !isset($smarty.get.heading)}
<tr>
<td>&nbsp;</td>
</tr>

<tr>
<td class="tdNote" width="650">
<p class="footnote">
{t escape='no'
  1='<a href="mailto:association@gnuherds.org">association@gnuherds.org</a>'
}Please send any feedback to %1. For example, you may send reports of technical problems such as broken links, bad page rendering, etc. We would also welcome any criticisms or suggestions. GNU Herds works for you!{/t}
</p>
</td>
</tr>
{/if}

<tr>
<td><img src="{$webpage->theme->borderLeftDownImage}"  width="2" height="2" align="left" alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightDownImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>

</table>
</td>
