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


class Countries
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getCountryList()
	{
		$countryTwoLetter = $this->getCountryTwoLetterList();
		$countryNames = $this->getCountryNameList();
		$countries = array_combine($countryTwoLetter, $countryNames);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		while (current($countries))
		{
 			$countries[key($countries)] = gettext( trim( current($countries) ) );
 			next($countries);
		}

		asort($countries); // Note After translate it, we sort this ComboBox.

		return $countries;
	}

	private function getCountryTwoLetterList()
	{
		$sqlQuery = "SELECT LO_TwoLetter FROM LO_Countries";
		return $this->postgresql->getOneField($sqlQuery,0);
	}

	private function getCountryNameList()
	{
		$sqlQuery = "SELECT LO_Name FROM LO_Countries";
		return $this->postgresql->getOneField($sqlQuery,0);
	}
}
?> 
