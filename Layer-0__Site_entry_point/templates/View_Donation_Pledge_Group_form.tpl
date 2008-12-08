{*
Authors: Davi Leal

Copyright (C) 2008 Davi Leal <davi at leals dot com>

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

<table cellpadding="0" rules="none" border="0">

{if $state.IsAlreadySubscribed eq 't' or $state.IsAlreadyDonator eq 't'}
	<tr align="center">
	<td colspan="2" align="center"><span class="modification">{t}Your email is subscribed to this notice:{/t} {if $state.IsAlreadyDonator eq 't'}{t}Donations{/t}{/if}{if $state.IsAlreadySubscribed eq 't' and $state.IsAlreadyDonator eq 't'}, {/if}{if $state.IsAlreadySubscribed eq 't'}{t}Workers{/t}{/if}</span></td>
	</tr>

	<tr> <td colspan="2">&nbsp;</td> </tr> 
	<tr> <td colspan="2">&nbsp;</td> </tr> 
{/if}


<tr>
<td class="subsection head">
{t}Donation pledge group{/t}
</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr> 

<tr valign="top">
<td>
<div class="tdDark limitWidth"><strong>{t}{$data.VacancyTitle}{/t}</strong></div>
</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"><a href="/pledges?action=edit&amp;id={$smarty.get.JobOfferId}" title="{t}Edit section{/t}: {t}Tasks{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr> 


{if $smarty.post.donate eq '' and $smarty.post.subscribe eq '' and $checks.result neq 'fail'}

<tr>
<td class="greenLight"> &nbsp; {'Last update'|gettext|strip:'&nbsp;'}&nbsp;: {$data.OfferDate}</td>
{if $data.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr> 

<tr valign="top">
<td>
<div class="greenLight limitWidth">{t}{$data.Description}{/t}</div>
</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"><a href="/pledges?action=edit&amp;id={$smarty.get.JobOfferId}" title="{t}Edit section{/t}: {t}Tasks{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td class="subsection">&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr> 


<tr>
<td>

<div>
<table>
<tr>
<td align="right"> &nbsp; &nbsp; <strong>{t}Telecommute{/t}</strong> : </td>
<td>{t}any location{/t}</td>
</tr>
<tr>
<td align="right"> &nbsp; &nbsp; <strong>{t}Estimated effort{/t}</strong> : </td>
<td>{t}unknown{/t}</td>
</tr>
<tr>
<td align="right"> &nbsp; &nbsp; <strong>{t}Deadline{/t}</strong> : </td>
<td>{t}no deadline{/t}</td>
</tr>
</table>
</div>

</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr>

{/if}


<tr>
<td class="subsection">&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td>&nbsp;</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr>


<tr>
<td>

<table cellpadding="0" rules="none" border="0" align="center">
<tr>
{assign var="Donations" value=0}
{foreach from=$data.Donators.Donation item=Donation key=i}
	{assign var="Donations" value=$Donations+$Donation }
{/foreach}
<td class="greenLight"><strong>{t}Donations{/t}</strong>&nbsp;:&nbsp;${$Donations}&nbsp;USD</td><td>&nbsp;</td><td class="greenLight">{t}Workers{/t}</td>
</tr>

<tr>
<td valign="top" style="background-color:#e0e1bf;">
<div style="width:200px; height:70px; overflow:auto; padding:0px; border:1px solid black;">
<table cellpadding="0" rules="none" border="0">
{foreach from=$data.Donators.Donation item=Donation key=i}
<tr>
<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $data.Donators.CompanyName[$i] neq ''}
	{$data.Donators.CompanyName[$i]|gettext|strip:'&nbsp;'}
{else}
{if $data.Donators.NonprofitName[$i] neq ''}
	{$data.Donators.NonprofitName[$i]|gettext|strip:'&nbsp;'}
{else}
{if $data.Donators.LastName[$i] neq '' or $data.Donators.MiddleName[$i] neq '' or $data.Donators.FirstName[$i] neq ''}
	{$data.Donators.LastName[$i]}{if trim($data.Donators.LastName[$i]) neq '' and trim($data.Donators.MiddleName[$i]) neq ''}&nbsp;{/if}{$data.Donators.MiddleName[$i]}{if trim($data.Donators.LastName[$i]) neq '' or trim($data.Donators.MiddleName[$i]) neq ''},&nbsp;{/if}{$data.Donators.FirstName[$i]}
{else}
	{'Email'|gettext|strip:'&nbsp;'}
{/if}
{/if}
{/if}

{if $state.IsAlreadySubscribed eq 't' or $state.IsAlreadyDonator eq 't'  or  $smarty.post.donate or $smarty.post.save_donation  or  $smarty.post.register_and_subscribe or $smarty.post.subscribe }
<br>
<a href="mailto:{$data.Donators.Email[$i]}">{$data.Donators.Email[$i]}</a>
{/if}

</td>
<td class="{if $i % 2}tdDark{else}tdLight{/if}">&nbsp;${$Donation}</td>
</tr>
{/foreach}
</table>
</div>
</td>

<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>

<td valign="top" style="background-color:#e0e1bf;">
<div style="width:200px; height:70px; overflow:auto; padding:0px; border:1px solid black;">
<table cellpadding="0" rules="none" border="0">
{foreach from=$data.Applications.FirstName item=Application key=i}
<tr>
<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $data.Applications.CompanyName[$i] neq ''}
	{$data.Applications.CompanyName[$i]|gettext|strip:'&nbsp;'}
{else}
{if $data.Applications.NonprofitName[$i] neq ''}
	{$data.Applications.NonprofitName[$i]|gettext|strip:'&nbsp;'}
{else}
{if $data.Applications.LastName[$i] neq '' or $data.Applications.MiddleName[$i] neq '' or $data.Applications.FirstName[$i] neq ''}
	{$data.Applications.LastName[$i]}{if trim($data.Applications.LastName[$i]) neq '' and trim($data.Applications.MiddleName[$i]) neq ''}&nbsp;{/if}{$data.Applications.MiddleName[$i]}{if trim($data.Applications.LastName[$i]) neq '' or trim($data.Applications.MiddleName[$i]) neq ''},&nbsp;{/if}{$data.Applications.FirstName[$i]}
{else}
	{'Email'|gettext|strip:'&nbsp;'}
{/if}
{/if}
{/if}

{if $state.IsAlreadySubscribed eq 't' or $state.IsAlreadyDonator eq 't'  or  $smarty.post.donate or $smarty.post.save_donation  or  $smarty.post.register_and_subscribe or $smarty.post.subscribe }
<br>
<a href="mailto:{$data.Applications.Email[$i]}">{$data.Applications.Email[$i]}</a>
{/if}

</td>
</tr>
{/foreach}
</table>
</div>
</td>
</tr>

<tr>
<td valign="top">
<br>
{if $smarty.post.subscribe eq '' and $smarty.post.register_and_subscribe eq ''} {* Do not show this donation section if we are processing the subscribe one. *}
{if $smarty.post.save_donation eq '' or $checks.result neq 'pass'} {* Do not show the donation section if you have donated right now. *}
	<form name="donateJobOfferForm" method="post" action="pledges?id={$smarty.get.JobOfferId}">
{if $smarty.post.donate neq '' or $checks.result eq 'fail'}
	<div class="splitWidth">
	<table>
	<tr> <td><span class="must">*</span><label for="WageRank">{t}Your donation{/t}: {t}in exchange for getting those tasks done{/t}</label></td> </tr>
	{if $checks.WageRank neq '' }
	<tr> <td><label for="WageRank" class="must">{$checks.WageRank}</label></td> </tr>
	{/if}
	<tr> <td><input type="text" name="WageRank" size="8" maxlength="30" class="required" value="{if $data.WageRank eq ''}0.02{else}{$data.WageRank}{/if}" onblur="if(this.value=='') this.value='0.02';" onfocus="if(this.value=='0.02') this.value='';"> {t}US Dollars (USD){/t}</td> </tr>
	{* XXX: TODO: Pending feature: <tr> <td><input type="checkbox" name="Anonymous" class="notRequired" {if $data.Anonymous eq 'true'} checked {/if}> {t}Anonymous donation{/t}</td> </tr> *}

	{if $smarty.session.Logged neq '1'}
	<tr> <td>&nbsp;</td> </tr>

	<tr> <td><span class="must">*</span><label for="Email">{t}Email{/t}</label></td> </tr>
	{if $checks.Email neq '' }
	<tr> <td><label for="Email" class="must">{$checks.Email}</label></td> </tr>
	{/if}
	<tr> <td><input type="text" name="Email" maxlength="60" class="required" value="{$data.Email}"></td> </tr>
	{/if}
	</table>
	</div>

	<br>

	<div class="splitWidth center">
	<input type="submit" name="save_donation" value="{t}donation pledge{/t}">
	</div>
{else}
	<div class="splitWidth center">
	{t escape='no'
	  1='<input type="submit" name="donate" value="'
	  2='">'
	}I want to add my %1donation pledge%2 in exchange for getting those tasks done.{/t}
	</div>
{/if}
	</form>
{/if}
{/if}
</td>

<td></td>

<td valign="top">
<br>
{if $smarty.post.donate eq '' and $smarty.post.save_donation eq ''} {* Do not show this subscribe section if we are processing the donation one. *}
{if $state.IsAlreadySubscribed neq 't' } {* Do not show the subscribe section if you are already subscribed. *}
	<form name="subscriteJobOfferForm" method="post" action="pledges?id={$smarty.get.JobOfferId}">
{if $smarty.post.subscribe neq '' or $checks.result eq 'fail'}
	<div class="splitWidth;">
	<span class="must">*</span><label for="Email">{t}Email{/t}</label><br>
	{if $checks.Email neq '' }
	<label for="Email" class="must">{$checks.Email}</label><br>
	{/if}
	<input type="text" name="Email" maxlength="60" class="required" value="{$data.Email}">
	</div>

	<br>

	<div class="splitWidth center">
	<input type="submit" name="register_and_subscribe" value="{t}I will do it{/t}">
	</div>
{else}
	<div class="splitWidth center">
	<input type="submit" name="subscribe" value="{t}I will do it{/t}"> {t}in exchange for that money.{/t}
	</div>
{/if}
	</form>
{else}
{if $state.IsAlreadySubscribed eq 't' }
	<div class="modification splitWidth justify">
{if $data.Applications.Count > 1 }
	{t}You should take note of all the above emails to contact them and join a work team. Anyway you can choose just do it yourself.{/t}<br>
	<br>
{/if}
	{t}The first team or indivual who finish all the tasks gets the money.{/t}
	</div>
{/if}
{/if}
{/if}
</td>
</tr>
</table>

</td>
{if $state.IsAlreadyDonator eq 't'}
<td class="edit"></td>
{/if}
</tr>

</table>
