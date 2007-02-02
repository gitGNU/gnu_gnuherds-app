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


function ResetLevels()
{
	if ( document.jobOfferForm.Language.value == "" )
	{
		document.jobOfferForm.languageSpokenLevel.disabled = true;
		document.jobOfferForm.languageWrittenLevel.disabled = true;
	}
	else
	{
		document.jobOfferForm.languageSpokenLevel.disabled = false;
		document.jobOfferForm.languageWrittenLevel.disabled = false;
	}

	// Find the idiom, and its position
	position = -1;
	for (i=0; i<document.jobOfferForm.LanguageList.length; i++)
	{
		if ( document.jobOfferForm.LanguageList.options[i].value == document.jobOfferForm.Language.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1)
	{
		document.jobOfferForm.languageSpokenLevel.value = "Null";
		document.jobOfferForm.languageWrittenLevel.value = "Null";

		for (i=0; i<document.jobOfferForm.ViewLanguageList.length; i++)
			document.jobOfferForm.ViewLanguageList.options[i].selected = false;
	}
	else
	{
		document.jobOfferForm.languageSpokenLevel.value = document.jobOfferForm.LanguageSpokenLevelList[position].value;
		document.jobOfferForm.languageWrittenLevel.value = document.jobOfferForm.LanguageWrittenLevelList[position].value;

		if (document.jobOfferForm.ViewLanguageList.selectedIndex>=0)
			document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.selectedIndex].selected = false;

		document.jobOfferForm.ViewLanguageList.options[position].selected = true;
	}
}

