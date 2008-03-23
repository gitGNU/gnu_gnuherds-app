<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007, 2008 Davi Leal <davi at leals dot com>
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
require_once "../lib/Translator.php";


class ApplicationStates
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getApplicationStatesList()
	{
		$sqlQuery = "SELECT LZ_Id FROM LZ_ApplicationStates";
		$applicationStatesIdList = $this->postgresql->getOneField($sqlQuery,0);
		$applicationStates = array_combine($applicationStatesIdList, $applicationStatesIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$applicationStates = $this->translator->t_array($applicationStates, 'database');
		// asort($byPeriod);  Note: We do not sort this ComboBox.

		return $applicationStates;
	}
}
?> 
