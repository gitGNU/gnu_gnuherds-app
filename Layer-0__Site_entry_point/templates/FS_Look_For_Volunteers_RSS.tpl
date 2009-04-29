<?xml version="1.0"?>

<rdf:RDF
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
xmlns:content="http://purl.org/rss/1.0/modules/content/"
xmlns="http://purl.org/rss/1.0/"
>
<channel rdf:about="http://gnuherds.org/volunteers">
<title>GNU Herds - {t}FS volunteers{/t}</title>
<link>http://gnuherds.org/volunteers</link>
<description>
{if count($data.LookForVolunteers.JobOfferId) == 0 }
  {t}There are no entries{/t}
{/if}
</description>
<sy:updatePeriod>daily</sy:updatePeriod>

<items>
<rdf:Seq>
{foreach from=$data.LookForVolunteers.JobOfferId item=Id key=i}
<rdf:li resource="http://gnuherds.org/offers?id={$Id}"/>
{/foreach}
</rdf:Seq>
</items>
</channel>

{foreach from=$data.LookForVolunteers.JobOfferId item=Id key=i}

<item rdf:about="http://gnuherds.org/offers?id={$Id}">
<title>{$data.LookForVolunteers.VacancyTitle[$i]}</title>
<link>http://gnuherds.org/volunteers?id={$Id}</link>
<content:encoded>&lt;PRE&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Location{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;FONT COLOR=&quot;#A020F0&quot;&gt;{t domain='database'}Any{/t}, {t}telework{/t}&lt;/FONT&gt;

&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Entry date{/t}:&lt;/FONT&gt;&lt;/B&gt; {$data.LookForVolunteers.OfferDate[$i]}&lt;/FONT&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Created by{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;B&gt;&lt;FONT COLOR=&quot;#BC8F8F&quot;&gt;{if $data.LookForVolunteers.EntityType[$i] eq 'Person'}{t}Person{/t}: {/if}{if $data.LookForVolunteers.EntityType[$i] eq 'Cooperative'}{t}Cooperative{/t}: {/if}{if $data.LookForVolunteers.EntityType[$i] eq 'Company'}{t}Company{/t}: {/if}{if $data.LookForVolunteers.EntityType[$i] eq 'non-profit Organization'}{t}non-profit Organization{/t}: {/if}&lt;/FONT&gt;&lt;/B&gt;&lt;FONT COLOR=&quot;#B8860B&quot;&gt;{if $data.LookForVolunteers.Email[$i]}{if $data.LookForVolunteers.EntityType[$i] eq 'Person'}{if $data.LookForVolunteers.LastName[$i] or $data.LookForVolunteers.FirstName[$i] or $data.LookForVolunteers.MiddleName[$i]}{$data.LookForVolunteers.LastName[$i]}{if $data.LookForVolunteers.LastName[$i] and ($data.LookForVolunteers.FirstName[$i] or $data.LookForVolunteers.MiddleName[$i])},{/if}{if $data.LookForVolunteers.FirstName[$i]} {$data.LookForVolunteers.FirstName[$i]}{/if}{if $data.LookForVolunteers.MiddleName[$i]} {$data.LookForVolunteers.MiddleName[$i]}{/if}{else}{t}Name{/t}: {t}not specified{/t}{/if}{/if}{if $data.LookForVolunteers.EntityType[$i] eq 'Cooperative'}{if $data.LookForVolunteers.CooperativeName[$i]}{$data.LookForVolunteers.CooperativeName[$i]}{else}{t}Name{/t}: {t}not specified{/t}{/if}{/if}{if $data.LookForVolunteers.EntityType[$i] eq 'Company'}{if $data.LookForVolunteers.CompanyName[$i]}{$data.LookForVolunteers.CompanyName[$i]}{else}{t}Name{/t}: {t}not specified{/t}{/if}{/if}{if $data.LookForVolunteers.EntityType[$i] eq 'non-profit Organization'}{if $data.LookForVolunteers.OrganizationName[$i]}{$data.LookForVolunteers.OrganizationName[$i]}{else}{t}Name{/t}: {t}not specified{/t}{/if}{/if}{else}{t}Email not verified!{/t}{/if}&lt;/FONT&gt;


&lt;/PRE&gt;
</content:encoded>
</item>

{/foreach}

</rdf:RDF>
