{*
Authors: Davi Leal

Copyright (C) 2007 Davi Leal <davi at leals dot com>

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

<td align="center">
{if $section neq 'profiles_etc'}
<button type="submit" name="jump" value="profiles_etc" title="{t}Save and move to section{/t} {t}Academic qualification{/t}">
<img src="/themes/red_Danijel/icons/{if $checkresults.profiles_etc eq 'pass'}green{else}red{/if}-dark.png" alt=""><br>
{else}
<button type="submit" name="jump" value="profiles_etc" title="{t}Save and move to section{/t} {t}Academic qualification{/t}" disabled>
<img src="/themes/red_Danijel/icons/{if $checkresults.profiles_etc eq 'pass'}green{else}red{/if}-light.png" alt=""><br>
{/if}
{t}Profiles, etc.{/t}
</button>
</td>

<td align="center">
{if $section neq 'skills'}
<button type="submit" name="jump" value="skills" title="{t}Save and move to section{/t} {t}Skills{/t}">
<img src="/themes/red_Danijel/icons/{if $checkresults.skills eq 'pass'}green{else}red{/if}-dark.png" alt=""><br>
{else}
<button type="submit" name="jump" value="skills" title="{t}Save and move to section{/t} {t}Skills{/t}" disabled>
<img src="/themes/red_Danijel/icons/{if $checkresults.skills eq 'pass'}green{else}red{/if}-light.png" alt=""><br>
{/if}
{t}Skills{/t}
</button>
</td>

<td align="center">
{if $section neq 'languages'}
<button type="submit" name="jump" value="languages" title="{t}Save and move to section{/t} {t}Languages{/t}">
<img src="/themes/red_Danijel/icons/{if $checkresults.languages eq 'pass'}green{else}red{/if}-dark.png" alt=""><br>
{else}
<button type="submit" name="jump" value="languages" title="{t}Save and move to section{/t} {t}Languages{/t}" disabled>
<img src="/themes/red_Danijel/icons/{if $checkresults.languages eq 'pass'}green{else}red{/if}-light.png" alt=""><br>
{/if}
{t}Languages{/t}
</button>
</td>

{* The certifications feature is disabled
<td align="center">
{if $section neq 'certifications'}
<button type="submit" name="jump" value="certifications" title="{t}Save and move to section{/t} {t}Certifications{/t}">
<img src="/themes/red_Danijel/icons/{if $checkresults.certifications eq 'pass'}green{else}red{/if}-dark.png" alt=""><br>
{else}
<button type="submit" name="jump" value="certifications" title="{t}Save and move to section{/t} {t}Certifications{/t}" disabled>
<img src="/themes/red_Danijel/icons/{if $checkresults.certifications eq 'pass'}green{else}red{/if}-light.png" alt=""><br>
{/if}
{t}Certifications{/t}
</button>
</td>
*}

<td align="center">
{if $section neq 'projects'}
<button type="submit" name="jump" value="projects" title="{t}Save and move to section{/t} {t}Experience with FS projects{/t}">
<img src="/themes/red_Danijel/icons/{if $checkresults.projects eq 'pass'}green{else}red{/if}-dark.png" alt=""><br>
{else}
<button type="submit" name="jump" value="projects" title="{t}Save and move to section{/t} {t}Experience with FS projects{/t}" disabled>
<img src="/themes/red_Danijel/icons/{if $checkresults.projects eq 'pass'}green{else}red{/if}-light.png" alt=""><br>
{/if}
{t}FS projects{/t}
</button>
</td>

<td align="center">
{if $section neq 'location'}
<button type="submit" name="jump" value="location" title="{t}Save and move to section{/t} {t}Residence location{/t}">
<img src="/themes/red_Danijel/icons/{if $checkresults.location eq 'pass'}green{else}red{/if}-dark.png" alt=""><br>
{else}
<button type="submit" name="jump" value="location" title="{t}Save and move to section{/t} {t}Residence location{/t}" disabled>
<img src="/themes/red_Danijel/icons/{if $checkresults.location eq 'pass'}green{else}red{/if}-light.png" alt=""><br>
{/if}
{t}Location{/t}
</button>
</td>

{if $smarty.session.LoginType eq 'Person' } 
<td align="center">
{if $section neq 'contract'}
<button type="submit" name="jump" value="contract" title="{t}Save and move to section{/t} {t}Contract{/t}">
<img src="/themes/red_Danijel/icons/{if $checkresults.contract eq 'pass'}green{else}red{/if}-dark.png" alt=""><br>
{else}
<button type="submit" name="jump" value="contract" title="{t}Save and move to section{/t} {t}Contract{/t}" disabled>
<img src="/themes/red_Danijel/icons/{if $checkresults.contract eq 'pass'}green{else}red{/if}-light.png" alt=""><br>
{/if}
{t}Contract{/t}
</button>
</td>
{/if}

</tr>

</table>
