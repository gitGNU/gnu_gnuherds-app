<?php
// Authors: Davi Leal
//
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008 Davi Leal <davi at leals dot com>
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
require_once "../lib/PasswordHash.php";


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
		$sqlQuery = "PREPARE query(text) AS  SELECT E1_Id,E1_Password,E1_EntityType,E1_SkillsAdmin FROM E1_Entities WHERE E1_Email=$1;  EXECUTE query('$_POST[LoginEmail]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery, 1);

		$array = array();
		$array[0] = pg_fetch_all_columns($result, 0);
		$array[1] = pg_fetch_all_columns($result, 1);
		$array[2] = pg_fetch_all_columns($result, 2);
		$array[3] = pg_fetch_all_columns($result, 3);

		if ( isset($array[1][0]) )
			$stored_hash = $array[1][0];
		else
			return false;

		if ( $this->hasher->CheckPassword($_POST['LoginPassword'], $stored_hash) )
		{
			$authenticationData = array();

			$authenticationData[0] = $array[0][0];
			$authenticationData[1] = $array[2][0];

			if ( $array[3][0] == 't' )
				$authenticationData[2] = true;
			else
				$authenticationData[2] = false;

			return $authenticationData;
		}
		else
			return false;
	}
}
?> 
