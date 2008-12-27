{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007, 2008 Davi Leal <davi at leals dot com>
              2007, 2008 Victor Engmark <victor dot engmark at gmail dot com>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.
*}

<h3><a name="top"></a>{t}Frequently asked questions (FAQ){/t}</h3>

<p>{t}Index{/t}</p>
<ol>
<li><a href="#JobSite" style='text-decoration: none;'>{t}Why another Job Site?{/t}</a>
<br><br>
<li><a href="#Payments" style='text-decoration: none;'>{t}Payments negotiation{/t}</a>
<br><br>
<li><a href="#How_to_subscribe" style='text-decoration: none;'>{t}How to subscribe to a job offer?{/t}</a>
<li><a href="#Who_can_subscribe" style='text-decoration: none;'>{t}Who can subscribe to a job offer?{/t}</a>
<li><a href="#Who_can_post" style='text-decoration: none;'>{t}Who can post a job offer?{/t}</a>
<li><a href="#FS_criteria" style='text-decoration: none;'>{t}Which criteria are applied to classify a program, language, protocol, specification, software distribution, etc. as Free or Non-Free Software?{/t}</a>
<br><br>
<li><a href="#JobSite_module_related_to_the_GNU_Herds_association" style='text-decoration: none;'>{t}How is the Job Site module related to the GNU Herds' association?{/t}</a>
<br><br>
<li><a href="#membership" style='text-decoration: none;'>{t}Who can join or register?{/t}</a>
<li><a href="#person_vs_company" style='text-decoration: none;'>{t}Can I not be a member of the association because I am a member of a company?{/t}</a>
<li><a href="#company_votes" style='text-decoration: none;'>{t}How many votes is a company able to obtain?{/t}</a>
<li><a href="#company_voices" style='text-decoration: none;'>{t}A 100-worker company can get 100 voices, while my 3-worker company can have only 3 voices?{/t}</a>
<li><a href="#yearly_basis" style='text-decoration: none;'>{t}Why voting membership is on a yearly basis?{/t}</a>
<li><a href="#e-Voting" style='text-decoration: none;'>{t}e-Voting{/t}</a>
</ol>

<p>&nbsp;</p>

<p>&nbsp;</p>


