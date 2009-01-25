-- Authors: Davi Leal
-- 
-- Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
-- 
-- This program is free software: you can redistribute it and/or modify it under
-- the terms of the GNU Affero General Public License as published by the Free Software Foundation,
-- either version 3 of the License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
-- General Public License for more details.
-- 
-- You should have received a copy of the GNU Affero General Public License along with this
-- program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.


-- Note: We revert to the version without Object Oriented support due to the PostgreSQL OO support is not good. Read http://www.postgresql.org/docs/8.1/static/ddl-inherit.html  5.8.1. Caveats


-- Many 2 many Relations
DROP TABLE R11_JobOffer2FieldProfiles;
DROP TABLE R12_JobOffer2ProfessionalProfiles;
DROP TABLE R13_JobOffer2ProductProfiles;
DROP TABLE R14_JobOffer2Skills;
DROP TABLE R15_JobOffer2Languages;
DROP TABLE R16_JobOffer2Certifications;
DROP TABLE R17_JobOffer2Nationalities;

DROP TABLE R21_Qualification2FieldProfiles;
DROP TABLE R22_Qualification2ProfessionalProfiles;
DROP TABLE R23_Qualification2ProductProfiles;
DROP TABLE R24_Qualification2Skills;
DROP TABLE R25_Qualification2Languages;
DROP TABLE R26_Qualification2Certifications;
DROP TABLE R27_Qualification2Academic;


-- Qualifications
DROP TABLE Q1_Qualifications; -- Resumes, for Persons, Companies and non-profit Organizations.

-- Searches
DROP TABLE QS_QualificationSearches;
DROP TABLE JS_JobOfferSearches;

-- Relations
DROP TABLE R0_Qualifications2JobOffersJoins; -- Application state. Resume, that is to say, entities Qualifications to JobOffer relationships.
DROP TABLE R1_Donations2JobOffersJoins; -- Donation pledge groups.
DROP TABLE E2_EntityFreeSoftwareExperiences; -- Contributions to Free Software projects. It extends the E1_Entities table.
DROP TABLE E3_Nationalities; -- List the entity nationalities. It extends the E1_Entities table.
DROP TABLE E4_EntityJobLicenseAt; -- List the countries where the entity has license to work. It extends the E1_Entities table.
DROP TABLE E5_EntityRequireCertifications; -- List the Certifications which this entity requires to its contractors entities or contracted entities. Take into account that some certifications can be only applyed to some entity types; See the content of the LC_Certifications table. For example a certification which is only applied to Persons, of course, is not required to Companies. This table extends the E1_Entities table.
DROP TABLE J1_JobOffers;
DROP TABLE A1_Alerts;
DROP TABLE E1_Entities;

-- Lists:
DROP TABLE LJ_OfferType;
DROP TABLE LN_Nationalities; -- Nationalities internationally recognized. That is to say, ISO nationalities.
DROP TABLE LO_Countries;
DROP TABLE LU_Currencies;
DROP TABLE LA_AcademicLevels;
DROP TABLE LC_Certifications; -- We do not translate de certifications. It is better so, in order to keep a unique 'image'. It is as the usual mark image.
DROP TABLE LK_ContractType;
DROP TABLE LB_ByPeriod;
DROP TABLE LM_TimeUnits;
DROP TABLE LE_Employability;
DROP TABLE LS_SpokenLevel;   -- List of Languages-Spoken-Levels
DROP TABLE LW_WrittenLevel; -- List of Languages-Written-Levels
DROP TABLE LZ_ApplicationStates;

-- Lists of Profiles:
DROP TABLE LF_FieldProfiles;
DROP TABLE LP_ProfessionalProfiles;
DROP TABLE LX_ProductProfiles; -- Due to the general use, the words keep into this table does not need translation. It uses the English language.

-- Lists of Skills:
DROP TABLE LI_Skills;
DROP TABLE LH_Skills;
DROP TABLE LT_SkillSetTypes;
DROP TABLE LG_KnowledgeLevel;
DROP TABLE LN_ExperienceLevel;

--
DROP TABLE LL_Languages;



-- =============================================================================


CREATE TABLE LJ_OfferType (
        LJ_Id            varchar(22) PRIMARY KEY CHECK (LJ_Id <> '')
);


CREATE TABLE LL_Languages (
        LL_TwoLetter     char(2) PRIMARY KEY CHECK (LL_TwoLetter <> ''),
        LL_Name          varchar(20) UNIQUE NOT NULL CHECK (LL_Name <> '')
);


CREATE TABLE LO_Countries (
        LO_TwoLetter     char(2) PRIMARY KEY CHECK (LO_TwoLetter <> ''),
        LO_ThreeLetter   char(3) UNIQUE NOT NULL CHECK (LO_ThreeLetter <> ''),
        LO_ThreeDigit    char(3) UNIQUE NOT NULL CHECK (LO_ThreeDigit <> ''),

        -- Due to the country name is sometimes long, we have
        -- splitted it into a Name, an Adjective and a Description.
        LO_Name          varchar(80) NOT NULL,
        LO_Adjective     varchar(80),
        LO_Description   varchar(100)
);


CREATE TABLE LN_Nationalities ( -- Nationalities internationally recognized. That is to say, ISO nationalities.
        LN_LO_TwoLetter  char(2) UNIQUE REFERENCES LO_Countries(LO_TwoLetter) NOT NULL,
        LN_Name          varchar(80) NOT NULL
);


CREATE TABLE LU_Currencies (
        LU_ThreeLetter   char(3) PRIMARY KEY CHECK (LU_ThreeLetter <> ''),

        LU_Name          varchar(80) UNIQUE NOT NULL CHECK (LU_Name <> ''),
        LU_PluralName    varchar(80) UNIQUE NOT NULL CHECK (LU_PluralName <> ''),
        LU_CountryList   varchar(240) NOT NULL CHECK (LU_CountryList <> ''), -- Used at these countries.

	LU_RefValue      NUMERIC(14,7) -- Value of reference to EUR or USD. -- XXX: Set the proper numbers, instead of 14 & 7
	  -- References: http://www.postgresql.org/docs/8.0/static/datatype-money.html
	  --             http://www.postgresql.org/docs/8.0/static/datatype.html#DATATYPE-NUMERIC-DECIMAL
          -- XXX: This field below table could be loaded, for example, by a 'cron' process.
                  -- Currency Update Service: http://www.xe.com/cus/
);


CREATE TABLE LA_AcademicLevels (
	LA_Id		varchar(40) PRIMARY KEY,
	LA_Level	char(2) UNIQUE NOT NULL CHECK (LA_Level <> '')
);


CREATE TABLE LF_FieldProfiles (
	LF_Id	varchar(17) PRIMARY KEY CHECK (LF_Id <> '')
);


CREATE TABLE LP_ProfessionalProfiles (
	LP_Id	varchar(26) PRIMARY KEY CHECK (LP_Id <> '')
);


CREATE TABLE LX_ProductProfiles (
	LX_Id	varchar(8) PRIMARY KEY CHECK (LX_Id <> '')
);


CREATE TABLE LC_Certifications (
        LC_Name               varchar(30) PRIMARY KEY CHECK (LC_Name <> ''),
	LC_Apply2Person       bool NOT NULL DEFAULT 'false', -- This certification can be applied to Persons entities
	LC_Apply2Company      bool NOT NULL DEFAULT 'false', -- This certification can be applied to Companies entities
	LC_Apply2Organization bool NOT NULL DEFAULT 'false'  -- This certification can be applied to no-for-profit Organizations entities
);


CREATE TABLE LK_ContractType (
	LK_Id	varchar(15) PRIMARY KEY CHECK (LK_Id <> '')
);


CREATE TABLE LB_ByPeriod(
	LB_Id	varchar(11) PRIMARY KEY CHECK (LB_Id <> '')
);


CREATE TABLE LM_TimeUnits(
	LM_Id	varchar(6) PRIMARY KEY CHECK (LM_Id <> '')
);


CREATE TABLE LE_Employability (
	LE_Id	varchar(22) PRIMARY KEY CHECK (LE_Id <> '')
);


CREATE TABLE LS_SpokenLevel (
	LS_Id	varchar(20) PRIMARY KEY CHECK (LS_Id <> ''),
	LS_Level char(2) NOT NULL CHECK (LS_Level <> '')
);


CREATE TABLE LW_WrittenLevel (
	LW_Id	varchar(20) PRIMARY KEY CHECK (LW_Id <> ''),
	LW_Level char(2) NOT NULL CHECK (LW_Level <> '')
);


CREATE TABLE LZ_ApplicationStates (
	LZ_Id	varchar(10) PRIMARY KEY CHECK (LZ_Id <> '')
);


CREATE TABLE LT_SkillSetTypes (
	LT_order char(2) NOT NULL UNIQUE CHECK (LT_order <> ''),
	LT_Id	varchar(35) PRIMARY KEY CHECK (LT_Id <> '')
);

CREATE TABLE LH_Skills (
	LH_Id	varchar(23) PRIMARY KEY CHECK (LH_Id <> '')
);

CREATE TABLE LI_Skills (
	LI_Id	varchar(153) PRIMARY KEY CHECK (LI_Id <> ''),
	LI_LH_Id varchar(23) REFERENCES LH_Skills(LH_Id) NOT NULL,
	LI_LT_Id varchar(35), -- REFERENCES LT_SkillSetTypes(LT_Id) NOT NULL

	-- To make the audit and maintenance of the LI_LH_Id skill tags easier.
	LI_LicenseName varchar(128), -- XXX: We could add a new table to keep a license list later.
	LI_LicenseURL  varchar(255),

	LI_ClassificationRationale text -- Rationale about why the skills is tagged as being LI_LH_Id.
);

CREATE TABLE LG_KnowledgeLevel (
	LG_Id	varchar(9) PRIMARY KEY CHECK (LG_Id <> ''),
	LG_Level char(2) NOT NULL CHECK (LG_Level <> '')
);

CREATE TABLE LN_ExperienceLevel (
	LN_Id	varchar(18) PRIMARY KEY CHECK (LN_Id <> ''),
	LN_Level char(2) NOT NULL CHECK (LN_Level <> '')
);


-- =============================================================================

-- Referential Integrity Tutorial
-- -- http://techdocs.postgresql.org/techdocs/hackingreferentialintegrity.php
-- -- http://techdocs.postgresql.org/college/002_referentialintegrity/

CREATE TABLE E1_Entities ( -- This table keeps the 'Person', 'Company' and 'non-profit Organization' entities.
        E1_Id              SERIAL PRIMARY KEY, -- Entity identifier

        --------------------------------------------------------------------------
        -- Account identification
        E1_Email           varchar(60) DEFAULT NULL CHECK (E1_Email <> ''), -- Person's email, or Company's or non-profit Organization contact email. It is used as identifier to log in.
        E1_Password        varchar(512) DEFAULT NULL CHECK (E1_Password <> ''),

	-- Others
        E1_Trusted         bool NOT NULL DEFAULT 'false', -- The web application will not block anything done by trusted entities. For example the web app will publish 'Pending'-to-classify skills present in offers and qualifications/resumes of FSF trusted accounts.
        E1_Revoked         bool NOT NULL DEFAULT 'false', -- Account disabled due to the members does not adhere to the Code of Ethics.
        E1_EntityType      varchar(23) NOT NULL CHECK (E1_EntityType <> ''), -- We have to add this field due to we can not use Object Oriented PostgreSQL features. Values will be: "Person", "Company" or "non-profit Organization". 

	-- Properties of web application administration roles
        E1_SkillsAdmin              bool NOT NULL DEFAULT 'false', -- Skills admin with all permission granted.

	-- Saved configuration
	E1_Locale          char(5) NOT NULL CHECK (E1_Locale <> '') DEFAULT 'en_US', -- To be used by the cron jobs to send mensages to each entity with its own locale.

	-- Wanted email
	E1_WantEmail       varchar(60), -- This field keeps the email which the entity want to use. It will be copied to E1_Email if the registration or change-email operations are rightly concluded.

	-- Magic
	E1_LostPasswordMagic        varchar(512) DEFAULT NULL CHECK (E1_LostPasswordMagic <> ''), -- Code which a user must supply to allow the password change.
	E1_RegisterMagic            varchar(512) DEFAULT NULL CHECK (E1_RegisterMagic <> ''), -- Code which a user must supply to allow register an account on that email.
	E1_WantEmailMagic           varchar(512) DEFAULT NULL CHECK (E1_WantEmailMagic <> ''), -- Code which a user must supply to allow the change to use that email.

	-- Magic expiration
	E1_LostPasswordMagicExpire  timestamp NOT NULL DEFAULT 'now',
	E1_RegisterMagicExpire      timestamp NOT NULL DEFAULT 'now',
	E1_WantEmailMagicExpire     timestamp NOT NULL DEFAULT 'now',

	-- To avoid Spam
	-- Each email which needs to avoid Spam has a flag
	E1_ActivateAccountEmail           bool NOT NULL DEFAULT 'true',
	E1_RegisterAccountDuplicatedEmail bool NOT NULL DEFAULT 'true',
	E1_LostPasswordEmail              bool NOT NULL DEFAULT 'true',

        --------------------------------------------------------------------------
        -- Address (Specific Location)
        E1_Street          varchar(80),
        E1_Suite           varchar(10),
        E1_City            varchar(30),
        E1_StateProvince   varchar(30), -- NOT NULL CHECK (E1_StateProvince <> ''),

        E1_PostalCode      varchar(15),
        E1_LO_Country      char(2), -- REFERENCES LO_Countries(LO_TwoLetter) NOT NULL,

        --------------------------------------------------------------------------
        -- ISO Nationalities (Location of birth and other recognized ISO nationalities for Persons, or Location for Companies and non-profit Organizations). (E3_Nationalities)

        --------------------------------------------------------------------------
        -- List the countries where the entity has license to work. (E4_EntityJobLicenseAt)
	
        --------------------------------------------------------------------------
	-- Various
        E1_BirthYear       varchar(4), -- NOT NULL CHECK (Q1_BirthYear <> ''),

        --------------------------------------------------------------------------
        -- Access Control List (ACL): List the Certifications which this entity requires to its contractors entities or contracted entities.
	-- Take into account that some certifications can be only applyed to some entity types; See the content
	-- of the LC_Certifications table. (E5_EntityRequireCertifications)

        --------------------------------------------------------------------------
        -- Interactive communication medias -- Voice-Video contact systems
        -- Internet [Video]Phone: VoIP & Video: Ekiga (a.k.a. GnomeMeeting), Kphone, SJphone, PhoneGaim,
	-- Skype, M$ Messenger. Reference: http://www.voip-info.org/wiki-VOIP+Phones )
        E1_IpPhoneOrVideo       varchar(255),
        E1_Landline             varchar(30),
        E1_MobilePhone          varchar(30),

        --------------------------------------------------------------------------
        -- Blog
        E1_Blog            varchar(255), -- Personal blog. Full URI, ie: http://lwn.net/ to be linked in your Job Offers

        --------------------------------------------------------------------------
        -- Website
        E1_Website         varchar(255), -- Personal, Company or non-profit Organization website. Full URI, ie: http://lwn.net/ to be linked in your Job Offers

        --------------------------------------------------------------------------
        -- Statistics
        E1_Media                text, -- It is just a survey, so it can be NULL. -- NOT NULL CHECK (E1_Media <> '')


	-- Only for Persons

        --------------------------------------------------------------------------
        -- Person Name
        EP_FirstName       varchar(20), -- NOT NULL CHECK (EP_FirstName <> ''),
        EP_LastName        varchar(20),
        EP_MiddleName      varchar(20),

        --------------------------------------------------------------------------
        -- To qualify for voting membership, the entity have to show a contribution to the Free Software community.
        E1_PublicKey       varchar(255), -- XXX: What is the maximum lenght of a public key. Is it unlimited? If so, should we allow a unlimited lenght? Yes, I think so.
        E1_Vote            bool, -- NOT NULL DEFAULT 'false', -- The vote feature is enabled by the committee based on the Contributions to FS (E2_EntityFreeSoftwareExperiences).
        E1_ReEvaluate      bool, -- NOT NULL DEFAULT 'true', -- At a new insert E1_ReEvaluate is set to 'true' automatically.

        --------------------------------------------------------------------------
        -- Statistics
        EP_Motivation      text, -- It is just a survey, so it can be NULL. -- NOT NULL CHECK (EP_Motivation <> '') -- Company motivations to join the Association is supposed to be to get a profit. So, we do not ask for it.

	-- Only for Companies

        --------------------------------------------------------------------------
        -- Company Name
        EC_CompanyName       varchar(30), -- NOT NULL CHECK (EC_CompanyName <> ''),

	-- Only for non-profit Organizations

        --------------------------------------------------------------------------
        -- Organization Name
        EO_OrganizationName  varchar(30) -- NOT NULL CHECK (EO_OrganizationName <> '')
);


