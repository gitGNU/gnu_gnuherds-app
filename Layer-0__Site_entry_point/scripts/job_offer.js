/*
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
*/


function SelectAllItems()
{
	for (i=0; i<document.jobOfferForm.SkillList.length; i++)
		document.jobOfferForm.SkillList.options[i].selected = true;
	for (i=0; i<document.jobOfferForm.SkillKnowledgeLevelList.length; i++)
		document.jobOfferForm.SkillKnowledgeLevelList.options[i].selected = true;
	for (i=0; i<document.jobOfferForm.SkillExperienceLevelList.length; i++)
		document.jobOfferForm.SkillExperienceLevelList.options[i].selected = true;

	for (i=0; i<document.jobOfferForm.LanguageList.length; i++)
		document.jobOfferForm.LanguageList.options[i].selected = true;
	for (i=0; i<document.jobOfferForm.LanguageSpokenLevelList.length; i++)
		document.jobOfferForm.LanguageSpokenLevelList.options[i].selected = true;
	for (i=0; i<document.jobOfferForm.LanguageWrittenLevelList.length; i++)
		document.jobOfferForm.LanguageWrittenLevelList.options[i].selected = true;
}

function InitializationOnLoad()
{
	// Visible skill list
	for (i=0; i<document.jobOfferForm.SkillList.length; i++) 
	{
		document.jobOfferForm.Skill.value = document.jobOfferForm.SkillList[i].value;
		document.jobOfferForm.skillKnowledgeLevel.value = document.jobOfferForm.SkillKnowledgeLevelList[i].value;
		document.jobOfferForm.skillExperienceLevel.value = document.jobOfferForm.SkillExperienceLevelList[i].value;
		document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.options.length] = new Option( document.jobOfferForm.Skill.options[document.jobOfferForm.Skill.selectedIndex].label +' '+ document.jobOfferForm.skillKnowledgeLevel.options[document.jobOfferForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.jobOfferForm.skillExperienceLevel.options[document.jobOfferForm.skillExperienceLevel.selectedIndex].label, document.jobOfferForm.Skill.options[document.jobOfferForm.Skill.selectedIndex].label +' '+ document.jobOfferForm.skillKnowledgeLevel.options[document.jobOfferForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.jobOfferForm.skillExperienceLevel.options[document.jobOfferForm.skillExperienceLevel.selectedIndex].label );
	}
	if (document.jobOfferForm.SkillList.length>0) {
		document.jobOfferForm.ViewSkillList.selectedIndex = 0;
		UpdateWithSelectedSkill(false);
		document.jobOfferForm.ViewSkillList.options[0].selected = false;
	}

	// Visible language list
	for (i=0; i<document.jobOfferForm.LanguageList.length; i++) 
	{
		document.jobOfferForm.Language.value = document.jobOfferForm.LanguageList[i].value;
		document.jobOfferForm.languageSpokenLevel.value = document.jobOfferForm.LanguageSpokenLevelList[i].value;
		document.jobOfferForm.languageWrittenLevel.value = document.jobOfferForm.LanguageWrittenLevelList[i].value;
		document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.options.length] = new Option( document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label +' '+ document.jobOfferForm.languageSpokenLevel.options[document.jobOfferForm.languageSpokenLevel.selectedIndex].label +' '+ document.jobOfferForm.languageWrittenLevel.options[document.jobOfferForm.languageWrittenLevel.selectedIndex].label, document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label +' '+ document.jobOfferForm.languageSpokenLevel.options[document.jobOfferForm.languageSpokenLevel.selectedIndex].label +' '+ document.jobOfferForm.languageWrittenLevel.options[document.jobOfferForm.languageWrittenLevel.selectedIndex].label );

		document.jobOfferForm.LanguageList[i].text = document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label;
	}
	if (document.jobOfferForm.LanguageList.length>0) {
		document.jobOfferForm.ViewLanguageList.selectedIndex = 0;
		UpdateWithSelectedItem(false);
		document.jobOfferForm.ViewLanguageList.options[0].selected = false;
	}

	UpdateVacancyTitle();

	evalAcademicQualificationDisplay();
	evalEstimatedEffortDisplay();
}

