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


class Currencies
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getCurrenciesList()
	{
		$currenciesThreeLetter = $this->getCurrenciesThreeLetterList();
		$currenciesName = $this->getCurrenciesNameList();
		$currencies = array_combine($currenciesThreeLetter, $currenciesName);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		while (current($currencies))
		{
			$currencies[key($currencies)] = gettext( trim( current($currencies) ) );
			next($currencies);
		}

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
?> 
