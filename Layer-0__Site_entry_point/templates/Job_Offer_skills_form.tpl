{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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

<form name="dataForm" method="post" action="offers?action=edit&id={$smarty.get.JobOfferId}">

<table align="center">

{if $smarty.get.JobOfferId }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}UPDATE JOB OFFER{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}NEW JOB OFFER{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4">
{include file="Job_Offer_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match. Please try again.{/t}</span></span></td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}TECHNICAL{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="right">

<table>
<tr>
<td>
{if $smarty.post.SkillList|@count >= 1}
<label for="DeleteSkillList">{'Mark to delete'|gettext|strip:'&nbsp;'}</label>
{/if}
</td>
<td><label class="raisePopUp" title="{t}Non-Free and Pending skills are not showed in the view{/t}">{t}Checks{/t}</label></td>
<td><label for="SkillList" class="raisePopUp" title="{t}Add skills and theirs knowledge and experience levels{/t}">{t}Skills{/t}</label></td>
<td>
<label for="SkillKnowledgeLevelList">{'Knowledge level'|gettext|strip:'&nbsp;'}</label>
</td>
<td>
<label for="SkillExperienceLevelList">{'Experience level'|gettext|strip:'&nbsp;'}</label>
</td>
</tr>


{foreach from=$smarty.post.SkillList item=Skill key=i}

<tr valign="top">
<td align="right">
{if $smarty.post.SkillList|@count >= 1}
<input type="checkbox" name="DeleteSkillList[]" id="DeleteSkillList" value="{$i}">
{/if}
</td>
<td>
{* Skills classification *}
{if $data.CheckList[$i] eq "Pending"}<label class="raisePopUp" title="{t}This skill is pending for checking{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
{if $data.CheckList[$i] eq "Unknown"}<label class="raisePopUp" title="{t}This skill is unknown{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
{if $data.CheckList[$i] eq "Abstract"}<label class="raisePopUp" title="{t}This skill is abstract{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
{* Classifying Software (programs, languages, protocols, specifications, software distributions, etc.) as Free or Non-Free Software *}
{if $data.CheckList[$i] eq "Free"}<label class="raisePopUp" title="{t}This skill is Free. Software criteria at the FAQ. Report any mistake!{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
{if $data.CheckList[$i] eq "Almost-Free"}<label class="raisePopUp" title="{t}This skill is almost Free. Software criteria at the FAQ. Report any mistake!{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
{if $data.CheckList[$i] eq "Non-Free"}<label class="raisePopUp" title="{t}This skill is not Free. Software criteria at the FAQ. Report any mistake!{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
{* Classifying Hardware *}
{if $data.CheckList[$i] eq "Hardware"}<label class="raisePopUp" title="{t}This skill is hardware{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
{* Classifying Documentation *}
{if $data.CheckList[$i] eq "Documentation"}<label class="raisePopUp" title="{t}This skill is documentation{/t}">{t}{$data.CheckList[$i]}{/t}</label>{/if}
</td>

<td>
<input type="text" name="SkillList[]" id="SkillList" size="40" maxlength="153" class="notRequired" value="{$smarty.post.SkillList[$i]}">
<input type="hidden" name="ShadowSkillList[]" value="{$smarty.post.ShadowSkillList[$i]}">
<input type="hidden" name="SkillsToInsert[]" value="{$smarty.post.SkillsToInsert[$i]}">
<input type="hidden" name="SuggestionShadow[]" value="{$smarty.post.SkillList[$i]}">

{if count($smarty.post.SuggestedSkills[$i]) >= 1 }
<br>
<span class="must">{t}Please choose one:{/t}<br></span>
{html_radios name='SuggestionSet'|cat:$i options=$smarty.post.SuggestedSkills[$i] separator='<br>'}
<label><input type="radio" name="SuggestionSet{$i}" value="Keep as is" />{t}Keep as is{/t}</label><br />
{/if}

{if $checks.SkillList[$i] neq '' }
<br>
<span class="must">{$checks.SkillList[$i]}</span>
{/if}

</td>

<td>
<select name="SkillKnowledgeLevelList[]" id="SkillKnowledgeLevelList" class="notRequired">
{html_options values=$skillKnowledgeLevelsId output=$skillKnowledgeLevelsName selected=$smarty.post.SkillKnowledgeLevelList[$i]}
</select>
{if $checks.SkillKnowledgeLevelList[$i] neq '' }
<br>
<span class="must">{$checks.SkillKnowledgeLevelList[$i]}</span>
{/if}
</td>

<td>
<select name="SkillExperienceLevelList[]" id="SkillExperienceLevelList" class="notRequired">
{html_options values=$skillExperienceLevelsId output=$skillExperienceLevelsName selected=$smarty.post.SkillExperienceLevelList[$i]}
</select>
{if $checks.SkillExperienceLevelList[$i] neq '' }
<br>
<span class="must">{$checks.SkillExperienceLevelList[$i]}</span>
{/if}
</td>
</tr>

{/foreach}


{if $checkresults.skills eq 'pass' or $smarty.post.SkillList|@count < 1 }

<tr valign="top">
<td>
</td>
<td>
</td>

<td>
<input type="text" name="SkillList[]" size="40" maxlength="153" class="notRequired" value="">
</td>

<td>
<select name="SkillKnowledgeLevelList[]" class="notRequired">
{html_options values=$skillKnowledgeLevelsId output=$skillKnowledgeLevelsName}
</select>
</td>

<td>
<select name="SkillExperienceLevelList[]" class="notRequired">
{html_options values=$skillExperienceLevelsId output=$skillExperienceLevelsName}
</select>
</td>
</tr>

{/if}


<tr>
<td colspan="5" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="Save and or delete and stay here to add more languages">
</td>
</tr>
</table>

</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.JobOfferId neq ''}
<a href="offers?id={$smarty.session.JobOfferId}">{t}Check offer view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="Save and move to the previous section">
<input type="submit" name="next" value="{t}Next{/t}" title="Save and move to the next section">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="profiles_etc">
<input type="hidden" name="jump2next" value="languages">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="Finish the edition" {if $checkresults.general neq 'pass' or $checkresults.profiles_etc neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or $checkresults.contract neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

