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


class ByPeriod
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getByPeriodList()
	{
		$byPeriodIdList = $this->getByPeriodIdList();
		$byPeriod = array_combine($byPeriodIdList, $byPeriodIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		while (current($byPeriod))
		{
			$byPeriod[key($byPeriod)] = gettext( trim( current($byPeriod) ) );
			next($byPeriod);
		}

		// asort($byPeriod);  Note: We do not sort this ComboBox.

		return $byPeriod;
	}

	public function getByPeriodIdList()
	{
		$sqlQuery = "SELECT LB_Id FROM LB_ByPeriod";
		return $this->postgresql->getOneField($sqlQuery,0);
	}
}
?> 
