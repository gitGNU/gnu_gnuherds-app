<?php
// Authors: Davi Leal
//
// Copyright (C) 2006 Davi Leal <davi at leals dot com>
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the Affero General Public License as published by Affero Inc.,
// either version 1 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful to the Free
// Software community, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
// General Public License for more details.
//
// You should have received a copy of the Affero General Public License with this
// software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
// Suite 225, San Francisco, CA 94107, USA


require_once "../Layer-5__DB_operation/PostgreSQL.php";


class Employability
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getEmployabilityList()
	{
		$sqlQuery = "SELECT LE_Id FROM LE_Employability";
		$employabilityIdList = $this->postgresql->getOneField($sqlQuery,0);
		$employability = array_combine($employabilityIdList, $employabilityIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		while (current($employability))
		{
			$employability[key($employability)] = gettext( trim( current($employability) ) );
			next($employability);
		}

		// asort($professionalProfiles);  Note: The 'Id' is sort from the DataBase so we do not need sort this list after translate it.

		return $employability;
	}
}
?> 
