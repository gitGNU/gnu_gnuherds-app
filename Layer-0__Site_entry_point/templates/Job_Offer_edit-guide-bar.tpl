{*
Authors: Davi Leal

Copyright (C) 2007, 2008 Davi Leal <davi at leals dot com>

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

<table cellpadding="0" cellspacing="0" rules="none" border="0">
<tr>

<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="general" title="{t}Save and move to section{/t} {t}General{/t}" {if $section eq 'general'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.general eq 'pass'}green{else}red{/if}-{if $section eq 'general'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}General{/t}" title="{t}Save and move to section{/t} {t}General{/t}" {if $section eq 'general'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}General{/t}</button>{/if}
</td>

<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="profiles_etc" title="{t}Save and move to section{/t} {t}Profiles{/t}" {if $section eq 'profiles_etc'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.profiles_etc eq 'pass'}green{else}red{/if}-{if $section eq 'profiles_etc'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}Profiles{/t}" title="{t}Save and move to section{/t} {t}Profiles{/t}" {if $section eq 'profiles_etc'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}Profiles{/t}</button>{/if}
</td>

<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="skills" title="{t}Save and move to section{/t} {t}Skills{/t}" {if $section eq 'skills'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.skills eq 'pass'}green{else}red{/if}-{if $section eq 'skills'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}Skills{/t}" title="{t}Save and move to section{/t} {t}Skills{/t}" {if $section eq 'skills'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}Skills{/t}</button>{/if}
</td>

<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="languages" title="{t}Save and move to section{/t} {t}Languages{/t}" {if $section eq 'languages'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.languages eq 'pass'}green{else}red{/if}-{if $section eq 'languages'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}Languages{/t}" title="{t}Save and move to section{/t} {t}Languages{/t}" {if $section eq 'languages'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}Languages{/t}</button>{/if}
</td>

{* The certifications feature is disabled
<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="certifications" title="{t}Save and move to section{/t} {t}Certifications{/t}" {if $section eq 'certifications'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.certifications eq 'pass'}green{else}red{/if}-{if $section eq 'certifications'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}Certifications{/t}" title="{t}Save and move to section{/t} {t}Certifications{/t}" {if $section eq 'certifications'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}Certifications{/t}</button>{/if}
</td>
*}

<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="projects" title="{t}Save and move to section{/t} {t}Experience with FS projects{/t}" {if $section eq 'projects'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.projects eq 'pass'}green{else}red{/if}-{if $section eq 'projects'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}FS projects{/t}" title="{t}Save and move to section{/t} {t}Experience with FS projects{/t}" {if $section eq 'projects'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}FS projects{/t}</button>{/if}
</td>

<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="location" title="{t}Save and move to section{/t} {t}Residence location{/t}" {if $section eq 'location'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.location eq 'pass'}green{else}red{/if}-{if $section eq 'location'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}Location{/t}" title="{t}Save and move to section{/t} {t}Residence location{/t}" {if $section eq 'location'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}Location{/t}</button>{/if}
</td>

<td align="center">
{if $IE_workaround == false}<button type="submit" name="jump" value="contract" title="{t}Save and move to section{/t} {t}Contract{/t}" {if $section eq 'contract'}disabled{/if}>{/if}
<img src="/themes/red_Danijel/icons/{if $checkresults.contract eq 'pass'}green{else}red{/if}-{if $section eq 'contract'}light{else}dark{/if}.png" alt="{t}{if $checkresults.general eq 'pass'}green{else}red{/if}{/t}"><br>
{if $IE_workaround == true}<input type="submit" name="jump" value="{t}Contract{/t}" title="{t}Save and move to section{/t} {t}Contract{/t}" {if $section eq 'contract'}disabled{/if}>{/if}
{if $IE_workaround == false}{t}Contract{/t}</button>{/if}
</td>

</tr>
</table>
