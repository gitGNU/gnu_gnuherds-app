{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>

This program is free software; you can redistribute it and/or modify it under
the terms of the Affero General Public License as published by Affero Inc.,
either version 1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful to the Free
Software community, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
General Public License for more details.

You should have received a copy of the Affero General Public License with this
software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
Suite 225, San Francisco, CA 94107, USA
*}

<h3>{t}Special Interest Group{/t}: {t}e-Voting{/t}</h3>

<p>{t}Initially, GNU Herds' members can vote showing their hands, sending an email.{/t}</p>


<p>&nbsp;</p>

<p>
{t}The GNU Herds' official voting mechanism is not intented to:{/t}
	<ul>
		<li>
			{t}be used as a country voting system.{/t}
		</li>
		<li>
			{t}be used as the FS community voting system. The FS community does not need a voting system. As Barry Fitzgerald exposes:{/t} <i>"Free Software embodies democracy in an anarchistic, classical democracy kind of way. The freedom of the community is itself the force of democracy"</i>.
		</li>
	</ul>
</p>

<p>
{t}The GNU Herds' official voting mechanism is only intented to:{/t}
	<ul>
		<li>
			{t}be used as voting system to this Association. The voting mechanism must be used as a tool to keep GNU Herds moving in the right direction, helping members guide the board members. It can also be used to get opinions about ideas, etc.: binding vote, opinion vote.{/t}
		</li>
	</ul>
</p>

<p>{t}See references to documentation at bottom of this page.{/t}</p>

<p>&nbsp;</p>


<h4>{t}Options{/t}</h4>

<p>
{t}There are several projects which try to solve the e-Voting trouble. The goal of each project can be different. Some of them has modified its aims or are stalled:{/t}
	<ul>
		<li><a href="http://www.gnu.org/software/free/" target="_top">GNU.FREE</a>: {t}The development has been discontinued due to{/t} <i>"creating an Internet Voting system sufficiently secure, reliable and anonymous is extremely difficult, if not impossible"</i>.
		</li>
		<li><a href="http://glasnost.entrouvert.org" target="_top">Glasnot</a>. {t escape='no'
		  1='<i>'
		  2='</i>'
		}It seems to support the %1Condorcet method%2 and even "a mix of secret and public ballots".{/t}
		</li>
		<li>{t}Some free GNU/Linux distributions use it own voting system.{/t}</li>
		<li><a href="http://www.nongnu.org/ampu/" target="_top">AMPU</a>. {t}Stalled since March 2002.{/t}</li>
	</ul>
</p>
<p>
{t escape='no'
  1='<i><a href="http://lwn.net/Articles/44077/" target="_top">'
  2='</a></i>'
  3='<a href="http://lwn.net/" target="_top">'
  4='</a>'
}We have added the below links from the %1"Bringing free software to voting booths"%2 %3LWN%4 article:{/t}
	<ul>
		<li><a href="http://votesystem.sourceforge.net/" target="_top">Voting Systems Toolbox</a>. {t}It is dormant.{/t}</li>
		<li><a href="http://electionmethods.org/GVI.htm" target="_top">GVI</a>. {t}It is interested in exploring alternative voting methods.{/t}</li>
		<li><a href="http://lwn.net/Articles/43600/" target="_top">EVM</a>. {t}It is too young to have released any useful code.{/t}</li>
		<li><a href="http://www.softimp.com.au/evacs/index.html" target="_top">eVACS</a>. {t}It has already been used in at least one election for the Legislative Assembly in the Australian Capitol Territory in October 2001 and is approved for use in future elections.{/t}</li>
		<li><a href="http://jfreevote.hispalinux.es/" target="_top">JFreeVote</a>. {t}It is a already implemented, working solution for electronic voting.{/t}</li>
	</ul>
</p>

<!--
<p>
Additionally, we have evaluated or we are evaluating some proposals to be
used as the GNU Herds e-Voting system. We know some of the below designs
are poor. Others have been rejected. If you have any comment ...
{mailto address='association@gnuherds.org'} :
</p>

<ol>

	<li>[Central server] &nbsp; <a href="http://www.gnu.org/software/free/" target="_top">GNU.FREE</a> &nbsp; <b>(State:&nbsp;REJECTED&nbsp;?&nbsp;)</b>
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
-->

<p>&nbsp;</p>


<h4>{t}References to documentation{/t}</h4>

<ul>

<li>
	<a href="http://www.thebell.net/papers/vote-req.pdf" target="_top">Voting System Requirements</a>.
	{t}A 16 page nontechnical paper, on 16 requirements that a voting system "must" meet. Read it to know a bit more about efforts underway at coming up with secure voting (and what may constitute a definition of secure voting). Consider in particular the requirement that anonimity be maintained.{/t}
</li>

<li>
	<a href="http://www.gnu.org/software/free/" target="_top">GNU.FREE links</a>. {t}We want remark:{/t}<br>
	<!-- &nbsp; &nbsp; <a href="http://www.votehere.net/products.htm" target="_top">E-voting Solutions</a> The list of requirements of the above reference can be useful to check any design. Anyway, we think the "<i>Revisability: A voter can change their vote in a given period of time</i>" feature is not necessary and even no convenient. What do you think?. <br> -->
	&nbsp; &nbsp; <a href="http://lorrie.cranor.org/" target="_top">Lorrie Faith Cranor</a> <br>
	&nbsp; &nbsp; <a href="http://www.vote.caltech.edu/" target="_top">Caltech</a> <br>
	&nbsp; &nbsp; <a href="http://www.notablesoftware.com/evote.html" target="_top">Electronic Voting</a> <br>
	{t}Note that all those systems are country voting oriented.{/t}<br>
</li>

<li><a href="http://grouper.ieee.org/groups/scc38/1583/" target="_top">IEEE, Voting Equipment Standards</a></li>

</ul>
