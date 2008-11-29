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
{if count($JobOfferId) == 0 }
  {t}There are no entries{/t}
{/if}
</description>
<sy:updatePeriod>daily</sy:updatePeriod>

<items>
<rdf:Seq>
{foreach from=$JobOfferId item=Id key=i}
<rdf:li resource="http://gnuherds.org/offers?id={$Id}"/>
{/foreach}
</rdf:Seq>
</items>
</channel>

{foreach from=$JobOfferId item=Id key=i}

<item rdf:about="http://gnuherds.org/offers?id={$Id}">
<title>{$VacancyTitle[$i]}</title>
<link>http://gnuherds.org/volunteers?id={$Id}</link>
<content:encoded>&lt;PRE&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Location{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;FONT COLOR=&quot;#A020F0&quot;&gt;{t domain='database'}Any{/t}, {t}telework{/t}&lt;/FONT&gt;

&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Entry date{/t}:&lt;/FONT&gt;&lt;/B&gt; {$OfferDate[$i]}&lt;/FONT&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Created by{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;B&gt;&lt;FONT COLOR=&quot;#BC8F8F&quot;&gt;{if $EP_FirstName[$i]}{t}Person{/t}: {/if}{if $EC_CompanyName[$i]}{t}Company{/t}: {/if}{if $EO_OrganizationName[$i]}{t}non-profit Organization{/t}: {/if}&lt;/FONT&gt;&lt;/B&gt;&lt;FONT COLOR=&quot;#B8860B&quot;&gt;{if $EP_FirstName[$i]}{$EP_LastName[$i]} {$EP_MiddleName[$i]}{if $EP_LastName[$i] or $EP_MiddleName[$i]},{/if} {$EP_FirstName[$i]}{/if}{if $EC_CompanyName[$i]}{$EC_CompanyName[$i]}{/if}{if $EO_OrganizationName[$i]}{$EO_OrganizationName[$i]}{/if}&lt;/FONT&gt;


&lt;/PRE&gt;
</content:encoded>
</item>

{/foreach}

</rdf:RDF>