CREATE TABLE A1_Alerts ( -- Alerts about anything: job offers, etc.
        A1_E1_Id           integer PRIMARY KEY REFERENCES E1_Entities(E1_Id) NOT NULL,

	-- Alerts
        A1_NewJobOffer             bool NOT NULL DEFAULT 'true', -- Alert me when _any_ new job offer is added.
        A1_NewDonationPledgeGroup  bool NOT NULL DEFAULT 'false', -- Alert me when _any_ new donation-pledge-group is added.
        A1_NewLookForVolunteers    bool NOT NULL DEFAULT 'false', -- Alert me when _any_ new look-for-volunteers is added.

	-- Alerts behavior
        A1_AlertMeOnMyOwnNotices   bool NOT NULL DEFAULT 'true' -- Determines if the entity should be alerted on its own notices too. So I will be able to note when alerts about my notices are sent to other association members.
);


CREATE TABLE Q1_Qualifications (
        Q1_E1_Id                           integer PRIMARY KEY REFERENCES E1_Entities(E1_Id) NOT NULL,
        Q1_CompletedEdition                bool DEFAULT 'false', -- The edition has been successfully completed. All checks pass.

        Q1_ProfessionalExperienceSinceYear varchar(4), -- NOT NULL CHECK (Q1_ProfessionalExperienceSinceYear <> ''),

        -- Academic (R27_Qualification2Academic)

        -- Profiles of: Field, Professional, and Product: (R21_Qualification2FieldProfiles, R22_Qualification2ProfessionalProfiles, R23_Qualification2ProductProfiles)

        -- Skills (R24_Qualification2Skills)

        -- Languages (R25_Qualification2Languages)

        -- Certifications (R26_Qualification2Certifications)
        -- FS Contributions: Experience with Free Software (E2_EntityFreeSoftwareExperiences)

	-- Only for Persons
        QP_LK_DesiredContractType      varchar(15), --  REFERENCES LK_ContractType(LK_Id), -- NOT NULL,
        QP_DesiredWageRank             varchar(90), -- point, -- NOT NULL,
        QP_LU_WageRankCurrency         char(3), -- REFERENCES LU_Currencies(LU_ThreeLetter), -- NOT NULL,
	QP_LB_WageRankByPeriod         varchar(11), -- REFERENCES LB_ByPeriod(LB_Id), -- NOT NULL,
        QP_CurrentEmployability        varchar(22), --  REFERENCES LE_Employability(LE_Id), -- NOT NULL,
        QP_AvailableToTravel           bool, -- DEFAULT 'false', -- NOT NULL,
        QP_AvailableToChangeResidence  bool -- DEFAULT 'false' -- NOT NULL
        -- The applicant's current location is filled in the E1_Entities table.
);


CREATE TABLE QS_QualificationSearches (
        QS_E1_Id           integer REFERENCES E1_Entities(E1_Id) NOT NULL,
        QS_SqlQuery        text NOT NULL CHECK (QS_SqlQuery <> ''), -- Allows duplication of the same sql query, that is to say, the same search.
        QS_Description     text NOT NULL CHECK (QS_Description <> '')
);

CREATE TABLE JS_JobOfferSearches (
        JS_E1_Id           integer REFERENCES E1_Entities(E1_Id) NOT NULL,
        JS_SqlQuery        text NOT NULL CHECK (JS_SqlQuery <> ''), -- Allows duplication of the same sql query, that is to say, the same search.
        JS_Description     text NOT NULL CHECK (JS_Description <> '')
);


CREATE TABLE R26_Qualification2Certifications (
	R26_Q1_E1_Id    integer REFERENCES Q1_Qualifications(Q1_E1_Id) NOT NULL,
	R26_LC_Name     varchar(30) REFERENCES LC_Certifications(LC_Name) NOT NULL,
	R26_State       varchar(15) NOT NULL DEFAULT 'Pending' -- 'Pending' ==> assigned-Queued ==> 'Rejected' or 'Accepted'
);

CREATE TABLE R21_Qualification2FieldProfiles (
	R21_Q1_E1_Id    integer REFERENCES Q1_Qualifications(Q1_E1_Id) NOT NULL,
	R21_LF_Id       varchar(17) REFERENCES LF_FieldProfiles(LF_Id) NOT NULL
);
CREATE TABLE R22_Qualification2ProfessionalProfiles (
	R22_Q1_E1_Id    integer REFERENCES Q1_Qualifications(Q1_E1_Id) NOT NULL,
	R22_LP_Id       varchar(26) REFERENCES LP_ProfessionalProfiles(LP_Id) NOT NULL
);
CREATE TABLE R23_Qualification2ProductProfiles (
	R23_Q1_E1_Id    integer REFERENCES Q1_Qualifications(Q1_E1_Id) NOT NULL,
	R23_LX_Id       varchar(8) REFERENCES LX_ProductProfiles(LX_Id) NOT NULL
);

CREATE TABLE R24_Qualification2Skills (
	R24_Q1_E1_Id    integer REFERENCES Q1_Qualifications(Q1_E1_Id) NOT NULL,
	R24_LI_Id       varchar(153) REFERENCES LI_Skills(LI_Id) NOT NULL,
	R24_LG_Id       varchar(9) REFERENCES LG_KnowledgeLevel(LG_Id) NOT NULL,
	R24_LN_Id       varchar(18) REFERENCES LN_ExperienceLevel(LN_Id) NOT NULL
);

CREATE TABLE R25_Qualification2Languages (
	R25_Q1_E1_Id    integer REFERENCES Q1_Qualifications(Q1_E1_Id) NOT NULL,
	R25_LL_Name     varchar(20) REFERENCES LL_Languages(LL_Name) NOT NULL,
	R25_LS_Id       varchar(20) REFERENCES LS_SpokenLevel(LS_Id) NOT NULL,
	R25_LW_Id       varchar(20) REFERENCES LW_WrittenLevel(LW_Id) NOT NULL
);

CREATE TABLE R27_Qualification2Academic (
	R27_Q1_E1_Id    integer REFERENCES Q1_Qualifications(Q1_E1_Id) NOT NULL,
	R27_Degree      varchar(80),
	R27_LA_Id       varchar(40), -- REFERENCES LA_AcademicLevels(LA_Id), -- If the user does not fill this field the automatic check will not work. Anyway we do not force the user to fill it.
        R27_DegreeGranted varchar(3), -- bool DEFAULT 'false',
        R27_StartDate   date,
        R27_FinishDate  date,
	R27_Institution varchar(80), -- University or education institution
	R27_InstitutionURI varchar(255), -- URI of such University or education institution
        R27_ShortComment varchar(80) -- Short comment or description
);

CREATE TABLE E2_EntityFreeSoftwareExperiences ( -- Contributions to Free Software projects
        E2_Id           SERIAL PRIMARY KEY, -- Identifier
        E2_E1_Id        integer REFERENCES E1_Entities(E1_Id) NOT NULL, -- Entity identity: being a Person, a Company or a non-profit Organization.
        E2_Project      varchar(30),
        E2_Description  varchar(60),
	E2_URI          varchar(255) -- One URI for each register. It will be checked automatically. Note the user can supply several URIs to the same FS project inserting several registers, one for each URI, due to E2_Project is not a primary key.
);

CREATE TABLE E3_Nationalities ( -- List the entity nationalities.
        E3_E1_Id        integer REFERENCES E1_Entities(E1_Id) NOT NULL, -- Entity identity: being a Person, a Company or a non-profit Organization.
        E3_LN_Id        char(2) REFERENCES LN_Nationalities(LN_LO_TwoLetter) NOT NULL
);

CREATE TABLE E4_EntityJobLicenseAt ( -- List the countries where the entity has license to work.
        E4_E1_Id        integer REFERENCES E1_Entities(E1_Id) NOT NULL, -- Entity identity: being a Person, a Company or a non-profit Organization.
        E4_LO_Id        char(2) REFERENCES LO_Countries(LO_TwoLetter) NOT NULL
);

CREATE TABLE E5_EntityRequireCertifications ( -- List the Certifications which this entity requires to its contractors entities or contracted entities. Take into account that some certifications can be only applyed to some entity types; See the content of the LC_Certifications table.
        E5_E1_Id        integer REFERENCES E1_Entities(E1_Id) NOT NULL, -- Entity identity: being a Person, a Company or a non-profit Organization.
        E5_LC_Name      varchar(30) REFERENCES LC_Certifications(LC_Name) NOT NULL
);


CREATE TABLE J1_JobOffers ( -- XXX: TODO: The idea is that maybe some of the volunteer-looking or pledges can be converted to actual job offers if they success getting the support of the needed donators.
        J1_Id              SERIAL PRIMARY KEY, -- Job Offer identifier
        J1_E1_Id           integer REFERENCES E1_Entities(E1_Id) NOT NULL, -- Employer identity: being a Person, a Company or a non-profit Organization.
        J1_CompletedEdition bool DEFAULT 'false', -- The edition has been successfully completed. All checks pass.
        J1_OfferType       varchar(22) REFERENCES LJ_OfferType(LJ_Id) NOT NULL,

        -- General data

        J1_EmployerJobOfferReference varchar(30), -- Id used by some entities to identify internally its job offers.
        J1_OfferDate       date, -- NOT NULL,
        J1_ExpirationDate  date, -- NOT NULL, -- An offer is active or filed. You can change the state editing the J1_ExpirationDate field. Initially, the expiration date will be 30 days more than the J1_OfferDate. It could be modified later if this web site is well-known and intensively used.
	J1_Closed          bool DEFAULT 'false', -- An offer is active or closed, that is to say, it does not accept more applicants. -- NOT NULL

        J1_HideEmployer    bool DEFAULT 'false', -- To hide the identity of the job supplier. -- NOT NULL

        J1_AllowPersonApplications       bool DEFAULT 'false', -- NOT NULL
        J1_AllowCompanyApplications      bool DEFAULT 'false', -- NOT NULL
        J1_AllowOrganizationApplications bool DEFAULT 'false', -- NOT NULL

        -- Offer:

        J1_VacancyTitle    varchar(100), -- NOT NULL CHECK (J1_VacancyTitle <> ''),
        J1_Vacancies       varchar(3),
        J1_Description     text, -- NOT NULL CHECK (J1_Description <> ''),

        -- Contract
        J1_LK_ContractType       varchar(15), -- REFERENCES LK_ContractType(LK_Id) NOT NULL,
        -- J1_ContractDuration varchar(255), - - - XXX: Is this field already implicit in the J1_LK_ContractType field?
        J1_WageRank              varchar(90), -- point, -- Minimum-Optimum
        J1_CommissionsIncentives varchar(255), -- - - - XXX: This fields is not used. If we use it, use a combo box to avoid another free-to-fill field.
        J1_LU_Currency           char(3), -- REFERENCES LU_Currencies(LU_ThreeLetter), -- NOT NULL,
	J1_LB_WageRankByPeriod   varchar(11), -- REFERENCES LB_ByPeriod(LB_Id), -- NOT NULL,
	J1_EstimatedEffort       varchar(90),
	J1_LM_TimeUnit           varchar(6), -- REFERENCES LM_TimeUnits(LM_Id), -- NOT NULL,
	J1_Deadline              date,
        J1_LaborDay_Schedule     varchar(255), -- NOT NULL CHECK (J1_LaborDay_Schedule <> '') -- Days of labor, (e.g.: Monday-Friday), and it schedule. -- The payment can be at finishing the project. - - - XXX: This fields is not used. If we use it, use a combo box to avoid another free-to-fill field.

        -- Requirements: The JobOffer demand:

        J1_ProfessionalExperienceSinceYear varchar(4),
	J1_LA_Id                           varchar(40), --  REFERENCES LA_AcademicLevels(LA_Id) NOT NULL, -- The Job Offer requires a minimum level of academic qualification.
        -- Certifications                                 (R16_JobOffer2Certifications)
        -- Profiles of: Field, Professional, and Product: (R11_JobOffer2FieldProfiles, R12_JobOffer2ProfessionalProfiles, R13_JobOffer2ProductProfiles)
        -- Skills                                         (R14_JobOffer2Skills)
        -- Languages                                      (R15_JobOffer2Languages)
        J1_FreeSoftwareProjects            varchar(60), -- NOT NULL CHECK (J1_FreeSoftwareProjects <> ''),

        -- Residence Location
        J1_City            varchar(30), -- Do not fill any address field if the offer is Telework.
        J1_StateProvince   varchar(30),
        J1_LO_Country      char(2), -- REFERENCES LO_Countries(LO_TwoLetter) NOT NULL,

        J1_AvailableToTravel bool, -- DEFAULT 'false', -- NOT NULL,

	-- Nationalities                                  (R17_JobOffer2Nationalities)  -- Only interested on applicants of that nationalities.
        J1_LO_JobLicenseAt   char(2), -- REFERENCES LO_Countries(LO_TwoLetter) -- NOT NULL -- Required license to work at least at that country.

	-- Flags about alerts on job offers
        J1_NewJobOfferAlert             bool DEFAULT 'true', -- Must the new-job-offer alert be raised on this job offer?: true=Yes, false=No. -- NOT NULL
        -- J1_FitMyQualificationsAlert  bool DEFAULT 'true', -- Must the fit-my-qualifications alert be raised on this job offer?: true=Yes, false=No. -- NOT NULL
        J1_NewDonationPledgeGroupAlert  bool DEFAULT 'true', -- Must the new-donation-pledge-group alert be raised on this donation-pledge-group?: true=Yes, false=No. -- NOT NULL
        J1_NewLookForVolunteersAlert    bool DEFAULT 'true' -- Must the new-look-for-volunteers alert be raised on this look-for-volunteers?: true=Yes, false=No. -- NOT NULL
        -- J1_CustomAlert               bool DEFAULT 'true' -- Must the custom alerts be raised on this job offer?: true=Yes, false=No. -- NOT NULL
);


CREATE TABLE R16_JobOffer2Certifications (
	R16_J1_Id    integer REFERENCES J1_JobOffers(J1_Id) NOT NULL,
	R16_LC_Name  varchar(30) REFERENCES LC_Certifications(LC_Name) NOT NULL
);

CREATE TABLE R11_JobOffer2FieldProfiles (
	R11_J1_Id    integer REFERENCES J1_JobOffers(J1_Id) NOT NULL,
	R11_LF_Id    varchar(17) REFERENCES LF_FieldProfiles(LF_Id) NOT NULL
);
CREATE TABLE R12_JobOffer2ProfessionalProfiles (
	R12_J1_Id    integer REFERENCES J1_JobOffers(J1_Id) NOT NULL,
	R12_LP_Id    varchar(26) REFERENCES LP_ProfessionalProfiles(LP_Id) NOT NULL
);
CREATE TABLE R13_JobOffer2ProductProfiles (
	R13_J1_Id    integer REFERENCES J1_JobOffers(J1_Id) NOT NULL,
	R13_LX_Id    varchar(8) REFERENCES LX_ProductProfiles(LX_Id) NOT NULL
);

CREATE TABLE R14_JobOffer2Skills (
	R14_J1_Id    integer REFERENCES J1_JobOffers(J1_Id) NOT NULL,
	R14_LI_Id    varchar(153) REFERENCES LI_Skills(LI_Id) NOT NULL,
	R14_LG_Id    varchar(9) REFERENCES LG_KnowledgeLevel(LG_Id) NOT NULL,
	R14_LN_Id    varchar(18) REFERENCES LN_ExperienceLevel(LN_Id) NOT NULL
);

CREATE TABLE R15_JobOffer2Languages (
	R15_J1_Id    integer REFERENCES J1_JobOffers(J1_Id) NOT NULL,
	R15_LL_Name  varchar(20) REFERENCES LL_Languages(LL_Name) NOT NULL,
	R15_LS_Id    varchar(20) REFERENCES LS_SpokenLevel(LS_Id) NOT NULL,
	R15_LW_Id    varchar(20) REFERENCES LW_WrittenLevel(LW_Id) NOT NULL
);

CREATE TABLE R17_JobOffer2Nationalities (
	R17_J1_Id    integer REFERENCES J1_JobOffers(J1_Id) NOT NULL,
        R17_LN_Id    char(2) REFERENCES LN_Nationalities(LN_LO_TwoLetter) NOT NULL
);


