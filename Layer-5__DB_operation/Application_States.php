<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
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


class ApplicationStates
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getApplicationStatesList()
	{
		$sqlQuery = "SELECT LZ_Id FROM LZ_ApplicationStates";
		$applicationStatesIdList = $this->postgresql->getOneField($sqlQuery,0);
		$applicationStates = array_combine($applicationStatesIdList, $applicationStatesIdList);

		while (current($applicationStates))
		{
			$applicationStates[key($applicationStates)] = gettext( trim( current($applicationStates) ) );
			next($applicationStates);
		}

		return $applicationStates;
	}
}
?> 
