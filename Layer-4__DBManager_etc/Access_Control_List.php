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

	private function notGranted_hintSessionExpired()
	{
		$error = "<p>".gettext('The access is not granted.')."</p><p>".gettext('Has the logged session expired?')."</p>";
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
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Cooperative' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
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

	public function checkSkillsAdminAccess()
	{
		$this->checkProperlyLogged();

		if ( $_SESSION['SkillsAdmin'] == true )
			$this->granted();
		else
			$this->notGranted();
	}


	public function checkQualificationsAccess($mode,$E1_Id)
	{
		// Check access to both:
		// qualifications entity information: profiles, academic, skills, languages, etc.,
		// and personal entity information: photo or logo, name, address, landline, etc.

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


	public function checkJobOfferEntityAccess($mode,$E1_Id)
	{
		// Check access to general entity information: photo or logo, name, etc.

		$jobOffer = new JobOffer();

		switch ($mode) {
			case "READ": // Data Base operations: get
				if ( // Check if the request comes from the JobOffer owner
				     $jobOffer->isOwner($E1_Id) == true
					or
				     // Check if the E1_Id entity has some job offer published
				     $jobOffer->hasJobOfferPublished($E1_Id) == true
					or
				     // Check if the logged entity is subscribed to some of the job offers owned by the E1_Id entity, even if such job offers are not active
				     $jobOffer->isApplicant($E1_Id) == true
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
					// If the job offer is not active, only the job offer owner and the entities already subscribed to such job offer can read it.
					if ( $_SESSION['Logged'] == '1' )
					{
						$joboffers = $jobOffer->getJobOffersForEntity(); // Job Offers for the logged Entity
						$entities = $jobOffer->getEntitiesSubscribed($J1_Id); // Entities subscribed to the $J1_Id Job Offer

						if ( in_array($J1_Id,$joboffers[0]) or in_array($_SESSION['EntityId'],$entities) )
							$this->granted();
						else
							$this->notActive();
					}
					else
					{
						$this->notActive();
					}
				}

				break;

			case "WRITE":
				$joboffer = $jobOffer->getJobOffer($J1_Id);

				switch ($joboffer[62][0]) {
					case 'Job offer':
					case 'Job offer (post faster)':

						if ( $_SESSION['Logged'] == '1' )
						{
							$joboffers = $jobOffer->getJobOffersForEntity(); // Job Offers for the logged Entity
						}

						if ( !in_array( $J1_Id, $joboffers[0] ) )
							$this->notGranted_hintSessionExpired();
						else
							$this->granted();

						break;

					case 'Donation pledge group':
						$this->granted(); // Anyone can edit if they follows the web application work flow
						break;

					case 'Looking for volunteers':
						$this->granted(); // Anyone can edit if they follows the web application work flow
						break;

					default:
						$this->notGranted();

				}

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
				$joboffer = $jobOffer->getJobOffer($J1_Id);
				if ( $joboffer[62][0] == 'Donation pledge group' ) // XXX: TODO: CHECK: The applicant's names for Donation pledge groups are public if they are not specially set to anonymous
				{
					$this->granted();
				}
				else
				{
					$joboffers = $jobOffer->getJobOffersForEntity();

					if ( !in_array( $J1_Id, $joboffers[0] ) )
						$this->notGranted();
				}

				break;

			default:
				$this->notGranted();
		}
	}
}
