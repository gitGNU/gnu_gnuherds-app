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


function ResetLevels()
{
	if ( document.qualificationsForm.Language.value == "" )
	{
		document.qualificationsForm.languageSpokenLevel.disabled = true;
		document.qualificationsForm.languageWrittenLevel.disabled = true;
	}
	else
	{
		document.qualificationsForm.languageSpokenLevel.disabled = false;
		document.qualificationsForm.languageWrittenLevel.disabled = false;
	}

	// Find the idiom, and its position
	position = -1;
	for (i=0; i<document.qualificationsForm.LanguageList.length; i++)
	{
		if ( document.qualificationsForm.LanguageList.options[i].value == document.qualificationsForm.Language.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1)
	{
		document.qualificationsForm.languageSpokenLevel.value = "Null";
		document.qualificationsForm.languageWrittenLevel.value = "Null";

		for (i=0; i<document.qualificationsForm.ViewLanguageList.length; i++)
			document.qualificationsForm.ViewLanguageList.options[i].selected = false;
	}
	else
	{
		document.qualificationsForm.languageSpokenLevel.value = document.qualificationsForm.LanguageSpokenLevelList[position].value;
		document.qualificationsForm.languageWrittenLevel.value = document.qualificationsForm.LanguageWrittenLevelList[position].value;

		if (document.qualificationsForm.ViewLanguageList.selectedIndex>=0)
			document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.selectedIndex].selected = false;

		document.qualificationsForm.ViewLanguageList.options[position].selected = true;
	}
}

function UpdateIdiom() // If there is already the idiom we will realize an Update, else an Insert. Setting both levels to 'Null' deletes the item.
{
	// Find the idiom, and its position
	position = -1;
	for (i=0; i<document.qualificationsForm.LanguageList.length; i++)
	{
		if ( document.qualificationsForm.LanguageList.options[i].value == document.qualificationsForm.Language.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1 )
	{
		if ( document.qualificationsForm.languageSpokenLevel.value != "Null" || document.qualificationsForm.languageWrittenLevel.value != "Null" )
		{
			document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.options.length] = new Option( document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label +' '+ document.qualificationsForm.languageSpokenLevel.options[document.qualificationsForm.languageSpokenLevel.selectedIndex].label +' '+ document.qualificationsForm.languageWrittenLevel.options[document.qualificationsForm.languageWrittenLevel.selectedIndex].label, document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label +' '+ document.qualificationsForm.languageSpokenLevel.options[document.qualificationsForm.languageSpokenLevel.selectedIndex].label +' '+ document.qualificationsForm.languageWrittenLevel.options[document.qualificationsForm.languageWrittenLevel.selectedIndex].label );
			document.qualificationsForm.LanguageList.options[document.qualificationsForm.LanguageList.options.length] = new Option(document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label, document.qualificationsForm.Language.value);
			document.qualificationsForm.LanguageSpokenLevelList.options[document.qualificationsForm.LanguageSpokenLevelList.options.length] = new Option(document.qualificationsForm.languageSpokenLevel.value, document.qualificationsForm.languageSpokenLevel.value);
			document.qualificationsForm.LanguageWrittenLevelList.options[document.qualificationsForm.LanguageWrittenLevelList.options.length] = new Option(document.qualificationsForm.languageWrittenLevel.value, document.qualificationsForm.languageWrittenLevel.value);

			if (document.qualificationsForm.ViewLanguageList.selectedIndex>=0)
				document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.selectedIndex].selected = false;
			document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.options.length-1].selected = true;
		}
	}
	else
	{
		if ( document.qualificationsForm.languageSpokenLevel.value != "Null" || document.qualificationsForm.languageWrittenLevel.value != "Null" )
		{
			document.qualificationsForm.ViewLanguageList.options[position].value = document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label +' '+ document.qualificationsForm.languageSpokenLevel.options[document.qualificationsForm.languageSpokenLevel.selectedIndex].label +' '+ document.qualificationsForm.languageWrittenLevel.options[document.qualificationsForm.languageWrittenLevel.selectedIndex].label ;
			document.qualificationsForm.ViewLanguageList.options[position].text = document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label +' '+ document.qualificationsForm.languageSpokenLevel.options[document.qualificationsForm.languageSpokenLevel.selectedIndex].label +' '+ document.qualificationsForm.languageWrittenLevel.options[document.qualificationsForm.languageWrittenLevel.selectedIndex].label ;
			document.qualificationsForm.LanguageList.options[position].value = document.qualificationsForm.Language.value;
			document.qualificationsForm.LanguageList.options[position].text = document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label;
			document.qualificationsForm.LanguageWrittenLevelList.options[position].value = document.qualificationsForm.languageWrittenLevel.value;
			document.qualificationsForm.LanguageWrittenLevelList.options[position].text = document.qualificationsForm.languageWrittenLevel.value;
			document.qualificationsForm.LanguageSpokenLevelList.options[position].value = document.qualificationsForm.languageSpokenLevel.value;
			document.qualificationsForm.LanguageSpokenLevelList.options[position].text = document.qualificationsForm.languageSpokenLevel.value;

			if (document.qualificationsForm.ViewLanguageList.selectedIndex>=0)
				document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.selectedIndex].selected = false;

			document.qualificationsForm.ViewLanguageList.options[position].selected = true;
		}
		else
		{
			DeleteItem(position);  // Setting both levels to 'Null' deletes the item
		}
	}
}

