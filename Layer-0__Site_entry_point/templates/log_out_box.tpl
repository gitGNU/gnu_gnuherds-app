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

<form name="LogForm" method="post" action="{$smarty.server.REQUEST_URI}">
<table width="155" border="0" cellspacing="0" cellpadding="2" bgcolor="{$webpage->theme->loginBoxBGcolor}">
<tr>
<td colspan="2" align="center"><span class="footnote">{'Now, you can go to the menu to manage your data'|gettext}</span><br>
<input type="submit" name="login" value="{'Log out'|gettext}">
</td>
</tr>
</table>
</form>
