/*
Authors: Davi Leal

Copyright (C) 2007 Davi Leal <davi at leals dot com>

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


function openPopUp(idPopUp, URL, width, height)
{
	day = new Date();
	id = day.getTime();

	eval("popup"+id+" = window.open('"+URL+"','"+idPopUp+"','toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width="+width+",height="+height+"');");
}
