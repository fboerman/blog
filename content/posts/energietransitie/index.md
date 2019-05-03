---
title: "De Energie Transitie en Nederland"
date: 2019-04-29
draft: false
description: "De harde cijfers over hoe het ermee gesteld staat in Nederland"
---
## Klimaat en de politiek
Global warming: het is een hot topic de laatste tijd. Het speelde een grote rol in de afgelopen Tweede Kamer verkiezingen (2017), met Jesse Klaver van Groenlinks als voornaamste aanjager. En met success, GroenLinks won flink. Mede hierdoor werd er vanaf 2018 een groot polder project gestart: het Nederlandse klimaat akkoord.  
Ook bij de afgelopen Provinciale Staten (en dus indirect de eerste kamer) verkiezingen was het wederom een hot topic. Dit keer was het resultaat anders, de grote winnaar van deze verkiezingen (FvD) is groot tegenstander van het klimaat akkoord.

Het doel van het [klimaat akkoord](https://www.klimaatakkoord.nl/klimaatakkoord) (die nog niet definitief gesloten is) is een reductie van CO2 uitstoot van 49% in 2010 t.o.v. 1990. Dit is onderdeel van de internationaal gesloten akkoord van Parijs. Een van de onderdelen om dit te bereiken is Energie, of om precies te zijn de [Energie Transitie](https://www.klimaatakkoord.nl/elektriciteit). Het doel hiervan is simpel samen te vatten, maar lastig uit te voeren:  
"In 2030 komt 70 procent van alle elektriciteit uit hernieuwbare bronnen"

Een veel gehoorde reactie op deze plannen is dat mensen denken dat Nederland het al heel goed doet met hernieuwbare energie, en willen er dus geen nieuwe grote investeringen erin doen. Ik had al eens gehoord dat dit verre van het geval is en daarom ben ik eens even in de cijfers gedoken.

Even een kleine technische note om mee te beginnen. Alle cijfers in deze post komen van het [CSB statline](https://opendata.cbs.nl/statline/#/CBS/nl/) programma. De meeste energie statestieken m.b.t. hernieuwbare energie wordt pas bijgehouden sinds begin jaren 90, dit verklaart de xas domein van veel van de gebruikte grafieken. Alle data is verwerkt in python, de source hiervan kan je vinden mijn [github](https://github.com/fboerman/blogposts-data).

## Energie Productie
Wat mij meteen opviel aan deze plot, is de relatieve bescheiden deelname van windenergie. Er wordt al jaren veel aandacht in de media en politiek besteed aan de voors en tegens van wind turbines en veel provincies pronken er mee als ze weer een nieuw park neergezet hebben. Voor extra duidelijkheid staan in onderstaande tabel de productie windenergie t.o.v. totaal energie productie uitgedrukt in procenten van de laatste 5 data punten.

| Jaar | %    |
|------|------|
| 2013 | 5.58 |
| 2014 | 5.61 |
| 2015 | 6.86 |
| 2016 | 7.09 |
| 2017 | 9.01 |

De deelname van wind is dus vrij bescheiden, een kleine 9% en vrij traag groeiend. Voor wat extra duidelijkheid hieronder een donut chart van het laatste jaar waar CBS data van heeft, 2017.  
{{< figure src="plots/productietotaal2017.svg" >}}  
De meeste categorie spreken voor zich, alleen wat is precies een steg-eenheid? Een snelle blik op wikipedia leert je dat dit een gecombineerde [Stoom- en gasturbine](https://nl.wikipedia.org/wiki/Stoom-_en_gascentrale) is. Het maakt gebruik van een slimme combinatie om het rendement op het gas stoken te verhogen.

Uit bovenstaande plots rijst al een wat somber beeld op als je het klimaat akkoord in je achterhoofd houdt. Het overgrote deel van de productie is verre van hernieuwbaar en komt uit stoom en gas.

## Energie Balans
Voordat we doorgaan door in te zoomen op de hernieuwbare energie bronnen is het belangrijk om ook de energie balans kort te beschouwen. Over de afgelopen 30 jaar is Nederland altijd een netto importeur geweest van energie, de balans per jaar is weergegeven in onderstaande grafiek.  
{{< figure src="plots/balans.svg" >}}
Waarschijnlijk neemt het klimaat akkoord als definitie dat hernieuwbare energie als percentage van verbruik i.p.v. eigen productie telt. Dit betekend dus dat er ook nadrukkelijk gekeken moet worden naar het buitenland en waar onze geimporteerde energie vandaan komt.

## Energie Productie uit Hernieuwbare Bronnen
Dan nu een blik op de cijfers voor hernieuwbare bronnen. In onderstaande figuur is het aandeel van hernieuwbare energie in productie binnen Nederland geplot. Links onderverdeelt in de verschillende categorie van herkomst, rechts als percentage van het totale verbruik in Nederland. Met andere woorden dit gaat over de energie productie die ook binnenlands geconsumeerd wordt. Dit is een specifieke keuze die volgens het CBS "voortvloeit uit Europese afspraken".
{{< figure src="plots/hernieuwbareproductie.svg" >}}  
Hieruit blijkt dus dat er nog wel wat te winnen valt. In het laatste jaar waar cijfers bekend van zijn, 2017, was het percentage slechts 14.33%. Dit is a far cry van de targets die het kabinet gezet heeft. Echter deze targets gelden vooral voor het percentage hernieuwbare energie van het daadwerkelijk verbruik van binnenlandse energie. Oftewel als je veel "vieze" stroom exporteert en veel groene stroom importeert, kan je dit nog wat verbeteren. Maar laat dit cijfer inderdaad wat gunstigers zien?

## Energie Verbruik uit Hernieuwbare Bronnen
Het antwoord hierop is te zien in onderstaande grafiek. Dit laat het aandeel van hernieuwbare energie in de binnenlandse energie consumptie zien, uitgesplitst over enkele categorieen.
{{< figure src="plots/hernieuwbareverbruik.svg" >}}  
Dit laat een triest plaatje zien. Met nog 11 jaar te gaan tot de gestelde target van 70% hernieuwbare energie van energie consumptie, laat Nederland een magere 6.6% zien over 2017. Dit is wel een verbetering t.o.v. de 1.22% waar we mee begonnen in 1990, maar het is bar weinig. Het laat zien dat er nog veel werk aan de winkel is en dat het klimaat akkoord grote en aggresieve maatregelen nodig heeft om deze targets te halen. Het antwoord op mijn gestelde vraag is dus nee, dit laat een nog triester beeld zien dan de energie productie.  
Wat wel leuk is om te zien is de opkomst van de electrische vervoersmiddelen. Beginnend in 2006 is deze ieder jaar vertegenwoordigt in de verbruiks statestieken.

## Conclusie
Al met al staat Nederland er dus niet best voor om haar doelen te halen. Een magere 6.6% hernieuwbare energie in het binnenlands energie verbruik laat zien dat er nog veel werk aan de winkel is. Nederland ligt hiermee ook achter op het Europese gemiddelde van 17.4% zoals [geraporteert door het EEA, European Environment Agency](https://www.eea.europa.eu/publications/renewable-energy-in-europe-2018). Er is dus werk aan de winkel en ik hoop dat de huidige politiek dit ter harte neemt! Dit zal echter alleen gebeuren met betere bewustwording van de stemmende Nederlanders. Alleen zij kunnen echte verandering pushen.