CREATE TABLE R0_Qualifications2JobOffersJoins (
        R0_J1_Id     integer REFERENCES J1_JobOffers(J1_Id) NOT NULL, -- Offer identifier
        R0_State     varchar(10) REFERENCES LZ_ApplicationStates NOT NULL,
        R0_E1_Id     integer REFERENCES E1_Entities(E1_Id) NOT NULL, -- Applicant's identity, being a Person, Company or non-profit Organization.
	PRIMARY KEY (R0_J1_Id,R0_E1_Id)
);

CREATE TABLE R1_Donations2JobOffersJoins (
        R1_Id        SERIAL PRIMARY KEY, -- Identifier
        R1_J1_Id     integer REFERENCES J1_JobOffers(J1_Id) NOT NULL, -- Offer identifier
        R1_Donation  varchar(15) NOT NULL,
        R1_E1_Id     integer REFERENCES E1_Entities(E1_Id) NOT NULL -- Donator's identity, being a Person, Company or non-profit Organization.
);



GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE E1_Entities, E1_Entities_e1_id_seq, E2_EntityFreeSoftwareExperiences, E2_EntityFreeSoftwareExperiences_e2_id_seq, E3_Nationalities, E4_EntityJobLicenseAt, E5_EntityRequireCertifications, Q1_Qualifications, QS_QualificationSearches, JS_JobOfferSearches, J1_JobOffers, J1_JobOffers_j1_id_seq, R0_Qualifications2JobOffersJoins, R1_Donations2JobOffersJoins, R16_JobOffer2Certifications, R11_JobOffer2FieldProfiles, R12_JobOffer2ProfessionalProfiles, R13_JobOffer2ProductProfiles, R14_JobOffer2Skills, R15_JobOffer2Languages, R17_JobOffer2Nationalities, R26_Qualification2Certifications, R21_Qualification2FieldProfiles, R22_Qualification2ProfessionalProfiles, R23_Qualification2ProductProfiles, R24_Qualification2Skills, R25_Qualification2Languages, R27_Qualification2Academic
TO "www-data" ;

GRANT SELECT  -- Note these tables are not modified by the webapp.
ON TABLE LJ_OfferType, LO_Countries, LU_Currencies, LL_Languages, LA_AcademicLevels, LC_Certifications, LK_ContractType, LB_ByPeriod, LM_TimeUnits, LE_Employability, LS_SpokenLevel, LW_WrittenLevel, LF_FieldProfiles, LP_ProfessionalProfiles, LX_ProductProfiles, LI_Skills, LT_SkillSetTypes, LG_KnowledgeLevel, LN_ExperienceLevel, LZ_ApplicationStates
TO "www-data" ;



INSERT INTO LJ_OfferType VALUES ( 'Job offer' ); -- That is the same text which is shown in the head of offers view.
INSERT INTO LJ_OfferType VALUES ( 'Donation pledge group' );
INSERT INTO LJ_OfferType VALUES ( 'Looking for volunteers' );



-- Reference: http://www.kidon.com/media-link/iso639.shtml
INSERT INTO LL_Languages VALUES ( 'aa', 'Afar' );
INSERT INTO LL_Languages VALUES ( 'ab', 'Abkhazian' );
INSERT INTO LL_Languages VALUES ( 'af', 'Afrikaans' );
INSERT INTO LL_Languages VALUES ( 'am', 'Amharic' );
INSERT INTO LL_Languages VALUES ( 'ar', 'Arabic' );
INSERT INTO LL_Languages VALUES ( 'as', 'Assamese' );
INSERT INTO LL_Languages VALUES ( 'ay', 'Aymara' );
INSERT INTO LL_Languages VALUES ( 'az', 'Azerbaijani' );
INSERT INTO LL_Languages VALUES ( 'ba', 'Bashkir' );
INSERT INTO LL_Languages VALUES ( 'be', 'Byelorussian' );
INSERT INTO LL_Languages VALUES ( 'bg', 'Bulgarian' );
INSERT INTO LL_Languages VALUES ( 'bh', 'Bihari' );
INSERT INTO LL_Languages VALUES ( 'bi', 'Bislama' );
INSERT INTO LL_Languages VALUES ( 'bn', 'Bengali' );
INSERT INTO LL_Languages VALUES ( 'bo', 'Tibetan' );
INSERT INTO LL_Languages VALUES ( 'br', 'Breton' );
INSERT INTO LL_Languages VALUES ( 'ca', 'Catalan; Valencian' );
INSERT INTO LL_Languages VALUES ( 'co', 'Corsican' );
INSERT INTO LL_Languages VALUES ( 'cs', 'Czech' );
INSERT INTO LL_Languages VALUES ( 'cy', 'Welsh' );
INSERT INTO LL_Languages VALUES ( 'da', 'Danish' );
INSERT INTO LL_Languages VALUES ( 'de', 'German' );
INSERT INTO LL_Languages VALUES ( 'dz', 'Dzongkha' );
INSERT INTO LL_Languages VALUES ( 'el', 'Greek' );
INSERT INTO LL_Languages VALUES ( 'en', 'English' );
INSERT INTO LL_Languages VALUES ( 'eo', 'Esperanto' );
INSERT INTO LL_Languages VALUES ( 'es', 'Spanish' );
INSERT INTO LL_Languages VALUES ( 'et', 'Estonian' );
INSERT INTO LL_Languages VALUES ( 'eu', 'Basque' );
INSERT INTO LL_Languages VALUES ( 'fa', 'Persian' );
INSERT INTO LL_Languages VALUES ( 'fi', 'Finnish' );
INSERT INTO LL_Languages VALUES ( 'fj', 'Fijian' );
INSERT INTO LL_Languages VALUES ( 'fo', 'Faroese' );
INSERT INTO LL_Languages VALUES ( 'fr', 'French' );
INSERT INTO LL_Languages VALUES ( 'fy', 'Frisian' );
INSERT INTO LL_Languages VALUES ( 'ga', 'Irish' );
INSERT INTO LL_Languages VALUES ( 'gd', 'Scots' );
INSERT INTO LL_Languages VALUES ( 'gl', 'Galician' );
INSERT INTO LL_Languages VALUES ( 'gn', 'Guaraní' );
INSERT INTO LL_Languages VALUES ( 'gu', 'Gujarati' );
INSERT INTO LL_Languages VALUES ( 'ha', 'Hausa' );
INSERT INTO LL_Languages VALUES ( 'he', 'Hebrew' );
INSERT INTO LL_Languages VALUES ( 'hi', 'Hindi' );
INSERT INTO LL_Languages VALUES ( 'hr', 'Croatian' );
INSERT INTO LL_Languages VALUES ( 'hu', 'Hungarian' );
INSERT INTO LL_Languages VALUES ( 'hy', 'Armenian' );
INSERT INTO LL_Languages VALUES ( 'ia', 'Interlingua' );
INSERT INTO LL_Languages VALUES ( 'ie', 'Interlingue' );
INSERT INTO LL_Languages VALUES ( 'ik', 'Inupiak' );
INSERT INTO LL_Languages VALUES ( 'in', 'Indonesian' );
INSERT INTO LL_Languages VALUES ( 'is', 'Icelandic' );
INSERT INTO LL_Languages VALUES ( 'it', 'Italian' );
INSERT INTO LL_Languages VALUES ( 'ja', 'Japanese' );
INSERT INTO LL_Languages VALUES ( 'ji', 'Yiddish' );
INSERT INTO LL_Languages VALUES ( 'jv', 'Javanese' );
INSERT INTO LL_Languages VALUES ( 'ka', 'Georgian' );
INSERT INTO LL_Languages VALUES ( 'kk', 'Kazakh' );
INSERT INTO LL_Languages VALUES ( 'kl', 'Greenlandic' );
INSERT INTO LL_Languages VALUES ( 'km', 'Cambodian' );
INSERT INTO LL_Languages VALUES ( 'kn', 'Kannada' );
INSERT INTO LL_Languages VALUES ( 'ko', 'Korean' );
INSERT INTO LL_Languages VALUES ( 'ks', 'Kashmiri' );
INSERT INTO LL_Languages VALUES ( 'ku', 'Kurdish' );
INSERT INTO LL_Languages VALUES ( 'ky', 'Kirghiz' );
INSERT INTO LL_Languages VALUES ( 'la', 'Latin' );
INSERT INTO LL_Languages VALUES ( 'ln', 'Lingala' );
INSERT INTO LL_Languages VALUES ( 'lo', 'Laothian' );
INSERT INTO LL_Languages VALUES ( 'lt', 'Lithuanian' );
INSERT INTO LL_Languages VALUES ( 'lv', 'Latvian' );
INSERT INTO LL_Languages VALUES ( 'mg', 'Malagasy' );
INSERT INTO LL_Languages VALUES ( 'mi', 'Maori' );
INSERT INTO LL_Languages VALUES ( 'mk', 'Macedonian' );
INSERT INTO LL_Languages VALUES ( 'ml', 'Malayalam' );
INSERT INTO LL_Languages VALUES ( 'mn', 'Mongolian' );
INSERT INTO LL_Languages VALUES ( 'mo', 'Moldavian' );
INSERT INTO LL_Languages VALUES ( 'mr', 'Marathi' );
INSERT INTO LL_Languages VALUES ( 'ms', 'Malay' );
INSERT INTO LL_Languages VALUES ( 'mt', 'Maltese' );
INSERT INTO LL_Languages VALUES ( 'my', 'Burmese' );
INSERT INTO LL_Languages VALUES ( 'na', 'Nauruan' );
INSERT INTO LL_Languages VALUES ( 'ne', 'Nepali' );
INSERT INTO LL_Languages VALUES ( 'nl', 'Dutch' );
INSERT INTO LL_Languages VALUES ( 'no', 'Norwegian' );
INSERT INTO LL_Languages VALUES ( 'oc', 'Occitan' );
INSERT INTO LL_Languages VALUES ( 'om', 'Oromo' );
INSERT INTO LL_Languages VALUES ( 'or', 'Oriya' );
INSERT INTO LL_Languages VALUES ( 'pa', 'Punjabi' );
INSERT INTO LL_Languages VALUES ( 'pl', 'Polish' );
INSERT INTO LL_Languages VALUES ( 'ps', 'Pashto' );
INSERT INTO LL_Languages VALUES ( 'pt', 'Portuguese' );
INSERT INTO LL_Languages VALUES ( 'qu', 'Quechua' );
INSERT INTO LL_Languages VALUES ( 'rm', 'Romansh' );
INSERT INTO LL_Languages VALUES ( 'rn', 'Kurundi' );
INSERT INTO LL_Languages VALUES ( 'ro', 'Romanian' );
INSERT INTO LL_Languages VALUES ( 'ru', 'Russian' );
INSERT INTO LL_Languages VALUES ( 'rw', 'Kinyarwanda' );
INSERT INTO LL_Languages VALUES ( 'sa', 'Sanskrit' );
INSERT INTO LL_Languages VALUES ( 'sd', 'Sindhi' );
INSERT INTO LL_Languages VALUES ( 'sg', 'Sangho' );
INSERT INTO LL_Languages VALUES ( 'sh', 'Serbo-Croatian' );
INSERT INTO LL_Languages VALUES ( 'si', 'Singhalese' );
INSERT INTO LL_Languages VALUES ( 'sk', 'Slovak' );
INSERT INTO LL_Languages VALUES ( 'sl', 'Slovenian' );
INSERT INTO LL_Languages VALUES ( 'sm', 'Samoan' );
INSERT INTO LL_Languages VALUES ( 'sn', 'Shona' );
INSERT INTO LL_Languages VALUES ( 'so', 'Somali' );
INSERT INTO LL_Languages VALUES ( 'sq', 'Albanian' );
INSERT INTO LL_Languages VALUES ( 'sr', 'Serbian' );
INSERT INTO LL_Languages VALUES ( 'ss', 'Siswati' );
INSERT INTO LL_Languages VALUES ( 'st', 'Sesotho' );
INSERT INTO LL_Languages VALUES ( 'su', 'Sundanese' );
INSERT INTO LL_Languages VALUES ( 'sv', 'Swedish' );
INSERT INTO LL_Languages VALUES ( 'sw', 'Swahili' );
INSERT INTO LL_Languages VALUES ( 'ta', 'Tamil' );
INSERT INTO LL_Languages VALUES ( 'te', 'Telugu' );
INSERT INTO LL_Languages VALUES ( 'tg', 'Tajik' );
INSERT INTO LL_Languages VALUES ( 'th', 'Thai' );
INSERT INTO LL_Languages VALUES ( 'ti', 'Tigrinya' );
INSERT INTO LL_Languages VALUES ( 'tk', 'Turkmen' );
INSERT INTO LL_Languages VALUES ( 'tl', 'Tagalog' );
INSERT INTO LL_Languages VALUES ( 'tn', 'Setswana' );
INSERT INTO LL_Languages VALUES ( 'to', 'Tongan' );
INSERT INTO LL_Languages VALUES ( 'tr', 'Turkish' );
INSERT INTO LL_Languages VALUES ( 'ts', 'Tsonga' );
INSERT INTO LL_Languages VALUES ( 'tt', 'Tatar' );
INSERT INTO LL_Languages VALUES ( 'tw', 'Twi' );
INSERT INTO LL_Languages VALUES ( 'uk', 'Ukrainian' );
INSERT INTO LL_Languages VALUES ( 'ur', 'Urdu' );
INSERT INTO LL_Languages VALUES ( 'uz', 'Uzbek' );
INSERT INTO LL_Languages VALUES ( 'vi', 'Vietnamese' );
INSERT INTO LL_Languages VALUES ( 'vo', 'Volapuk' );
INSERT INTO LL_Languages VALUES ( 'wo', 'Wolof' );
INSERT INTO LL_Languages VALUES ( 'xh', 'Xhosa' );
INSERT INTO LL_Languages VALUES ( 'yo', 'Yoruba' );
INSERT INTO LL_Languages VALUES ( 'zh', 'Chinese' );
INSERT INTO LL_Languages VALUES ( 'zu', 'Zulu' );


