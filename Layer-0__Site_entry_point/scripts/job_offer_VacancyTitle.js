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


function UpdateVacancyTitle()
{
	const MAX_LENGTH = 100;

	for (i=0; i<document.jobOfferForm.ProfessionalProfileList.length && document.jobOfferForm.ProfessionalProfileList[i].selected==false; i++)
		;
	if (i<document.jobOfferForm.ProfessionalProfileList.length)
		document.jobOfferForm.VacancyTitle.value = document.jobOfferForm.ProfessionalProfileList[i].value;
	else
		document.jobOfferForm.VacancyTitle.value = 'Empty professional profile';

	for (i++; i<document.jobOfferForm.ProfessionalProfileList.length; i++)
		if ( document.jobOfferForm.ProfessionalProfileList[i].selected==true && ( document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.ProfessionalProfileList[i].value ).length < MAX_LENGTH )
			document.jobOfferForm.VacancyTitle.value = document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.ProfessionalProfileList[i].value;
			
	for (i=0; i<document.jobOfferForm.FieldProfileList.length; i++)
		if ( document.jobOfferForm.FieldProfileList[i].selected==true && ( document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.FieldProfileList[i].value ).length < MAX_LENGTH )
			document.jobOfferForm.VacancyTitle.value = document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.FieldProfileList[i].value;
			
	for (i=0; i<document.jobOfferForm.SkillList.length; i++)
		if ( ( document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.SkillList[i].value ).length < MAX_LENGTH )
			document.jobOfferForm.VacancyTitle.value = document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.SkillList[i].value;

	for (i=0; i<document.jobOfferForm.LanguageList.length; i++)
		if ( ( document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.LanguageList[i].value ).length < MAX_LENGTH )
			document.jobOfferForm.VacancyTitle.value = document.jobOfferForm.VacancyTitle.value + ", " + document.jobOfferForm.LanguageList[i].value;
}

