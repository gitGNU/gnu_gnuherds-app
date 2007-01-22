{*
Authors: Neal Coombes, Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006 Neal Coombes <Neal.Coombes at attbi dot com>
              2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>

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

<table width="100%" cellpadding="0" cellspacing="0" rules="none" border="0">
<tr valign="top">
<td width="210" background="{$webpage->theme->headBackgroundImage}"><a href="/images/gnus-desc.html" target="_top"><img src="/images/gnus.jpg" align="left" alt="" border="0" hspace="0" vspace="0"></a></td>

<td background="{$webpage->theme->headBackgroundImage}">

<table>
<tr>

<td>
<h1>GNU Herds</h1>
<h2>{$webpage->theme->headSubtitle|gettext|strip:'&nbsp;'}</h2>
<!-- <h4 class="{$webpage->theme->headNoticeStyle}">{$webpage->theme->headNotice|gettext|strip:'&nbsp;'}</h4> -->
</td>

<td width="100%"></td>

<td>
{'Languages'|gettext}:&nbsp;<br><a href="{literal}javascript:{document.getElementById('languageForm').language.value=document.getElementById('languageForm').languageEN.value;document.getElementById('languageForm').submit();}{/literal}" title="{'English'|gettext}">English</a>,&nbsp;<a href="{literal}javascript:{document.getElementById('languageForm').language.value=document.getElementById('languageForm').languageES.value;document.getElementById('languageForm').submit();}{/literal}" title="{'Spanish'|gettext}">Espa&#x00f1;ol</a>,&nbsp;<a href="{literal}javascript:{document.getElementById('languageForm').language.value=document.getElementById('languageForm').languageIT.value;document.getElementById('languageForm').submit();}{/literal}" title="{'Italian'|gettext}">Italiano</a>

<!-- &nbsp;<a href="{literal}javascript:{document.getElementById('languageForm').language.value=document.getElementById('languageForm').languagePT_BR.value;document.getElementById('languageForm').submit();}{/literal}" title="{'Portuguese'|gettext}">Portugu&#x0ea;s</a> -->

<br>
<span class="hidden2">{'______________________________'|strip:'&nbsp;'}</span>
<br>
{t}Project state{/t}: Beta
<br>
{t escape='no'
  1='<a href="/GNU_Herds_Hackers_Guide.php" target="_top">'
  2='</a>'
}Look at the %1Hackers' Guide%2{/t}

<!-- Set the Language session variable and come back -->
<form name="languageForm" id="languageForm" method="post" action="{if !isset($smarty.server.HTTPS) or $smarty.server.HTTPS != 'on'}http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}">
<input type="hidden" name="languageEN" id="languageEN" value="en_US">
<input type="hidden" name="languageES" id="languageES" value="es_ES">
<input type="hidden" name="languageIT" id="languageIT" value="it_IT">
<input type="hidden" name="languagePT_BR" id="languagePT_BR" value="pt_BR">
<input type="hidden" name="language" id="language" value="none">

<!-- These are the post values which we must pass through at this page. -->
<input type="hidden" name="JobOfferId" value="{$smarty.post.JobOfferId}">
<input type="hidden" name="ViewEntityId" value="{$smarty.post.ViewEntityId}">
<input type="hidden" name="ViewJobOfferId" value="{$smarty.post.ViewJobOfferId}">
<input type="hidden" name="SearchWordsInFullTextQualifications" value="{$smarty.post.SearchWordsInFullTextQualifications}">

</form>
</td>

</tr>
</table>

</td>
</tr>
</table>
