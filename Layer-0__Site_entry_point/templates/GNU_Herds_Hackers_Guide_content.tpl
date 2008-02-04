{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

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

<h3><a name="top"></a>{t}GNU Herds coders' guide{/t}</h3>

<p>{t}Index{/t}</p>
<ol>
<li> <a href="#Introduction" style='text-decoration: none;'>{t}Introduction{/t}</a>
<li> <a href="#Roadmap" style='text-decoration: none;'>{t}Roadmap{/t}</a>
<li> <a href="#Technology" style='text-decoration: none;'>{t}Technologies{/t}</a>
<li> <a href="#Architecture" style='text-decoration: none;'>{t}Web application Architecture{/t}</a>
<li> <a href="#Design" style='text-decoration: none;'>{t}Web application Design{/t}</a>
<li> <a href="#Coding_Standards" style='text-decoration: none;'>{t}Coding Standards{/t}</a>
<li> <a href="#i18n" style='text-decoration: none;'>{t}Internationalization and Localization{/t}</a>
<li> <a href="#env_Integration" style='text-decoration: none;'>{t}How the development team and production is integrated?{/t}</a>
<li> <a href="#TODO" style='text-decoration: none;'>{t}Task list{/t}</a>
<li> <a href="#wiki" style='text-decoration: none;'>Wikis</a>
<li> <a href="#Source_code" style='text-decoration: none;'>{t}The source code{/t}</a>
<li> <a href="#Source_repository" style='text-decoration: none;'>{t}The Git master server{/t}</a>
<li> <a href="#Data_base" style='text-decoration: none;'>{t}The PostgreSQL data base{/t}</a>
<li> <a href="#Communication" style='text-decoration: none;'>{t}Mailing lists{/t}</a>
<li> <a href="#Setup" style='text-decoration: none;'>{t}How to install a development environment?{/t}</a>
<li> <a href="#Team" style='text-decoration: none;'>{t}Current work team{/t}</a>
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
	  1='<a href="#Source_code">'
	  2='<a href="#Setup">'
	  3='</a>'
	}To play with the web application, %1download%3 the code and %2install%3 it at your host. Translators do not need to download the source code. We will send them the gettext POT file to translate. Seek advice from this Coders' Guide. If you need support ask for it at{/t} {mailto address='gnuherds-app-dev@nongnu.org'}
	</p>

	<p>
	{t escape='no'
	  1='<a href="charter">'
	  2='</a>'
	}Read the current draft of %1GNU Herds' Charter%2.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>2. {t}Roadmap{/t} <a name="Roadmap"></a> </h4>
	<ul>
	<li><p><span class="modification">{t}DONE!{/t}</span>: {t}Add the member support.{/t}</p></li>
	<li><p><span class="modification">{t}DONE!{/t}</span>: {t}Add the FS Job Offers support.{/t}</p></li>
	<li><p><span class="modification">{t}DONE!{/t}</span>: {t}Give a little progress report, with reference to this web site, to Richard Stallman so they review our activities and tell us what, if anything, needs to be changed.{/t}</p></li>
	<li><p><span class="modification">{t}DONE!{/t}</span>: {t escape='no'
	  1='<a href="http://www.fsf.org/">'
	  2='</a>'
	}To keep the access to the user data physically secure, we have proposed to move the PostgreSQL and HTTP service of the gnuherds.org domain to offices managed by %1FSF%2 staff.{/t}
	</p></li>
	<li><p><span class="modification">{t}ONGOING PROCESS{/t}</span>: {t}Translate the web site to other languages.{/t}</p></li>
	<li><p>{t}Official job site and association announcement.{/t}</p></li>
	<li><p>{t}Work on e-Vote subjects:{/t}</p>
		<ul>
		<li> {t}Be ready to use at least a primitive e-Vote system, as for example, to count emails.{/t}</li>
		<li> {t}Work on others e-Vote proposals.{/t}</li>
		<li> {t}Finish and show the draft of the P2P based e-Vote system proposal.{/t}
			{*
			Davi develops a draft and check it with Lorenzo and a friend who is interested in e-Voting (Gabriel).
			We ask for the opinion of the rest of this email list.
			We ask for the opinion of Jason Kitcat, though we know he is very busy.
			We check with the security experts community.
			*}
		</li>
		</ul>
	</li>
	</ul>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>3. {t}Technologies{/t} <a name="Technology"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=179">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>4. {t}Web application Architecture{/t}<a name="Architecture"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=180">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>5. {t}Web application Design{/t}<a name="Design"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=181">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>6. {t}Coding Standards{/t} <a name="Coding_Standards"></a> </h4>

	<p class="strike">
	{t escape='no'
	  1='<a href="http://docs.clawphp.org/standards/index">'
	  2='</a>'
	}We will try to follow these %1Coding Standards%2.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>7. {t}Internationalization and Localization{/t} <a name="i18n"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=152">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>8. {t}How the development team and production is integrated?{/t} <a name="env_Integration"></a> </h4>

	<p>{t}Git is used as repository. The HTTP server gets a tagged release via 'update' from the Git master server.{/t}</p>

	<img src="/doc/How_the_development_team_and_production_is_integrated.png" alt="{t}How the development team and production is integrated?{/t}">

	<p>
	{t escape='no'
	  1='"<i>git format-patch</i>"'
	  2='"<i>git send-email</i>"'
	}To share source code among the developers, publish your repository and let others know where to fetch from, or use %1 or %2.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>9. {t}Task list{/t} <a name="TODO"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/task/?group=gnuherds-app">'
	  2='</a>'
	}See the %1Task Manager%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>10. Wikis <a name="wiki"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=146">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>11. {t}The source code{/t} <a name="Source_code"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://download.savannah.gnu.org/releases/gnuherds-app/">'
	  2='</a>'
	}If you do not like play with Git, you can get a, maybe outdated package, of the website, at our  Savannah %1Filelist (Download area)%2.{/t}
	{t escape='no'
	  1='<a href="gnuherds-online.tar.gz">'
	  2='</a>'
	}Or much better, you can %1download%2 the code which is running this site right now!.{/t}

	</p><p>
	{t escape='no'
	  1='<a href="#Technology">'
	  2='</a>'
	}You could set up all the required %1Technologies%2 on your host, to be used as your development environment.{/t}
	</p><p>
	{t}The source code can have 'XXX' flags, which are used to mark pending tasks, etc.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>12. {t}The Git master server{/t} <a name="Source_repository"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=153">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>13. {t}The PostgreSQL data base{/t} <a name="Data_base"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=154">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>14. {t}Mailing lists{/t} <a name="Communication"></a> </h4>