<h4>1. <a name="JobSite"></a>{t}Why another Job Site?{/t}</h4>

	<p>
	{t}Because no one comply the below proposed conditions:{/t}
	</p>

	<ul>
		<li> {t}Service is free of any cost to its users{/t}. {t}The GNU Herds project does not charge for any of its services.{/t}

		<li> {t escape='no'
		  1='<a href="http://www.fsf.org/licensing/licenses/agpl-3.0.html">'
		  2='</a>'
		}Use a license to cover use of the software over a computer network. We are using the %1GNU AGPLv3%2 license. Anyhow, the project is always open to discuss this and any other subject.{/t}

		<li> {t escape='no'
		  1='<a href="/doc/GNUHerds__ER__Logical-model.png">'
		  2='</a>'
		  3='<a href="charter#Committee">'
		  4='<a href="http://www.gnu.org/philosophy/free-sw.html">'
		}Moreover, the management of the jobsite must be %1controlled by its own users%2 using the democratic policy. That will be guaranteed by the GNU Herds association policy. So, being sure the evolution of the jobsite will be controlled and led by its users.{/t}

		<li> {t}Supplying support to engage among companies and persons, it doesn't matter the which or the order, helping the raise of a diversity of business models.  That is flexibility.{/t}

		<li> {t}Make it easy the contacts among persons and companies interested in Free Software business.{/t}

		<li> {t}Having a global scope, supporting business models based on long-distance jobs. With future technologies the localisation must not be an obstacle to establish relationships about IT services. So, the goal, already got, to translate the webapp to other languages, and to support the fact that a job offer could be inserted in several languages.{/t}
	</ul>

	<p>
	{t escape='no'
	  1='<a href="charter#Aims">'
	  2='</a>'
	  3='<i>'
	  4='</i>'
	}All this taking into account that: "%3The %1aims%2 of the Association shall be to assist and encourage people in their paid work as Free Software authors, getting the highest levels of competence and efficiency.%4"{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>2. <a name="Payments"></a>{t}Payments negotiation{/t}</h4>

	<p>
	{t}Companies and customers sign agreements.{/t}
	</p>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&item_id=199">'
	  2='</a>'
	}Donators and workers can %1negotiate%2 (30%, 25%, 20%, 25%) or sign the functional requirement specifications and payments agreement.{/t}
	</p>

	{* XXX: DELETE ME
	<p>
	{t}Disclaimer{/t}: {t}Right now GNU Herds do not guarantee workers will get the money or donators will get tasks done.{/t}
	</p>
	*}

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>3. <a name="How_to_subscribe"></a>{t}How to subscribe to a job offer?{/t}</h4>

	<ul>
		<li> {t escape='no'
		  1='<a href="person">'
		  2='<a href="company">'
		  3='<a href="nonprofit">'
		  4='</a>'
		}Register as new %1Person%4, %2Company%4 or %3non-profit Organization%4.{/t}

		<li> {t escape='no'
		  1='<a href="resume?action=edit&amp;id='
		  2=$smarty.session.EntityId
		  3='&amp;section=profiles_etc">'
		  4='</a>'
		}Fill the %1%2%3Qualifications%4 form.{/t}
		{t}It is recommended provide the more information possible.{/t}

		<li> {t}Log in.{/t}

		<li> {t}Subscribe to the offer.{/t}
	</ul>

	<p>
	{t}Note that some offers could allow to subscribe only to some entity types: Persons, Companies or non-profit Organizations.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>4. <a name="Who_can_subscribe"></a>{t}Who can subscribe to a job offer?{/t}</h4>

	<p>{t}Persons, Companies or non-profit Organizations that have met the conditions imposed by the Qualifications form. That is to say, who has been able to fill it rightly.{/t}</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>5. <a name="Who_can_post"></a>{t}Who can post a job offer?{/t}</h4>

	<p>{t}Any Person, Company or non-profit Organization meeting the conditions imposed by the JobOffer form and whose offer fits one of the following requirements:{/t}</p>

	<ul>
		<li>{t escape='no'
			1='<a href="http://www.gnu.org/philosophy/free-sw.html">'
			2='</a>'
		    }Development or maintenance of software for distribution to the public, if all the software to be developed or maintained is %1Free Software%2.{/t} </li>

		<li>{t escape='no'
			1='<a href="http://www.gnu.org/philosophy/free-sw.html">'
			2='</a>'
		    }Writing or maintenance of documentation for software, if all the software to be documented is %1Free Software%2, and all the documentation to be written or maintained is free in the same sense.{/t} </li>

		<li>{t escape='no'
			1='<a href="http://www.gnu.org/philosophy/free-sw.html">'
			2='</a>'
		    }Development or maintenance of software for private use by specific clients, if the clients will have the source code and rights to modify and distribute it, and if the software to be used for the development is all %1Free Software%2.{/t} </li>

		<li>{t escape='no'
			1='<a href="http://www.gnu.org/philosophy/free-sw.html">'
			2='</a>'
		    }Providing support of software, if all the software to be supported is %1Free Software%2.{/t} </li>

		<li>{t escape='no'
			1='<a href="http://www.gnu.org/philosophy/free-sw.html">'
			2='</a>'
		    }Promotion or marketing of software, if all the software to be promoted and/or marketed is %1Free Software%2.{/t} </li>

		<li>{t escape='no'
			1='<a href="http://www.gnu.org/philosophy/free-sw.html">'
			2='</a>'
		    }Installation of software, if all the software to be installed is %1Free Software%2.{/t} </li>
	</ul>

	<p>{t escape='no'
		1='<a href="mailto:association@gnuherds.org" >association@gnuherds.org</a>'
	   }Report to %1 about any offer that seems improper.{/t}</p>

	<p>{t}It is recommended provide the more information possible.{/t}</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>6. <a name="FS_criteria"></a>{t}Which criteria are applied to classify a program, language, protocol, specification, software distribution, etc. as Free or Non-Free Software?{/t}</h4>

	<ul>

	<li>
	{t escape='no'
	  1='<a href="http://www.gnu.org/philosophy/free-sw.html">'
	  2='</a>'
	}For a program, read the %1Free Software%2 definition to know the criteria.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-09/msg00052.html">'
	  2='<a href="http://www.gnu.org/licenses/license-list.html">'
	  3='</a>'
	}For development languages, protocols, specifications, etc. the meaningful question is whether it is %1supported%3 by software licensed under any of the %2Free Software Licenses%3: BSD, GPL, etc.  Can you use it with Free Software exclusively?{/t}
	</li>

	<li>
	{t}For software distributions, they must not recommend, promote or grant legitimacy to Non-Free Software.{/t}
	</li>

	</ul>

	<p>&nbsp;</p>

 	<p>{t}Currently, the tags applyed to classify skills are:{/t}</p>
	<ul>
	<li><i>{t}Free Software{/t}</i></li>
	<li><i>{t}Almost-Free Software{/t}</i>, {t}only for software distributions{/t}.</li>
	<li><i>{t}Partially-Free Software{/t}</i>, {t}only for software distributions{/t}.</li>
	<li><i>{t}Non-Free Software{/t}</i></li>
	</ul>

	<p>&nbsp;</p>

 	<p>{t}For example, applying such criteria to Java:{/t}</p>

	<ul>
 	<li>
	{t escape='no'
	  1='<strong>'
	  2='</strong>'
	  3='<i>'
	  4='</i>'
	}The %1Java%2 technology-skill is tagged as %3Free Software%4 due to there are free software Java compilers.{/t}
	</li>
	</ul>

	<p>
	{t escape='no'
	  1='<i>'
	  2='</i>'
	  3='<a href="http://icedtea.classpath.org/wiki/Main_Page">'
	  4='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-09/msg00060.html">'
	  5='</a>'
	}However the below Sun Java technologies are tagged as %1Non-Free Software%2 because of the license you have to agree to download them is not a Free Software license. Anyhow, most of the Java Sun technologies are GPL'd. Sun has made substantial progress towards freeing the JDK under the GPL. The %3IcedTea%5 project is filling in the %4gaps%5.{/t}
	</p>

	<ul>
	<li>Java 2 Platform, Standard Edition (<strong>J2SE</strong>)</li>
	<li>Java 2 Platform, Enterprise Edition (<strong>J2EE</strong>)</li>
	<li>Java 2 Platform, Micro Edition (<strong>J2ME</strong>)</li>
	<li>Java Platform, Standard Edition (<strong>Java SE</strong>)</li>
	<li>Java Platform, Enterprise Edition (<strong>Java EE</strong>)</li>
	<li>Java Platform, Micro Edition (<strong>Java ME</strong>)</li>
	</ul>

	<p>&nbsp;</p>

 	<p>{t}Applying it to .NET:{/t}</p>

	<ul>
	<li>
	{t escape='no'
	  1='<strong>'
	  2='</strong>'
	  3='<i>'
	  4='</i>'
	}%1Microsoft .NET%2 is tagged as %3Non-Free Software%4.{/t}
	</li>
	<li>
	{t escape='no'
	  1='<strong>'
	  2='</strong>'
	  3='<i>'
	  4='</i>'
	}%1Mono .NET%2 is a set of tools under GPL, LGPL and MIT, or dual licenses. It is tagged as %3Free Software%4.{/t}
	</li>
	<li>
	{t escape='no'
	  1='<strong>'
	  2='</strong>'
	  3='<i>'
	  4='</i>'
	}%1.NET%2 is tagged as %3Non-Free Software%4 because of the Mono tools are not 100% complete. Mono does not cover all .NET{/t}
	</li>
	<li>
	{t escape='no'
	  1='<strong>'
	  2='</strong>'
	  3='<i>'
	  4='</i>'
	}%1C#%2 is tagged as %3Free Software%4 due to there are free software C# compilers.{/t}
	</li>
	</ul>

	<p>&nbsp;</p>

 	<p>{t}Applying it to some software distributions:{/t}</p>

	<ul>

	<li>
	{t escape='no'
	  1='<strong>Debian GNU/Linux</strong>'
	  2='<acronym title="Binary Large OBject">BLOB</acronym>s'
	  3='<i>'
	  4='</i>'
	}%1 is %3Almost-Free Software%4 because it contains Non-Free Software %2 in its kernel.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>Debian GNU/Hurd</strong>'
	  2='<i>'
	  3='</i>'
	}%1 is %2Free Software%3 because it does not ship anything that is Non-Free Software.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>Debian GNU/NetBSD</strong>'
	}%1 is not classified yet.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>Debian GNU/kFreeBSD</strong>'
	}%1 is not classified yet.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>Debian</strong>'
	  2='<i>'
	  3='</i>'
	  4='<a href="http://www.debian.org/ports/">'
	  5='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-10/msg00048.html">'
	  6='</a>'
	}%1 is %2Almost-Free Software%3. Debian is a general term which refer to Debian GNU/Linux and all Debian %4ports%6. The Debian project %5offers%6 the download of some Non-Free Software packages from its archives and website.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>Ubuntu</strong>'
	  2='<i>'
	  3='</i>'
	  4='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-11/msg00071.html">'
	  5='</a>'
	}%1 is %2Partially-Free Software%3 %4because%5 it is made of many programs; some are free and some are not.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>gNewSense</strong>'
	  2='<acronym title="Binary Large OBject">BLOB</acronym>'
	  3='<i>'
	  4='</i>'
	  5='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-10/msg00049.html">'
	  6='</a>'
	}%1 is %3Free Software%4 because it does not ship anything that is Non-Free Software neither work to provide easy access to Non-Free Software. A Non-Free Software %2 not removed from gNewSense is a bug. The gNewSense's %5policy%6 is to delete any non-free software found in the Linux kernel or elsewhere in the GNU/Linux system.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>OpenBSD</strong>'
	  2='<i>'
	  3='</i>'
	  4='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-10/msg00033.html">'
	  5='</a>'
	}%1 is %2Almost-Free Software%3 because although it does not ship anything that is Non-Free Software it provides for easy installation of Non-Free Software through the %4ports system%5. Not many packages though: Java and a few others.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>FreeBSD</strong>'
	  2='<strong>NetBSD</strong>'
	  3='<acronym title="Binary Large OBject">BLOB</acronym>s'
	  4='<i>'
	  5='</i>'
	  6='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-10/msg00033.html">'
	  7='</a>'
	}%1 and %2 are %4Almost-Free Software%5 because provide for easy installation of some Non-Free Software products through the %6ports system%7. Besides both contain Non-Free Software %3 in its kernel too.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>'
	  2='</strong>'
	  3='<i>'
	  4='</i>'
	}%1Mac OS X%2 is tagged as %3Non-Free Software%4.{/t}
	</li>

	<li>
	{t escape='no'
	  1='<strong>'
	  2='</strong>'
	  3='<i>'
	  4='</i>'
	}%1Microsoft Windows Vista%2 is tagged as %3Non-Free Software%4.{/t}
	</li>

	</ul>

	<p>
	{t escape='no'
	  1='<acronym title="Binary Large OBject">BLOB</acronym>s'
	}Note that not all %1 are Non-Free Software, because %1 can be data (not compiled source code) licensed under a Free Software license. However, we need to verify that it really is data, because the non-free object code is typically dressed up as data.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>7. <a name="JobSite_module_related_to_the_GNU_Herds_association"></a>{t}How is the Job Site module related to the GNU Herds' association?{/t}</h4>

	<p>
	{t escape='no'
	  1='<a href="#JobSite">'
	  2='</a>'
	}The Job Site module is %1controlled%2 by the association. Any new module will be controlled by the association too.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>8. <a name="membership"></a>{t}Who can join or register?{/t}</h4>

	<p>
	{t escape='no'
	  1='<a href="charter#Membership">'
	  2='</a>'
	}Any entity type can join the association or just register into the web application and use its services. Showing a Free Software contribution is not a requirement to register or join. It is just a requirement to be able to %1vote%2 at the association.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>9. <a name="person_vs_company"></a>{t}Can I not be a member of the association because I am a member of a company?{/t}</h4>

	<p>
	{t}You can. You can be in any case an "associate member" or a "voting member".{/t}
	</p>

	<p>
	{t escape='no'
	  1='<a href="charter#Membership">'
	  2='</a>'
	}The association's %1Charter%2 reads:{/t} "<i>{t}There shall be two kinds of members, voting members, to be known simply as a member, and non-voting members, to be known as an associate member.{/t}</i>"
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>10. <a name="company_votes"></a>{t}How many votes is a company able to obtain?{/t}</h4>

	<p>
	{t escape='no'
	  1='</p><ul>'
	  2='<li>'
	  3='</li>'
	  4='</ul>'
	}A company could be able to get:%1 %2only one vote as 'company' and%3 %2any number of votes as 'people' (their workers), all having individually contributed to free software.%3%4{/t}

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>11. <a name="company_voices"></a>{t}A 100-worker company can get 100 voices, while my 3-worker company can have only 3 voices?{/t}</h4>

	<p>
	{t}The company gets 100 voting-voices only if each one of its workers has individually contributed to the free software community, and each one of its workers take the personal decision to join and vote at the association.{/t}
	</p>

	<p>
	{t escape='no'
	  1='<a href="charter#Membership">'
	  2='</a>'
	}The association's %1Charter%2 reads:{/t} "<i>{t}To qualify for voting membership one must show a contribution to the Free Software movement.{/t}</i>"
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>12. <a name="yearly_basis"></a>{t}Why voting membership is on a yearly basis?{/t}</h4>

	<p>
	{t escape='no'
	  1='<a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2007-09/msg00051.html">'
	  2='</a>'
	}Not doing it so could make it impossible to dissolve the association %1due to%2 making all turnout figures low.{/t}
	{t}The membership renew process is automated to reduce bureaucracy.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>13. <a name="e-Voting"></a>{t}e-Voting{/t}</h4>

	<p>{t}Initially, GNU Herds' members can vote showing their hands, sending an email.{/t}</p>


	<p>&nbsp;</p>

	<p>
	{t}The GNU Herds' official voting mechanism is not intented to:{/t}
	</p>
		<ul>
			<li>
				{t}be used as a country voting system.{/t}
			</li>
			<li>
				{t}be used as the FS community voting system. The FS community does not need a voting system. As Barry Fitzgerald exposes:{/t} <i>"Free Software embodies democracy in an anarchistic, classical democracy kind of way. The freedom of the community is itself the force of democracy"</i>.
			</li>
		</ul>

	<p>
	{t}The GNU Herds' official voting mechanism is only intented to:{/t}
	</p>
		<ul>
			<li>
				{t}be used as voting system to this Association. The voting mechanism must be used as a tool to keep GNU Herds moving in the right direction, helping members guide the board members. It can also be used to get opinions about ideas, etc.: binding vote, opinion vote.{/t}
			</li>
		</ul>

	<p>{t}See references to documentation.{/t}</p>

	<p>&nbsp;</p>


	<p>{t}Options{/t}:</p>

	<p>
	{t}There are several projects which try to solve the e-Voting trouble. The goal of each project can be different. Some of them has modified its aims or are stalled:{/t}
	</p>
		<ul>
			<li><a href="http://www.gnu.org/software/free/">GNU.FREE</a>: {t}The development has been discontinued due to{/t} <i>"creating an Internet Voting system sufficiently secure, reliable and anonymous is extremely difficult, if not impossible"</i>.
			</li>
			<li><a href="http://glasnost.entrouvert.org">Glasnot</a>. {t escape='no'
			  1='<i>'
			  2='</i>'
			}It seems to support the %1Condorcet method%2 and even "a mix of secret and public ballots".{/t}
			</li>
			<li><a href="http://lists.gnu.org/archive/html/gnuherds-app-dev/2006-12/msg00055.html">demexp</a>
			</li>
			<li>{t}Some free GNU/Linux distributions use it own voting system.{/t}</li>
			<li><a href="http://www.nongnu.org/ampu/">AMPU</a>. {t}Stalled since March 2002.{/t}</li>

			<li><a href="http://votesystem.sourceforge.net/">Voting Systems Toolbox</a>. {t}It is dormant.{/t}</li>
			<li><a href="http://electionmethods.org/GVI.htm">GVI</a>. {t}It is interested in exploring alternative voting methods.{/t}</li>
			<li><a href="http://lwn.net/Articles/43600/">EVM</a>. {t}It is too young to have released any useful code.{/t}</li>
			<li><a href="http://www.softimp.com.au/evacs/index.html">eVACS</a>. {t}It has already been used in at least one election for the Legislative Assembly in the Australian Capitol Territory in October 2001 and is approved for use in future elections.{/t}</li>
			<li><a href="http://jfreevote.hispalinux.es/">JFreeVote</a>. {t}It is a already implemented, working solution for electronic voting.{/t}</li>
		</ul>

	{*
	<p>
	Additionally, we have evaluated or we are evaluating some proposals to be
	used as the GNU Herds e-Voting system. We know some of the below designs
	are poor. Others have been rejected. If you have any comment ...
	{mailto address='association@gnuherds.org'} :
	</p>

	<ol>

		<li>[Central server] &nbsp; <a href="http://www.gnu.org/software/free/">GNU.FREE</a> &nbsp; <b>(State:&nbsp;REJECTED&nbsp;?&nbsp;)</b>
			<p><i>Disadventage</i>: Central server. Jose's opinion:
			"The GNU.FREE voting system is not the solution to all
			voting problems any more than any system could be. In
			particular, there is a central point where the
			potential for abuse is great. This is fine (great)
			when this central point can be watched, controlled,
			audited, etc. properly; that is, when the voters have
			near complete trust that the system in not being
			abused or hijacked at this central point. ...".
			</p>
		</li>
		<li>
			[P2P] &nbsp; Using the 'Peer to Peer network' paradigm instead of the 'Central server' &nbsp; <b>(State:&nbsp;REJECTED&nbsp;)</b>
			<p><i>Goal</i>: Solve the 'central server' disadvantege.</p>
			<p><i>Detailed design</i>: none</p>
			<p><i>Pre-design</i>:
			Using the 'Peer to Peer network' paradigm instead of the 'Central server',
			each member could have a duplication of the voting system.
			All systems in the P2P network get the same member DB, votes, etc. So you can
			not manipulate a system without being noted by the others duplicated 'servers'
			on the network. The voting result have to be the same on all the peers.
			</p>
			<p>
			Any member can connect to the voting system and audit the voting process using
			her system 'copy'.  He can audit the new information (members, votes, ...) which his host is getting from the network.
			</p>
		</li>

		<li>[P2P] &nbsp; Using the 'Peer to Peer network' paradigm instead of the 'Central server' &nbsp; <b>(State:&nbsp;LOOKing&nbsp;FOR&nbsp;comment&nbsp;)</b>
			<p><i>Goal</i>: Solve the 'central server' disadvantege.</p>
			<p><i>Detailed design</i>: NOT READY YET</p>
			<p><i>Comments</i>: none yet</p>
		</li>

	</ol>


	<p>&nbsp;</p>
	*}

	<p>&nbsp;</p>


	<p>{t}References to documentation{/t}:</p>

	<ul>

	<li>
		<a href="http://www.thebell.net/papers/vote-req.pdf">Voting System Requirements</a>.
		{t}A 16 page nontechnical paper, on 16 requirements that a voting system "must" meet. Read it to know a bit more about efforts underway at coming up with secure voting (and what may constitute a definition of secure voting). Consider in particular the requirement that anonimity be maintained.{/t}
	</li>

	<li>
		{t}We want remark:{/t}<br>
		{* &nbsp; &nbsp; <a href="http://www.votehere.net/products.htm">E-voting Solutions</a> The list of requirements of the above reference can be useful to check any design. Anyway, we think the "<i>Revisability: A voter can change their vote in a given period of time</i>" feature is not necessary and even no convenient. What do you think? <br> *}
		&nbsp; &nbsp; <a href="http://lorrie.cranor.org/">Lorrie Faith Cranor</a> <br>
		&nbsp; &nbsp; <a href="http://www.vote.caltech.edu/">Caltech</a> <br>
		&nbsp; &nbsp; <a href="http://www.notablesoftware.com/evote.html">Electronic Voting</a> <br>
		{t}Note that all those systems are country voting oriented.{/t}<br>
	</li>

	</ul>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>
