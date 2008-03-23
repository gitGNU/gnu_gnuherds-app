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


require_once "../Layer-4__DBManager_etc/DB_Manager.php";


class DeletePhotoOrLogo
{
	private function goBack()
	{
		if ( $_SESSION['LoginType'] == 'Person' )
			$request_uri = "person"; // The request come from that URI
		elseif ( $_SESSION['LoginType'] == 'Company' )
			$request_uri = "company";
		elseif ( $_SESSION['LoginType'] == 'non-profit Organization' )
			$request_uri = "nonprofit";

		header("Location: https://$_SERVER[HTTP_HOST]/$request_uri");
	}

	public function deletePhotoOrLogo()
	{
		$manager = new DBManager();
		$manager->deletePhotoOrLogo();

		$this->goBack();
	}
}
?>
