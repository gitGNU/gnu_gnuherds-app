{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>

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
<li> <a href="#Introduction" style='text-decoration: none;' target="_top">{t}Introduction{/t}</a>
<li> <a href="#Technologies" style='text-decoration: none;' target="_top">{t}Technologies{/t}</a>
<li> <a href="#Web_application_Architecture" style='text-decoration: none;' target="_top">{t}Web application Architecture{/t}</a>
<li> <a href="#Web_application_Design" style='text-decoration: none;' target="_top">{t}Web application Design{/t}</a>
<li> <a href="#Coding_Standards" style='text-decoration: none;' target="_top">{t}Coding Standards{/t}</a>
<li> <a href="#Internationalization_and_Localization" style='text-decoration: none;' target="_top">{t}Internationalization and Localization{/t}</a>
<li> <a href="#How_the_development_team_and_production_is_integrated" style='text-decoration: none;' target="_top">{t}How the development team and production is integrated?{/t}</a>
<li> <a href="#The_TODO_task_list" style='text-decoration: none;' target="_top">{t}The TODO task list{/t}</a>
<li> <a href="#Wikis" style='text-decoration: none;' target="_top">Wikis</a>
<li> <a href="#The_source_code" style='text-decoration: none;' target="_top">{t}The source code{/t}</a>
<li> <a href="#The_CVS_server" style='text-decoration: none;' target="_top">{t}The CVS server{/t}</a>
<li> <a href="#The_web_site" style='text-decoration: none;' target="_top">{t}The web site{/t}</a>
<li> <a href="#The_PostgreSQL_data_base" style='text-decoration: none;' target="_top">{t}The PostgreSQL data base{/t}</a>
<li> <a href="#Email_lists" style='text-decoration: none;' target="_top">{t}Email lists{/t}</a>
<li> <a href="#How_to_install_a_development_environment" style='text-decoration: none;' target="_top">{t}How to install a development environment?{/t}</a>
<!-- XXX <li> <a href="#How_to_kill_spam_by_hand_at_our_email_lists" style='text-decoration: none;' target="_top">{t}How to kill spam by hand at our email lists{/t}</a> -->
<li> <a href="#Current_work_team" style='text-decoration: none;' target="_top">{t}Current work team{/t}</a>
</ol>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>


<h4>1. {t}Introduction{/t} <a name="Introduction"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://lists.nongnu.org/mailman/listinfo/gnuherds-app-dev" target="_top">'
	  2='</a>'
	}If you want to join the GNU Herds team, or collaborate sporadicly, as several guys already have done, please %1subscribe%2 to the 'gnuherds-app-dev' mailing list or coordinate with one of the team members. Thanks!.{/t}
	</p>

	<p>
	{t escape='no'
	  1='<a href="#The_source_code" target="_top">'
	  2='</a>'
	}To play with the web application, %1download%2 the code and install it at your host. Translators do not need to download the source code. We will send them the gettext POT file to translate. Seek advice from this Hackers' Guide. If you need support ask for it at{/t} {mailto address='gnuherds-app-dev@nongnu.org'}
	</p>

	<p>
	{t escape='no'
	  1='<a href="/Charter.php" target="_top">'
	  2='</a>'
	}Read the current draft of %1GNU Herds' Charter%2.{/t}
	</p>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>2. {t}Technologies{/t} <a name="Technologies"></a> </h4>

	<p>
	{t}The project depends on the below technologies. Though it is and must be open to any proposal.{/t}
	</p>

	<table>
	<tr> <td><a href="http://www.w3.org/TR/html401/" target="_top">HTML</a> 4.01 Strict <td>
	<tr> <td><a href="http://www.php.net/" target="_top">PHP</a> >= 5.1 <td>
	<tr> <td><a href="http://smarty.php.net/" target="_top">Smarty</a> <td>
	<tr> <td><a href="http://smarty.incutio.com/?page=SmartyGettext" target="_top">Smarty-Gettext</a> <td>
	<tr> <td><a href="http://www.gnu.org/software/gettext/" target="_top">gettext</a> <td>
	<tr> <td><a href="http://wp.netscape.com/eng/mozilla/3.0/handbook/javascript/" target="_top">JavaScript 1.x</a> <td>
	<tr> <td><a href="http://www.w3.org/Style/CSS/" target="_top">CSS x.y</a> <td>
	<tr> <td><a href="http://httpd.apache.org/" target="_top">Apache x.y</a> <td>
	<tr> <td><a href="http://www.postgresql.org/" target="_top">PostgreSQL</a> >= 7.4.x <td>
	<tr> <td><a href="http://www.maxmind.com/" target="_top">GeoIP</a> <td>
	<tr> <td>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cgi-bin/viewcvs/gnuherds-app/gnuherds-app/" target="_top">'
	  2='<a href="http://savannah.gnu.org/" target="_top">'
	  3='</a>'
	}%1CVS%3 server at %2Savannah%3{/t}
	<td>
	<!-- XXX: <tr> <td><a href="http://www.openbsd.org/" target="_top">OpenBSD 3.x</a> <td>The gnuherds.org host is a 633MHZ DEC Alpha 64-bit CPU running OpenBSD. -->
	</table>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>3. {t}Web application Architecture{/t}<a name="Web_application_Architecture"></a> </h4>

	<p>
	{t}As a Free Software project we look for a modular and extensible design. We hope it could be easy to change the technology of a specific layer if it is needed.{/t}
	</p><p>
	{t}This architecture proposal is based on PHP:{/t}
	</p>

	<table>
	<tr> <td><b>Layer 0.</b> <td>Site entry point (<a href="http://www.w3.org/TR/html401/" target="_top">HTML</a>, <a href="http://www.w3.org/Style/CSS/" target="_top">CSS</a>, <a href="http://smarty.php.net/" target="_top">Smarty</a>, <a href="http://wp.netscape.com/eng/mozilla/3.0/handbook/javascript/" target="_top">JavaScript</a>, <a href="http://httpd.apache.org/docs/2.0/howto/ssi.html" target="_top">Apache SSI</a> and <a href="http://www.php.net/" target="_top">PHP</a> ).
	<tr> <td><b>Layer 1.</b> <td>GUI page builder and themes (PHP)
	<tr> <td><b>Layer 2.</b> <td>GUI business logic: content section, others (checking & processing forms) (PHP, HTML)
	<tr> <td><b>Layer 4.</b> <td>Data base Manager class, PHP Tools class and Mailer class (PHP)
	<tr> <td><b>Layer 5.</b> <td>Data base Operation classes (PHP, SQL)
	<tr> <td><b>Layer 6.</b> <td><a href="http://adodb.sourceforge.net/" target="_top">ADOdb</a> Database Abstraction Library (PHP)
	<tr> <td><b>..... ..</b> <td>NO stored procedures layer.
	<tr> <td><b>Layer 7.</b> <td><a href="http://www.postgresql.org/" target="_top">PostgreSQL</a> data base server (PostgreSQL, SQL)
	<tr> <td><b>locale</b> <td>Here are the files which translate the webapp (<a href="http://www.gnu.org/software/gettext/" target="_top">gettext</a>)
	</table>

	<p><img src="/doc/Layers_1_2_3_4_5_and_6.png" align="middle" alt="" border="0" hspace="0" vspace="0"> <span class="modification">({t}outdated{/t})</span> </p>  <!-- XXX Update this image -->

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>4. {t}Web application Design{/t}<a name="Web_application_Design"></a> </h4>

	<table border="0">
	<tbody>
	<tr><td><p><b>Layers 0, 1, 2, 4 and 5.</b> GUI, Forms, DBManager, PHPTools, and Mailer <span class="modification">({t}outdated{/t})</span> </p>
	<tr><td><p><a href="/doc/UML__Layers_1_2_3_and_4___GUI__Forms__DBManager__PHPTools__Mailer__Data_base_Operation_classes.png" target="_top"><img src="/doc/UML__Layers_1_2_3_and_4___GUI__Forms__DBManager__PHPTools__Mailer__Data_base_Operation_classes.scaled.png" align="middle" alt="" border="0" hspace="0" vspace="0"></a> </p>  <!-- XXX Update this image -->
	<p>{t}The Smarty templates could be moved outside this layer.{/t}</p>
	<p>&nbsp;</p>

	<tbody>
	<tr><td><p><b>Layer 6.</b> ADOdb Database Abstraction Library (PHP)</p>
	<tr><td>
	<p>
	{t escape='no'
	  1='<a href="http://php.net/pdo" target="_top">'
	  2='</a>'
	}ADOdb is an external library. It is not being used yet. We give up about using a data base abstraction library, and this proposal will use instead just %1PDO%2.{/t}
	</p>
	<p>&nbsp;</p>

	<tbody>
	<tr><td><p><b>Layer 7.</b> PostgreSQL data base server (PostgreSQL, SQL)</p>
	<tr><td><p>{t}Documentation of the new Data Base design:{/t}</p>
	<ul>
		<li><a href="/doc/GNUHerds__ER__Logical-model.png" target="_top">{t}Entity Relation logical model{/t}</a><br>
		&nbsp; Diagram editor (Dia) image <a href="/doc/GNUHerds__ER__Logical-model.dia" target="_top">source</a><br>
		<br>
		<a href="/doc/GNUHerds__ER__Logical-model.png" target="_top"><img src="/doc/GNUHerds__ER__Logical-model.scaled.png" align="middle" alt="" border="0" hspace="0" vspace="0"></a>
		<li><a href="/doc/GNUHerds__Physical-model.png" target="_top">{t}Physical model{/t}</a> <span class="modification">({t}outdated{/t})</span> <br>
		<li><a href="/doc/GNUHerds__SQL_Implementation.psql" target="_top">{t}SQL Implementation{/t}</a>
	</ul>
	</table>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>5. {t}Coding Standards{/t} <a name="Coding_Standards"></a> </h4>

	<p>
	<STRIKE>
	{t escape='no'
	  1='<a href="http://docs.clawphp.org/standards/index" target="_top">'
	  2='</a>'
	}We will try to follow these %1Coding Standards%2.{/t}
	</STRIKE>
	</p>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>6. {t}Internationalization and Localization{/t} <a name="Internationalization_and_Localization"></a> </h4>