<ul>
	<li><a href="https://lists.gnuherds.org/mailman/listinfo/association">association</a> {t}is the project main list.{/t}</li>
	<li><a href="http://lists.nongnu.org/mailman/listinfo/gnuherds-app-dev">gnuherds-app-dev</a> {t}to carry on the web application development.{/t}</li>
	<li>IRC: &nbsp; /server irc.freenode.net &nbsp; /join #gnuherds</li>
</ul>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>15. {t}How to install a development environment?{/t} <a name="Setup"></a> </h4>

	<p>
	{t escape='no'
	  1='<a href="http://savannah.nongnu.org/cookbook/?func=detailitem&amp;item_id=155">'
	  2='</a>'
	}See its %1wiki page%2 at Savannah.{/t}
	</p>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>

<p>&nbsp;</p>


<h4>16. {t}Current work team{/t} <a name="Team"></a> </h4>

	<p>
	{t}The list could be outdated:{/t}<br>
	<br>
	</p>
	<table>
	<tr> <td><b>Antenore</b> <td>Localization architecture Adviser, Auditor, initial and current Italian Translator, etc.
	<tr> <td><b>Bill</b>     <td>System administrator, architecture Adviser, etc.
	<tr> <td><b>Charles</b>  <td>Auditor, Quality Assurance, etc.
	<tr> <td><b>Davi</b>     <td>Web developer, Spanish Translator, etc.
	<tr> <td><b>David</b>    <td>Web developer, second Italian Translator.
	<tr> <td><b>Duarte</b>   <td>Portuguese Translator.
	<tr> <td><b>Fatima</b>   <td>Quality Assurance and Functional Auditor.
	<tr> <td><b>Gabriel</b>  <td>Data Base arquitecture Adviser.
	<tr> <td><b>Jean-Michel</b> <td>French Translator.
	<tr> <td><b>Jonas</b>    <td>GNU Business Network.
	<tr> <td><b>Jose</b>     <td>Architecture Adviser.
	<tr> <td><b>Klaus</b>    <td>Web developer, Code Auditor, German Translator.
	<tr> <td><b>Martin</b>   <td>Auditor and Quality Assurance. Public Relations.
	<tr> <td><b>Neal</b>     <td>Initial proposal, project Chapter, Public Relations, etc.
	<tr> <td><b>RMS</b>      <td>Ethics Officer; he evaluates the project as a whole.
	<tr> <td><b>Sameer Naik</b> <td>HTML/CSS Adviser and Developer.
	<tr> <td><b>Victor</b>   <td>Web developer, Quality Assurance.
	</table>

<p class="top"><a href="#top">{t}Back to top{/t}</a></p>
