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

<table bgcolor="{$webpage->theme->menuBGcolor}" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>
<td><img src="{$webpage->theme->borderLeftUpImage}"  width="2" height="2" align="left"  alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightUpImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>
<tr>

<td>
<p>
{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/Home.php" and $smarty.server.REQUEST_URI neq "/index.php"}<a href="Home.php" class="menu1">{/if}{'Home'|gettext}{if $smarty.server.REQUEST_URI neq "/" and $smarty.server.REQUEST_URI neq "/Home.php" and $smarty.server.REQUEST_URI neq "/index.php"}</a>{/if}<br>
{if $smarty.server.REQUEST_URI neq "/Charter.php"}<a href="Charter.php" class="menu1">{/if}{'Charter (draft)'|gettext}{if $smarty.server.REQUEST_URI neq "/Charter.php"}</a>{/if}<br>
{if $smarty.server.REQUEST_URI neq "/Timeline.php"}<a href="Timeline.php" class="menu1">{/if}{'Timeline'|gettext}{if $smarty.server.REQUEST_URI neq "/Timeline.php"}</a>{/if}<br>
{if $smarty.server.REQUEST_URI neq "/GNU_Herds_Hackers_Guide.php"}<a href="GNU_Herds_Hackers_Guide.php" class="menu1">{/if}{"Hackers' Guide"|gettext}{if $smarty.server.REQUEST_URI neq "/GNU_Herds_Hackers_Guide.php"}</a>{/if}<br>
{if $smarty.server.REQUEST_URI neq "/FAQ.php"}<a href="FAQ.php" class="menu1">{/if}{'FAQ'|gettext}{if $smarty.server.REQUEST_URI neq "/FAQ.php"}</a>{/if}<br>
</p>

{if $smarty.session.Logged eq '1'}
<p>
<span class="menu1noactive">{'Manage your data'|gettext|strip:'&nbsp;'}</span><br>

{if $smarty.session.LoginType eq 'Person' }
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Person.php"}<a href="Person.php" class="menu3">{/if}<span class="menu3">{'Person (Member)'|gettext}</span>{if $smarty.server.REQUEST_URI neq "/Person.php"}</a>{/if}<br>
{/if}

{if $smarty.session.LoginType eq 'Company' }
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Company.php"}<a href="Company.php" class="menu3">{/if}<span class="menu3">{'Company'|gettext}</span>{if $smarty.server.REQUEST_URI neq "/Company.php"}</a>{/if}<br>
{/if}

{if $smarty.session.LoginType eq 'non-profit Organization' }
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/non-profit_Organization.php"}<a href="non-profit_Organization.php" class="menu3">{/if}<span class="menu3">{'non-profit Organization'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/non-profit_Organization.php"}</a>{/if}<br>
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Qualifications.php"}<a href="Qualifications.php" class="menu3">{/if}<span class="menu3">{'My qualifications'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/Qualifications.php"}</a>{/if}<br>
{else}
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Qualifications.php"}<a href="Qualifications.php" class="menu3">{/if}<span class="menu3">{'Our qualifications'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/Qualifications.php"}</a>{/if}<br>
{/if}
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Manage_Job_Offers.php"}<a href="Manage_Job_Offers.php" class="menu3">{/if}<span class="menu3">{'My job offers'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/Manage_Job_Offers.php"}</a>{/if}<br>
{else}
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Manage_Job_Offers.php"}<a href="Manage_Job_Offers.php" class="menu3">{/if}<span class="menu3">{'Our job offers'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/Manage_Job_Offers.php"}</a>{/if}<br>
{/if}
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/View_Job_Applications_State.php"}<a href="View_Job_Applications_State.php" class="menu3">{/if}<span class="menu3">{'My job applications'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/View_Job_Applications_State.php"}</a>{/if}<br>
{else}
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/View_Job_Applications_State.php"}<a href="View_Job_Applications_State.php" class="menu3">{/if}<span class="menu3">{'Our job applications'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/View_Job_Applications_State.php"}</a>{/if}<br>
{/if}
{/if}

{if $smarty.session.Logged eq '1' }
{if $smarty.session.LoginType eq "Person" }
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Alerts.php"}<a href="Alerts.php" class="menu3" target="_top">{/if}<span class="menu3">{'My Alerts'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/Alerts.php"}</a>{/if}<br>
{else}
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/Alerts.php"}<a href="Alerts.php" class="menu3" target="_top">{/if}<span class="menu3">{'Our Alerts'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/Alerts.php"}</a>{/if}<br>
{/if}
{/if}

</p>
{/if}

<p>
<span class="menu1noactive">{'Resources'|gettext}</span><br>
	&nbsp;&nbsp;<span class="menu2noactive">{'Careers'|gettext}</span><br>
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/FS_Job_Offers.php"}<a href="FS_Job_Offers.php" class="menu3">{/if}<span class="menu3">{'FS Job Offers'|gettext|strip:'&nbsp;'}</span>{if $smarty.server.REQUEST_URI neq "/FS_Job_Offers.php"}</a>{/if}<br>
	&nbsp;&nbsp;{if $smarty.server.REQUEST_URI neq "/FS_Business_Networks.php"}<a href="FS_Business_Networks.php" class="menu3">{/if}<span class="menu3">{'FS Business Networks'|gettext|strip:'&nbsp;'}{if $smarty.server.REQUEST_URI neq "/FS_Business_Networks.php"}</span></a>{/if}<br>
</p>
<p>
<span class="menu1noactive">{'Special Interest Groups'|gettext|strip:'&nbsp;'}</span><br>
	&nbsp;{if $smarty.server.REQUEST_URI neq "/e-Voting_SIG.php"}<a href="e-Voting_SIG.php" class="menu3">{/if}<span class="menu3">{'e-Voting'|gettext}</span>{if $smarty.server.REQUEST_URI neq "/e-Voting_SIG.php"}</a>{/if}<br>
</p>
</td>

</tr>
<tr>
<td><img src="{$webpage->theme->borderLeftDownImage}"  width="2" height="2" align="left"  alt="" border="0" hspace="0" vspace="0"></td>
<td><img src="{$webpage->theme->borderRightDownImage}" width="2" height="2" align="right" alt="" border="0" hspace="0" vspace="0"></td>
</tr>
</table>
