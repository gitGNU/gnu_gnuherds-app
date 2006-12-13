/*
Authors: Davi Leal

Copyright (C) 2006 Davi Leal <davi at leals dot com>

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
	for (i=0; i<document.viewJobOfferForm.LanguageList.length; i++) 
	{
		document.viewJobOfferForm.Language.value = document.viewJobOfferForm.LanguageList[i].value;
		document.viewJobOfferForm.languageSpokenLevel.value = document.viewJobOfferForm.LanguageSpokenLevelList[i].value;
		document.viewJobOfferForm.languageWrittenLevel.value = document.viewJobOfferForm.LanguageWrittenLevelList[i].value;
		document.viewJobOfferForm.ViewLanguageList.options[document.viewJobOfferForm.ViewLanguageList.options.length] = new Option( document.viewJobOfferForm.Language.options[document.viewJobOfferForm.Language.selectedIndex].label +' '+ document.viewJobOfferForm.languageSpokenLevel.options[document.viewJobOfferForm.languageSpokenLevel.selectedIndex].label +' '+ document.viewJobOfferForm.languageWrittenLevel.options[document.viewJobOfferForm.languageWrittenLevel.selectedIndex].label );
	}
}