<pre>
  &lt;meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8"&gt;

  $ iconv --from-code=ISO-8859-1 --to-code=UTF-8 ./oldfile.htm > ./newfile.html

  # edit the gettext messages.po files
  "Content-Type: text/plain; charset=UTF-8\n"
  "Content-Transfer-Encoding: 8bit\n"

  $ edit your .emacs
  (setq locale-coding-system 'UTF-8)
  (set-terminal-coding-system 'UTF-8)
  (set-keyboard-coding-system 'UTF-8)
  (set-selection-coding-system 'UTF-8)
  (prefer-coding-system 'UTF-8)

  ;; remove all the stuff like
  ;; (standard-display-european 1)

  ;; manually you can
  ;; M-x prefer-coding-system  UTF-8

  # Set your LC_TYPE locally and start vim
  $ LC_CTYPE=it_IT.UTF-8  vim

  # Or you can execute a terminal window with the LC_TYPE set to UTF-8 like this, and start vim inside it
  $ LC_CTYPE=it_IT.UTF-8  xterm -u8 -fn '-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1'
  $ vim

  $ edit your httpd.conf
  AddDefaultCharset Off

  # install the php5.0-mbstring module
  $ edit your php.ini
  output_handler = mb_output_handler
  mbstring.http_output = UTF-8
</pre>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>7. {t}How the development team and production is integrated?{/t} <a name="How_the_development_team_and_production_is_integrated"></a> </h4>

	<p>{t}CVS is used as repository. The HTTP server gets a tagged release via 'update' from the CVS server.{/t}</p>

	<img src="/doc/How_the_development_team_and_production_is_integrated.png" align="middle" alt="" border="0" hspace="0" vspace="0">

	<p>
	{t escape='no'
	  1='"<i>cvs diff -c3p</i>"'
	  2='"<i>diff -up OLD NEW</i>"'
	}The suggested formats to share source code among the developers are %1 or %2.{/t}
	</p>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>8. {t}The TODO task list{/t} <a name="The_TODO_task_list"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/task/?group=gnuherds-app" target="_top">'
	  2='</a>'
	}See the %1Task Manager%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>9. Wikis <a name="Wikis"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="https://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=146" target="_top">'
	  2='</a>'
	}See the %1Wiki HOWTO%2 at Savannah.{/t}
	</p>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>10. {t}The source code{/t} <a name="The_source_code"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://download.savannah.gnu.org/releases/gnuherds-app/" target="_top">'
	  2='</a>'
	}If you do not like play with CVS, you can get a, maybe outdated package, of the website, at our  Savannah %1Filelist (Download area)%2.{/t}
	{t escape='no'
	  1='<a href="/gnuherds-online.tar.gz" target="_top">'
	  2='</a>'
	}Or much better, you can %1download%2 the code which is running this site right now!.{/t}

	</p><p>
	{t escape='no'
	  1='<a href="#Technologies" target="_top">'
	  2='</a>'
	}You could set up all the required %1Technologies%2 on your host, to be used as your development environment.{/t}
	</p><p>
	{t}The source code can have 'XXX' flags, which are used to mark pending tasks, etc.{/t}
	</p>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>11. {t}The CVS server{/t} <a name="The_CVS_server"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.gnu.org" target="_top">'
	  2='</a>'
	}The CVS of gnuherds-app is at %1Savannah%2. The PostgreSQL database and the website is at the gnuherds.org host.{/t}
	</p><p>
	{t}Though before getting write permision to the CVS repository it is usual to prove the interest with some patch, you can register at the Savannah development site and ask to join the project. Do not fear, if you join, nobody will force you to contribute :) {/t}
	</p>

	<p>
	{t}Hints{/t}:
	</p>
	<ul>
		<li>
		{t escape='no'
		  1='<a href="https://savannah.nongnu.org//account/register.php" target="_top">'
		  2='<a href="http://savannah.gnu.org/" target="_top">'
		  3='</a>'
		}%1Register%3 at %2Savannah%3{/t}

		<li>
		{t escape='no'
		  1='<a href="https://savannah.gnu.org/my/groups.php" target="_top">'
		  2='</a>'
		}%1Request%2 for inclusion to the project{/t}

		<li>
		{t escape='no'
		  1='<a href="http://savannah.nongnu.org/cgi-bin/viewcvs/gnuherds-app/gnuherds-app/" target="_top">'
		  2='</a>'
		}gnuherds-app %1CVS%2 view{/t}

		<li>
		{t escape='no'
		  1='<a href="http://savannah.nongnu.org/cvs/?group=gnuherds-app" target="_top">'
		  2='</a>'
		}CVS %1HOW TO%2{/t}
	</ul>

	<p>
	{t}Note: If you register at Savannah and join the project, both checkout and checkin will work in spite of the message "Your savannah password is useless for cvs".  When you register, take note of your passphrase. Savannah will ask for it at each cvs operation. For example, my first checkout was as follows:{/t}
	</p>

