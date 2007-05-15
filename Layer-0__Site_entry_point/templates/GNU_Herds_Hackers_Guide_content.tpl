{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

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

<h3>{t}GNU Herds Hackers' Guide{/t}</h3>

<p>{t}Index{/t}</p>
<ol>
<li> <a href="#Introduction" style='text-decoration: none;'>{t}Introduction{/t}</a>
<li> <a href="#Roadmap" style='text-decoration: none;'>{t}Roadmap{/t}</a>
<li> <a href="#Technologies" style='text-decoration: none;'>{t}Technologies{/t}</a>
<li> <a href="#Web_application_Architecture" style='text-decoration: none;'>{t}Web application Architecture{/t}</a>
<li> <a href="#Web_application_Design" style='text-decoration: none;'>{t}Web application Design{/t}</a>
<li> <a href="#Coding_Standards" style='text-decoration: none;'>{t}Coding Standards{/t}</a>
<li> <a href="#Internationalization_and_Localization" style='text-decoration: none;'>{t}Internationalization and Localization{/t}</a>
<li> <a href="#How_the_development_team_and_production_is_integrated" style='text-decoration: none;'>{t}How the development team and production is integrated?{/t}</a>
<li> <a href="#The_TODO_task_list" style='text-decoration: none;'>{t}The TODO task list{/t}</a>
<li> <a href="#Wikis" style='text-decoration: none;'>Wikis</a>
<li> <a href="#The_source_code" style='text-decoration: none;'>{t}The source code{/t}</a>
<li> <a href="#The_CVS_server" style='text-decoration: none;'>{t}The CVS server{/t}</a>
<li> <a href="#The_PostgreSQL_data_base" style='text-decoration: none;'>{t}The PostgreSQL data base{/t}</a>
<li> <a href="#Email_lists" style='text-decoration: none;'>{t}Email lists{/t}</a>
<li> <a href="#How_to_install_a_development_environment" style='text-decoration: none;'>{t}How to install a development environment?{/t}</a>
<!-- XXX <li> <a href="#How_to_kill_spam_by_hand_at_our_email_lists" style='text-decoration: none;'>{t}How to kill spam by hand at our email lists{/t}</a> -->
<li> <a href="#Current_work_team" style='text-decoration: none;'>{t}Current work team{/t}</a>
</ol>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>


<h4>1. {t}Introduction{/t} <a name="Introduction"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://lists.nongnu.org/mailman/listinfo/gnuherds-app-dev">'
	  2='</a>'
	}If you want to join the GNU Herds team, or collaborate sporadicly, as several guys already have done, please %1subscribe%2 to the 'gnuherds-app-dev' mailing list or coordinate with one of the team members. Thanks!.{/t}
	</p>

	<p>
	{t escape='no'
	  1='<a href="#The_source_code">'
	  2='</a>'
	}To play with the web application, %1download%2 the code and install it at your host. Translators do not need to download the source code. We will send them the gettext POT file to translate. Seek advice from this Hackers' Guide. If you need support ask for it at{/t} {mailto address='gnuherds-app-dev@nongnu.org'}
	</p>

	<p>
	{t escape='no'
	  1='<a href="charter">'
	  2='</a>'
	}Read the current draft of %1GNU Herds' Charter%2.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>2. {t}Roadmap{/t} <a name="Roadmap"></a> </h4>
	<ul>
	<li><p><span class="modification">{t}DONE!{/t}</span>: {t}Add the member support.{/t}</p></li>
	<li><p><span class="modification">{t}DONE!{/t}</span>: {t}Add the FS Job Offers support.{/t}</p></li>
	<li><p><span class="modification">{t}DONE!{/t}</span>: {t}Give a little progress report, with reference to this web site, to Richard Stallman so they review our activities and tell us what, if anything, needs to be changed.{/t}</p></li>
	<li><p> {t escape='no'
	  1='<a href="http://www.fsf.org/">'
	  2='</a>'
	}To keep the access to the user data physically secure, we have proposed to move the PostgreSQL and HTTP service of the gnuherds.org domain to offices managed by %1FSF%2 staff.{/t}
	</p></li>
	<li><p> <span class="modification">{t}ONGOING PROCESS{/t}</span>: {t}Association announcement.{/t}</p></li>
	<li><p><span class="modification">{t}ONGOING PROCESS{/t}</span>: {t}Translate the web site to other languages.{/t}</p></li>
	<li><p>{t}Work on e-Vote subjects:{/t}</p>
		<ul>
		<li> {t}Be ready to use at least a primitive e-Vote system, as for example, to count emails.{/t}</li>
		<li> {t}Work on others e-Vote proposals.{/t}</li>
		<li> {t}Finish and show the draft of the P2P based e-Vote system proposal.{/t}
			<!--
			Davi develops a draft and check it with Lorenzo and a friend who is interested in e-Voting (Gabriel).
			We ask for the opinion of the rest of this email list.
			We ask for the opinion of Jason Kitcat, though we know he is very busy.
			We check with the security experts community.
			-->
		</li>
		</ul>
	</li>
	</ul>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>3. {t}Technologies{/t} <a name="Technologies"></a> </h4>

	<p>
	{t}The project depends on the below technologies. Though it is and must be open to any proposal.{/t}
	</p>

	<table>
	<tr> <td><a href="http://www.w3.org/TR/html401/">HTML</a> 4.01 Strict <td>
	<tr> <td><a href="http://www.php.net/">PHP</a> >= 5.1 <td>
	<tr> <td><a href="http://smarty.php.net/">Smarty</a> <td>
	<tr> <td><a href="http://smarty.incutio.com/?page=SmartyGettext">Smarty-Gettext</a> <td>
	<tr> <td><a href="http://www.gnu.org/software/gettext/">gettext</a> <td>
	<tr> <td><a href="http://wp.netscape.com/eng/mozilla/3.0/handbook/javascript/">JavaScript 1.x</a> <td>
	<tr> <td><a href="http://www.w3.org/Style/CSS/">CSS x.y</a> <td>
	<tr> <td><a href="http://httpd.apache.org/">Apache x.y</a> <td>
	<tr> <td><a href="http://www.postgresql.org/">PostgreSQL</a> >= 7.4.x <td>
	<tr> <td><a href="http://www.maxmind.com/">GeoIP</a> <td>
	<tr> <td>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cgi-bin/viewcvs/gnuherds-app/gnuherds-app/">'
	  2='<a href="http://savannah.gnu.org/">'
	  3='</a>'
	}%1CVS%3 server at %2Savannah%3{/t}
	<td>
	<!-- XXX: <tr> <td><a href="http://www.openbsd.org/">OpenBSD 3.x</a> <td>The gnuherds.org host is a 633MHZ DEC Alpha 64-bit CPU running OpenBSD. -->
	</table>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>4. {t}Web application Architecture{/t}<a name="Web_application_Architecture"></a> </h4>

	<p>
	{t}As a Free Software project we look for a modular and extensible design. We hope it could be easy to change the technology of a specific layer if it is needed.{/t}
	</p><p>
	{t}This architecture proposal is based on PHP:{/t}
	</p>

	<table>
	<tr> <td><b>Layer 0.</b> <td>Site entry point (<a href="http://www.w3.org/TR/html401/">HTML</a>, <a href="http://www.w3.org/Style/CSS/">CSS</a>, <a href="http://smarty.php.net/">Smarty</a>, <a href="http://wp.netscape.com/eng/mozilla/3.0/handbook/javascript/">JavaScript</a>, <a href="http://httpd.apache.org/docs/2.0/howto/ssi.html">Apache SSI</a> and <a href="http://www.php.net/">PHP</a> ).
	<tr> <td><b>Layer 1.</b> <td>GUI page builder and themes (PHP)
	<tr> <td><b>Layer 2.</b> <td>GUI business logic: content section, others (checking & processing forms) (PHP, HTML)
	<tr> <td><b>Layer 4.</b> <td>Data base Manager class, PHP Tools class and Mailer class (PHP)
	<tr> <td><b>Layer 5.</b> <td>Data base Operation classes (PHP, SQL)
	<tr> <td><b>Layer 6.</b> <td><a href="http://adodb.sourceforge.net/">ADOdb</a> Database Abstraction Library (PHP)
	<tr> <td><b>..... ..</b> <td>NO stored procedures layer.
	<tr> <td><b>Layer 7.</b> <td><a href="http://www.postgresql.org/">PostgreSQL</a> data base server (PostgreSQL, SQL)
	<tr> <td><b>locale</b> <td>Here are the files which translate the webapp (<a href="http://www.gnu.org/software/gettext/">gettext</a>)
	</table>

	<p><img src="/doc/Layers_1_2_3_4_5_and_6.png" align="middle" alt="" border="0" hspace="0" vspace="0"> <span class="modification">({t}outdated{/t})</span> </p>  <!-- XXX Update this image -->

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>5. {t}Web application Design{/t}<a name="Web_application_Design"></a> </h4>

	<table border="0">
	<tbody>
	<tr><td><p><b>Layers 0, 1, 2, 4 and 5.</b> GUI, Forms, DBManager, PHPTools, and Mailer <span class="modification">({t}outdated{/t})</span> </p>
	<tr><td><p><a href="/doc/UML__Layers_1_2_3_and_4___GUI__Forms__DBManager__PHPTools__Mailer__Data_base_Operation_classes.png"><img src="/doc/UML__Layers_1_2_3_and_4___GUI__Forms__DBManager__PHPTools__Mailer__Data_base_Operation_classes.scaled.png" align="middle" alt="" border="0" hspace="0" vspace="0"></a> </p>  <!-- XXX Update this image -->
	<p>{t}The Smarty templates could be moved outside this layer.{/t}</p>
	<p>&nbsp;</p>

	<tbody>
	<tr><td><p><b>Layer 6.</b> ADOdb Database Abstraction Library (PHP)</p>
	<tr><td>
	<p>
	{t escape='no'
	  1='<a href="http://php.net/pdo">'
	  2='</a>'
	}ADOdb is an external library. It is not being used yet. We give up about using a data base abstraction library, and this proposal will use instead just %1PDO%2.{/t}
	</p>
	<p>&nbsp;</p>

	<tbody>
	<tr><td><p><b>Layer 7.</b> PostgreSQL data base server (PostgreSQL, SQL)</p>
	<tr><td><p>{t}Documentation of the new Data Base design:{/t}</p>
	<ul>
		<li><a href="/doc/GNUHerds__ER__Logical-model.png">{t}Entity Relation logical model{/t}</a><br>
		&nbsp; Diagram editor (Dia) image <a href="/doc/GNUHerds__ER__Logical-model.dia">source</a><br>
		<br>
		<a href="/doc/GNUHerds__ER__Logical-model.png"><img src="/doc/GNUHerds__ER__Logical-model.scaled.png" align="middle" alt="" border="0" hspace="0" vspace="0"></a>
		<li><a href="/doc/GNUHerds__Physical-model.png">{t}Physical model{/t}</a> <span class="modification">({t}outdated{/t})</span> <br>
		<li><a href="/doc/GNUHerds__SQL_Implementation.psql">{t}SQL Implementation{/t}</a>
	</ul>
	</table>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>6. {t}Coding Standards{/t} <a name="Coding_Standards"></a> </h4>

	<p>
	<STRIKE>
	{t escape='no'
	  1='<a href="http://docs.clawphp.org/standards/index">'
	  2='</a>'
	}We will try to follow these %1Coding Standards%2.{/t}
	</STRIKE>
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>7. {t}Internationalization and Localization{/t} <a name="Internationalization_and_Localization"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="https://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=152">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>8. {t}How the development team and production is integrated?{/t} <a name="How_the_development_team_and_production_is_integrated"></a> </h4>

	<p>{t}CVS is used as repository. The HTTP server gets a tagged release via 'update' from the CVS server.{/t}</p>

	<img src="/doc/How_the_development_team_and_production_is_integrated.png" align="middle" alt="" border="0" hspace="0" vspace="0">

	<p>
	{t escape='no'
	  1='"<i>cvs diff -c3p</i>"'
	  2='"<i>diff -up OLD NEW</i>"'
	}The suggested formats to share source code among the developers are %1 or %2.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>9. {t}The TODO task list{/t} <a name="The_TODO_task_list"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/task/?group=gnuherds-app">'
	  2='</a>'
	}See the %1Task Manager%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>10. Wikis <a name="Wikis"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="https://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=146">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>11. {t}The source code{/t} <a name="The_source_code"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://download.savannah.gnu.org/releases/gnuherds-app/">'
	  2='</a>'
	}If you do not like play with CVS, you can get a, maybe outdated package, of the website, at our  Savannah %1Filelist (Download area)%2.{/t}
	{t escape='no'
	  1='<a href="gnuherds-online.tar.gz">'
	  2='</a>'
	}Or much better, you can %1download%2 the code which is running this site right now!.{/t}

	</p><p>
	{t escape='no'
	  1='<a href="#Technologies">'
	  2='</a>'
	}You could set up all the required %1Technologies%2 on your host, to be used as your development environment.{/t}
	</p><p>
	{t}The source code can have 'XXX' flags, which are used to mark pending tasks, etc.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>12. {t}The CVS server{/t} <a name="The_CVS_server"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="https://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=153">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>13. {t}The PostgreSQL data base{/t} <a name="The_PostgreSQL_data_base"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="https://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=154">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>14. {t}Email lists{/t} <a name="Email_lists"></a> </h4>

