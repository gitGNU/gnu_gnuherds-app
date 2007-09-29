{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

This program is free software; you can redistribute it and/or modify it under
the terms of the Affero General Public License as published by Affero Inc.,
either version 1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful to the Free
Software community, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
General Public License for more details.

You should have received a copy of the Affero General Public License with this
software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
Suite 225, San Francisco, CA 94107, USA
*}

<table bgcolor="{$webpage->theme->menuBGcolor}" width="155" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td><img src="{$webpage->theme->borderLeftUpImage}"  width="2" height="2" align="left"  alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightUpImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>
<tr>

<td>
<p>
{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/index.php"}<a href="/" class="menu1">{/if}{'Home'|gettext}{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/index.php"}</a>{/if}<br>
{if $smarty.server.REQUEST_URI neq "/charter"}<a href="charter" class="menu1">{/if}{'Charter (draft)'|gettext}{if $smarty.server.REQUEST_URI neq "/charter"}</a>{/if}<br>
{if $smarty.server.REQUEST_URI neq "/development"}<a href="development" class="menu1">{/if}{"Hackers' Guide"|gettext}{if $smarty.server.REQUEST_URI neq "/development"}</a>{/if}<br>
{if $smarty.server.REQUEST_URI neq "/faq"}<a href="faq" class="menu1">{/if}{'FAQ'|gettext}{if $smarty.server.REQUEST_URI neq "/faq"}</a>{/if}<br>
</p>

{if $smarty.session.Logged eq '1'}
<p>
<span class="menu1noactive">{'Manage your data'|gettext|strip:'&nbsp;'}</span><br>

{if $smarty.session.LoginType eq 'Person' }
	&nbsp;&nbsp;<a href="person" class="menu3">{'Person'|gettext}</a><br>
{/if}

{if $smarty.session.LoginType eq 'Company' }
	&nbsp;&nbsp;<a href="company" class="menu3">{'Company'|gettext}</a><br>
{/if}

{if $smarty.session.LoginType eq 'non-profit Organization' }
	&nbsp;&nbsp;<a href="nonprofit" class="menu3">{'non-profit Organization'|gettext|strip:'&nbsp;'}</a><br>
{/if}

{if $smarty.session.Logged eq '1' }

{if $smarty.session.HasQualifications eq '1' }
	{assign var="url" value="resume?id=`$smarty.session.EntityId`"}
{else}
	{assign var="url" value="resume?action=edit&id=&section=profiles_etc"}
{/if}

{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;<a href="{$url}" class="menu3">{'My qualifications'|gettext|strip:'&nbsp;'}</a><br>
{else}
	&nbsp;&nbsp;<a href="{$url}" class="menu3">{'Our qualifications'|gettext|strip:'&nbsp;'}</a><br>
{/if}
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;<a href="offers?owner=me" class="menu3">{'My job offers'|gettext|strip:'&nbsp;'}</a><br>
{else}
	&nbsp;&nbsp;<a href="offers?owner=me" class="menu3">{'Our job offers'|gettext|strip:'&nbsp;'}</a><br>
{/if}
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;<a href="applications" class="menu3">{'My job applications'|gettext|strip:'&nbsp;'}</a><br>
{else}
	&nbsp;&nbsp;<a href="applications" class="menu3">{'Our job applications'|gettext|strip:'&nbsp;'}</a><br>
{/if}
{/if}

{if $smarty.session.Logged eq '1' }
	&nbsp;&nbsp;<a href="settings" class="menu3" target="_top">{'Settings'|gettext|strip:'&nbsp;'}</a><br>
{/if}

</p>
{/if}

<p>
<span class="menu1noactive">{'Resources'|gettext}</span><br>
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/offers"}<a href="offers" class="menu3">{/if}<span class="menu3">{'FS Job Offers'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/offers"}</a>{/if}<br>
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/business_models"}<a href="business_models" class="menu3">{/if}<span class="menu3">{'FS Business Models'|gettext|strip:'&nbsp;'}{if $smarty.server.REQUEST_URI neq "/business_models"}</span></a>{/if}<br>
</p>
</td>

</tr>
<tr>
<td><img src="{$webpage->theme->borderLeftDownImage}"  width="2" height="2" align="left"  alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightDownImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>
</table>
