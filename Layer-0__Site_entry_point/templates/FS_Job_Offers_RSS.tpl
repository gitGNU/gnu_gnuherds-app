<?xml version="1.0"?>

<rdf:RDF
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
xmlns:content="http://purl.org/rss/1.0/modules/content/"
xmlns="http://purl.org/rss/1.0/"
>
<channel rdf:about="http://gnuherds.org/offers">
<title>GNU Herds - {t}FS job offers{/t}</title>
<link>http://gnuherds.org/offers</link>
<description>
{if count($JobOfferId) == 0 }
  {t}There are no active job offers{/t}
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
<link>http://gnuherds.org/offers?id={$Id}</link>
<content:encoded>&lt;PRE&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Location{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;FONT COLOR=&quot;#A020F0&quot;&gt;{if trim($City[$i]) eq '' and trim($StateProvince[$i]) eq '' and trim($CountryName[$i]) eq ''}{t domain='database'}Any{/t}, {t}telework{/t}{else}{if trim($CountryName[$i]) neq ''}{t domain='iso_3166'}{$CountryName[$i]}{/t}{if $StateProvince[$i]}, {$StateProvince[$i]}{/if}{if $City[$i]}, {$City[$i]}{/if}{else}{if trim($StateProvince[$i]) neq ''}{$StateProvince[$i]}{if $City[$i]}, {$City[$i]}{/if}{else}{$City[$i]}{/if}{/if}{/if}&lt;/FONT&gt;

&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Offer date{/t}:&lt;/FONT&gt;&lt;/B&gt; {$OfferDate[$i]}&lt;/FONT&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Offered by{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;B&gt;&lt;FONT COLOR=&quot;#BC8F8F&quot;&gt;{if $EntityType[$i] eq 'Person'}{t}Person{/t}: {/if}{if $EntityType[$i] eq 'Cooperative'}{t}Cooperative{/t}: {/if}{if $EntityType[$i] eq 'Company'}{t}Company{/t}: {/if}{if $EntityType[$i] eq 'non-profit Organization'}{t}non-profit Organization{/t}: {/if}&lt;/FONT&gt;&lt;/B&gt;&lt;FONT COLOR=&quot;#B8860B&quot;&gt;{if $EntityType[$i] eq 'Person'}{$EP_LastName[$i]}{if $EP_LastName[$i] and ($EP_FirstName[$i] or $EP_MiddleName[$i])},{/if}{if $EP_FirstName[$i]} {$EP_FirstName[$i]}{/if}{if $EP_MiddleName[$i]} {$EP_MiddleName[$i]}{/if}{/if}{if $EntityType[$i] eq 'Cooperative'}{$EC_CooperativeName[$i]}{/if}{if $EntityType[$i] eq 'Company'}{$EC_CompanyName[$i]}{/if}{if $EntityType[$i] eq 'non-profit Organization'}{$EO_OrganizationName[$i]}{/if}&lt;/FONT&gt;


&lt;/PRE&gt;
</content:encoded>
</item>

{/foreach}

</rdf:RDF>