function UpdateIdiom() // If there is already the idiom we will realize an Update, else an Insert. Setting both levels to 'Null' deletes the item.
{
	// Find the idiom, and its position
	position = -1;
	for (i=0; i<document.jobOfferForm.LanguageList.length; i++)
	{
		if ( document.jobOfferForm.LanguageList.options[i].value == document.jobOfferForm.Language.value )
		{
			position = i;
			break;
		}
	}

	if (position == -1 )
	{
		if ( document.jobOfferForm.languageSpokenLevel.value != "Null" || document.jobOfferForm.languageWrittenLevel.value != "Null" )
		{
			document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.options.length] = new Option( document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label +' '+ document.jobOfferForm.languageSpokenLevel.options[document.jobOfferForm.languageSpokenLevel.selectedIndex].label +' '+ document.jobOfferForm.languageWrittenLevel.options[document.jobOfferForm.languageWrittenLevel.selectedIndex].label, document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label +' '+ document.jobOfferForm.languageSpokenLevel.options[document.jobOfferForm.languageSpokenLevel.selectedIndex].label +' '+ document.jobOfferForm.languageWrittenLevel.options[document.jobOfferForm.languageWrittenLevel.selectedIndex].label );
			document.jobOfferForm.LanguageList.options[document.jobOfferForm.LanguageList.options.length] = new Option(document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label, document.jobOfferForm.Language.value);
			document.jobOfferForm.LanguageSpokenLevelList.options[document.jobOfferForm.LanguageSpokenLevelList.options.length] = new Option(document.jobOfferForm.languageSpokenLevel.value, document.jobOfferForm.languageSpokenLevel.value);
			document.jobOfferForm.LanguageWrittenLevelList.options[document.jobOfferForm.LanguageWrittenLevelList.options.length] = new Option(document.jobOfferForm.languageWrittenLevel.value, document.jobOfferForm.languageWrittenLevel.value);

			if (document.jobOfferForm.ViewLanguageList.selectedIndex>=0)
				document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.selectedIndex].selected = false;
			document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.options.length-1].selected = true;
		}
	}
	else
	{
		if ( document.jobOfferForm.languageSpokenLevel.value != "Null" || document.jobOfferForm.languageWrittenLevel.value != "Null" )
		{
			document.jobOfferForm.ViewLanguageList.options[position].value = document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label +' '+ document.jobOfferForm.languageSpokenLevel.options[document.jobOfferForm.languageSpokenLevel.selectedIndex].label +' '+ document.jobOfferForm.languageWrittenLevel.options[document.jobOfferForm.languageWrittenLevel.selectedIndex].label ;
			document.jobOfferForm.ViewLanguageList.options[position].text = document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label +' '+ document.jobOfferForm.languageSpokenLevel.options[document.jobOfferForm.languageSpokenLevel.selectedIndex].label +' '+ document.jobOfferForm.languageWrittenLevel.options[document.jobOfferForm.languageWrittenLevel.selectedIndex].label ;
			document.jobOfferForm.LanguageList.options[position].value = document.jobOfferForm.Language.value;
			document.jobOfferForm.LanguageList.options[position].text = document.jobOfferForm.Language.options[document.jobOfferForm.Language.selectedIndex].label;
			document.jobOfferForm.LanguageWrittenLevelList.options[position].value = document.jobOfferForm.languageWrittenLevel.value;
			document.jobOfferForm.LanguageWrittenLevelList.options[position].text = document.jobOfferForm.languageWrittenLevel.value;
			document.jobOfferForm.LanguageSpokenLevelList.options[position].value = document.jobOfferForm.languageSpokenLevel.value;
			document.jobOfferForm.LanguageSpokenLevelList.options[position].text = document.jobOfferForm.languageSpokenLevel.value;

			if (document.jobOfferForm.ViewLanguageList.selectedIndex>=0)
				document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.selectedIndex].selected = false;

			document.jobOfferForm.ViewLanguageList.options[position].selected = true;
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
	document.jobOfferForm.ViewLanguageList.options[position] = null;
	document.jobOfferForm.LanguageList.options[position] = null;
	document.jobOfferForm.LanguageSpokenLevelList.options[position] = null;
	document.jobOfferForm.LanguageWrittenLevelList.options[position] = null;

	// Select a new element
	if (document.jobOfferForm.ViewLanguageList.length>0)
	{
		if (document.jobOfferForm.ViewLanguageList.length>position)
		{
			if (document.jobOfferForm.ViewLanguageList.selectedIndex>=0)
				document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.selectedIndex].selected = false;

			document.jobOfferForm.ViewLanguageList.options[position].selected = true;
		}
		else
		{
			if (document.jobOfferForm.ViewLanguageList.selectedIndex>=0)
				document.jobOfferForm.ViewLanguageList.options[document.jobOfferForm.ViewLanguageList.selectedIndex].selected = false;

			document.jobOfferForm.ViewLanguageList.options[position-1].selected = true;
		}
	}
	UpdateWithSelectedItem(false);
}

function UpdateWithSelectedItem(IE_workaround) 
{
	if ( IE_workaround == true ) // Workaround to IE 6.0 bug, that expose a wrong value on .selectedIndex;  Moving the focus, we get the right .selectedIndex value.
	{
		document.jobOfferForm.Language.focus();
		document.jobOfferForm.ViewLanguageList.focus();
	}

	if (document.jobOfferForm.ViewLanguageList.selectedIndex>=0)
	{
		document.jobOfferForm.Language.value = document.jobOfferForm.LanguageList[document.jobOfferForm.ViewLanguageList.selectedIndex].value;
		document.jobOfferForm.languageSpokenLevel.value = document.jobOfferForm.LanguageSpokenLevelList[document.jobOfferForm.ViewLanguageList.selectedIndex].value;
		document.jobOfferForm.languageWrittenLevel.value = document.jobOfferForm.LanguageWrittenLevelList[document.jobOfferForm.ViewLanguageList.selectedIndex].value;

		document.jobOfferForm.languageSpokenLevel.disabled = false;
		document.jobOfferForm.languageWrittenLevel.disabled = false;
	}
	else
	{
		document.jobOfferForm.languageSpokenLevel.value = "Null";
		document.jobOfferForm.languageWrittenLevel.value = "Null";
	}
}

