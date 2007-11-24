<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License as published by the Free Software Foundation,
// either version 3 of the License, or (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
// General Public License for more details.
// 
// You should have received a copy of the GNU Affero General Public License along with this
// program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.


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
