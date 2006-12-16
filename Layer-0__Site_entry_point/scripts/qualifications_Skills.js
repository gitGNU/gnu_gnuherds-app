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
	if ( document.qualificationsForm.Skill.value == "" )
	{
		document.qualificationsForm.skillKnowledgeLevel.disabled = true;
		document.qualificationsForm.skillExperienceLevel.disabled = true;
	}
	else
	{
		document.qualificationsForm.skillKnowledgeLevel.disabled = false;
		document.qualificationsForm.skillExperienceLevel.disabled = false;
	}

	// Find the skill, and its position
	position = -1;
	for (i=0; i<document.qualificationsForm.SkillList.length; i++)
	{
		if ( document.qualificationsForm.SkillList.options[i].value == document.qualificationsForm.Skill.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1)
	{
		document.qualificationsForm.skillKnowledgeLevel.value = "Null";
		document.qualificationsForm.skillExperienceLevel.value = "Null";

		for (i=0; i<document.qualificationsForm.ViewSkillList.length; i++)
			document.qualificationsForm.ViewSkillList.options[i].selected = false;
	}
	else
	{
		document.qualificationsForm.skillKnowledgeLevel.value = document.qualificationsForm.SkillKnowledgeLevelList[position].value;
		document.qualificationsForm.skillExperienceLevel.value = document.qualificationsForm.SkillExperienceLevelList[position].value;

		if (document.qualificationsForm.ViewSkillList.selectedIndex>=0)
			document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.selectedIndex].selected = false;

		document.qualificationsForm.ViewSkillList.options[position].selected = true;
	}
}

function UpdateSkill() // If there is already the skill we will realize an Update, else an Insert. Setting both levels to 'Null' deletes the item.
{
	// Find the skill, and its position
	position = -1;
	for (i=0; i<document.qualificationsForm.SkillList.length; i++)
	{
		if ( document.qualificationsForm.SkillList.options[i].value == document.qualificationsForm.Skill.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1 )
	{
		if ( document.qualificationsForm.skillKnowledgeLevel.value != "Null" || document.qualificationsForm.skillExperienceLevel.value != "Null" )
		{
			document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.options.length] = new Option( document.qualificationsForm.Skill.options[document.qualificationsForm.Skill.selectedIndex].label +' '+ document.qualificationsForm.skillKnowledgeLevel.options[document.qualificationsForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.qualificationsForm.skillExperienceLevel.options[document.qualificationsForm.skillExperienceLevel.selectedIndex].label, document.qualificationsForm.Skill.options[document.qualificationsForm.Skill.selectedIndex].label +' '+ document.qualificationsForm.skillKnowledgeLevel.options[document.qualificationsForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.qualificationsForm.skillExperienceLevel.options[document.qualificationsForm.skillExperienceLevel.selectedIndex].label );
			document.qualificationsForm.SkillList.options[document.qualificationsForm.SkillList.options.length] = new Option(document.qualificationsForm.Skill.value, document.qualificationsForm.Skill.value);
			document.qualificationsForm.SkillKnowledgeLevelList.options[document.qualificationsForm.SkillKnowledgeLevelList.options.length] = new Option(document.qualificationsForm.skillKnowledgeLevel.value, document.qualificationsForm.skillKnowledgeLevel.value);
			document.qualificationsForm.SkillExperienceLevelList.options[document.qualificationsForm.SkillExperienceLevelList.options.length] = new Option(document.qualificationsForm.skillExperienceLevel.value, document.qualificationsForm.skillExperienceLevel.value);

			if (document.qualificationsForm.ViewSkillList.selectedIndex>=0)
				document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.selectedIndex].selected = false;
			document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.options.length-1].selected = true;
		}
	}
	else
	{
		if ( document.qualificationsForm.skillKnowledgeLevel.value != "Null" || document.qualificationsForm.skillExperienceLevel.value != "Null" )
		{
			document.qualificationsForm.ViewSkillList.options[position].value = document.qualificationsForm.Skill.options[document.qualificationsForm.Skill.selectedIndex].label +' '+ document.qualificationsForm.skillKnowledgeLevel.options[document.qualificationsForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.qualificationsForm.skillExperienceLevel.options[document.qualificationsForm.skillExperienceLevel.selectedIndex].label ;
			document.qualificationsForm.ViewSkillList.options[position].text = document.qualificationsForm.Skill.options[document.qualificationsForm.Skill.selectedIndex].label +' '+ document.qualificationsForm.skillKnowledgeLevel.options[document.qualificationsForm.skillKnowledgeLevel.selectedIndex].label +' '+ document.qualificationsForm.skillExperienceLevel.options[document.qualificationsForm.skillExperienceLevel.selectedIndex].label ;
			document.qualificationsForm.SkillList.options[position].value = document.qualificationsForm.Skill.value;
			document.qualificationsForm.SkillList.options[position].text = document.qualificationsForm.Skill.value;
			document.qualificationsForm.SkillExperienceLevelList.options[position].value = document.qualificationsForm.skillExperienceLevel.value;
			document.qualificationsForm.SkillExperienceLevelList.options[position].text = document.qualificationsForm.skillExperienceLevel.value;
			document.qualificationsForm.SkillKnowledgeLevelList.options[position].value = document.qualificationsForm.skillKnowledgeLevel.value;
			document.qualificationsForm.SkillKnowledgeLevelList.options[position].text = document.qualificationsForm.skillKnowledgeLevel.value;

			if (document.qualificationsForm.ViewSkillList.selectedIndex>=0)
				document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.selectedIndex].selected = false;

			document.qualificationsForm.ViewSkillList.options[position].selected = true;
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
	document.qualificationsForm.ViewSkillList.options[position] = null;
	document.qualificationsForm.SkillList.options[position] = null;
	document.qualificationsForm.SkillKnowledgeLevelList.options[position] = null;
	document.qualificationsForm.SkillExperienceLevelList.options[position] = null;

	// Select a new element
	if (document.qualificationsForm.ViewSkillList.length>0)
	{
		if (document.qualificationsForm.ViewSkillList.length>position)
		{
			if (document.qualificationsForm.ViewSkillList.selectedIndex>=0)
				document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.selectedIndex].selected = false;

			document.qualificationsForm.ViewSkillList.options[position].selected = true;
		}
		else
		{
			if (document.qualificationsForm.ViewSkillList.selectedIndex>=0)
				document.qualificationsForm.ViewSkillList.options[document.qualificationsForm.ViewSkillList.selectedIndex].selected = false;

			document.qualificationsForm.ViewSkillList.options[position-1].selected = true;
		}
	}
	UpdateWithSelectedSkill();
}

function UpdateWithSelectedSkill() 
{
	if (document.qualificationsForm.ViewSkillList.selectedIndex>=0)
	{
		document.qualificationsForm.Skill.value = document.qualificationsForm.SkillList[document.qualificationsForm.ViewSkillList.selectedIndex].value;
		document.qualificationsForm.skillKnowledgeLevel.value = document.qualificationsForm.SkillKnowledgeLevelList[document.qualificationsForm.ViewSkillList.selectedIndex].value;
		document.qualificationsForm.skillExperienceLevel.value = document.qualificationsForm.SkillExperienceLevelList[document.qualificationsForm.ViewSkillList.selectedIndex].value;

		document.qualificationsForm.skillKnowledgeLevel.disabled = false;
		document.qualificationsForm.skillExperienceLevel.disabled = false;
	}
	else
	{
		document.qualificationsForm.skillKnowledgeLevel.value = "Null";
		document.qualificationsForm.skillExperienceLevel.value = "Null";
	}
}

