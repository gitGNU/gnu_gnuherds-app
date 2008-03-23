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


class PostgreSQL
{
	public function getOneField($sqlQuery,$prepared)
	{
		$result = $this->getPostgreSQLObject($sqlQuery,$prepared);
		return pg_fetch_all_columns($result, 0); // We do not return the PostgreSQL object result but an array ready to be used by the Smarty templates
	}

	public function execute($sqlQuery,$prepared)
	{
		$this->getPostgreSQLObject($sqlQuery,$prepared);
	}

	public function getPostgreSQLObject($sqlQuery,$prepared=0)
	{
		// Connect
		$GLOBALS["PG_CONNECT"] = pg_connect("dbname=gnuherds user=www-data");
		if (!$GLOBALS["PG_CONNECT"])
		{
			$error = "<p>".gettext("ERROR: Connection to database failed!")."</p>\n";
			throw new Exception($error,false);
		}

		// Check the connection
		if (!$GLOBALS["PG_CONNECT"])
			return 0;

		// Launch the query
		$lev=error_reporting (8); // NO WARRING!!
		// echo $sqlQuery."  <br>";; // DEBUG
		$result = pg_query ($sqlQuery);
		error_reporting ($lev); // DEFAULT!!

		// Check for query error
		if (strlen ($r=pg_last_error ($GLOBALS["PG_CONNECT"])))
		{
			$error = "ERROR:<pre> {$sqlQuery} </pre> {$r}"; // DEBUG
			// $error = "$r"; // No DEBUG
			throw new Exception($error,true);
		}

		if ( $prepared == 1 )
		{
			// Deallocate the prepared statement
			// echo "DEALLOCATE query;  <br>"; // DEBUG
			pg_query ("DEALLOCATE query;");
			error_reporting ($lev);

			// Check for query error
			if (strlen ($r=pg_last_error ($GLOBALS["PG_CONNECT"])))
			{
				$error = "ERROR:<pre> {$sqlQuery} </pre> {$r}"; // DEBUG
				// $error = "$r"; // No DEBUG
				throw new Exception($error,true);
			}
		}

		return $result;
	}
}
?> 