<pre>
    $ cvs -z3 -d:ext:USER@cvs.savannah.nongnu.org:/sources/gnuherds-app co gnuherds-app

      The authenticity of host 'savannah.nongnu.org (199.232.41.4)' can't be 
      established.
      RSA key fingerprint is 80:5a:b0:0c:ec:93:66:29:49:7e:04:2b:fd:ba:2c:d5.
      Are you sure you want to continue connecting (yes/no)? yes

      Warning: Permanently added 'savannah.nongnu.org,199.232.41.4' (RSA) to the 
      list of known hosts.

      Enter passphrase for key '/home/USER/.ssh/id_dsa': 

      cvs checkout: Updating gnuherds-app
        U gnuherds-app/AfferoGPL
        U gnuherds-app/Charter.php
        ...
    $ 


  {t}Now you can work:{/t}


    $ cvs log Charter.php
    $ cvs diff
    $ cvs diff Charter.php
    $ cvs diff -r 1.4 -r 1.3 Charter.php
    $ cvs update
    $ cvs ci Charter.php

    $ man cvs


  {t}To avoid writing the pass phrase at every cvs command:{/t}


    $ ssh-agent
    $ ssh-add
</pre>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>12. {t}The web site{/t} <a name="The_web_site"></a> </h4>

	<p>
	{t}It is in the gnuherds.org host.{/t}
	</p>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>13. {t}The PostgreSQL data base{/t} <a name="The_PostgreSQL_data_base"></a> </h4>

	<p>
	{t}Creating from scratch. Follow the below steps:{/t}
	</p>

