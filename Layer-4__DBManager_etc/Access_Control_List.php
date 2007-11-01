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


require_once "../Layer-5__DB_operation/Qualifications.php";


class AccessControlList
{
	private function granted()
	{
	}

	private function notGranted()
	{
		$error = "<p>".gettext('The access is not granted.')."</p>";
		throw new Exception($error,false);
	}

	private function notActive()
	{
		$error = "<p>".gettext('Such job offer is already closed, removed, or never was here.')."</p>";
		throw new Exception($error,false);
	}

	public function checkProperlyLogged()
	{
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>".gettext('To access this section you have to login first.')."</p>";
				throw new Exception($error,false);
			}
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
    		}
	}


	public function checkQualificationsAccess($mode,$E1_Id)
	{
		$this->checkProperlyLogged();

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


	public function checkEntityAccess($mode,$E1_Id)
	{
		$jobOffer = new JobOffer();

		switch ($mode) {
			case "READ": // Data Base operations: get
				if ( // Check if the request comes from the JobOffer owner
				     $jobOffer->isOwner($E1_Id) == true
					or
				     // Check if the E1_Id entity has some job offer published
				     $jobOffer->hasJobOfferPublished($E1_Id) == true
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


	public function checkJobOfferAccess($mode,$J1_Id)
	{
		$jobOffer = new JobOffer();

		switch ($mode) {
			case "READ":
				// We add this ACL due to though a job offer can be closed or expired, Google keeps the link
				// to such job offer, e.g. https://www.gnuherds.org/View_Job_Offer.php?JobOfferId=10 . So we
				// have to block the access to it to avoid confussion. Else, people could think it is an
				// active job offer.
				// Additionally, with this ACL, we show a soft message instead of an error when a client try
				// to access an non-existent job offer.

				if ( $jobOffer->isJobOfferActive($J1_Id) )
				{
					// If the job offer is active, it is public information. So we grant the READ access.
					$this->granted();
				}
				else
				{
					// If the job offer is not active, only the job offer owner can read it.
					if ( $_SESSION['Logged'] == '1' )
					{
						$joboffers = $jobOffer->getJobOffersForEntity(); // Job Offers for the logged Entity

						if ( !in_array( $J1_Id, $joboffers[0] ) )
							$this->notActive();
						else
							$this->granted();
					}
					else
					{
						$this->notActive();
					}
				}

				break;

			case "WRITE":
				$joboffers = $jobOffer->getJobOffersForEntity(); // Job Offers for the logged Entity

				if ( !in_array( $J1_Id, $joboffers[0] ) )
					$this->notGranted();

				break;

			default:
				$this->notGranted();
		}
	}


	public function checkApplicationsAccess($mode,$J1_Id)
	{
		$jobOffer = new JobOffer();

		switch ($mode) {
			case "READ":
			case "WRITE":
				$joboffers = $jobOffer->getJobOffersForEntity();

				if ( !in_array( $J1_Id, $joboffers[0] ) )
					$this->notGranted();

				break;

			default:
				$this->notGranted();
		}
	}
}
?> 