-- Reference: http://www.davros.org/misc/iso3166.html#existing
INSERT INTO LO_Countries VALUES ( 'AF', 'AFG', '004', 'Afghanistan',   '','');
INSERT INTO LO_Countries VALUES ( 'AX', '---', '---', 'Åland Islands', '','');
INSERT INTO LO_Countries VALUES ( 'AL', 'ALB', '008', 'Albania',       'People\'s Socialist Republic of','');
INSERT INTO LO_Countries VALUES ( 'DZ', 'DZA', '012', 'Algeria',       'People\'s Democratic Republic of','');
INSERT INTO LO_Countries VALUES ( 'AS', 'ASM', '016', 'American Samoa','','');
INSERT INTO LO_Countries VALUES ( 'AD', 'AND', '020', 'Andorra',       'Principality of','');
INSERT INTO LO_Countries VALUES ( 'AO', 'AGO', '024', 'Angola',        'Republic of','');
INSERT INTO LO_Countries VALUES ( 'AI', 'AIA', '660', 'Anguilla',      '','');
INSERT INTO LO_Countries VALUES ( 'AQ', 'ATA', '010', 'Antarctica',    '','(the territory South of 60 deg S)');
INSERT INTO LO_Countries VALUES ( 'AG', 'ATG', '028', 'Antigua and Barbuda','','');
INSERT INTO LO_Countries VALUES ( 'AR', 'ARG', '032', 'Argentina',     'Argentine Republic','');
INSERT INTO LO_Countries VALUES ( 'AM', 'ARM', '051', 'Armenia',       '','');
INSERT INTO LO_Countries VALUES ( 'AW', 'ABW', '533', 'Aruba',         '','');
INSERT INTO LO_Countries VALUES ( 'AU', 'AUS', '036', 'Australia',     'Commonwealth of','');
INSERT INTO LO_Countries VALUES ( 'AT', 'AUT', '040', 'Austria',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'AZ', 'AZE', '031', 'Azerbaijan',    'Republic of','');
INSERT INTO LO_Countries VALUES ( 'BS', 'BHS', '044', 'Bahamas',       'Commonwealth of the','');
INSERT INTO LO_Countries VALUES ( 'BH', 'BHR', '048', 'Bahrain',       'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'BD', 'BGD', '050', 'Bangladesh',    'People\'s Republic of','');
INSERT INTO LO_Countries VALUES ( 'BB', 'BRB', '052', 'Barbados',      '','');
INSERT INTO LO_Countries VALUES ( 'BY', 'BLR', '112', 'Belarus',       '','');
INSERT INTO LO_Countries VALUES ( 'BE', 'BEL', '056', 'Belgium',       'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'BZ', 'BLZ', '084', 'Belize',        '','');
INSERT INTO LO_Countries VALUES ( 'BJ', 'BEN', '204', 'Benin',         'People\'s Republic of','(was Dahomey)');
INSERT INTO LO_Countries VALUES ( 'BM', 'BMU', '060', 'Bermuda',       '','');
INSERT INTO LO_Countries VALUES ( 'BT', 'BTN', '064', 'Bhutan',        'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'BO', 'BOL', '068', 'Bolivia',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'BA', 'BIH', '070', 'Bosnia and Herzegovina','','');
INSERT INTO LO_Countries VALUES ( 'BW', 'BWA', '072', 'Botswana',      'Republic of','');
INSERT INTO LO_Countries VALUES ( 'BV', 'BVT', '074', 'Bouvet Island', '(Bouvetoya)','');
INSERT INTO LO_Countries VALUES ( 'BR', 'BRA', '076', 'Brazil',        'Federative Republic of','');
INSERT INTO LO_Countries VALUES ( 'IO', 'IOT', '086', 'British Indian Ocean Territory', '(Chagos Archipelago)','');
INSERT INTO LO_Countries VALUES ( 'VG', 'VGB', '092', 'British Virgin Islands','','');
INSERT INTO LO_Countries VALUES ( 'BN', 'BRN', '096', 'Brunei','','');
INSERT INTO LO_Countries VALUES ( 'BG', 'BGR', '100', 'Bulgaria',      'People\'s Republic of','');
INSERT INTO LO_Countries VALUES ( 'BF', 'BFA', '854', 'Burkina Faso',  '','(was Upper Volta)');
INSERT INTO LO_Countries VALUES ( 'BI', 'BDI', '108', 'Burundi',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'KH', 'KHM', '116', 'Cambodia',      'Kingdom of','(was Khmer Republic/Kampuchea, Democratic)');
INSERT INTO LO_Countries VALUES ( 'CM', 'CMR', '120', 'Cameroon',      'United Republic of','');
INSERT INTO LO_Countries VALUES ( 'CA', 'CAN', '124', 'Canada',        '','');
INSERT INTO LO_Countries VALUES ( 'CV', 'CPV', '132', 'Cape Verde',    'Republic of','');
INSERT INTO LO_Countries VALUES ( 'KY', 'CYM', '136', 'Cayman Islands','','');
INSERT INTO LO_Countries VALUES ( 'CF', 'CAF', '140', 'Central African Republic','','');
INSERT INTO LO_Countries VALUES ( 'TD', 'TCD', '148', 'Chad',          'Republic of','');
INSERT INTO LO_Countries VALUES ( 'CL', 'CHL', '152', 'Chile',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'CN', 'CHN', '156', 'China',         'People\'s Republic of','');
INSERT INTO LO_Countries VALUES ( 'CX', 'CXR', '162', 'Christmas Island','','');
INSERT INTO LO_Countries VALUES ( 'CC', 'CCK', '166', 'Cocos (Keeling) Islands','','');
INSERT INTO LO_Countries VALUES ( 'CO', 'COL', '170', 'Colombia',      'Republic of','');
INSERT INTO LO_Countries VALUES ( 'KM', 'COM', '174', 'Comoros',       'Union of the','');
INSERT INTO LO_Countries VALUES ( 'CD', 'COD', '180', 'Congo, The Democratic Republic of the','','(was Zaire)');
INSERT INTO LO_Countries VALUES ( 'CG', 'COG', '178', 'Congo, People\'s Republic of','','');
INSERT INTO LO_Countries VALUES ( 'CK', 'COK', '184', 'Cook Islands',  '','');
INSERT INTO LO_Countries VALUES ( 'CR', 'CRI', '188', 'Costa Rica',    'Republic of','');
INSERT INTO LO_Countries VALUES ( 'CI', 'CIV', '384', 'Côte d\'Ivoire','Ivory Coast, Republic of the','');
INSERT INTO LO_Countries VALUES ( 'CU', 'CUB', '192', 'Cuba',          'Republic of','');
INSERT INTO LO_Countries VALUES ( 'CY', 'CYP', '196', 'Cyprus',        'Republic of','');
INSERT INTO LO_Countries VALUES ( 'CZ', 'CZE', '203', 'Czech Republic','','');
INSERT INTO LO_Countries VALUES ( 'DK', 'DNK', '208', 'Denmark',       'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'DJ', 'DJI', '262', 'Djibouti',      'Republic of','(was French Afars and Issas)');
INSERT INTO LO_Countries VALUES ( 'DM', 'DMA', '212', 'Dominica',      'Commonwealth of','');
INSERT INTO LO_Countries VALUES ( 'DO', 'DOM', '214', 'Dominican Republic','','');
INSERT INTO LO_Countries VALUES ( 'EC', 'ECU', '218', 'Ecuador',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'EG', 'EGY', '818', 'Egypt',         'Arab Republic of','');
INSERT INTO LO_Countries VALUES ( 'SV', 'SLV', '222', 'El Salvador',   'Republic of','');
INSERT INTO LO_Countries VALUES ( 'GQ', 'GNQ', '226', 'Equatorial Guinea', 'Republic of','');
INSERT INTO LO_Countries VALUES ( 'ER', 'ERI', '232', 'Eritrea',       '','');
INSERT INTO LO_Countries VALUES ( 'EE', 'EST', '233', 'Estonia',       '','');
INSERT INTO LO_Countries VALUES ( 'ET', 'ETH', '231', 'Ethiopia',      '','');
INSERT INTO LO_Countries VALUES ( 'FO', 'FRO', '234', 'Faroe Islands','','');
INSERT INTO LO_Countries VALUES ( 'FK', 'FLK', '238', 'Falkland Islands (Malvinas)','','');
INSERT INTO LO_Countries VALUES ( 'FJ', 'FJI', '242', 'Fiji Islands',  'Republic of','');
INSERT INTO LO_Countries VALUES ( 'FI', 'FIN', '246', 'Finland',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'FR', 'FRA', '250', 'France',        'French Republic','');
INSERT INTO LO_Countries VALUES ( 'GF', 'GUF', '254', 'French Guiana', '','');
INSERT INTO LO_Countries VALUES ( 'PF', 'PYF', '258', 'French Polynesia','','');
INSERT INTO LO_Countries VALUES ( 'TF', 'ATF', '260', 'French Southern Territories','','');
INSERT INTO LO_Countries VALUES ( 'GA', 'GAB', '266', 'Gabon',         'Gabonese Republic','');
INSERT INTO LO_Countries VALUES ( 'GM', 'GMB', '270', 'Gambia',        'Republic of the','');
INSERT INTO LO_Countries VALUES ( 'GE', 'GEO', '268', 'Georgia',       '','');
INSERT INTO LO_Countries VALUES ( 'DE', 'DEU', '276', 'Germany',       '','');
INSERT INTO LO_Countries VALUES ( 'GH', 'GHA', '288', 'Ghana',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'GI', 'GIB', '292', 'Gibraltar',     '','');
INSERT INTO LO_Countries VALUES ( 'GR', 'GRC', '300', 'Greece',        'Hellenic Republic','');
INSERT INTO LO_Countries VALUES ( 'GL', 'GRL', '304', 'Greenland',     '','');
INSERT INTO LO_Countries VALUES ( 'GD', 'GRD', '308', 'Grenada',       '','');
INSERT INTO LO_Countries VALUES ( 'GP', 'GLP', '312', 'Guadeloupe',    '','');
INSERT INTO LO_Countries VALUES ( 'GU', 'GUM', '316', 'Guam',          '','');
INSERT INTO LO_Countries VALUES ( 'GT', 'GTM', '320', 'Guatemala',     'Republic of','');
INSERT INTO LO_Countries VALUES ( 'GN', 'GIN', '324', 'Guinea',        'Revolutionary People\'s Rep\'c of','');
INSERT INTO LO_Countries VALUES ( 'GW', 'GNB', '624', 'Guinea-Bissau', 'Republic of','(was Portuguese Guinea)');
INSERT INTO LO_Countries VALUES ( 'GY', 'GUY', '328', 'Guyana',        'Republic of','');
INSERT INTO LO_Countries VALUES ( 'HT', 'HTI', '332', 'Haiti',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'HM', 'HMD', '334', 'Heard Island and McDonald Islands','','');
INSERT INTO LO_Countries VALUES ( 'VA', 'VAT', '336', 'Holy See (Vatican City State)','','');
INSERT INTO LO_Countries VALUES ( 'HN', 'HND', '340', 'Honduras',      'Republic of','');
INSERT INTO LO_Countries VALUES ( 'HK', 'HKG', '344', 'Hong Kong',     'Special Administrative Region of China','');
INSERT INTO LO_Countries VALUES ( 'HR', 'HRV', '191', 'Hrvatska (Croatia)','','');
INSERT INTO LO_Countries VALUES ( 'HU', 'HUN', '348', 'Hungary',       'Hungarian People\'s Republic','');
INSERT INTO LO_Countries VALUES ( 'IS', 'ISL', '352', 'Iceland',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'IN', 'IND', '356', 'India',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'ID', 'IDN', '360', 'Indonesia',     'Republic of','');
INSERT INTO LO_Countries VALUES ( 'IR', 'IRN', '364', 'Iran',          'Islamic Republic of','');
INSERT INTO LO_Countries VALUES ( 'IQ', 'IRQ', '368', 'Iraq',          'Republic of','');
INSERT INTO LO_Countries VALUES ( 'IE', 'IRL', '372', 'Ireland',       '','');
INSERT INTO LO_Countries VALUES ( 'IL', 'ISR', '376', 'Israel',        'State of','');
INSERT INTO LO_Countries VALUES ( 'IT', 'ITA', '380', 'Italy',         'Italian Republic','');
INSERT INTO LO_Countries VALUES ( 'JM', 'JAM', '388', 'Jamaica',       '','');
INSERT INTO LO_Countries VALUES ( 'JP', 'JPN', '392', 'Japan',         '','');
INSERT INTO LO_Countries VALUES ( 'JO', 'JOR', '400', 'Jordan',        'Hashemite Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'KZ', 'KAZ', '398', 'Kazakhstan',    'Republic of','');
INSERT INTO LO_Countries VALUES ( 'KE', 'KEN', '404', 'Kenya',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'KI', 'KIR', '296', 'Kiribati',      'Republic of','(was Gilbert Islands)');
INSERT INTO LO_Countries VALUES ( 'KP', 'PRK', '408', 'Korea, Democratic People\'s Republic of','','');
INSERT INTO LO_Countries VALUES ( 'KR', 'KOR', '410', 'Korea, Republic of','','');
INSERT INTO LO_Countries VALUES ( 'KW', 'KWT', '414', 'Kuwait',        'State of','');
INSERT INTO LO_Countries VALUES ( 'KG', 'KGZ', '417', 'Kyrgyzstan',    'Kyrgyz Republic','');
INSERT INTO LO_Countries VALUES ( 'LA', 'LAO', '418', 'Laos',          'Lao People\'s Democratic Republic','');
INSERT INTO LO_Countries VALUES ( 'LV', 'LVA', '428', 'Latvia',        '','');
INSERT INTO LO_Countries VALUES ( 'LB', 'LBN', '422', 'Lebanon',       'Lebanese Republic','');
INSERT INTO LO_Countries VALUES ( 'LS', 'LSO', '426', 'Lesotho',       'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'LR', 'LBR', '430', 'Liberia',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'LY', 'LBY', '434', 'Libyan Arab Jamahiriya','','');
INSERT INTO LO_Countries VALUES ( 'LI', 'LIE', '438', 'Liechtenstein', 'Principality of','');
INSERT INTO LO_Countries VALUES ( 'LT', 'LTU', '440', 'Lithuania',     '','');
INSERT INTO LO_Countries VALUES ( 'LU', 'LUX', '442', 'Luxembourg',    'Grand Duchy of','');
INSERT INTO LO_Countries VALUES ( 'MO', 'MAC', '446', 'Macau',         'Special Administrative Region of China','');
INSERT INTO LO_Countries VALUES ( 'MK', 'MKD', '807', 'Macedonia',     'the former Yugoslav Republic of','');
INSERT INTO LO_Countries VALUES ( 'MG', 'MDG', '450', 'Madagascar',    'Republic of','');
INSERT INTO LO_Countries VALUES ( 'MW', 'MWI', '454', 'Malawi',        'Republic of','');
INSERT INTO LO_Countries VALUES ( 'MY', 'MYS', '458', 'Malaysia',      '','');
INSERT INTO LO_Countries VALUES ( 'MV', 'MDV', '462', 'Maldives',      'Republic of','');
INSERT INTO LO_Countries VALUES ( 'ML', 'MLI', '466', 'Mali',          'Republic of','');
INSERT INTO LO_Countries VALUES ( 'MT', 'MLT', '470', 'Malta',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'MH', 'MHL', '584', 'Marshall Islands','','');
INSERT INTO LO_Countries VALUES ( 'MQ', 'MTQ', '474', 'Martinique',     '','');
INSERT INTO LO_Countries VALUES ( 'MR', 'MRT', '478', 'Mauritania',     'Islamic Republic of','');
INSERT INTO LO_Countries VALUES ( 'MU', 'MUS', '480', 'Mauritius',      '','');
INSERT INTO LO_Countries VALUES ( 'YT', 'MYT', '175', 'Mayotte',        '','');
INSERT INTO LO_Countries VALUES ( 'MX', 'MEX', '484', 'Mexico',         'United Mexican States','');
INSERT INTO LO_Countries VALUES ( 'FM', 'FSM', '583', 'Micronesia',     'Federated States of','');
INSERT INTO LO_Countries VALUES ( 'MD', 'MDA', '498', 'Moldova',        'Republic of','');
INSERT INTO LO_Countries VALUES ( 'MC', 'MCO', '492', 'Monaco',         'Principality of','');
INSERT INTO LO_Countries VALUES ( 'MN', 'MNG', '496', 'Mongolia',       'Mongolian People\'s Republic','');
INSERT INTO LO_Countries VALUES ( 'ME', 'MNE', '499', 'Montenegro',     '','');
INSERT INTO LO_Countries VALUES ( 'MS', 'MSR', '500', 'Montserrat',     '','');
INSERT INTO LO_Countries VALUES ( 'MA', 'MAR', '504', 'Morocco',        'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'MZ', 'MOZ', '508', 'Mozambique',     'People\'s Republic of','');
INSERT INTO LO_Countries VALUES ( 'MM', 'MMR', '104', 'Myanmar',        '','(was Burma)');
INSERT INTO LO_Countries VALUES ( 'NA', 'NAM', '516', 'Namibia',        '','');
INSERT INTO LO_Countries VALUES ( 'NR', 'NRU', '520', 'Nauru',          'Republic of','');
INSERT INTO LO_Countries VALUES ( 'NP', 'NPL', '524', 'Nepal',          'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'AN', 'ANT', '530', 'Netherlands Antilles','','');
INSERT INTO LO_Countries VALUES ( 'NL', 'NLD', '528', 'Netherlands',    'Kingdom of the','');
INSERT INTO LO_Countries VALUES ( 'NC', 'NCL', '540', 'New Caledonia',  '','');
INSERT INTO LO_Countries VALUES ( 'NZ', 'NZL', '554', 'New Zealand',    '','');
INSERT INTO LO_Countries VALUES ( 'NI', 'NIC', '558', 'Nicaragua',      'Republic of','');
INSERT INTO LO_Countries VALUES ( 'NE', 'NER', '562', 'Niger',          'Republic of the','');
INSERT INTO LO_Countries VALUES ( 'NG', 'NGA', '566', 'Nigeria',        'Federal Republic of','');
INSERT INTO LO_Countries VALUES ( 'NU', 'NIU', '570', 'Niue',           'Republic of','');
INSERT INTO LO_Countries VALUES ( 'NF', 'NFK', '574', 'Norfolk Island', '','');
INSERT INTO LO_Countries VALUES ( 'MP', 'MNP', '580', 'Northern Mariana Islands','','');
INSERT INTO LO_Countries VALUES ( 'NO', 'NOR', '578', 'Norway',         'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'OM', 'OMN', '512', 'Oman',           'Sultanate of','(was Muscat and Oman)');
INSERT INTO LO_Countries VALUES ( 'PK', 'PAK', '586', 'Pakistan',       'Islamic Republic of','');
INSERT INTO LO_Countries VALUES ( 'PW', 'PLW', '585', 'Palau',          '','');
INSERT INTO LO_Countries VALUES ( 'PS', 'PSE', '275', 'Palestinian Territory', 'Occupied','');
INSERT INTO LO_Countries VALUES ( 'PA', 'PAN', '591', 'Panama',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'PG', 'PNG', '598', 'Papua New Guinea','','');
INSERT INTO LO_Countries VALUES ( 'PY', 'PRY', '600', 'Paraguay',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'PE', 'PER', '604', 'Peru',           'Republic of','');
INSERT INTO LO_Countries VALUES ( 'PH', 'PHL', '608', 'Philippines',    'Republic of the','');
INSERT INTO LO_Countries VALUES ( 'PN', 'PCN', '612', 'Pitcairn Islands','','');
INSERT INTO LO_Countries VALUES ( 'PL', 'POL', '616', 'Poland',         'Polish People\'s Republic','');
INSERT INTO LO_Countries VALUES ( 'PT', 'PRT', '620', 'Portugal',       'Portuguese Republic','');
INSERT INTO LO_Countries VALUES ( 'PR', 'PRI', '630', 'Puerto Rico',    '','');
INSERT INTO LO_Countries VALUES ( 'QA', 'QAT', '634', 'Qatar',          'State of','');
INSERT INTO LO_Countries VALUES ( 'RE', 'REU', '638', 'Réunion',        '','');
INSERT INTO LO_Countries VALUES ( 'RO', 'ROU', '642', 'Romania',        'Socialist Republic of','');
INSERT INTO LO_Countries VALUES ( 'RU', 'RUS', '643', 'Russian Federation','','');
INSERT INTO LO_Countries VALUES ( 'RW', 'RWA', '646', 'Rwanda',         'Rwandese Republic','');
INSERT INTO LO_Countries VALUES ( 'SH', 'SHN', '654', 'Saint Helena',   '','');
INSERT INTO LO_Countries VALUES ( 'KN', 'KNA', '659', 'Saint Kitts and Nevis','','');
INSERT INTO LO_Countries VALUES ( 'LC', 'LCA', '662', 'Saint Lucia',    '','');
INSERT INTO LO_Countries VALUES ( 'PM', 'SPM', '666', 'Saint Pierre and Miquelon','','');
INSERT INTO LO_Countries VALUES ( 'VC', 'VCT', '670', 'Saint Vincent and the Grenadines','','');
INSERT INTO LO_Countries VALUES ( 'WS', 'WSM', '882', 'Samoa',          'Independent State of','(was Western Samoa)');
INSERT INTO LO_Countries VALUES ( 'SM', 'SMR', '674', 'San Marino',     'Republic of','');
INSERT INTO LO_Countries VALUES ( 'ST', 'STP', '678', 'São Tomé and Príncipe', 'Democratic Republic of','');
INSERT INTO LO_Countries VALUES ( 'SA', 'SAU', '682', 'Saudi Arabia',   'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'SN', 'SEN', '686', 'Senegal',        'Republic of','');
INSERT INTO LO_Countries VALUES ( 'RS', 'SRB', '688', 'Serbia',         '','');
INSERT INTO LO_Countries VALUES ( 'SC', 'SYC', '690', 'Seychelles',     'Republic of','');
INSERT INTO LO_Countries VALUES ( 'SL', 'SLE', '694', 'Sierra Leone',   'Republic of','');
INSERT INTO LO_Countries VALUES ( 'SG', 'SGP', '702', 'Singapore',      'Republic of','');
INSERT INTO LO_Countries VALUES ( 'SK', 'SVK', '703', 'Slovakia',       '(Slovak Republic)','');
INSERT INTO LO_Countries VALUES ( 'SI', 'SVN', '705', 'Slovenia',       '','');
INSERT INTO LO_Countries VALUES ( 'SB', 'SLB', '090', 'Solomon Islands','','(was British Solomon Islands)');
INSERT INTO LO_Countries VALUES ( 'SO', 'SOM', '706', 'Somalia',        'Somali Republic','');
INSERT INTO LO_Countries VALUES ( 'ZA', 'ZAF', '710', 'South Africa',   'Republic of','');
INSERT INTO LO_Countries VALUES ( 'GS', 'SGS', '239', 'South Georgia and the South Sandwich Islands','','');
INSERT INTO LO_Countries VALUES ( 'ES', 'ESP', '724', 'Spain',          'Spanish State','');
INSERT INTO LO_Countries VALUES ( 'LK', 'LKA', '144', 'Sri Lanka',      'Democratic Socialist Republic of','(was Ceylon)');
INSERT INTO LO_Countries VALUES ( 'SD', 'SDN', '736', 'Sudan',          'Democratic Republic of the','');
INSERT INTO LO_Countries VALUES ( 'SR', 'SUR', '740', 'Suriname',       'Republic of','');
INSERT INTO LO_Countries VALUES ( 'SJ', 'SJM', '744', 'Svalbard and Jan Mayen','','');
INSERT INTO LO_Countries VALUES ( 'SZ', 'SWZ', '748', 'Swaziland',      'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'SE', 'SWE', '752', 'Sweden',         'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'CH', 'CHE', '756', 'Switzerland',    'Swiss Confederation','');
INSERT INTO LO_Countries VALUES ( 'SY', 'SYR', '760', 'Syrian Arab Republic','','');
INSERT INTO LO_Countries VALUES ( 'TW', 'TWN', '158', 'Taiwan',         'Province of China','');
INSERT INTO LO_Countries VALUES ( 'TJ', 'TJK', '762', 'Tajikistan',     '','');
INSERT INTO LO_Countries VALUES ( 'TZ', 'TZA', '834', 'Tanzania',       'United Republic of','');
INSERT INTO LO_Countries VALUES ( 'TH', 'THA', '764', 'Thailand',       'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'TL', 'TLS', '626', 'East Timor',     'Democratic Republic of','');
INSERT INTO LO_Countries VALUES ( 'TG', 'TGO', '768', 'Togo',           'Togolese Republic','');
INSERT INTO LO_Countries VALUES ( 'TK', 'TKL', '772', 'Tokelau',        '(Tokelau Islands)','');
INSERT INTO LO_Countries VALUES ( 'TO', 'TON', '776', 'Tonga',          'Kingdom of','');
INSERT INTO LO_Countries VALUES ( 'TT', 'TTO', '780', 'Trinidad and Tobago', 'Republic of','');
INSERT INTO LO_Countries VALUES ( 'TN', 'TUN', '788', 'Tunisia',        'Republic of','');
INSERT INTO LO_Countries VALUES ( 'TR', 'TUR', '792', 'Turkey',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'TM', 'TKM', '795', 'Turkmenistan',   '','');
INSERT INTO LO_Countries VALUES ( 'TC', 'TCA', '796', 'Turks and Caicos Islands','','');
INSERT INTO LO_Countries VALUES ( 'TV', 'TUV', '798', 'Tuvalu',         '','(was part of Gilbert & Ellice Islands)');
INSERT INTO LO_Countries VALUES ( 'VI', 'VIR', '850', 'US Virgin Islands','','');
INSERT INTO LO_Countries VALUES ( 'UG', 'UGA', '800', 'Uganda',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'UA', 'UKR', '804', 'Ukraine',        '','');
INSERT INTO LO_Countries VALUES ( 'AE', 'ARE', '784', 'United Arab Emirates','','(was Trucial States)');
INSERT INTO LO_Countries VALUES ( 'GB', 'GBR', '826', 'United Kingdom of Great Britain and Northern Ireland','','');
INSERT INTO LO_Countries VALUES ( 'UM', 'UMI', '581', 'United States Minor Outlying Islands','','');
INSERT INTO LO_Countries VALUES ( 'US', 'USA', '840', 'United States of America','','');
INSERT INTO LO_Countries VALUES ( 'UY', 'URY', '858', 'Uruguay',        'Eastern Republic of','');
INSERT INTO LO_Countries VALUES ( 'UZ', 'UZB', '860', 'Uzbekistan',     '','');
INSERT INTO LO_Countries VALUES ( 'VU', 'VUT', '548', 'Vanuatu',        '','(was New Hebrides)');
INSERT INTO LO_Countries VALUES ( 'VE', 'VEN', '862', 'Venezuela',      'Bolivarian Republic of','');
INSERT INTO LO_Countries VALUES ( 'VN', 'VNM', '704', 'Viet Nam',       'Socialist Republic of','(was Democratic Republic of & Republic of)');
INSERT INTO LO_Countries VALUES ( 'WF', 'WLF', '876', 'Wallis and Futuna','','');
INSERT INTO LO_Countries VALUES ( 'EH', 'ESH', '732', 'Western Sahara', '','(was Spanish Sahara)');
INSERT INTO LO_Countries VALUES ( 'YE', 'YEM', '887', 'Yemen',          '','');
INSERT INTO LO_Countries VALUES ( 'ZM', 'ZMB', '894', 'Zambia',         'Republic of','');
INSERT INTO LO_Countries VALUES ( 'ZW', 'ZWE', '716', 'Zimbabwe',       '','(was Southern Rhodesia)');


-- Nationalities
INSERT INTO LN_Nationalities VALUES ( 'AF', 'Afghan');
INSERT INTO LN_Nationalities VALUES ( 'AX', 'Åland Islander');
INSERT INTO LN_Nationalities VALUES ( 'AL', 'Albanian');
INSERT INTO LN_Nationalities VALUES ( 'DZ', 'Algerian');
INSERT INTO LN_Nationalities VALUES ( 'AS', 'Samoan, American');
INSERT INTO LN_Nationalities VALUES ( 'AD', 'Andorran');
INSERT INTO LN_Nationalities VALUES ( 'AO', 'Angolan');
INSERT INTO LN_Nationalities VALUES ( 'AI', 'Anguillan');
INSERT INTO LN_Nationalities VALUES ( 'AQ', 'Antarctic');
INSERT INTO LN_Nationalities VALUES ( 'AG', 'Antiguan');
INSERT INTO LN_Nationalities VALUES ( 'AR', 'Argentinian');
INSERT INTO LN_Nationalities VALUES ( 'AM', 'Armenian');
INSERT INTO LN_Nationalities VALUES ( 'AW', 'Aruban');
INSERT INTO LN_Nationalities VALUES ( 'AU', 'Australian');
INSERT INTO LN_Nationalities VALUES ( 'AT', 'Austrian');
INSERT INTO LN_Nationalities VALUES ( 'AZ', 'Azerbaijani');
INSERT INTO LN_Nationalities VALUES ( 'BS', 'Bahamian');
INSERT INTO LN_Nationalities VALUES ( 'BH', 'Bahraini');
INSERT INTO LN_Nationalities VALUES ( 'BD', 'Bangladeshi');
INSERT INTO LN_Nationalities VALUES ( 'BB', 'Barbadian');
INSERT INTO LN_Nationalities VALUES ( 'BY', 'Belarusian');
INSERT INTO LN_Nationalities VALUES ( 'BE', 'Belgian');
INSERT INTO LN_Nationalities VALUES ( 'BZ', 'Belizean');
INSERT INTO LN_Nationalities VALUES ( 'BJ', 'Beninese');
INSERT INTO LN_Nationalities VALUES ( 'BM', 'Bermudian');
INSERT INTO LN_Nationalities VALUES ( 'BT', 'Bhutanese');
INSERT INTO LN_Nationalities VALUES ( 'BO', 'Bolivian');
INSERT INTO LN_Nationalities VALUES ( 'BA', 'Bosnian and Herzegovinian');
INSERT INTO LN_Nationalities VALUES ( 'BW', 'Botswanan');
INSERT INTO LN_Nationalities VALUES ( 'BV', 'Bouvet');
INSERT INTO LN_Nationalities VALUES ( 'BR', 'Brazilian');
INSERT INTO LN_Nationalities VALUES ( 'IO', 'British Indian Ocean Territory');
INSERT INTO LN_Nationalities VALUES ( 'VG', 'British Virgin Islander');
INSERT INTO LN_Nationalities VALUES ( 'BN', 'Bruneian');
INSERT INTO LN_Nationalities VALUES ( 'BG', 'Bulgarian');
INSERT INTO LN_Nationalities VALUES ( 'BF', 'Burkinabe');
INSERT INTO LN_Nationalities VALUES ( 'BI', 'Burundian');
INSERT INTO LN_Nationalities VALUES ( 'KH', 'Cambodian');
INSERT INTO LN_Nationalities VALUES ( 'CM', 'Cameroonian');
INSERT INTO LN_Nationalities VALUES ( 'CA', 'Canadian');
INSERT INTO LN_Nationalities VALUES ( 'CV', 'Cape Verdean');
INSERT INTO LN_Nationalities VALUES ( 'KY', 'Caymanian');
INSERT INTO LN_Nationalities VALUES ( 'CF', 'Central African');
INSERT INTO LN_Nationalities VALUES ( 'TD', 'Chadian');
INSERT INTO LN_Nationalities VALUES ( 'CL', 'Chilean');
INSERT INTO LN_Nationalities VALUES ( 'CN', 'Chinese');
INSERT INTO LN_Nationalities VALUES ( 'CX', 'Christmas Islander');
INSERT INTO LN_Nationalities VALUES ( 'CC', 'Cocos Islander');
INSERT INTO LN_Nationalities VALUES ( 'CO', 'Colombian');
INSERT INTO LN_Nationalities VALUES ( 'KM', 'Comorian');
INSERT INTO LN_Nationalities VALUES ( 'CD', 'Congolese from The Democratic Republic of the Congo');
INSERT INTO LN_Nationalities VALUES ( 'CG', 'Congolese from the Republic of Congo');
INSERT INTO LN_Nationalities VALUES ( 'CK', 'Cook Islander');
INSERT INTO LN_Nationalities VALUES ( 'CR', 'Costa Rican');
INSERT INTO LN_Nationalities VALUES ( 'CI', 'Ivorian');
INSERT INTO LN_Nationalities VALUES ( 'CU', 'Cuban');
INSERT INTO LN_Nationalities VALUES ( 'CY', 'Cypriot');
INSERT INTO LN_Nationalities VALUES ( 'CZ', 'Czech');
INSERT INTO LN_Nationalities VALUES ( 'DK', 'Danish');
INSERT INTO LN_Nationalities VALUES ( 'DJ', 'Djiboutian');
INSERT INTO LN_Nationalities VALUES ( 'DM', 'Dominican');
INSERT INTO LN_Nationalities VALUES ( 'DO', 'Dominican from Dominican Republic');
INSERT INTO LN_Nationalities VALUES ( 'EC', 'Ecuadorian');
INSERT INTO LN_Nationalities VALUES ( 'EG', 'Egyptian');
INSERT INTO LN_Nationalities VALUES ( 'SV', 'Salvadorian');
INSERT INTO LN_Nationalities VALUES ( 'GQ', 'Equatorial Guinean');
INSERT INTO LN_Nationalities VALUES ( 'ER', 'Eritrean');
INSERT INTO LN_Nationalities VALUES ( 'EE', 'Estonian');
INSERT INTO LN_Nationalities VALUES ( 'ET', 'Ethiopian');
INSERT INTO LN_Nationalities VALUES ( 'FO', 'Faroese');
INSERT INTO LN_Nationalities VALUES ( 'FK', 'Falkland Islanders');
INSERT INTO LN_Nationalities VALUES ( 'FJ', 'Fiji Islander');
INSERT INTO LN_Nationalities VALUES ( 'FI', 'Finnish');
INSERT INTO LN_Nationalities VALUES ( 'FR', 'French');
INSERT INTO LN_Nationalities VALUES ( 'GF', 'Guianese');
INSERT INTO LN_Nationalities VALUES ( 'PF', 'Polynesian');
INSERT INTO LN_Nationalities VALUES ( 'TF', 'French Southern Territories');
INSERT INTO LN_Nationalities VALUES ( 'GA', 'Gabonese');
INSERT INTO LN_Nationalities VALUES ( 'GM', 'Gambian');
INSERT INTO LN_Nationalities VALUES ( 'GE', 'Georgian');
INSERT INTO LN_Nationalities VALUES ( 'DE', 'German');
INSERT INTO LN_Nationalities VALUES ( 'GH', 'Ghanaian');
INSERT INTO LN_Nationalities VALUES ( 'GI', 'Gibraltarian');
INSERT INTO LN_Nationalities VALUES ( 'GR', 'Greek');
INSERT INTO LN_Nationalities VALUES ( 'GL', 'Greenlandic');
INSERT INTO LN_Nationalities VALUES ( 'GD', 'Grenadian');
INSERT INTO LN_Nationalities VALUES ( 'GP', 'Guadeloupean');
INSERT INTO LN_Nationalities VALUES ( 'GU', 'Guamanian');
INSERT INTO LN_Nationalities VALUES ( 'GT', 'Guatemalan');
INSERT INTO LN_Nationalities VALUES ( 'GN', 'Guinean');
INSERT INTO LN_Nationalities VALUES ( 'GW', 'Guinean from Guinea-Bissau');
INSERT INTO LN_Nationalities VALUES ( 'GY', 'Guyanese');
INSERT INTO LN_Nationalities VALUES ( 'HT', 'Haitian');
INSERT INTO LN_Nationalities VALUES ( 'HM', 'Heard Island and McDonald Islands');
INSERT INTO LN_Nationalities VALUES ( 'VA', 'Holy See (Vatican City State)');
INSERT INTO LN_Nationalities VALUES ( 'HN', 'Honduran');
INSERT INTO LN_Nationalities VALUES ( 'HK', 'Hong Kong');
INSERT INTO LN_Nationalities VALUES ( 'HR', 'Croatian');
INSERT INTO LN_Nationalities VALUES ( 'HU', 'Hungarian');
INSERT INTO LN_Nationalities VALUES ( 'IS', 'Icelandic');
INSERT INTO LN_Nationalities VALUES ( 'IN', 'Indian');
INSERT INTO LN_Nationalities VALUES ( 'ID', 'Indonesian');
INSERT INTO LN_Nationalities VALUES ( 'IR', 'Iranian');
INSERT INTO LN_Nationalities VALUES ( 'IQ', 'Iraqi');
INSERT INTO LN_Nationalities VALUES ( 'IE', 'Irish');
INSERT INTO LN_Nationalities VALUES ( 'IL', 'Israeli');
INSERT INTO LN_Nationalities VALUES ( 'IT', 'Italian');
INSERT INTO LN_Nationalities VALUES ( 'JM', 'Jamaican');
INSERT INTO LN_Nationalities VALUES ( 'JP', 'Japanese');
INSERT INTO LN_Nationalities VALUES ( 'JO', 'Jordanian');
INSERT INTO LN_Nationalities VALUES ( 'KZ', 'Kazakh');
INSERT INTO LN_Nationalities VALUES ( 'KE', 'Kenyan');
INSERT INTO LN_Nationalities VALUES ( 'KI', 'Kiribatian');
INSERT INTO LN_Nationalities VALUES ( 'KP', 'North Korean');
INSERT INTO LN_Nationalities VALUES ( 'KR', 'South Korean');
INSERT INTO LN_Nationalities VALUES ( 'KW', 'Kuwaiti');
INSERT INTO LN_Nationalities VALUES ( 'KG', 'Kyrgyzstani');
INSERT INTO LN_Nationalities VALUES ( 'LA', 'Lao');
INSERT INTO LN_Nationalities VALUES ( 'LV', 'Latvian');
INSERT INTO LN_Nationalities VALUES ( 'LB', 'Lebanese');
INSERT INTO LN_Nationalities VALUES ( 'LS', 'Basotho');
INSERT INTO LN_Nationalities VALUES ( 'LR', 'Liberian');
INSERT INTO LN_Nationalities VALUES ( 'LY', 'Libyan');
INSERT INTO LN_Nationalities VALUES ( 'LI', 'Liechtensteiner');
INSERT INTO LN_Nationalities VALUES ( 'LT', 'Lithuanian');
INSERT INTO LN_Nationalities VALUES ( 'LU', 'Luxembourger');
INSERT INTO LN_Nationalities VALUES ( 'MO', 'Macanese');
INSERT INTO LN_Nationalities VALUES ( 'MK', 'Macedonian');
INSERT INTO LN_Nationalities VALUES ( 'MG', 'Malagasy');
INSERT INTO LN_Nationalities VALUES ( 'MW', 'Malawian');
INSERT INTO LN_Nationalities VALUES ( 'MY', 'Malaysian');
INSERT INTO LN_Nationalities VALUES ( 'MV', 'Maldivian');
INSERT INTO LN_Nationalities VALUES ( 'ML', 'Malian');
INSERT INTO LN_Nationalities VALUES ( 'MT', 'Maltese');
INSERT INTO LN_Nationalities VALUES ( 'MH', 'Marshallese');
INSERT INTO LN_Nationalities VALUES ( 'MQ', 'Martinican');
INSERT INTO LN_Nationalities VALUES ( 'MR', 'Mauritanian');
INSERT INTO LN_Nationalities VALUES ( 'MU', 'Mauritian');
INSERT INTO LN_Nationalities VALUES ( 'YT', 'Mahoran');
INSERT INTO LN_Nationalities VALUES ( 'MX', 'Mexican');
INSERT INTO LN_Nationalities VALUES ( 'FM', 'Micronesian');
INSERT INTO LN_Nationalities VALUES ( 'MD', 'Moldovan');
INSERT INTO LN_Nationalities VALUES ( 'MC', 'Monegasque');
INSERT INTO LN_Nationalities VALUES ( 'MN', 'Mongolian');
INSERT INTO LN_Nationalities VALUES ( 'ME', 'Montenegrin');
INSERT INTO LN_Nationalities VALUES ( 'MS', 'Montserratian');
INSERT INTO LN_Nationalities VALUES ( 'MA', 'Moroccan');
INSERT INTO LN_Nationalities VALUES ( 'MZ', 'Mozambican');
INSERT INTO LN_Nationalities VALUES ( 'MM', 'Burmese');
INSERT INTO LN_Nationalities VALUES ( 'NA', 'Namibian');
INSERT INTO LN_Nationalities VALUES ( 'NR', 'Nauruan');
INSERT INTO LN_Nationalities VALUES ( 'NP', 'Nepalese');
INSERT INTO LN_Nationalities VALUES ( 'AN', 'Netherlands Antillean');
INSERT INTO LN_Nationalities VALUES ( 'NL', 'Dutch');
INSERT INTO LN_Nationalities VALUES ( 'NC', 'New Caledonian');
INSERT INTO LN_Nationalities VALUES ( 'NZ', 'New Zealander');
INSERT INTO LN_Nationalities VALUES ( 'NI', 'Nicaraguan');
INSERT INTO LN_Nationalities VALUES ( 'NE', 'Nigerien');
INSERT INTO LN_Nationalities VALUES ( 'NG', 'Nigerian');
INSERT INTO LN_Nationalities VALUES ( 'NU', 'Niuean');
INSERT INTO LN_Nationalities VALUES ( 'NF', 'Norfolk Islander');
INSERT INTO LN_Nationalities VALUES ( 'MP', 'Northern Mariana Islander');
INSERT INTO LN_Nationalities VALUES ( 'NO', 'Norwegian');
INSERT INTO LN_Nationalities VALUES ( 'OM', 'Omani');
INSERT INTO LN_Nationalities VALUES ( 'PK', 'Pakistani');
INSERT INTO LN_Nationalities VALUES ( 'PW', 'Palauan');
INSERT INTO LN_Nationalities VALUES ( 'PS', 'Palestinian');
INSERT INTO LN_Nationalities VALUES ( 'PA', 'Panamanian');
INSERT INTO LN_Nationalities VALUES ( 'PG', 'Papua New Guinean');
INSERT INTO LN_Nationalities VALUES ( 'PY', 'Paraguayan');
INSERT INTO LN_Nationalities VALUES ( 'PE', 'Peruvian');
INSERT INTO LN_Nationalities VALUES ( 'PH', 'Filipino');
INSERT INTO LN_Nationalities VALUES ( 'PN', 'Pitcairn Islander');
INSERT INTO LN_Nationalities VALUES ( 'PL', 'Polish');
INSERT INTO LN_Nationalities VALUES ( 'PT', 'Portuguese');
INSERT INTO LN_Nationalities VALUES ( 'PR', 'Puerto Rican');
INSERT INTO LN_Nationalities VALUES ( 'QA', 'Qatari');
INSERT INTO LN_Nationalities VALUES ( 'RE', 'Reunionese');
INSERT INTO LN_Nationalities VALUES ( 'RO', 'Romanian');
INSERT INTO LN_Nationalities VALUES ( 'RU', 'Russian');
INSERT INTO LN_Nationalities VALUES ( 'RW', 'Rwandan');
INSERT INTO LN_Nationalities VALUES ( 'SH', 'Saint Helenian');
INSERT INTO LN_Nationalities VALUES ( 'KN', 'Kittsian; Nevisian');
INSERT INTO LN_Nationalities VALUES ( 'LC', 'Saint Lucian');
INSERT INTO LN_Nationalities VALUES ( 'PM', 'St-Pierrais; Miquelonnais');
INSERT INTO LN_Nationalities VALUES ( 'VC', 'Vincentian');
INSERT INTO LN_Nationalities VALUES ( 'WS', 'Samoan');
INSERT INTO LN_Nationalities VALUES ( 'SM', 'San Marinese');
INSERT INTO LN_Nationalities VALUES ( 'ST', 'São Toméan');
INSERT INTO LN_Nationalities VALUES ( 'SA', 'Saudi Arabian');
INSERT INTO LN_Nationalities VALUES ( 'SN', 'Senegalese');
INSERT INTO LN_Nationalities VALUES ( 'RS', 'Serbian');
INSERT INTO LN_Nationalities VALUES ( 'SC', 'Seychellois');
INSERT INTO LN_Nationalities VALUES ( 'SL', 'Sierra Leonean');
INSERT INTO LN_Nationalities VALUES ( 'SG', 'Singaporean');
INSERT INTO LN_Nationalities VALUES ( 'SK', 'Slovak');
INSERT INTO LN_Nationalities VALUES ( 'SI', 'Slovenian');
INSERT INTO LN_Nationalities VALUES ( 'SB', 'Solomon Islander');
INSERT INTO LN_Nationalities VALUES ( 'SO', 'Somali');
INSERT INTO LN_Nationalities VALUES ( 'ZA', 'South African');
INSERT INTO LN_Nationalities VALUES ( 'GS', 'South Georgia and the South Sandwich Islands');
INSERT INTO LN_Nationalities VALUES ( 'ES', 'Spanish');
INSERT INTO LN_Nationalities VALUES ( 'LK', 'Sri Lankan');
INSERT INTO LN_Nationalities VALUES ( 'SD', 'Sudanese');
INSERT INTO LN_Nationalities VALUES ( 'SR', 'Surinamese');
INSERT INTO LN_Nationalities VALUES ( 'SJ', 'Svalbard and Jan Mayen');
INSERT INTO LN_Nationalities VALUES ( 'SZ', 'Swazi');
INSERT INTO LN_Nationalities VALUES ( 'SE', 'Swedish');
INSERT INTO LN_Nationalities VALUES ( 'CH', 'Swiss');
INSERT INTO LN_Nationalities VALUES ( 'SY', 'Syrian');
INSERT INTO LN_Nationalities VALUES ( 'TW', 'Taiwanese');
INSERT INTO LN_Nationalities VALUES ( 'TJ', 'Tajik');
INSERT INTO LN_Nationalities VALUES ( 'TZ', 'Tanzanian');
INSERT INTO LN_Nationalities VALUES ( 'TH', 'Thai');
INSERT INTO LN_Nationalities VALUES ( 'TL', 'East Timorese');
INSERT INTO LN_Nationalities VALUES ( 'TG', 'Togolese');
INSERT INTO LN_Nationalities VALUES ( 'TK', 'Tokelauan');
INSERT INTO LN_Nationalities VALUES ( 'TO', 'Tongan');
INSERT INTO LN_Nationalities VALUES ( 'TT', 'Trinidadian; Tobagonian');
INSERT INTO LN_Nationalities VALUES ( 'TN', 'Tunisian');
INSERT INTO LN_Nationalities VALUES ( 'TR', 'Turkish');
INSERT INTO LN_Nationalities VALUES ( 'TM', 'Turkmen');
INSERT INTO LN_Nationalities VALUES ( 'TC', 'Turks and Caicos Islander');
INSERT INTO LN_Nationalities VALUES ( 'TV', 'Tuvaluan');
INSERT INTO LN_Nationalities VALUES ( 'VI', 'US Virgin Islander');
INSERT INTO LN_Nationalities VALUES ( 'UG', 'Ugandan');
INSERT INTO LN_Nationalities VALUES ( 'UA', 'Ukrainian');
INSERT INTO LN_Nationalities VALUES ( 'AE', 'Emirian');
INSERT INTO LN_Nationalities VALUES ( 'GB', 'British');
INSERT INTO LN_Nationalities VALUES ( 'UM', 'United States Minor Outlying Islands');
INSERT INTO LN_Nationalities VALUES ( 'US', 'American');
INSERT INTO LN_Nationalities VALUES ( 'UY', 'Uruguayan');
INSERT INTO LN_Nationalities VALUES ( 'UZ', 'Uzbek');
INSERT INTO LN_Nationalities VALUES ( 'VU', 'Vanuatuan');
INSERT INTO LN_Nationalities VALUES ( 'VE', 'Venezuelan');
INSERT INTO LN_Nationalities VALUES ( 'VN', 'Vietnamese');
INSERT INTO LN_Nationalities VALUES ( 'WF', 'Wallisian; Futunan');
INSERT INTO LN_Nationalities VALUES ( 'EH', 'Sahrawi');
INSERT INTO LN_Nationalities VALUES ( 'YE', 'Yemeni');
INSERT INTO LN_Nationalities VALUES ( 'ZM', 'Zambian');
INSERT INTO LN_Nationalities VALUES ( 'ZW', 'Zimbabwean');



-- Reference: http://www.xe.net/ucc/full.shtml
   -- XXX: If there is plural we use it, else we use just the 'Name' in the forms.
INSERT INTO LU_Currencies VALUES ( 'AFA', 'Afghani', 'Afghanis', 'Afghanistan' );
INSERT INTO LU_Currencies VALUES ( 'ALL', 'Lek',     'Lekë', 'Albania' );

INSERT INTO LU_Currencies VALUES ( 'DZD', 'Dinar, Algeria', 'Dinars, Algeria', 'Algeria' );
INSERT INTO LU_Currencies VALUES ( 'BHD', 'Dinar, Bahrain', 'Dinars, Bahrain', 'Bahrain' );
INSERT INTO LU_Currencies VALUES ( 'IQD', 'Dinar, Iraq',    'Dinars, Iraq', 'Iraq' );
INSERT INTO LU_Currencies VALUES ( 'JOD', 'Dinar, Jordan',  'Dinars, Jordan', 'Jordan' );
INSERT INTO LU_Currencies VALUES ( 'KWD', 'Dinar, Kuwait',  'Dinars, Kuwait', 'Kuwait' );
INSERT INTO LU_Currencies VALUES ( 'LYD', 'Dinar, Libya',   'Dinars, Libya', 'Libya' );
INSERT INTO LU_Currencies VALUES ( 'CSD', 'Dinar, Serbia',  'Dinars, Serbia', 'Serbia' );
INSERT INTO LU_Currencies VALUES ( 'SDD', 'Dinar, Sudan',   'Dinars, Sudan', 'Sudan' );
INSERT INTO LU_Currencies VALUES ( 'TND', 'Dinar, Tunisia', 'Dinars, Tunisia', 'Tunisia' );

INSERT INTO LU_Currencies VALUES ( 'USD', 'Dollar, United States of America', 'Dollars, United States of America', 'United States of America, Samoa, East Timor, Ecuador, Guam, Johnson, Micronesia, Navassa, Panama, Palau, Puerto Rico' );
INSERT INTO LU_Currencies VALUES ( 'XCD', 'Dollar, East Caribbean',           'Dollars, East Caribbean', 'Anguilla, Antigua and Barbuda, Dominica, Grenada, Montserrat, Saint Kitts and Nevis, Saint Lucia, Saint Vincent and The Grenadines' );
INSERT INTO LU_Currencies VALUES ( 'AUD', 'Dollar, Australia',                'Dollars, Australia', 'Australia, Kiribati, Nauru, Tuvalu' );
INSERT INTO LU_Currencies VALUES ( 'BSD', 'Dollar, Bahamas ',                 'Dollars, Bahamas', 'Bahamas' );
INSERT INTO LU_Currencies VALUES ( 'BBD', 'Dollar, Barbados',                 'Dollars, Barbados', 'Barbados' );
INSERT INTO LU_Currencies VALUES ( 'BZD', 'Dollar, Belize',                   'Dollars, Belize', 'Belize' );
INSERT INTO LU_Currencies VALUES ( 'BMD', 'Dollar, Bermuda',                  'Dollars, Bermuda', 'Bermuda' );
INSERT INTO LU_Currencies VALUES ( 'BND', 'Dollar, Brunei',                   'Dollars, Brunei', 'Brunei' );
INSERT INTO LU_Currencies VALUES ( 'SGD', 'Dollar, Singapore',                'Dollars, Singapore', 'Singapore, Brunei' );
INSERT INTO LU_Currencies VALUES ( 'CAD', 'Dollar, Canada',                   'Dollars, Canada', 'Canada' );
INSERT INTO LU_Currencies VALUES ( 'FJD', 'Dollar, Fiji',                     'Dollars, Fiji', 'Fiji' );
INSERT INTO LU_Currencies VALUES ( 'GYD', 'Dollar, Guyana',                   'Dollars, Guyana', 'Guyana' );
INSERT INTO LU_Currencies VALUES ( 'HKD', 'Dollar, Hong Kong',                'Dollars, Hong Kong', 'Hong Kong' );
INSERT INTO LU_Currencies VALUES ( 'JMD', 'Dollar, Jamaica',                  'Dollars, Jamaica', 'Jamaica' );
INSERT INTO LU_Currencies VALUES ( 'LRD', 'Dollar, Liberia',                  'Dollars, Liberia', 'Liberia' );
INSERT INTO LU_Currencies VALUES ( 'NAD', 'Dollar, Namibia',                  'Dollars, Namibia', 'Namibia' );
INSERT INTO LU_Currencies VALUES ( 'NZD', 'Dollar, New Zealand',              'Dollars, New Zealand', 'New Zealand, Niue, Pitcairn, Tokelau' );
INSERT INTO LU_Currencies VALUES ( 'SRD', 'Dollar, Suriname',                 'Dollars, Suriname', 'Suriname' );
INSERT INTO LU_Currencies VALUES ( 'TWD', 'New Dollar, Taiwan',               'New Dollars, Taiwan', 'Taiwan' );
INSERT INTO LU_Currencies VALUES ( 'TTD', 'Dollar, Trinidad and Tobago',      'Dollars, Trinidad and Tobago', 'Trinidad and Tobago' );
INSERT INTO LU_Currencies VALUES ( 'TVD', 'Dollar, Tuvalu',                   'Dollars, Tuvalu', 'Tuvalu' );
INSERT INTO LU_Currencies VALUES ( 'ZWD', 'Dollar, Zimbabwe',                 'Dollars, Zimbabwe', 'Zimbabwe' );

INSERT INTO LU_Currencies VALUES ( 'EUR', 'Euro', 'Euros', 'Andorra, Austria, Belgium, Dutch (Netherlands), Finland, France, Germany, Greece, Guadeloupe, Holland (Netherlands), Ireland, Italy, Luxembourg, Mayotte, Monaco, Montenegro, Netherlands, Portugal, Reunion, San Marino, Spain, Vatican City' );

INSERT INTO LU_Currencies VALUES ( 'AOA', 'Kwanza', 'Kwanzas', 'Angola' );
INSERT INTO LU_Currencies VALUES ( 'AMD', 'Dram',   'Dram', 'Armenia' );

INSERT INTO LU_Currencies VALUES ( 'AWG', 'Guilder, Aruba',                'Guilders, Aruba', 'Aruba' ); -- XXX: !!!: What is the Aruba's currency the Guilder or the Florin? Reference: http://en.wikipedia.org/wiki/Aruban_florin
INSERT INTO LU_Currencies VALUES ( 'ANG', 'Guilder, Netherlands Antilles', 'Guilders, Netherlands Antilles', 'Bonaire, Curaço, Netherlands Antilles, Saba, Sint Eustatius, Sint Maarten' );-- XXX: !!!: What is the Netherlands Antilles' currency the Guilder or the Gulden? Reference: http://en.wikipedia.org/wiki/Netherlands_Antillean_gulden

INSERT INTO LU_Currencies VALUES ( 'AZM', 'Manat, Azerbaijan',   'Manats, Azerbaijan', 'Azerbaijan' );
INSERT INTO LU_Currencies VALUES ( 'TMM', 'Manat, Turkmenistan', 'Manats, Turkmenistan', 'Turkmenistan' );

INSERT INTO LU_Currencies VALUES ( 'BDT', 'Taka',  'Taka', 'Bangladesh' );
INSERT INTO LU_Currencies VALUES ( 'BYR', 'Ruble', 'Rubles', 'Belarus' );

INSERT INTO LU_Currencies VALUES ( 'XOF', 'CFA Franc BCEAO',                        'CFA Francs BCEAO', 'Benin, Burkina Faso, CFA Communauté Financière, Côte dIvoire, Mali, Niger, Senegal, Togo' );
INSERT INTO LU_Currencies VALUES ( 'BIF', 'Franc, Burundi',                         'Francs, Burundi', 'Burundi' );
INSERT INTO LU_Currencies VALUES ( 'XAF', 'CFA Franc BEAC',                         'CFA Francs BEAC', 'Cameroon, Central African Republic, Communauté Financière Africaine, Chad, Congo/Brazzaville, Equatorial Guinea, Gabon' );
INSERT INTO LU_Currencies VALUES ( 'KMF', 'Franc, Comoros',                         'Francs, Comoros', 'Comoros' );
INSERT INTO LU_Currencies VALUES ( 'CDF', 'Franc, Congo',                           'Francs, Congo', 'Congo' );
INSERT INTO LU_Currencies VALUES ( 'DJF', 'Franc, Djibouti',                        'Francs, Djibouti', 'Djibouti' );
INSERT INTO LU_Currencies VALUES ( 'GNF', 'Franc, Guinea',                          'Francs, Guinea', 'Guinea' );
INSERT INTO LU_Currencies VALUES ( 'CHF', 'Franc, Switzerland',                     'Francs, Switzerland', 'Switzerland, Liechtenstein' );
-- Note: We have removed the 'Français' word to make it shorter, so the form look cool. Recover it later if needed. -- INSERT INTO Currencies VALUES ( 'XPF', 'Franc, Comptoirs Français du Pacifique', 'Francs, Comptoirs Français du Pacifique', 'French Polynesia, New Caledonia' );
INSERT INTO LU_Currencies VALUES ( 'XPF', 'Franc, Comptoirs du Pacifique', 'Francs, Comptoirs du Pacifique', 'French Polynesia, New Caledonia' );
INSERT INTO LU_Currencies VALUES ( 'RWF', 'Franc, Rwanda',                          'Francs, Rwanda', 'Rwanda' );

INSERT INTO LU_Currencies VALUES ( 'INR', 'Rupee, India',      'Rupees, India', 'India, Bhutan' );
INSERT INTO LU_Currencies VALUES ( 'SCR', 'Rupee, Seychelles', 'Rupees, Seychelles', 'Seychelles' );
INSERT INTO LU_Currencies VALUES ( 'LKR', 'Rupee, Sri Lanka',  'Rupees, Sri Lanka', 'Sri Lanka' );
INSERT INTO LU_Currencies VALUES ( 'MUR', 'Rupee, Mauritius',  'Rupees, Mauritius', 'Mauritius' );
INSERT INTO LU_Currencies VALUES ( 'NPR', 'Rupee, Nepal',      'Rupees, Nepal', 'Nepal' );
INSERT INTO LU_Currencies VALUES ( 'PKR', 'Rupee, Pakistan',   'Rupees, Pakistan', 'Pakistan' );

INSERT INTO LU_Currencies VALUES ( 'BTN', 'Ngultrum',          'Ngultrum', 'Bhutan' );
INSERT INTO LU_Currencies VALUES ( 'BOB', 'Boliviano',         'Bolivianos', 'Bolivia' );
INSERT INTO LU_Currencies VALUES ( 'BAM', 'Convertible Marka', 'Convertible Maraka', 'Bosnia and Herzegovina' );
INSERT INTO LU_Currencies VALUES ( 'BWP', 'Pula',              'Pula', 'Botswana' );
INSERT INTO LU_Currencies VALUES ( 'BRL', 'Real',              'Reais', 'Brazil' );

INSERT INTO LU_Currencies VALUES ( 'GBP', 'Pound, United Kingdom',  'Pounds, United Kingdom', 'England, Great Britain, Scotland, South Georgia, South Georgia, United Kingdom, Britain' );
INSERT INTO LU_Currencies VALUES ( 'CYP', 'Pound, Cyprus',          'Pounds, Cyprus', 'Cyprus' );
INSERT INTO LU_Currencies VALUES ( 'EGP', 'Pound, Egypt',           'Pounds, Egypt', 'Egypt' );
INSERT INTO LU_Currencies VALUES ( 'GIP', 'Pound, Gibraltar',       'Pounds, Gibraltar', 'Gibraltar' );
INSERT INTO LU_Currencies VALUES ( 'GGP', 'Pound, Guernsey',        'Pounds, Guernsey', 'Guernsey' );
INSERT INTO LU_Currencies VALUES ( 'IMP', 'Pound, Isle of Man',     'Pounds, Isle of Man', 'Isle of Man' );
INSERT INTO LU_Currencies VALUES ( 'JEP', 'Pound, Jersey',          'Pounds, Jersey', 'Jersey' );
INSERT INTO LU_Currencies VALUES ( 'LBP', 'Pound, Lebanon',         'Pounds, Lebanon', 'Lebanon' );
INSERT INTO LU_Currencies VALUES ( 'SHP', 'Pound, Saint Helena',    'Pounds, Saint Helena', 'Saint Helena' );
INSERT INTO LU_Currencies VALUES ( 'SYP', 'Pound, Syria',           'Pounds, Syria', 'Syria' );

INSERT INTO LU_Currencies VALUES ( 'BGN', 'Lev',    'Leva', 'Bulgaria' );
INSERT INTO LU_Currencies VALUES ( 'MMK', 'Kyat',   'Kyats', 'Myanmar, Burma' );
INSERT INTO LU_Currencies VALUES ( 'KHR', 'Riel',   'Riels', 'Cambodia' );

INSERT INTO LU_Currencies VALUES ( 'CVE', 'Escudo, Cape Verde',       'Escudos, Cape Verde', 'Cape Verde' );

INSERT INTO LU_Currencies VALUES ( 'ARS', 'Peso, Argentina',          'Pesos, Argentina', 'Argentina' );
INSERT INTO LU_Currencies VALUES ( 'CLP', 'Peso, Chile',              'Pesos, Chile', 'Chile' );
INSERT INTO LU_Currencies VALUES ( 'COP', 'Peso, Colombia',           'Pesos, Colombia', 'Colombia' );
INSERT INTO LU_Currencies VALUES ( 'CUP', 'Peso, Cuba',               'Pesos, Cuba', 'Cuba' );
INSERT INTO LU_Currencies VALUES ( 'DOP', 'Peso, Dominican Republic', 'Pesos, Dominican Republic', 'Dominican Republic' );
INSERT INTO LU_Currencies VALUES ( 'MXN', 'Peso, Mexico',             'Pesos, Mexico', 'Mexico' );
INSERT INTO LU_Currencies VALUES ( 'PHP', 'Peso, Philippines',        'Pesos, Philippines', 'Philippines' );
INSERT INTO LU_Currencies VALUES ( 'UYU', 'Peso, Uruguay',            'Pesos, Uruguay', 'Uruguay' );

INSERT INTO LU_Currencies VALUES ( 'CNY', 'Yuan Renminbi',      'Yuan', 'China, Nepal' );

INSERT INTO LU_Currencies VALUES ( 'CRC', 'Colon, Costa Rica',  'Colones, Costa Rica', 'Costa Rica' );
-- INSERT INTO LU_Currencies VALUES ( 'SVC', 'Colon, El Salvador', 'Colones, El Salvador', 'El Salvador' ); -- XXX: Discontinued: Reference: http://en.wikipedia.org/wiki/El_Salvador

INSERT INTO LU_Currencies VALUES ( 'HRK', 'Kuna',               'Kuna', 'Croatia' );

INSERT INTO LU_Currencies VALUES ( 'CZK', 'Koruna, Czech Republic', 'Koruny, Czech Republic', 'Czech Republic' );
INSERT INTO LU_Currencies VALUES ( 'SKK', 'Koruna, Slovakia',       'Koruny, Slovakia',       'Slovakia' );

INSERT INTO LU_Currencies VALUES ( 'DKK', 'Krone, Denmark', 'Kroner, Denmark', 'Denmark, Greenland' );
INSERT INTO LU_Currencies VALUES ( 'NOK', 'Krone, Norway',  'Kroner, Norway', 'Norway, Svalbard and Jan Mayen' );

INSERT INTO LU_Currencies VALUES ( 'ISK', 'Krona, Iceland', 'Kronur, Iceland', 'Iceland' );
INSERT INTO LU_Currencies VALUES ( 'SEK', 'Krona, Sweden',  'Kronor, Sweden', 'Sweden' );

INSERT INTO LU_Currencies VALUES ( 'ERN', 'Nakfa',  'Nakfas', 'Eritrea' );
INSERT INTO LU_Currencies VALUES ( 'EEK', 'Kroon',  'Krooni', 'Estonia' );
INSERT INTO LU_Currencies VALUES ( 'ETB', 'Birr',   'Birr', 'Ethiopia' );
INSERT INTO LU_Currencies VALUES ( 'GMD', 'Dalasi', 'Dalasis', 'Gambia' );

INSERT INTO LU_Currencies VALUES ( 'ILS', 'Israel New Shekel', 'Israel New Shekels', 'Gaza Strip, Israel' );

INSERT INTO LU_Currencies VALUES ( 'GEL', 'Lari', 'Lari', 'Georgia' );
INSERT INTO LU_Currencies VALUES ( 'GHC', 'Cedi', 'Cedis', 'Ghana' );

INSERT INTO LU_Currencies VALUES ( 'GTQ', 'Quetzal',       'Quetzales', 'Guatemala' );
INSERT INTO LU_Currencies VALUES ( 'HTG', 'Gourde, Haiti', 'Gourdes, Haiti', 'Haiti, Navassa' );
INSERT INTO LU_Currencies VALUES ( 'HNL', 'Lempira',       'Lempiras', 'Honduras' );

INSERT INTO LU_Currencies VALUES ( 'HUF', 'Forint, Hungary', 'Forints, Hungary', 'Hungary' );

INSERT INTO LU_Currencies VALUES ( 'IDR', 'Rupiah, Indonesia', 'Rupiahs, Indonesia', 'Indonesia' );

INSERT INTO LU_Currencies VALUES ( 'XDR', 'Special Drawing Right', 'Special Drawing Rights', 'International Monetary Fund' );

INSERT INTO LU_Currencies VALUES ( 'IRR', 'Rial, Iran',  'Rials, Iran', 'Iran' );
INSERT INTO LU_Currencies VALUES ( 'OMR', 'Rial, Oman',  'Rials, Oman', 'Oman' );
INSERT INTO LU_Currencies VALUES ( 'YER', 'Rial, Yemen', 'Rials, Yemen', 'Yemen' );

INSERT INTO LU_Currencies VALUES ( 'JPY', 'Yen, Japan',  'Yen, Japan', 'Japan' );
INSERT INTO LU_Currencies VALUES ( 'KZT', 'Tenge',       'Tenge', 'Kazakhstan' );

INSERT INTO LU_Currencies VALUES ( 'KES', 'Shilling, Kenya',    'Shillings, Kenya', 'Kenya' );
INSERT INTO LU_Currencies VALUES ( 'UGX', 'Shilling, Uganda',   'Shillings, Uganda', 'Uganda' );
INSERT INTO LU_Currencies VALUES ( 'SOS', 'Shilling, Somalia',  'Shillings, Somalia', 'Somalia' );
INSERT INTO LU_Currencies VALUES ( 'TZS', 'Shilling, Tanzania', 'Shillings, Tanzania', 'Tanzania' );

INSERT INTO LU_Currencies VALUES ( 'KGS', 'Som, Kyrgyzstan', 'Som, Kyrgyzstan', 'Kyrgyzstan' );
INSERT INTO LU_Currencies VALUES ( 'UZS', 'Som, Uzbekistan', 'Som, Uzbekistan', 'Uzbekistan' );

INSERT INTO LU_Currencies VALUES ( 'LAK', 'Kip',           'Kip', 'Laos' );
INSERT INTO LU_Currencies VALUES ( 'LVL', 'Lat',           'Lats', 'Latvia' );
INSERT INTO LU_Currencies VALUES ( 'LSL', 'Loti, Lesotho', 'Maloti, Lesotho', 'Lesotho' );
INSERT INTO LU_Currencies VALUES ( 'LTL', 'Litas',         'Litas', 'Lithuania' );
INSERT INTO LU_Currencies VALUES ( 'MOP', 'Pataca',        'Patacas', 'Macau' );
INSERT INTO LU_Currencies VALUES ( 'MKD', 'Denar',         'Denars', 'Macedonia' );
INSERT INTO LU_Currencies VALUES ( 'MGA', 'Ariary',        'Ariary', 'Madagascar' );

INSERT INTO LU_Currencies VALUES ( 'MWK', 'Kwacha, Malawi', 'Kwacha, Malawi', 'Malawi' );
INSERT INTO LU_Currencies VALUES ( 'ZMK', 'Kwacha, Zambia', 'Kwacha, Zambia', 'Zambia' );

INSERT INTO LU_Currencies VALUES ( 'MYR', 'Ringgit, Malaysia', 'Ringgits, Malaysia', 'Malaysia' );

INSERT INTO LU_Currencies VALUES ( 'MVR', 'Rufiyaa',      'Rufiyaa', 'Maldives' );

INSERT INTO LU_Currencies VALUES ( 'MTL', 'Lira, Malta',  'Liras, Malta', 'Malta' );
INSERT INTO LU_Currencies VALUES ( 'TRL', 'Lira, Turkey', 'Liras, Turkey', 'Turkey' );

INSERT INTO LU_Currencies VALUES ( 'MRO', 'Ouguiya', 'Ouguiya', 'Mauritania' );

INSERT INTO LU_Currencies VALUES ( 'MDL', 'Leu, Moldova', 'Lei, Moldova', 'Moldova, Transnistria' );
INSERT INTO LU_Currencies VALUES ( 'ROL', 'Leu, Romania', 'Lei, Romania', 'Romania' );

INSERT INTO LU_Currencies VALUES ( 'MNT', 'Tugrug', 'Tugrug', 'Mongolia' );

INSERT INTO LU_Currencies VALUES ( 'MAD', 'Dirham, Morocco',              'Dirhams, Morocco', 'Morocco, Western Sahara' );
INSERT INTO LU_Currencies VALUES ( 'AED', 'Dirham, United Arab Emirates', 'Dirhams, United Arab Emirates', 'United Arab Emirates' );

INSERT INTO LU_Currencies VALUES ( 'MZM', 'Metical',      'Meticais', 'Mozambique' );
INSERT INTO LU_Currencies VALUES ( 'NIO', 'Córdoba',      'Córdobas', 'Nicaragua' );
INSERT INTO LU_Currencies VALUES ( 'NGN', 'Naira',        'Nairas', 'Nigeria' );

INSERT INTO LU_Currencies VALUES ( 'KPW', 'Won, North Korea', 'Won, North Korea', 'North Korea' );
INSERT INTO LU_Currencies VALUES ( 'KRW', 'Won, South Korea', 'Won, South Korea', 'South Korea' );

INSERT INTO LU_Currencies VALUES ( 'PAB', 'Balboa',    'Balboas', 'Panama' );
INSERT INTO LU_Currencies VALUES ( 'PGK', 'Kina',      'Kina', 'Papua New Guinea' );
INSERT INTO LU_Currencies VALUES ( 'PYG', 'Guaraní',   'Guaraníes', 'Paraguay' );
INSERT INTO LU_Currencies VALUES ( 'PEN', 'Nuevo Sol', 'Nuevos Soles', 'Peru' );

INSERT INTO LU_Currencies VALUES ( 'PLN', 'Złoty, Poland', 'Złotych, Poland', 'Poland' );

INSERT INTO LU_Currencies VALUES ( 'QAR', 'Riyal, Qatar',        'Riyals, Qatar', 'Qatar' );
INSERT INTO LU_Currencies VALUES ( 'SAR', 'Riyal, Saudi Arabia', 'Riyals, Saudi Arabia', 'Saudi Arabia' );

INSERT INTO LU_Currencies VALUES ( 'RUR', 'Ruble, Russia', 'Rubles, Russia', 'Russia, Tajikistan' );

INSERT INTO LU_Currencies VALUES ( 'WST', 'Tala',    'Tala', 'Samoa, Western Samoa' );
INSERT INTO LU_Currencies VALUES ( 'STD', 'Dobra',   'Dobras', 'São Tome and Principe' );
-- INSERT INTO LU_Currencies VALUES ( 'SPL', 'Luigino', 'Luigino', 'Seborga' );  -- XXX: The legal currency is nevertheless the euro. Reference: http://en.wikipedia.org/wiki/Luigino
INSERT INTO LU_Currencies VALUES ( 'SLL', 'Leone',   'Leones', 'Sierra Leone' );
-- INSERT INTO LU_Currencies VALUES ( 'SIT', 'Tolar',   'Tolarjev', 'Slovenia' );  -- XXX: Will be replaced by the euro (EUR) on 1 January 2007. Reference: http://en.wikipedia.org/wiki/Slovenia

INSERT INTO LU_Currencies VALUES ( 'ZAR', 'Rand, South Africa', 'Rand, South Africa', 'South Africa, Swaziland' );

INSERT INTO LU_Currencies VALUES ( 'SZL', 'Lilangeni', 'Emalangeni', 'Swaziland' );
INSERT INTO LU_Currencies VALUES ( 'TJS', 'Somoni',    'Somoni', 'Tajikistan' );

INSERT INTO LU_Currencies VALUES ( 'THB', 'Baht', 'Baht', 'Thailand' );

INSERT INTO LU_Currencies VALUES ( 'TOP', 'Pa\'anga', 'Pa\'anga', 'Tonga' ); -- XXX: Check if the \' character could raise a bug.
INSERT INTO LU_Currencies VALUES ( 'UAH', 'Hryvna',   'Hryvnias', 'Ukraine' );
INSERT INTO LU_Currencies VALUES ( 'VUV', 'Vatu',     'Vatu', 'Vanuatu' );

INSERT INTO LU_Currencies VALUES ( 'VEB', 'Bolivar', 'Bolivares', 'Venezuela' );

INSERT INTO LU_Currencies VALUES ( 'VND', 'Dong', 'Dong', 'Vietnam' );



INSERT INTO LF_FieldProfiles VALUES ( 'Data Bases' );
INSERT INTO LF_FieldProfiles VALUES ( 'Networks' );
INSERT INTO LF_FieldProfiles VALUES ( 'Systems' );
INSERT INTO LF_FieldProfiles VALUES ( 'Security' );
INSERT INTO LF_FieldProfiles VALUES ( 'Web' );
INSERT INTO LF_FieldProfiles VALUES ( 'Creative design' );
INSERT INTO LF_FieldProfiles VALUES ( 'Quality Assurance' );

INSERT INTO LP_ProfessionalProfiles VALUES ( 'General Manager' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'HH.RR.' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Marketing' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Logistics and Distribution' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Commercial - Seller' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Customer support' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Research and Development' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Account Manager' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Project Manager' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Architect' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Auditor' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Adviser' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Technician' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Functional Analyst' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Technician Analyst' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Developer' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Beta tester' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Administrator' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Documentalist' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Technical Redactor' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Teacher' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Translator' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Operator' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Technical support' );
INSERT INTO LP_ProfessionalProfiles VALUES ( 'Helpdesk' );

INSERT INTO LX_ProductProfiles VALUES ( 'Software' );
INSERT INTO LX_ProductProfiles VALUES ( 'Firmware' );
INSERT INTO LX_ProductProfiles VALUES ( 'Hardware' );

-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LA_AcademicLevels VALUES ( 'Enrolled at a University (Undergraduate)', '10' );
INSERT INTO LA_AcademicLevels VALUES ( 'Bachelor\'s degree (1st University cycle)','20' );
INSERT INTO LA_AcademicLevels VALUES ( 'Master\'s degree (2nd University cycle)',  '30' );
INSERT INTO LA_AcademicLevels VALUES ( 'Doctoral degree (3rd University cycle)',   '40' );
INSERT INTO LA_AcademicLevels VALUES ( 'Other',                                    '00' );


INSERT INTO LC_Certifications VALUES ( 'GNU Business Network',      'false', 'true',  'true'  ); -- This certification could be checked automatically.
INSERT INTO LC_Certifications VALUES ( 'Free Software Contributor', 'true',  'true',  'true'  ); -- This certification is automatically checked by the webapp, checking the E2_URI field.

-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LK_ContractType VALUES ( 'Any' );
INSERT INTO LK_ContractType VALUES ( 'Vacation cover' );
INSERT INTO LK_ContractType VALUES ( 'Maternity cover' );
INSERT INTO LK_ContractType VALUES ( 'Training' );
INSERT INTO LK_ContractType VALUES ( 'By hours' );
INSERT INTO LK_ContractType VALUES ( 'By project' );
INSERT INTO LK_ContractType VALUES ( 'Partner' );
INSERT INTO LK_ContractType VALUES ( 'Freelance' );
INSERT INTO LK_ContractType VALUES ( 'Temporary' );
INSERT INTO LK_ContractType VALUES ( 'Half time' );
INSERT INTO LK_ContractType VALUES ( 'Full time' );
INSERT INTO LK_ContractType VALUES ( 'Indefinite' );

INSERT INTO LB_ByPeriod VALUES ( 'by year' );
INSERT INTO LB_ByPeriod VALUES ( 'by month' );
INSERT INTO LB_ByPeriod VALUES ( 'by week' );
INSERT INTO LB_ByPeriod VALUES ( 'by day' );
INSERT INTO LB_ByPeriod VALUES ( 'by hour' );
INSERT INTO LB_ByPeriod VALUES ( 'by project' );

INSERT INTO LM_TimeUnits VALUES ( 'hours' );
INSERT INTO LM_TimeUnits VALUES ( 'days' );
INSERT INTO LM_TimeUnits VALUES ( 'weeks' );
INSERT INTO LM_TimeUnits VALUES ( 'months' );
INSERT INTO LM_TimeUnits VALUES ( 'years' );

-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LE_Employability VALUES ( 'Working' );
INSERT INTO LE_Employability VALUES ( 'Working and Studying' );
INSERT INTO LE_Employability VALUES ( 'Freelance' );
INSERT INTO LE_Employability VALUES ( 'Freelance and Studying' );
INSERT INTO LE_Employability VALUES ( 'Studying' );
INSERT INTO LE_Employability VALUES ( 'Without job' );

-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LS_SpokenLevel VALUES ( 'Null',         '00' );
INSERT INTO LS_SpokenLevel VALUES ( 'Basic',        '01' );
INSERT INTO LS_SpokenLevel VALUES ( 'Conversation', '02' );
INSERT INTO LS_SpokenLevel VALUES ( 'Negotiation',  '03' );
INSERT INTO LS_SpokenLevel VALUES ( 'Native',       '04' );

-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LW_WrittenLevel VALUES ( 'Null',       '00' );
INSERT INTO LW_WrittenLevel VALUES ( 'Basic',      '01' );
INSERT INTO LW_WrittenLevel VALUES ( 'Medium',     '02' );
INSERT INTO LW_WrittenLevel VALUES ( 'High',       '03' );
INSERT INTO LW_WrittenLevel VALUES ( 'Excellent',  '04' );

-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LZ_ApplicationStates VALUES ( 'Received' );
INSERT INTO LZ_ApplicationStates VALUES ( 'In process' );
INSERT INTO LZ_ApplicationStates VALUES ( 'Ruled out' );
INSERT INTO LZ_ApplicationStates VALUES ( 'Finalist' );
INSERT INTO LZ_ApplicationStates VALUES ( 'Selected' );

INSERT INTO LT_SkillSetTypes VALUES ( '00', 'Software distributions' );
INSERT INTO LT_SkillSetTypes VALUES ( '01', 'Operating systems' );
INSERT INTO LT_SkillSetTypes VALUES ( '02', 'Operating system kernels' );
INSERT INTO LT_SkillSetTypes VALUES ( '03', 'Hardware architectures' );
INSERT INTO LT_SkillSetTypes VALUES ( '04', 'Software engineering methodologies' );
INSERT INTO LT_SkillSetTypes VALUES ( '05', 'Architectural Patterns' );
INSERT INTO LT_SkillSetTypes VALUES ( '06', 'Design Patterns' );
-- INSERT INTO LT_SkillSetTypes VALUES ( '00', 'Coding Patterns (Idioms)' );
INSERT INTO LT_SkillSetTypes VALUES ( '07', 'Development formal languages' );
INSERT INTO LT_SkillSetTypes VALUES ( '08', 'Development specification languages' );
INSERT INTO LT_SkillSetTypes VALUES ( '09', 'Development tools' );
INSERT INTO LT_SkillSetTypes VALUES ( '10', 'Development libraries' );
INSERT INTO LT_SkillSetTypes VALUES ( '11', 'Development frameworks' );
INSERT INTO LT_SkillSetTypes VALUES ( '12', 'Development techniques' );
INSERT INTO LT_SkillSetTypes VALUES ( '13', 'Testing frameworks' );
INSERT INTO LT_SkillSetTypes VALUES ( '14', 'Specifications' );
INSERT INTO LT_SkillSetTypes VALUES ( '15', 'Network protocols' );
INSERT INTO LT_SkillSetTypes VALUES ( '16', 'Network servers' );
INSERT INTO LT_SkillSetTypes VALUES ( '17', 'Network tools' );
INSERT INTO LT_SkillSetTypes VALUES ( '18', 'Desktop applications' );
-- INSERT INTO LT_SkillSetTypes VALUES ( 'Analisys and Design tools' );
INSERT INTO LT_SkillSetTypes VALUES ( '19', 'Documentation tools' );
INSERT INTO LT_SkillSetTypes VALUES ( '20', 'Translation tools' );



-- Skills classification:  Read the email thread: http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-11/msg00066.html

-- *) Initial flag
INSERT INTO LH_Skills VALUES ( 'Pending' ); -- Pending to classify.

-- *) General flags
INSERT INTO LH_Skills VALUES ( 'Unknown' ); -- After trying to classify it, we conclude such skill is unknown.
INSERT INTO LH_Skills VALUES ( 'Abstract' ); -- After trying to classify it, we conclude such skill does not reference a specific Software (program, language, protocol, specification, software distribution, etc.), Hardware, Documentation, Data or Art. For example, the "IP Networking protocols" skills is classified as 'Abstract'.

-- 1) Classifying Software (programs, languages, protocols, specifications, software distributions, etc.) as Free or Non-Free Software
INSERT INTO LH_Skills VALUES ( 'Free Software' );
INSERT INTO LH_Skills VALUES ( 'Almost-Free Software' );
INSERT INTO LH_Skills VALUES ( 'Partially-Free Software' );
INSERT INTO LH_Skills VALUES ( 'Non-Free Software' );

-- 2) Classifying Hardware
INSERT INTO LH_Skills VALUES ( 'Hardware' );

-- 3) Classifying Documentation
INSERT INTO LH_Skills VALUES ( 'Documentation' ); -- If we do not want invest time to check if a documentation item is free or not, we can just tag it as Documentation, without specifying its freedomness.
INSERT INTO LH_Skills VALUES ( 'Free Documentation' );
INSERT INTO LH_Skills VALUES ( 'Non-Free Documentation' );

-- 4) Classifying Data
INSERT INTO LH_Skills VALUES ( 'Data' ); -- If we do not want invest time to check if a data item is free or not, we can just tag it as Data, without specifying its freedomness.
INSERT INTO LH_Skills VALUES ( 'Free Data' );
INSERT INTO LH_Skills VALUES ( 'Non-Free Data' );

-- 5) Classifying Art
INSERT INTO LH_Skills VALUES ( 'Art' ); -- If we do not want invest time to check if a art item is sharable or not, we can just tag it as Art, without specifying it.
INSERT INTO LH_Skills VALUES ( 'Sharable Art' );
INSERT INTO LH_Skills VALUES ( 'Non-Sharable Art' );



-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LG_KnowledgeLevel VALUES ( 'Null',                '00' );
INSERT INTO LG_KnowledgeLevel VALUES ( 'Basic',               '01' ); -- as User
INSERT INTO LG_KnowledgeLevel VALUES ( 'Good',                '02' ); -- as User
INSERT INTO LG_KnowledgeLevel VALUES ( 'Master',              '03' ); -- as User
INSERT INTO LG_KnowledgeLevel VALUES ( 'Expert',              '04' ); -- as User
INSERT INTO LG_KnowledgeLevel VALUES ( 'internals',           '05' ); -- as Developer

-- These registers must be inserted in sort according to the value of the first field:
INSERT INTO LN_ExperienceLevel VALUES ( 'Null',               '00' );
INSERT INTO LN_ExperienceLevel VALUES ( 'up to 6 months',     '01' );
INSERT INTO LN_ExperienceLevel VALUES ( 'up to 2 years',      '02' );
INSERT INTO LN_ExperienceLevel VALUES ( 'up to 5 years',      '03' );
INSERT INTO LN_ExperienceLevel VALUES ( 'up to 10 years',     '04' );
INSERT INTO LN_ExperienceLevel VALUES ( 'more than 10 years', '05' );

