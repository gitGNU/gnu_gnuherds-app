{*
Authors: Davi Leal

Copyright (C) 2007 Davi Leal <davi at leals dot com>

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

<h3>{t}Skills administration{/t}</h3>

<a href="/admin?section=classify_skills" title="{t}Attend pending to classify skills{/t}">{t}Classify{/t}</a>
 | 
<a href="/admin?section=reclassify_skills" title="{t}Attend reclassify skill requests{/t}">{t}Reclassify{/t}</a>
 | 
<a href="/admin?section=add_skills" title="{t}Add new skills{/t}">{t}Add{/t}</a>

<br>
<br>

<br>

<fieldset>
<legend>
{if $smarty.get.section eq 'classify_skills' or $smarty.get.section eq '' }
{t}Attend pending to classify skills{/t}
{/if}
{if $smarty.get.section eq 'reclassify_skills' }
{t}Attend reclassify skill requests{/t}
{/if}
{if $smarty.get.section eq 'add_skills' }
{t}Add new skills{/t}
{/if}
</legend>

<br>

<form name="formLogin" method="post" action="{$smarty.server.REQUEST_URI}">
<div>

{if $smarty.get.section eq 'classify_skills' or $smarty.get.section eq '' }
{if $data.PendingSkillList|@count > 0 or $data.Skill2Process neq '' }
<label for="Skill2Process">{t}Skill{/t}</label>
<select name="Skill2Process" id="Skill2Process" {if $smarty.post.cancel eq ''}disabled{/if}>
{if $data.PendingSkillList|@count > 0 }
{html_options values=$data.PendingSkillList output=$data.PendingSkillList selected=$data.Skill2Process}
{else}
<option label="{$data.Skill2Process}" value="{$data.Skill2Process}" selected="selected">{$data.Skill2Process}</option>
{/if}
</select>
<input type="hidden" name="ShadowSkill2Process" value="{$data.Skill2Process}">
<input type="submit" name="show" value="{t}Show{/t}" {if $smarty.post.cancel eq ''}disabled{/if}>
{else}
<p>{t}There are not pending to classify skills.{/t}</p>
{/if}
{/if}

{if $smarty.get.section eq 'reclassify_skills' }
<label for="Skill2Process">{t}Skill{/t}</label>
<input type="text" name="Skill2Process" id="Skill2Process" size="40" maxlength="153" value="{$data.Skill2Process}" {if $data.Skill2Process neq ''}disabled{/if}>
<input type="hidden" name="ShadowSkill2Process" value="{$data.Skill2Process}">
<input type="submit" name="search" value="{t}Search{/t}" {if $data.Skill2Process neq ''}disabled{/if}>
{/if}

{if $smarty.get.section eq 'add_skills' }
{/if}

{if $smarty.get.section eq 'classify_skills' or $smarty.get.section eq '' or $smarty.get.section eq 'reclassify_skills' }
<br>
<br>

<br>
<br>
{/if}

{if ( ( $smarty.get.section eq 'classify_skills' or $smarty.get.section eq '' ) and $smarty.post.cancel eq '' and ( $data.PendingSkillList|@count > 0 or $data.Skill2Process neq '' ) )  or
    ( $smarty.get.section eq 'reclassify_skills' and $data.Skill2Process neq '' )  or
    $smarty.get.section eq 'add_skills' }
<table>

{if $checks.result eq 'fail' }
<tr><td colspan="2" class="footnote"><span class="must">{t}Some fields does not match.{/t} {t}Please try again.{/t}</span></span></td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
{elseif $checks.result eq 'suggestions' }
<tr><td colspan="2" class="footnote"><span class="must">{t}Some fields offer suggestions.{/t} {t}The form has not been saved yet.{/t} {t}Please, choose or edit again.{/t}</span></td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
{/if}

<tr><td colspan="2" class="subsection">{t}Skill properties{/t}</td></tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr valign="top">
<td align="right"><span class="must">*</span><label for="SkillName" class="raisePopUp" title="{t}Change the skill name{/t}">{t}Name{/t}</label></td>
<td>
<input type="text" name="SkillName" id="SkillName" size="40" maxlength="153" class="required" value="{$data.SkillName}"> <!-- Do not support automatic skill-list processing yet -->

{if count($smarty.post.SuggestedSkills[0]) >= 1 }
<br>
<span class="must">{t}Please choose:{/t}<br></span>
{html_radios name='SuggestionSet'|cat:'0' options=$smarty.post.SuggestedSkills[0] separator='<br>'}
<label><input type="radio" name="SuggestionSet{0}" value="Keep as is" />{t}Keep as is{/t}</label><br />
{/if}

{if $checks.SkillName neq '' }
<br>
<span class="must">{$checks.SkillName}</span>
{/if}

</td>
</tr>

<tr>
<td align="right"><span class="must">*</span><label for="SkillTag" class="raisePopUp" title="{t}Change the classification tag{/t}">{t}Tag{/t}</label></td>
<td>
<select name="SkillTag" id="SkillTag" class="required">
{html_options values=$skillTagsId output=$skillTagsIdTranslated selected=$data.SkillTag}
</select>

{if $checks.SkillTag neq '' }
<br>
<span class="must">{$checks.SkillTag}</span>
{/if}

</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
<td align="right"><label for="SkillType">{t}Type{/t}</label></td>
<td>
<select name="SkillType" id="SkillType" class="notRequired">
{html_options values=$setTypesSkillId output=$setTypesSkillId selected=$data.SkillType}
</select>
</td>
</tr>

<tr>
<td align="right"><label for="SkillLicenseName" class="raisePopUp" title="{t}License or licenses used by such skill{/t}">{'License name'|gettext|strip:'&nbsp;'}</label></td>
<td>
<input type="text" name="SkillLicenseName" id="SkillLicenseName" size="60" maxlength="128" class="notRequired" value="{$data.SkillLicenseName}">
</td>
</tr>

<tr>
<td align="right"><label for="SkillLicenseURL">{'License URI'|gettext|strip:'&nbsp;'}</label></td>
<td>
<input type="text" name="SkillLicenseURL" id="SkillLicenseURL" size="60" maxlength="255" class="notRequired" value="{$data.SkillLicenseURL}">
</td>
</tr>

<tr valign="top">
<td align="right"><label for="SkillClassificationRationale" class="raisePopUp" title="{t}Notes taken to make it more clear the rationale behind the current classification decision{/t}">{t}Rationale{/t}</label></td>
<td>
<textarea name="SkillClassificationRationale" id="SkillClassificationRationale" rows="8" cols="60" class="notRequired">{$data.SkillClassificationRationale}</textarea>
</td>
</tr>

<tr> <td colspan="2">&nbsp;</td> </tr>

<tr>
<td colspan="2" align="center">
<input type="submit" name="save" value="{t}Save{/t}">
{if $smarty.get.section eq 'classify_skills' or $smarty.get.section eq '' or $smarty.get.section eq 'reclassify_skills' }
&nbsp; &nbsp; &nbsp;
<input type="submit" name="cancel" value="{t}Cancel{/t}">
{/if}
</td>
</tr>

</table>
{/if}

{if $smarty.get.section eq 'reclassify_skills' and $data.Skill2Process eq '' and $smarty.post.search neq ''}
<p>{t}Not found.{/t} {t}Please, try again.{/t}</p>
{/if}

</fieldset>

</div>
</form>

