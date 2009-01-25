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

require_once "../Layer-4__DBManager_etc/DB_Manager.php";

class ViewPhotoOrLogo
{
	private function checkParameters()
	{
		// Data         = Me, Qualifications or JobOffer
		// EntityId     = EntityId

		if ( ($_GET['Data'] != "Me" and $_GET['Data'] != "Qualifications" and $_GET['Data'] != "JobOffer")  or  $_GET['EntityId'] == '' )
		{
			echo "Wrong parameters";
			exit;
		}
	}

	public function viewPhotoOrLogo()
	{
		$manager = new DBManager();

		// Check parameters and then we ask to the DB manager for the PNG image.
		$this->checkParameters();

		// Ask to the DB manager for the PNG image.
		if ( $_GET['Data'] == "Me" )
			$im = $manager->getEntityPhotoOrLogo($_SESSION['EntityId']);
		elseif ( $_GET['Data'] == "Qualifications" )
			$im = $manager->getQualificationsPhotoOrLogoForEntity($_GET['EntityId']);
		elseif ( $_GET['Data'] == "JobOffer" )
			$im = $manager->getJobOfferPhotoOrLogoForEntity($_GET['EntityId']);

		// Send the image to the web browser.
		ob_start("pngOutputHandler");
		imagepng($im,NULL);
		ob_end_flush();
	}
}
