/*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>

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
*/


function SelectAllItems()
{
	for (i=0; i<document.qualificationsForm.SkillList.length; i++)
		document.qualificationsForm.SkillList.options[i].selected = true;
	for (i=0; i<document.qualificationsForm.SkillKnowledgeLevelList.length; i++)
		document.qualificationsForm.SkillKnowledgeLevelList.options[i].selected = true;
	for (i=0; i<document.qualificationsForm.SkillExperienceLevelList.length; i++)
		document.qualificationsForm.SkillExperienceLevelList.options[i].selected = true;

	for (i=0; i<document.qualificationsForm.LanguageList.length; i++)
		document.qualificationsForm.LanguageList.options[i].selected = true;
	for (i=0; i<document.qualificationsForm.LanguageSpokenLevelList.length; i++)
		document.qualificationsForm.LanguageSpokenLevelList.options[i].selected = true;
	for (i=0; i<document.qualificationsForm.LanguageWrittenLevelList.length; i++)
		document.qualificationsForm.LanguageWrittenLevelList.options[i].selected = true;

	for (i=0; i<document.qualificationsForm.ContributionsListProject.length; i++) 
		document.qualificationsForm.ContributionsListProject.options[i].selected = true;
	for (i=0; i<document.qualificationsForm.ContributionsListDescription.length; i++) 
		document.qualificationsForm.ContributionsListDescription.options[i].selected = true;
	for (i=0; i<document.qualificationsForm.ContributionsListURI.length; i++) 
		document.qualificationsForm.ContributionsListURI.options[i].selected = true;
}

function InitializationOnLoad()
{
	// Visible skill list
	for (i=0; i<document.qualificationsForm.SkillList.length; i++) 
	{
		document.qualificationsForm.Skill.value = document.qualificationsForm.SkillList[i].value;
		document.qualificationsForm.skillKnowledgeLevel.value = document.qualificationsForm.SkillKnowledgeLevelList[i].value;
		document.qualificationsForm.skillExperienceLevel.value = document.qualificationsForm.SkillExperienceLevelList[i].value;
		document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.options.length] = new Option( document.qualificationsForm.Skill.options[document.qualificationsForm.Skill.selectedIndex].label +' '+ document.qualificationsForm.skillKnowledgeLevel.options[document.qualificationsForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.qualificationsForm.skillExperienceLevel.options[document.qualificationsForm.skillExperienceLevel.selectedIndex].label, document.qualificationsForm.Skill.options[document.qualificationsForm.Skill.selectedIndex].label +' '+ document.qualificationsForm.skillKnowledgeLevel.options[document.qualificationsForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.qualificationsForm.skillExperienceLevel.options[document.qualificationsForm.skillExperienceLevel.selectedIndex].label );
	}
	if (document.qualificationsForm.SkillList.length>0) {
		document.qualificationsForm.ViewSkillList.selectedIndex = 0;
		UpdateWithSelectedSkill();
		document.qualificationsForm.ViewSkillList.options[0].selected = false;
	}

	// Visible language list
	for (i=0; i<document.qualificationsForm.LanguageList.length; i++) 
	{
		document.qualificationsForm.Language.value = document.qualificationsForm.LanguageList[i].value;
		document.qualificationsForm.languageSpokenLevel.value = document.qualificationsForm.LanguageSpokenLevelList[i].value;
		document.qualificationsForm.languageWrittenLevel.value = document.qualificationsForm.LanguageWrittenLevelList[i].value;
		document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.options.length] = new Option( document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label +' '+ document.qualificationsForm.languageSpokenLevel.options[document.qualificationsForm.languageSpokenLevel.selectedIndex].label +' '+ document.qualificationsForm.languageWrittenLevel.options[document.qualificationsForm.languageWrittenLevel.selectedIndex].label, document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label +' '+ document.qualificationsForm.languageSpokenLevel.options[document.qualificationsForm.languageSpokenLevel.selectedIndex].label +' '+ document.qualificationsForm.languageWrittenLevel.options[document.qualificationsForm.languageWrittenLevel.selectedIndex].label );

		document.qualificationsForm.LanguageList[i].text = document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label;
	}
	if (document.qualificationsForm.LanguageList.length>0) {
		document.qualificationsForm.ViewLanguageList.selectedIndex = 0;
		UpdateWithSelectedItem();
		document.qualificationsForm.ViewLanguageList.options[0].selected = false;
	}

	// Visible contribution list
	for (i=0; i<document.qualificationsForm.ContributionsListProject.length; i++) 
	{
		document.qualificationsForm.VisibleContributionsList.options[document.qualificationsForm.VisibleContributionsList.options.length] = new Option( document.qualificationsForm.ContributionsListProject[i].text + " " + document.qualificationsForm.ContributionsListDescription[i].text, document.qualificationsForm.ContributionsListProject[i].text + " " + document.qualificationsForm.ContributionsListDescription[i].text );
	}
}