<ul>
	<li><a href="https://lists.gnuherds.org/mailman/listinfo/association">association</a> {t}is the project main list.{/t}</li>
	<li><a href="http://lists.nongnu.org/mailman/listinfo/gnuherds-app-dev">gnuherds-app-dev</a> {t}to carry on the web application development.{/t}</li>
</ul>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>15. {t}How to install a development environment?{/t} <a name="How_to_install_a_development_environment"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="https://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=155">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>16. {t}Current work team{/t} <a name="Current_work_team"></a> </h4>

	<p>
	{t}The list could be outdated:{/t}<br>
	<br>
	</p>
	<table>
	<tr> <td><b>Antenore</b> <td>Localization architecture Adviser, Auditor, Italian Translator, etc.
	<tr> <td><b>Bill</b>     <td>System administrator, architecture Adviser, etc.
	<tr> <td><b>Charles</b>  <td>Auditor, Quality Assurance, etc.
	<tr> <td><b>Davi</b>     <td>Web developer, CVS, Spanish Translator, etc.
	<tr> <td><b>David</b>    <td>Web developer, Italian Translator.
	<tr> <td><b>Duarte</b>   <td>Portuguese Translator.
	<tr> <td><b>Fatima</b>   <td>Functional Auditor.
	<tr> <td><b>Gabriel</b>  <td>Data base Adviser.
	<tr> <td><b>Jonas</b>    <td>GNU Business Network.
	<tr> <td><b>Jose</b>     <td>Architecture Adviser.
	<tr> <td><b>Klaus</b>    <td>Web developer, Code Auditor.
	<tr> <td><b>Lars</b>     <td>Romanian Translator and maybe some coding.
	<tr> <td><b>Martin</b>   <td>Auditor and Quality Assurance; he evaluates the project as a whole. Public Relations.
	<tr> <td><b>Neal</b>     <td>Initial proposal, project Chapter, Public Relations, etc.
	<tr> <td><b>RMS</b>      <td>Ethics Officer; he evaluates the project as a whole.
	<tr> <td><b>Victor</b>   <td>Web developer.
	</table>

<center><a href="#" style='text-decoration: none;'>{t}Back to top{/t}</a></center>

<p>&nbsp;</p>

<p class="footnote">{t}For more information:{/t} {mailto address='gnuherds-app-dev@nongnu.org'} </p>

