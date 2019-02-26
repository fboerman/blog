---
title: "Gesprekken met mijn oma: Pensioenkosten"
date: 2019-02-24
draft: false
description: "Waarom aanpassingen in de AOW nodig zijn voor de toekomst"
---

Mijn opa en oma wonen vrij dichtbij mij in de buurt. Met mijn familie gaan we daar dan ook geregeld heen. Mijn oma is een intelligent mens en al mijn hele leven herinner ik me haar als iemand die nadenkt over de wereld om haar heen en daarover discusieert. Enige tijd geleden kwamen we op een zondag op een gevoelig onderwerp: de pensioenen. Deze zijn veel in het nieuws omdat deze alleen maar lijken te versomberen terwijl de economie wel goed draait op het moment. Ook de verhoging van de pensioen leeftijd  is altijd een hot topic.

Een van mijn statements van die zondag was dat het pensioenstelsel zoals die in de jaren 50 is ontworpen (de AOW wet is in 1956 ingegaan [[wiki](https://nl.wikipedia.org/wiki/Algemene_Ouderdomswet)]) niet meer houdbaar is voor mijn generatie vanwege de bevolkings ontwikkelingen. Hier was niet iedereen om de tafel het mee eens. Dit prikkelde mijn interesse om dit te proberen onderbouwen met harde cijfers.

Even een kleine technische note om mee te beginnen. Alle cijfers in deze post komen van het [CSB statline](https://opendata.cbs.nl/statline/#/CBS/nl/) programma. Aangezien het CBS data over arbeidsdeelname pas sinds 1969 beschikbaar heeft starten alle grafieken vanaf daar en niet vanaf het begin van de AOW. Alle data is verwerkt in python, de source hiervan kan je vinden mijn github.

## Pensioenbasis: de AOW
Het pensioen stelsel in Nederland is vrij uitgebreid, maar om de trend te laten zien als argument beperk ik mij hier even tot de basis daarvan: de AOW. De Algemene Ouderdomswet (AOW) is in Nederland sinds 1956 de basis van de pensioenen. Het zorgt voor een basis pensioen voor iedereen boven de pensioens gerechtigde leeftijd, die op dat moment werd vastgesteld op 65. In 2012 werd dit door het toenmalig kabinet gewijzigd naar een oplopende leeftijd afhankelijk van je geboorte jaar, in reactie op het probleem wat ik ga beschrijven.

De AOW wordt grotendeels gefinancierd door de AOW premies, deze worden betaald door iedereen in Nederland als onderdeel van de belastingen zolang je werkt. Mensen die AOW ontvangen dragen hier niet meer aan bij, wat dus heel kort door de bocht betekend dat mensen die op dit moment werken de AOW financieren van de mensen die op dit moment AOW ontvangen. Met andere woorden de huidige generatie betaald voor de generatie boven hen. Dit met het idee dat de generatie na hen hetzelfde zal doen voor hen. En hier zit dus de kern van het probleem.

## Bevolkingsgroei
Laten we even beginnen met de basis, de algemene bevolking in Nederland stijgt al jaren, van 12.8 miljoen in 1969 naar iets meer dan 17 miljoen in 2017. Dit is in het onderstaande figuur weergegeven.
{{< figure src="plots/bevolkingsgroei.svg" >}}

## Bevolkingsontwikkelingen
Als we even inzoomen op deze groei zien we twee voor de AOW relevante ontwikkelingen.

Allereerst groeit ook de groep mensen die werken en dus AOW premies betalen. Niet alleen in absolute zin vanwege de groeiende bevolking, maar ook in relatieve zin door factoren zoals de vergrote arbeidsparticipatie onder vrouwen. In de onderstaande figuur kan je links de absolute stijging zien en rechts is het percentage van beroeps bevolking op de gehele bevolking uitgedrukt.
{{< figure src="plots/aandeelberoepsbevolking.svg" >}}
Hier kan je zien dan de beroepsbevolking is gestegen van 5.2 miljoen in 1969 naar iets meer dan 9 miljoen in 2017. Relatief uitgedrukt is het percentage beroepsbevolking op de volledige bevolking van 40.91% in 1969 naar 52.79% in 2017 gestegen.

Hier staat een andere zorgwekkende trend tegenover. Als gevolg van het feit dat de baby boom generatie nu de "ouderen" fase in gaat vergrijst de Nederlandse bevolking. Dit is te zien in de onderstaande figuur van de absolute(links) en relatieve(rechts) aandeel van 65+ in de Nederlandse bevolking.
{{< figure src="plots/aandeel65.svg" >}}
Dit laat een absolute stijging zien van 1.2 miljoen in 1969 naar 3.2 miljoen in 2017, maar veelzeggender een relatieve stijging (ten opzichte van de totale bevolking) van 10.01% in 1969 naar 18.49% in 2017.
[//]: # (TODO: grafiekje prognose groei van 65+)

Wat betekend dit? Dat zowel het deel van de bevolking dat betaald voor de AOW als de AOW ontvangers gestegen is, maar de ontvangende groep relatief veel harder. Laten we dan nu kijken naar het effect hiervan op de AOW cijfers zelf.

## De AOW cijfers
Laten we dan nu de cijfers van de AOW zelf erbij pakken. Allereerst wederom de basis, hieronder staat de totaal aantal AOW uitkeringen in Nederland. Deze is gestegen, weinig verassend als je kijkt naar de stijgende hoeveelheid 65+ mensen. Er moet echter wel een heel belangrijke kanttekeing geplaatst worden bij deze data, zoals het CBS zelf al aangeeft. Per 1 april 1985 is de AOW voor mannen en vrouwen gelijkgetrokken, conform de EG (de voorloper van de EU) richtlijnen. Hierdoor wordt geen onderscheid meer gemaakt tussen gehuwde mannen en vrouwen, zij hebben beide recht op AOW, dat was voor 1985 niet het geval. Deze gelijkheid is er dus pas sinds een kleine 34 jaar, vrij recent als je erover nadenkt. Deze verandering kan je duidelijk zien in de sprong die de grafiek maakt rond 1985.
{{< figure src="plots/aantaalaowuitkeringen.svg" >}}
Dit brengt mij naar de laatst en belangrijkste grafiek. Om de bevolkings ontwikkelingen echt goed uit te drukken in de gevolgen voor de AOW kan je kijken naar de graadmeter hoeveel werkende er per AOW uitkering is. Hiervoor delen we de beroepsbevolking door het aantal AOW ontvangers. Hierbij negeren we voor het gemak even veranderende inkomens ongelijkheid omdat we ervan uit gaan dat de maatregelen van de overheid om op een eerlijke manier AOW te heffen ook echt 100% eerlijk zijn (een ander discutabel onderwerp). Dit ziet er als volgt uit:
{{< figure src="plots/aantalwerkendeperaow.svg" >}}
Dit is dus hard gedaald, van naar 5.06 in 1968 naar 2.64 in 2017. Echter is er de aanpassing van de AOW in 1985 zoals genoemd, dit is dus niet een helemaal eerlijke vergelijking. Daarom kijken we naar de relatieve trend voor en na de wijziging voor  een goeie vergelijking.

tijdsperiode | voor | na | procentueel
--- | --- | --- | ---
1969-1985 | 5.06 | 4.47 | -13.20 %
1986-2017 | 3.39 | 2.64 | -28.41 %

In beide perioden zien we dus een sterke daling, met na 1985 een zeer sterke daling. Dit betekend dus dat relatief gezien de hoeveelheid werkende mensen ten opzichte van de hoeveelheid mensen die een AOW ontvangen krimpt.

## Conclusie
De jongere generaties (zoals die van mij) moeten dus relatief meer betalen voor onze ouderen dan de generaties voor ons, door de manier waarop onze AOW opgezet is in combinatie met de toenemende vergrijzing. Met de verwachte voortzettende vergrijzing van de Nederlandse bevolking zal dit alleen maar erger worden. Het is niet dat ik niet wil betalen voor mijn opa en oma en hun generatie genoten. Graag zelfs, ze hebben ons land opgebouwd en samen met de generatie van mijn ouders (die ook langzaam richting de AOW groep opschuiven) de mogelijkheden geschept voor mijn bestaan. Echter moet er wel serieus gekeken worden naar hoe dit systeem betaalbaar gehouden kan worden, zodat mijn en latere generaties niet bezwijken onder de toenemende lasten. Het verhogen van de AOW leeftijd waar nu naar gegrepen wordt is een optie, of dat de beste is zullen we de komende tijd gaan zien.
