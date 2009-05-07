{*
Authors: Davi Leal

Copyright (C) 2008, 2009 Davi Leal <davi at leals dot com>

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

<h3>{t}Looking for volunteers{/t}</h3>


{include file="offer-type-bar.tpl"}


<p>
{t escape='no'
  1='<a href="pledges">'
  2='</a>'
  3='<i>'
  4='</i>'
}If you would like to donate something for fulfilling a task, please create it as a %1FS pledge%2 entry instead of as a %3looking for volunteers%4 one.{/t}
</p>

<!-- XXX: DELAYED: This feature is delayed.
<p>
{t escape='no'
  1='<a href="pledges">'
  2='</a>'
  3='<i>'
  4='</i>'
}You can promise your two cents to convert some of the below volunteer entries into a %1FS pledge%2. Just open it and click "%3My pledge%4".{/t}
</p>
-->

<table class="marginA">
{include file="button-to-create-look-for-volunteers.tpl"}
</table>

<br>
<br>
<br>

<table border="0">
{include file="table-to-list-look-for-volunteers.tpl"}
</table>
