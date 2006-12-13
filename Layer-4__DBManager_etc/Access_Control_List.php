<?php
// Authors: Davi Leal
//
// Copyright (C) 2006 Davi Leal <davi at leals dot com>
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


require_once "../Layer-5__DB_operation/Qualifications.php";


class AccessControlList
{
	private function granted()
	{
	}

	private function notGranted()
	{
		$error = "<p>".gettext('The access is not granted.')."</p>";
		throw new Exception($error,true);
	}


	public function checkQualificationsAccess($mode,$E1_Id)
	{
		$qualifications = new Qualifications();

		switch ($mode) {
			case "READ": // Data Base operations: get
				if ( // Check if the request comes from the Qualifications owner
				     $qualifications->isOwner($E1_Id) == true
					or
				     // Check if the request comes from an Entity that has a JobOffer with such Qualifications subscribed
				     $qualifications->isJobOfferApplication($E1_Id) == true
				   )
					$this->granted();
				else
					$this->notGranted();

				break;

		//	case "WRITE": // Data Base operations: add, delete, update
		//		$this->notGranted();
		//		break;

			default:
				$this->notGranted();
		}
	}
}
?> 