function DeleteItem(position)
{
	if (position == -1)
		return;

	// Delete the item
	document.qualificationsForm.ViewLanguageList.options[position] = null;
	document.qualificationsForm.LanguageList.options[position] = null;
	document.qualificationsForm.LanguageSpokenLevelList.options[position] = null;
	document.qualificationsForm.LanguageWrittenLevelList.options[position] = null;

	// Select a new element
	if (document.qualificationsForm.ViewLanguageList.length>0)
	{
		if (document.qualificationsForm.ViewLanguageList.length>position)
		{
			if (document.qualificationsForm.ViewLanguageList.selectedIndex>=0)
				document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.selectedIndex].selected = false;

			document.qualificationsForm.ViewLanguageList.options[position].selected = true;
		}
		else
		{
			if (document.qualificationsForm.ViewLanguageList.selectedIndex>=0)
				document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.selectedIndex].selected = false;

			document.qualificationsForm.ViewLanguageList.options[position-1].selected = true;
		}
	}
	UpdateWithSelectedItem(false);
}

function UpdateWithSelectedItem(IE_workaround) 
{
	if ( IE_workaround == true ) // Workaround to IE 6.0 bug, that expose a wrong value on .selectedIndex;  Moving the focus, we get the right .selectedIndex value.
	{
		document.qualificationsForm.Language.focus();
		document.qualificationsForm.ViewLanguageList.focus();
	}

	if (document.qualificationsForm.ViewLanguageList.selectedIndex>=0)
	{
		document.qualificationsForm.Language.value = document.qualificationsForm.LanguageList[document.qualificationsForm.ViewLanguageList.selectedIndex].value;
		document.qualificationsForm.languageSpokenLevel.value = document.qualificationsForm.LanguageSpokenLevelList[document.qualificationsForm.ViewLanguageList.selectedIndex].value;
		document.qualificationsForm.languageWrittenLevel.value = document.qualificationsForm.LanguageWrittenLevelList[document.qualificationsForm.ViewLanguageList.selectedIndex].value;

		document.qualificationsForm.languageSpokenLevel.disabled = false;
		document.qualificationsForm.languageWrittenLevel.disabled = false;
	}
	else
	{
		document.qualificationsForm.languageSpokenLevel.value = "Null";
		document.qualificationsForm.languageWrittenLevel.value = "Null";
	}
}

