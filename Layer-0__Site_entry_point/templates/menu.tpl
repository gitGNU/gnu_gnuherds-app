{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>

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

<table bgcolor="{$webpage->theme->menuBGcolor}" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td><img src="{$webpage->theme->borderLeftUpImage}"  width="2" height="2" align="left"  alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightUpImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>
<tr>

<td>
<p>
<a href="http://{$smarty.server.HTTP_HOST}/Home.php" class="menu1" target="_top">{'Home'|gettext}</a><br>
<a href="http://{$smarty.server.HTTP_HOST}/Charter.php" class="menu1" target="_top">{'Charter (draft)'|gettext}</a><br>
<a href="http://{$smarty.server.HTTP_HOST}/Timeline.php" class="menu1" target="_top">{'Timeline'|gettext}</a><br>
<a href="http://{$smarty.server.HTTP_HOST}/GNU_Herds_Hackers_Guide.php" class="menu1" target="_top">{"Hackers' Guide"|gettext}</a><br>
<a href="http://{$smarty.server.HTTP_HOST}/FAQ.php" class="menu1" target="_top">{'FAQ'|gettext}</a><br>
</p>

{if $smarty.session.Logged eq '1'}
<p>
<span class="menu1noactive">{'Manage your data'|gettext|strip:'&nbsp;'}</span><br>

{if $smarty.session.LoginType eq 'Person' }
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/Person.php" class="menu3" target="_top">{'Person (Member)'|gettext}</a><br>
{/if}

{if $smarty.session.LoginType eq 'Company' }
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/Company.php" class="menu3" target="_top">{'Company'|gettext}</a><br>
{/if}

{if $smarty.session.LoginType eq 'non-profit Organization' }
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/non-profit_Organization.php" class="menu3" target="_top">{'non-profit Organization'|gettext|strip:'&nbsp;'}</a><br>
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/Qualifications.php" class="menu3" target="_top">{'My qualifications'|gettext|strip:'&nbsp;'}</a><br>
{else}
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/Qualifications.php" class="menu3" target="_top">{'Our qualifications'|gettext|strip:'&nbsp;'}</a><br>
{/if}
{else}
	&nbsp;&nbsp;<span class="menu3noactive">{'Your qualifications'|gettext|strip:'&nbsp;'}</span><br>
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/Manage_Job_Offers.php" class="menu3" target="_top">{'My job offers'|gettext|strip:'&nbsp;'}</a><br>
{else}
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/Manage_Job_Offers.php" class="menu3" target="_top">{'Our job offers'|gettext|strip:'&nbsp;'}</a><br>
{/if}
{else}
	&nbsp;&nbsp;<span class="menu3noactive">{'Your job offers'|gettext|strip:'&nbsp;'}</span><br>
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/View_Job_Applications_State.php" class="menu3" target="_top">{'My job applications'|gettext|strip:'&nbsp;'}</a><br>
{else}
	&nbsp;&nbsp;<a href="https://{$smarty.server.HTTP_HOST}/View_Job_Applications_State.php" class="menu3" target="_top">{'Our job applications'|gettext|strip:'&nbsp;'}</a><br>
{/if}
{else}
	&nbsp;&nbsp;<span class="menu3noactive">{'Your job applications'|gettext|strip:'&nbsp;'}</span><br>
{/if}

{* Disabled. Maybe we will remove this feature.
{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;<span class="menu3noactive">{'My qualif. searches'|gettext|strip:'&nbsp;'}</span><br>
{else}
	&nbsp;&nbsp;<span class="menu3noactive">{'Our qualif. searches'|gettext|strip:'&nbsp;'}</span><br>
{/if}
{else}
	&nbsp;&nbsp;<span class="menu3noactive">{'Your qualif. searches'|gettext|strip:'&nbsp;'}</span><br>
{/if}
*}

</p>
{/if}

<p>
<span class="menu1noactive">{'Resources'|gettext}</span><br>
	&nbsp;&nbsp;<span class="menu2noactive">{'Careers'|gettext}</span><br>
	&nbsp;&nbsp;<a href="http://{$smarty.server.HTTP_HOST}/FS_Job_Offers.php" class="menu3" target="_top">{'FS Job Offers'|gettext|strip:'&nbsp;'}</a><br>
	&nbsp;&nbsp;<a href="http://{$smarty.server.HTTP_HOST}/FS_Business_Networks.php" class="menu3" target="_top">{'FS Business Networks'|gettext|strip:'&nbsp;'}</a><br>
</p>
<p>
<span class="menu1noactive">{'Special Interest Groups'|gettext|strip:'&nbsp;'}</span><br>
	&nbsp; <a href="http://{$smarty.server.HTTP_HOST}/e-Voting_SIG.php" class="menu3" target="_top">{'e-Voting'|gettext}</a><br>
</p>
</td>

</tr>
<tr>
<td><img src="{$webpage->theme->borderLeftDownImage}"  width="2" height="2" align="left"  alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightDownImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>
</table>
