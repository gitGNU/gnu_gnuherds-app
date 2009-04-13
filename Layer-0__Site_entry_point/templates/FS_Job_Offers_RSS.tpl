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
{if count($data.JobOffers.JobOfferId) == 0 }
  {t}There are no active job offers{/t}
{/if}
</description>
<sy:updatePeriod>daily</sy:updatePeriod>

<items>
<rdf:Seq>
{foreach from=$data.JobOffers.JobOfferId item=Id key=i}
<rdf:li resource="http://gnuherds.org/offers?id={$Id}"/>
{/foreach}
</rdf:Seq>
</items>
</channel>

{foreach from=$data.JobOffers.JobOfferId item=Id key=i}

<item rdf:about="http://gnuherds.org/offers?id={$Id}">
<title>{$data.JobOffers.VacancyTitle[$i]}</title>
<link>http://gnuherds.org/offers?id={$Id}</link>
<content:encoded>&lt;PRE&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Location{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;FONT COLOR=&quot;#A020F0&quot;&gt;{if trim($data.JobOffers.City[$i]) eq '' and trim($data.JobOffers.StateProvince[$i]) eq '' and trim($data.JobOffers.CountryName[$i]) eq ''}{t domain='database'}Any{/t}, {t}telework{/t}{else}{if trim($data.JobOffers.CountryName[$i]) neq ''}{t domain='iso_3166'}{$data.JobOffers.CountryName[$i]}{/t}{if $data.JobOffers.StateProvince[$i]}, {$data.JobOffers.StateProvince[$i]}{/if}{if $data.JobOffers.City[$i]}, {$data.JobOffers.City[$i]}{/if}{else}{if trim($data.JobOffers.StateProvince[$i]) neq ''}{$data.JobOffers.StateProvince[$i]}{if $data.JobOffers.City[$i]}, {$data.JobOffers.City[$i]}{/if}{else}{$data.JobOffers.City[$i]}{/if}{/if}{/if}&lt;/FONT&gt;

&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Offer date{/t}:&lt;/FONT&gt;&lt;/B&gt; {$data.JobOffers.OfferDate[$i]}&lt;/FONT&gt;
&amp;nbsp;&amp;nbsp; &lt;B&gt;&lt;FONT COLOR=&quot;#5F9EA0&quot;&gt;{t}Offered by{/t}:&lt;/FONT&gt;&lt;/B&gt; &lt;B&gt;&lt;FONT COLOR=&quot;#BC8F8F&quot;&gt;{if $data.JobOffers.EntityType[$i] eq 'Person'}{t}Person{/t}: {/if}{if $data.JobOffers.EntityType[$i] eq 'Cooperative'}{t}Cooperative{/t}: {/if}{if $data.JobOffers.EntityType[$i] eq 'Company'}{t}Company{/t}: {/if}{if $data.JobOffers.EntityType[$i] eq 'non-profit Organization'}{t}non-profit Organization{/t}: {/if}&lt;/FONT&gt;&lt;/B&gt;&lt;FONT COLOR=&quot;#B8860B&quot;&gt;{if $data.JobOffers.EntityType[$i] eq 'Person'}{$data.JobOffers.LastName[$i]}{if $data.JobOffers.LastName[$i] and ($data.JobOffers.FirstName[$i] or $data.JobOffers.MiddleName[$i])},{/if}{if $data.JobOffers.FirstName[$i]} {$data.JobOffers.FirstName[$i]}{/if}{if $data.JobOffers.MiddleName[$i]} {$data.JobOffers.MiddleName[$i]}{/if}{/if}{if $data.JobOffers.EntityType[$i] eq 'Cooperative'}{$data.JobOffers.CooperativeName[$i]}{/if}{if $data.JobOffers.EntityType[$i] eq 'Company'}{$data.JobOffers.CompanyName[$i]}{/if}{if $data.JobOffers.EntityType[$i] eq 'non-profit Organization'}{$data.JobOffers.OrganizationName[$i]}{/if}&lt;/FONT&gt;


&lt;/PRE&gt;
</content:encoded>
</item>

{/foreach}

</rdf:RDF>
