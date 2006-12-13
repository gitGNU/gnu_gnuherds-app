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


function ResetSkillLevels()
{
	if ( document.jobOfferForm.Skill.value == "" )
	{
		document.jobOfferForm.skillKnowledgeLevel.disabled = true;
		document.jobOfferForm.skillExperienceLevel.disabled = true;
	}
	else
	{
		document.jobOfferForm.skillKnowledgeLevel.disabled = false;
		document.jobOfferForm.skillExperienceLevel.disabled = false;
	}

	// Find the skill, and its position
	position = -1;
	for (i=0; i<document.jobOfferForm.SkillList.length; i++)
	{
		if ( document.jobOfferForm.SkillList.options[i].text == document.jobOfferForm.Skill.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1)
	{
		document.jobOfferForm.skillKnowledgeLevel.value = "Null";
		document.jobOfferForm.skillExperienceLevel.value = "Null";

		for (i=0; i<document.jobOfferForm.ViewSkillList.length; i++)
			document.jobOfferForm.ViewSkillList.options[i].selected = false;
	}
	else
	{
		document.jobOfferForm.skillKnowledgeLevel.value = document.jobOfferForm.SkillKnowledgeLevelList[position].value;
		document.jobOfferForm.skillExperienceLevel.value = document.jobOfferForm.SkillExperienceLevelList[position].value;

		if (document.jobOfferForm.ViewSkillList.selectedIndex>=0)
			document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.selectedIndex].selected = false;

		document.jobOfferForm.ViewSkillList.options[position].selected = true;
	}
}

function UpdateSkill() // If there is already the skill we will realize an Update, else an Insert. Setting both levels to 'Null' deletes the item.
{
	// Find the skill, and its position
	position = -1;
	for (i=0; i<document.jobOfferForm.SkillList.length; i++)
	{
		if ( document.jobOfferForm.SkillList.options[i].text == document.jobOfferForm.Skill.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1 )
	{
		if ( document.jobOfferForm.skillKnowledgeLevel.value != "Null" || document.jobOfferForm.skillExperienceLevel.value != "Null" )
		{
			document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.options.length] = new Option( document.jobOfferForm.Skill.options[document.jobOfferForm.Skill.selectedIndex].label +' '+ document.jobOfferForm.skillKnowledgeLevel.options[document.jobOfferForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.jobOfferForm.skillExperienceLevel.options[document.jobOfferForm.skillExperienceLevel.selectedIndex].label );
			document.jobOfferForm.SkillList.options[document.jobOfferForm.SkillList.options.length] = new Option(document.jobOfferForm.Skill.value);
			document.jobOfferForm.SkillKnowledgeLevelList.options[document.jobOfferForm.SkillKnowledgeLevelList.options.length] = new Option(document.jobOfferForm.skillKnowledgeLevel.value);
			document.jobOfferForm.SkillExperienceLevelList.options[document.jobOfferForm.SkillExperienceLevelList.options.length] = new Option(document.jobOfferForm.skillExperienceLevel.value);

			if (document.jobOfferForm.ViewSkillList.selectedIndex>=0)
				document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.selectedIndex].selected = false;
			document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.options.length-1].selected = true;
		}
	}
	else
	{
		if ( document.jobOfferForm.skillKnowledgeLevel.value != "Null" || document.jobOfferForm.skillExperienceLevel.value != "Null" )
		{
			document.jobOfferForm.ViewSkillList.options[position].value = document.jobOfferForm.Skill.options[document.jobOfferForm.Skill.selectedIndex].label +' '+ document.jobOfferForm.skillKnowledgeLevel.options[document.jobOfferForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.jobOfferForm.skillExperienceLevel.options[document.jobOfferForm.skillExperienceLevel.selectedIndex].label ;
			document.jobOfferForm.ViewSkillList.options[position].text = document.jobOfferForm.Skill.options[document.jobOfferForm.Skill.selectedIndex].label +' '+ document.jobOfferForm.skillKnowledgeLevel.options[document.jobOfferForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.jobOfferForm.skillExperienceLevel.options[document.jobOfferForm.skillExperienceLevel.selectedIndex].label ;
			document.jobOfferForm.SkillList.options[position].value = document.jobOfferForm.Skill.value;
			document.jobOfferForm.SkillList.options[position].text = document.jobOfferForm.Skill.value;
			document.jobOfferForm.SkillExperienceLevelList.options[position].value = document.jobOfferForm.skillExperienceLevel.value;
			document.jobOfferForm.SkillExperienceLevelList.options[position].text = document.jobOfferForm.skillExperienceLevel.value;
			document.jobOfferForm.SkillKnowledgeLevelList.options[position].value = document.jobOfferForm.skillKnowledgeLevel.value;
			document.jobOfferForm.SkillKnowledgeLevelList.options[position].text = document.jobOfferForm.skillKnowledgeLevel.value;

			if (document.jobOfferForm.ViewSkillList.selectedIndex>=0)
				document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.selectedIndex].selected = false;

			document.jobOfferForm.ViewSkillList.options[position].selected = true;
		}
		else
		{
			DeleteSkill(position);  // Setting both levels to 'Null' deletes the item
		}
	}
}

function DeleteSkill(position)
{
	// Delete the item
	document.jobOfferForm.ViewSkillList.options[position] = null;
	document.jobOfferForm.SkillList.options[position] = null;
	document.jobOfferForm.SkillKnowledgeLevelList.options[position] = null;
	document.jobOfferForm.SkillExperienceLevelList.options[position] = null;

	// Select a new element
	if (document.jobOfferForm.ViewSkillList.length>0)
	{
		if (document.jobOfferForm.ViewSkillList.length>position)
		{
			if (document.jobOfferForm.ViewSkillList.selectedIndex>=0)
				document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.selectedIndex].selected = false;

			document.jobOfferForm.ViewSkillList.options[position].selected = true;
		}
		else
		{
			if (document.jobOfferForm.ViewSkillList.selectedIndex>=0)
				document.jobOfferForm.ViewSkillList.options[document.jobOfferForm.ViewSkillList.selectedIndex].selected = false;

			document.jobOfferForm.ViewSkillList.options[position-1].selected = true;
		}
	}
	UpdateWithSelectedSkill();
}

function UpdateWithSelectedSkill() 
{
	if (document.jobOfferForm.ViewSkillList.selectedIndex>=0)
	{
		document.jobOfferForm.Skill.value = document.jobOfferForm.SkillList[document.jobOfferForm.ViewSkillList.selectedIndex].value;
		document.jobOfferForm.skillKnowledgeLevel.value = document.jobOfferForm.SkillKnowledgeLevelList[document.jobOfferForm.ViewSkillList.selectedIndex].value;
		document.jobOfferForm.skillExperienceLevel.value = document.jobOfferForm.SkillExperienceLevelList[document.jobOfferForm.ViewSkillList.selectedIndex].value;

		document.jobOfferForm.skillKnowledgeLevel.disabled = false;
		document.jobOfferForm.skillExperienceLevel.disabled = false;
	}
	else
	{
		document.jobOfferForm.skillKnowledgeLevel.value = "Null";
		document.jobOfferForm.skillExperienceLevel.value = "Null";
	}
}

