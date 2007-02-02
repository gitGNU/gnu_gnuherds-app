/*
Authors: Davi Leal

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>

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


function AddContributionItem() 
{
	if (document.qualificationsForm.ContributionProject.value == "" || document.qualificationsForm.ContributionURI.value == "")
	{
		alert(document.qualificationsForm.ContributionErrorMessage.value);
	}
	else
	{
		document.qualificationsForm.VisibleContributionsList.options[document.qualificationsForm.VisibleContributionsList.options.length] = new Option( document.qualificationsForm.ContributionProject.value + " " + document.qualificationsForm.ContributionDescription.value, document.qualificationsForm.ContributionProject.value + " " + document.qualificationsForm.ContributionDescription.value );

		document.qualificationsForm.ContributionsListProject.options[document.qualificationsForm.ContributionsListProject.options.length] = new Option( document.qualificationsForm.ContributionProject.value, document.qualificationsForm.ContributionProject.value );
		document.qualificationsForm.ContributionsListDescription.options[document.qualificationsForm.ContributionsListDescription.options.length] = new Option( document.qualificationsForm.ContributionDescription.value, document.qualificationsForm.ContributionDescription.value );
		document.qualificationsForm.ContributionsListURI.options[document.qualificationsForm.ContributionsListURI.options.length] = new Option( document.qualificationsForm.ContributionURI.value, document.qualificationsForm.ContributionURI.value );

		// Reset
		document.qualificationsForm.ContributionProject.value = "";
		document.qualificationsForm.ContributionDescription.value = "";
		document.qualificationsForm.ContributionURI.value = "http://";
	}
}

function DeleteContributionItem(position) 
{
	if (position == -1)
		return;

	// Delete the item
	document.qualificationsForm.VisibleContributionsList.options[position] = null;

	document.qualificationsForm.ContributionsListProject.options[position] = null;
	document.qualificationsForm.ContributionsListDescription.options[position] = null;
	document.qualificationsForm.ContributionsListURI.options[position] = null;

	// Select a new element at VisibleContributionsList
	if (document.qualificationsForm.VisibleContributionsList.length>0)
	{
		if (document.qualificationsForm.VisibleContributionsList.length>position)
		{
			if (document.qualificationsForm.VisibleContributionsList.selectedIndex>=0)
				document.qualificationsForm.VisibleContributionsList.options[document.qualificationsForm.VisibleContributionsList.selectedIndex].selected = false;
			document.qualificationsForm.VisibleContributionsList.options[position].selected = true;
		}
		else
		{
			if (document.qualificationsForm.VisibleContributionsList.selectedIndex>=0)
				document.qualificationsForm.VisibleContributionsList.options[document.qualificationsForm.VisibleContributionsList.selectedIndex].selected = false;

			document.qualificationsForm.VisibleContributionsList.options[position-1].selected = true;
		}
	}
}