<pre>
  a) {t}Create the data base{/t}


    peter@server:/home/user:~$ su -
    root@server:/home/user# su - postgres
    postgres@server:~$
    postgres@server:~$ createdb gnuherds
    CREATE DATABASE
    postgres@server:~$ 

      {t}Reference{/t}: http://www.postgresql.org/docs/8.0/static/app-createdb.html


  b) {t}Create the user, as super user{/t}


    postgres@server:~$ psql gnuherds
    gnuherds=#
    gnuherds=# CREATE USER peter CREATEUSER ;
    CREATE USER
    gnuherds=# 

      {t}Reference{/t}: http://www.postgresql.org/docs/8.0/interactive/user-manag.html#DATABASE-USERS


  c) {t}Grant permissions{/t}


    gnuherds=# GRANT ALL ON DATABASE gnuherds TO peter ;
    GRANT
    gnuherds=# 

      {t}References{/t}: http://www.postgresql.org/docs/8.0/interactive/sql-grant.html
                  http://www.postgresql.org/docs/8.0/interactive/privileges.html


  d) {t}Quit{/t}


    gnuherds=# \q
    postgres@server:~$ 
    postgres@server:~$ exit
    peter@server:/home/user:~$


  e) {t}Create the initial state of the data base{/t}


       Layer-0__Site_entry_point/doc/GNUHerds__SQL_Implementation.psql

     Edit the GRANT lines of that file to fit with your Apache's user.
     Warning: Note the DROPs at the head. All data will be deleted.

    peter@server:/home/user:~$ psql gnuherds < GNUHerds__SQL_Implementation.psql > stdout 2> stderr
    peter@server:/home/user:~$ 


  f) {t}Check that 'stderr' and 'stdout' do not show errors{/t}




  {t}General references:{/t}

    http://www.postgresql.org/docs/8.0/interactive/index.html
    http://www.postgresql.org/

  Foreign Keys & Primary Keys
    http://www.postgresql.org/docs/8.0/interactive/tutorial-fk.html
