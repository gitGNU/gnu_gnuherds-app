<?php
// Authors: Davi Leal
// 
// Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
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


class PHPTools
{
	public function resetPHPsession()
	{
		$language = $_SESSION['Language'];

		// Unset all of the session variables.
		session_unset();

		// We do not destroy the session with session_destroy()
		// due to we want to recover the $language.

		$_SESSION['Language'] = $language;
	}
}
?>
