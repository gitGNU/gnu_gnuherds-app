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


class Academic
{
	private $postgresql;
	private $translator;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
		$this->translator = new Translator();
	}


	public function getAcademicLevelsList()
	{
		$academicLevelsIdList = $this->getAcademicLevelsIdList();
		$academicLevels = array_combine($academicLevelsIdList, $academicLevelsIdList);

		// This method is used to fill the combo box in the forms, so we sort it according to the language using gettext().
		$academicLevels = $this->translator->t_array($academicLevels, 'database');
		// asort($academicLevels);  Note: The 'Id' is sort from the DataBase so we do not need sort this list after translate it.

		return $academicLevels;
	}

	public function getAcademicLevelsIdList()
	{
		$sqlQuery = "SELECT LA_Id FROM LA_AcademicLevels";
		return $this->postgresql->getOneField($sqlQuery, 0);
	}

	public function getAcademicLevelsLevelList()
	{
		$sqlQuery = "SELECT LA_Level FROM LA_AcademicLevels";
		return $this->postgresql->getOneField($sqlQuery, 0);
	}


	public function getAcademicLevelsEqualOrBetterThan($AcademicLevelId)
	{
		$sqlQuery = "PREPARE query(text) AS  SELECT LA_Id FROM LA_AcademicLevels WHERE LA_Level >= (SELECT LA_Level FROM LA_AcademicLevels WHERE LA_Id=$1);  EXECUTE query('$AcademicLevelId');";
		return $this->postgresql->getOneField($sqlQuery, 1);
	}


	public function getAcademicForEntity($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R27_Degree,R27_LA_Id,R27_DegreeGranted,R27_StartDate,R27_FinishDate,R27_Institution,R27_InstitutionURI,R27_ShortComment FROM R27_Qualification2Academic WHERE R27_Q1_E1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array[0] = pg_fetch_all_columns($result, 0 );
		$array[1] = pg_fetch_all_columns($result, 1 );
		$array[2] = pg_fetch_all_columns($result, 2 );
		$array[3] = pg_fetch_all_columns($result, 3 );
		$array[4] = pg_fetch_all_columns($result, 4 );
		$array[5] = pg_fetch_all_columns($result, 5 );
		$array[6] = pg_fetch_all_columns($result, 6 );
		$array[7] = pg_fetch_all_columns($result, 7 );

		return $array;
	}

	public function setAcademicForEntity()
	{
		// clear
		$this->delAcademicForEntity();

		// set
		for( $i=0; $i < count($_POST['AcademicLevelList']); $i++)
		{
			$degree = trim($_POST['DegreeList'][$i]);
			$academicLevel = trim($_POST['AcademicLevelList'][$i]);
			$degreeGranted = trim($_POST['DegreeGrantedList'][$i]);
			$startDate = trim($_POST['StartDateList'][$i]);
			$finishDate = trim($_POST['FinishDateList'][$i]);
			$institution = trim($_POST['InstitutionList'][$i]);
			$institutionURI = trim($_POST['InstitutionURIList'][$i]);
			$shortComment = trim($_POST['ShortCommentList'][$i]);

			if ( $startDate and $finishDate ) // XXX: Improve this duplication of queries or leave as is now?
				$sqlQuery = "PREPARE query(integer,text,text,text,date,date,text,text,text) AS  INSERT INTO R27_Qualification2Academic (R27_Q1_E1_Id,R27_Degree,R27_LA_Id,R27_DegreeGranted,R27_StartDate,R27_FinishDate,R27_Institution,R27_InstitutionURI,R27_ShortComment) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($degree)."','".pg_escape_string($academicLevel)."','".$degreeGranted."','".pg_escape_string($startDate)."','".pg_escape_string($finishDate)."','".pg_escape_string($institution)."','".pg_escape_string($institutionURI)."','".pg_escape_string($shortComment)."');";
			elseif ( $startDate )
				$sqlQuery = "PREPARE query(integer,text,text,text,date,text,text,text) AS  INSERT INTO R27_Qualification2Academic (R27_Q1_E1_Id,R27_Degree,R27_LA_Id,R27_DegreeGranted,R27_StartDate,R27_Institution,R27_InstitutionURI,R27_ShortComment) VALUES ($1,$2,$3,$4,$5,$6,$7,$8);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($degree)."','".pg_escape_string($academicLevel)."','".$degreeGranted."','".pg_escape_string($startDate)."','".pg_escape_string($institution)."','".pg_escape_string($institutionURI)."','".pg_escape_string($shortComment)."');";
			elseif ( $finishDate )
				$sqlQuery = "PREPARE query(integer,text,text,text,date,text,text,text) AS  INSERT INTO R27_Qualification2Academic (R27_Q1_E1_Id,R27_Degree,R27_LA_Id,R27_DegreeGranted,R27_FinishDate,R27_Institution,R27_InstitutionURI,R27_ShortComment) VALUES ($1,$2,$3,$4,$5,$6,$7,$8);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($degree)."','".pg_escape_string($academicLevel)."','".$degreeGranted."','".pg_escape_string($finishDate)."','".pg_escape_string($institution)."','".pg_escape_string($institutionURI)."','".pg_escape_string($shortComment)."');";
			else
				$sqlQuery = "PREPARE query(integer,text,text,text,text,text,text) AS  INSERT INTO R27_Qualification2Academic (R27_Q1_E1_Id,R27_Degree,R27_LA_Id,R27_DegreeGranted,R27_Institution,R27_InstitutionURI,R27_ShortComment) VALUES ($1,$2,$3,$4,$5,$6,$7);  EXECUTE query('$_SESSION[EntityId]','".pg_escape_string($degree)."','".pg_escape_string($academicLevel)."','".$degreeGranted."','".pg_escape_string($institution)."','".pg_escape_string($institutionURI)."','".pg_escape_string($shortComment)."');";

			$this->postgresql->execute($sqlQuery,1);
		}
	}

	public function delAcademicForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R27_Qualification2Academic WHERE R27_Q1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$this->postgresql->execute($sqlQuery,1);
	}
}
