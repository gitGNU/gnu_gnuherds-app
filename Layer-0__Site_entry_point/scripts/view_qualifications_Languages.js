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


function InitializationOnLoad()
{
	// Visible language list
	for (i=0; i<document.qualificationsForm.LanguageList.length; i++) 
	{
		document.qualificationsForm.Language.value = document.qualificationsForm.LanguageList[i].value;
		document.qualificationsForm.languageSpokenLevel.value = document.qualificationsForm.LanguageSpokenLevelList[i].value;
		document.qualificationsForm.languageWrittenLevel.value = document.qualificationsForm.LanguageWrittenLevelList[i].value;
		document.qualificationsForm.ViewLanguageList.options[document.qualificationsForm.ViewLanguageList.options.length] = new Option( document.qualificationsForm.Language.options[document.qualificationsForm.Language.selectedIndex].label +': Spoken level '+ document.qualificationsForm.languageSpokenLevel.options[document.qualificationsForm.languageSpokenLevel.selectedIndex].label +', Written level '+ document.qualificationsForm.languageWrittenLevel.options[document.qualificationsForm.languageWrittenLevel.selectedIndex].label );
	}
}

