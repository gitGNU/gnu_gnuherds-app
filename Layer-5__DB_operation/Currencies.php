<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
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


class Currencies
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getCurrenciesList()
	{
		$currenciesThreeLetter = $this->getCurrenciesThreeLetterList();
		$currenciesName = $this->getCurrenciesNameList();
		$currencies = array_combine($currenciesThreeLetter, $currenciesName);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$currencies = $this->translator->t_array($currencies, 'iso_4217');
		asort($currencies); // Note After translate it, we sort this ComboBox.

		return $currencies;
	}

	public function getCurrenciesThreeLetterList()
	{
		$sqlQuery = "SELECT LU_ThreeLetter FROM LU_Currencies";
		return $this->postgresql->getOneField($sqlQuery,0);
	}

	public function getCurrenciesNameList()
	{
		$sqlQuery = "SELECT LU_PluralName FROM LU_Currencies";
		return $this->postgresql->getOneField($sqlQuery,0);
	}


	public function getCurrencyName($Id)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT LU_PluralName FROM LU_Currencies WHERE LU_ThreeLetter=$1;  EXECUTE query('$Id');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}
}
