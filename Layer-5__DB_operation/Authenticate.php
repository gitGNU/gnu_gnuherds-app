<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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
require_once "../Layer-5__DB_operation/lib/PasswordHash.php";


class Authenticate
{
	private $postgresql;
	private $hasher;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->hasher = new PasswordHash(8, FALSE);
	}


	public function checkLogin()
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT E1_Id,E1_EntityType,E1_Password FROM E1_Entities WHERE E1_Email=$1;  EXECUTE query('$_POST[Email]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 1);

		$array = array();
		$array[0] = pg_fetch_all_columns($result, 0);
		$array[1] = pg_fetch_all_columns($result, 1);
		$array[2] = pg_fetch_all_columns($result, 2);

		if ( isset($array[2][0]) )
			$stored_hash = $array[2][0];
		else
			return false;

		if ( $this->hasher->CheckPassword($_POST['Password'], $stored_hash) )
		{
			$authenticationData = array();

			$authenticationData[0] = $array[1][0];
			$authenticationData[1] = $array[0][0];

			return $authenticationData;
		}
		else
			return false;
	}
}
?> 