</pre>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>14. {t}Email lists{/t} <a name="Email_lists"></a> </h4>

<ul>
	<li><a href="https://lists.gnuherds.org/mailman/listinfo/association" target="_top">association</a> {t}is the project main list.{/t}</li>
	<li><a href="http://lists.nongnu.org/mailman/listinfo/gnuherds-app-dev" target="_top">gnuherds-app-dev</a> {t}to carry on the web application development.{/t}</li>
</ul>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>


<h4>15. {t}How to install a development environment?{/t} <a name="How_to_install_a_development_environment"></a> </h4>

<ul>
	<li>{t}Install{/t}: PostgreSQL
	<li><a href="/GNU_Herds_Hackers_Guide.php#The_PostgreSQL_data_base">{t}Configure{/t}</a>: PostgreSQL
	<li>{t}Install{/t}: Apache HTTP server
	<li>{t}Install{/t}: PHP
	<li>{t}Install{/t}: GeoIP
	<li>{t}Install{/t}: Smarty
	<li>{t}Install{/t}: Smarty-Gettext
<li>
<pre>
cd Layer-0__Site_entry_point
mkdir templates_c
chown user.www-data templates_c
chmod 770 templates_c
</pre>
	<li>{t}Install{/t}: PHP PEAR module for HTTP related stuff
	<li>{t}Configure{/t}: Apache HTTP server -- <a href="/doc/conf/apache_virtual_domain.conf">virtual domain</a>
	<li>{t}Configure{/t}: PHP -- <a href="/doc/conf/php.ini">php.ini</a>
<li>
<pre>
cd Layer-0__Site_entry_point
ln -s Home.php index.php
</pre>

<li>
<pre>
cd locale/es_ES/LC_MESSAGES
msgcat messages.po iso_639.po iso_4217.po iso_3166.po > result.po
msgfmt result.po
locale/it_IT/LC_MESSAGES
msgcat messages.po iso_639.po iso_4217.po iso_3166.po > result.po
msgfmt result.po
...
/etc/init.d/apache2 reload
</pre>

</ul>

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

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

<center><a href="#" style='text-decoration: none;' target="_top">{t}Back to top{/t}</a></center>

<p>&nbsp;</p>

<p class="footnote">{t}For more information:{/t} {mailto address='gnuherds-app-dev@nongnu.org'} </p>

