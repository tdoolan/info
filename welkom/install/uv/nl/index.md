---
layout: welkom-tutorial
title: Python installeren met uv
tutorial_questions:
  os:
    question: "Welk besturingssysteem gebruik je?"
    choices:
      mac: "macOS"
      linux: "Linux"
      windows: "Windows"
  setup:
    question: "Wat heb je van je vak gekregen?"
    description: "Als je niet weet wat we bedoelen, lees dan eerst het vorige onderdeel."
    choices:
      nothing: "Niets (geen configuratiebestand)"
      requirements: "Een requirements.txt-bestand"
      pyproject: "Een pyproject.toml-bestand"
---

* Automatisch gegenereerde inhoudsopgave voor deze pagina
{:toc}

# Handleiding Python installeren met `uv`

In deze handleiding lees je hoe je:

- `uv` en een recente versie van Python installeert
- een programmeermap en submappen voor je vakken maakt
- de Python-packages beheert die je voor elk vak nodig hebt
- je Python-programma's uitvoert

Er zijn ook andere manieren om Python te beheren! Maar in deze tutorial proberen we een consistente werkwijze aan te bieden die goed werkt op de universiteit.

## Wat achtergrond over bestanden en mappen

Als je nieuw bent met programmeren, is het belangrijk om te begrijpen hoe bestanden en mappen werken. Al je documenten worden op je computer opgeslagen als bestand. Om een groot aantal bestanden te ordenen, gebruik je mappen.

- Een **bestand** is een document of stukje data, zoals een Python-programma (de naam eindigt dan op `.py`), maar het kan ook een databestand zijn (bijvoorbeeld eindigend op `.csv`) of een Word-document (eindigend op `.docx`).

- Een **map** (ook wel directory genoemd) is een "container" waarin bestanden kunnen zitten. Maar in een map kunnen ook weer andere mappen zitten. Zo kun je je bestanden in een hiërarchische structuur ordenen.

Bijvoorbeeld:

- `programmeren/` → een hoofdmap
- `mijn-vak/` → een map binnen `programmeren`
- `hello.py` → een bestand binnen `mijn-vak`

Met nog twee andere bestanden erbij ziet de structuur er zo uit:

~~~text
programmeren/
└── mijn-vak/
    ├── hello.py
    └── week1.py
    └── zac-data-2026.csv
~~~

De bestanden waar je vooral mee te maken krijgt zijn **Python-bestanden**. Je begint vaak met een leeg (blanco) bestand, schrijft Python-code, slaat het bestand op en voert het dan **uit**. Daarover later meer.

### Paden

Een **pad** is een volledige beschrijving van waar een bestand te vinden is, inclusief de namen van alle mappen waarin het zit. In plaats van naar een bestand kan een pad ook naar een map wijzen.

Je hebt bijvoorbeeld waarschijnlijk wel eens bestanden opgeslagen in de map `Documenten` op je computer. Hier zijn voorbeelden van het volledige pad naar een map binnen je documentenmap:

- `/Users/isaiah/Documents/UvA/intro` (macOS/Linux)
- `C:\Users\isaiah\Documents\UvA\intro` (Windows)
- `C:\Users\isaiah\OneDrive\Documents\UvA\intro` (Windows met OneDrive)

#### Thuismap

De paden hierboven beginnen met `/Users/isaiah/` en `C:\Users\isaiah`. Dat zijn de paden naar je "thuismap" (home directory). Je thuismap is jouw persoonlijke ruimte op de computer waar je bestanden staan, gescheiden van andere mensen die dezelfde computer gebruiken.

#### Afkortingen

Omdat veel van je bestanden in je thuismap staan, is er een afkorting! In plaats van het volledige pad kun je `~` (macOS/Linux) of `$HOME` (Windows PowerShell) gebruiken.

Daarmee kun je iets kortere paden naar dezelfde locatie gebruiken:

- `~/Documents/UvA/intro` (macOS/Linux)
- `$HOME\Documents\UvA\intro` (Windows)
- `$env:OneDrive\Documents\UvA\intro` (Windows met OneDrive)

> Die laatste laat zien wat er gebeurt op Windows met OneDrive. Je mappen `Documents` en `Desktop` staan dan helemaal niet in `$HOME`: OneDrive heeft ze in de map `OneDrive` gezet om ze te kunnen synchroniseren. De map `$HOME\Documents` lijkt dan misschien leeg, of je hebt zelfs bestanden op beide plekken. Verderop in deze tutorial lees je waarom je je programmeerwerk *niet* in zo'n map moet zetten.

## Met je computer werken vanuit een shell

Als je je computer normaal gebruikt, klik je op iconen, open je mappen en sleep je bestanden. Dat heet een **grafische gebruikersinterface (GUI)**.

Een **shell** is een andere manier om met je computer te werken. In plaats van klikken typ je opdrachten (commando's).

Je bereikt de shell via een programma dat een **terminal** heet.

- Op macOS: Terminal
- Op Linux: Terminal
- Op Windows: PowerShell of Windows Terminal

### De terminal openen

#### macOS [mac]

1. Druk op `Cmd + Spatie` om Spotlight te openen
2. Typ `Terminal`
3. Druk op Enter

Er opent een venster met tekst zoals dit:

~~~text
Last login: ...
username@macbook ~ %
~~~

De `%` is de **prompt**. De prompt is de plek waar je commando's typt. Het betekent dat de terminal klaar is om een commando aan te nemen.

En zie je dat kleine `~` voor het procentteken? Dat is de map waaraan de shell gekoppeld is. In dit geval is dat je thuismap, zoals je hierboven hebt geleerd.

#### Windows (PowerShell) [windows]

1. Druk op de Windows-toets
2. Typ `PowerShell` of `Windows Terminal`
3. Druk op Enter

Er opent een venster met tekst zoals dit:

~~~text
PS C:\Users\JouwNaam>
~~~

De `>` is de **prompt**. De prompt is de plek waar je commando's typt. Het betekent dat de terminal klaar is om een commando aan te nemen.

De shell laat ook het pad zien van de map waaraan hij gekoppeld is; in dit geval `C:\Users\JouwNaam`.

### Eerste stappen in de terminal

Je kunt een paar eenvoudige commando's proberen om in mappen te kijken en te zien welke bestanden en mappen daar staan:

#### macOS/Linux [mac/linux]

Laat een lijst zien van de bestanden in de huidige map:

~~~bash
ls
~~~

Ga naar je map Documents:

~~~bash
cd ~/Documents
~~~

"Ergens naartoe gaan" betekent hier: de shell aan een andere map koppelen. Als je daarna weer `ls` geeft, krijg je een lijst van de bestanden in *die* map.

#### Windows PowerShell [windows]

Laat een lijst zien van de bestanden in de huidige map:

~~~powershell
dir
~~~

Ga naar je map Documents:

~~~powershell
cd $HOME\Documents
~~~

"Ergens naartoe gaan" betekent hier: de shell aan een andere map koppelen. Als je daarna weer `dir` geeft, krijg je een lijst van de bestanden in *die* map.

### Tussen mappen bewegen

Dit is zo'n belangrijk idee dat we het nog een keer uitleggen. Je hebt gezien dat je naar een andere map kunt gaan door in de shell het commando `cd` te typen (change directory).

Dit ga je heel vaak doen, vooral als je de terminal opnieuw opstart. De shell start altijd gekoppeld aan je thuismap. Daar sla je je bestanden *niet* op! Dus je moet eerst naar de juiste map gaan voordat je iets anders doet.

Je wilt bijvoorbeeld een Python-programma `mario.py` uitvoeren dat in een map `pyprog` staat. Verderop in deze tutorial beslis je waar zulke mappen op je computer horen te staan; ga er voor nu van uit dat het volledige pad hieronder klopt.

#### macOS en Linux [mac/linux]

~~~bash
cd ~/example/pyprog
uv run mario.py
~~~

#### Windows [windows]

~~~powershell
cd C:\example\pyprog
uv run mario.py
~~~

Het tweede commando, `uv run`, zou helemaal niet werken als je niet eerst met `cd` naar de map `pyprog` was gegaan.

### Hoe de shell zich verhoudt tot normaal computergebruik

Met de shell kun je dezelfde dingen doen als met klikken, maar dan via tekstcommando's.

Bijvoorbeeld:

- een map openen → `cd mapnaam`
- bestanden opsommen → `ls` (macOS/Linux) of `dir` (Windows)
- een programma uitvoeren → typ de naam ervan

Deze handleiding gebruikt de shell omdat programmeergereedschap zoals `uv` met commando's bediend wordt.


#### Waarom dit belangrijk is

Programmeurs werken over het algemeen veel in de shell, omdat ze daarmee beter kunnen werken:

- commando's zijn precies en herhaalbaar
- je kunt instructies precies volgen zoals ze opgeschreven staan
- veel programmeergereedschap is gemaakt voor gebruik in de shell

Werken in de shell vervangt niet je normale manier van computergebruik; je voegt de shell toe als tweede manier van werken.




## uv en Python installeren

`uv` is een package- en omgevingsbeheerder voor Python. Dat betekent dat het Python voor je installeert, in de versie die je nodig hebt, met de extra software die je project vraagt. Het vervangt een aantal oudere gereedschappen die je in andere handleidingen misschien tegenkomt:

- `pip` (voor het installeren van packages)
- `venv` (voor het maken van virtuele omgevingen)
- losse Python-installatieprogramma's

In plaats van meerdere gereedschappen te leren, gebruik je **één gereedschap (uv) voor alles**. Dat heeft voordelen, maar ook nadelen. Voor nu houdt het het leren eenvoudig, en later kun je je kennis uitbreiden.

### Installeer uv nu

Open een terminal en installeer het:

#### macOS en Linux [mac/linux]

Voer het volgende commando uit in je terminal:

~~~bash
curl -LsSf https://astral.sh/uv/install.sh | sh
~~~

Sluit na de installatie je terminal en open hem opnieuw.

Controleer of het werkt:

~~~bash
uv --version
~~~

Er kunnen fouten optreden! Vraag in dat geval je docent om hulp.

#### Windows [windows]

Voer dit uit in PowerShell:

~~~powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
~~~

Open daarna PowerShell opnieuw en controleer:

~~~powershell
uv --version
~~~

### Een Python-versie installeren met `uv`

De eerste stap bij het gebruik van `uv` is het installeren van Python zelf. Je hebt een recente versie van Python nodig, en met `uv` is die heel makkelijk te krijgen.

Om bijvoorbeeld Python 3.14 te installeren:

~~~bash
uv python install 3.14
~~~

Je kunt controleren welke Python-versies er op je systeem beschikbaar zijn met:

~~~bash
uv python list
~~~

Soms staan er ook een paar oudere versies in die lijst. Dat is prima: in een latere stap stel je in dat je tijdens je vak Python 3.14 gebruikt.



## Mappen maken voor al je vakken

Nu moet je beslissen waar je vakbestanden op je computer worden opgeslagen. Waarschijnlijk heb je al een plek gemaakt voor universitair werk, bijvoorbeeld in je map `Documenten`. Misschien heb je dat al geordend, bijvoorbeeld met een map per vak.

Je eerste taak is een **aparte** map te maken waar al je **programmeergerelateerde vakbestanden** komen te staan. Dat is niet per se dezelfde map als waar ander universitair werk staat. Je gaat meerdere programmeervakken volgen, en misschien een paar projecten, dus het is goed om daar een eigen map voor te maken.

> **De belangrijkste regel van dit hele onderdeel**: zet die map **niet** in `Documenten`, op het `Bureaublad`, in `Downloads`, in `OneDrive` of in `iCloud Drive`.

### Waarom niet in Documenten, OneDrive of iCloud

Clouddiensten zoals OneDrive en iCloud Drive herschrijven, vergrendelen en downloaden voortdurend gedeeltelijk de bestanden in de mappen die ze beheren. De virtuele omgeving die je zo gaat maken bevat duizenden kleine bestanden. Als een clouddienst halverwege het synchroniseren daarvan is, werken je programma's niet meer, en de foutmeldingen die je krijgt vertellen je niet waarom.

Op Windows en macOS loop je hier makkelijk per ongeluk tegenaan, omdat `Documenten` en `Bureaublad` vaak door OneDrive of iCloud worden beheerd zonder dat je daar ooit om hebt gevraagd. Daarom is de regel: **blijf helemaal uit die mappen**, en maak één gewone map ergens anders.

> Je programmeerwerk wordt dan niet automatisch geback-upt. Back-ups maken is je eigen verantwoordelijkheid. Later in je studie leer je werken met `git`, wat dit netjes oplost.

### Goede locaties voor je werk

De juiste locatie kiezen is belangrijk omdat je je werk niet wilt kwijtraken en het makkelijk terug wilt kunnen vinden.

#### macOS en Linux [mac/linux]

Zet een map `Programming` direct in je thuismap:

- voorbeeld: `/Users/jouwnaam/Programming`, of met de afkorting geschreven: `~/Programming`

Maak hem nu aan:

~~~bash
mkdir -p ~/Programming
~~~

#### Windows [windows]

Zet een map `programming` direct op je `C:`-schijf, ver weg van alles wat OneDrive beheert:

- voorbeeld: `C:\programming`

Maak hem nu aan:

~~~powershell
mkdir C:\programming
~~~

> Als Windows weigert die map te maken, gebruik dan `mkdir $HOME\Programming` en gebruik dat pad overal hieronder. Die map wordt ook niet door OneDrive gesynchroniseerd.

### Staat je vakwerk al op de verkeerde plek?

Als je programmeerwerk in `Documenten` staat, op het `Bureaublad`, in `Downloads`, in `OneDrive`, in `iCloud Drive` of in een `Nextcloud`-map, verplaats die map dan nu naar de nieuwe locatie die je net hebt gemaakt. Gebruik daarvoor Finder of Verkenner; de map slepen is prima.

Verwijder elke `.venv`-map die je erin tegenkomt. Die hoef je niet te bewaren, en in de volgende stap maak je een verse aan.

### Een submap maken voor één vak of project

Stel dat je het volgende pad als programmeermap gebruikt:

- macOS/Linux: `~/Programming`
- Windows: `C:\programming`

Dan is het nu tijd om een submap voor een specifiek vak te maken.

#### macOS en Linux [mac/linux]

`mkdir` betekent "make directory" (maak een map).

~~~bash
mkdir -p ~/Programming/mijn-vak
cd ~/Programming/mijn-vak
~~~

#### Windows PowerShell [windows]

`mkdir` betekent "make directory" (maak een map).

~~~powershell
mkdir C:\programming\mijn-vak
cd C:\programming\mijn-vak
~~~

Vervang `mijn-vak` door de echte naam van je vak.

Gebruik eenvoudige namen zonder spaties (bijvoorbeeld: `python101`, niet `python 101`). Als je wel spaties gebruikt, wordt werken met die map heel vervelend in de shell.

Goede voorbeelden:

- `python101`
- `intro-programmeren`
- `datascience-vak`


## Een virtuele omgeving maken voor het vak

Nu je een map voor het vak hebt, maak je daarin een virtuele omgeving. Een **virtuele omgeving** bevat een Python-installatie speciaal voor dit vak of project.

Waarom dit belangrijk is:

- het houdt de packages voor dit vak gescheiden van andere vakken
- het voorkomt conflicten tussen verschillende projecten
- het maakt het makkelijker om later dezelfde installatie te reproduceren

We onderscheiden een paar mogelijkheden:

1. Je docent geeft je misschien geen enkele configuratie. In dat geval maak je een "lege" virtuele omgeving voor het vak en kun je alle packages installeren die je nodig hebt.

2. Je docent geeft je een `requirements.txt`-bestand met een lijst van packages die nodig zijn (vaak samen met een aantal andere benodigde bestanden).

3. Je docent geeft je een `pyproject.toml`, opnieuw met een lijst van packages die nodig zijn. Dat werkt net iets anders.

In de volgende onderdelen geven we instructies voor elk van deze gevallen.

### Een lege virtuele omgeving installeren [nothing]

> Volg deze instructies alleen als je géén `requirements.txt` en géén `pyproject.toml` van het vak hebt gekregen! Als je die bestanden wel hebt, volg dan de andere instructies.


#### macOS en Linux [mac/linux]

Zorg dat je **in** de vakmap zit:

~~~bash
cd ~/Programming/mijn-vak
~~~

Voer dan uit:

~~~bash
uv venv --python 3.14
~~~

#### Windows PowerShell [windows]

Zorg dat je **in** de vakmap zit:

~~~powershell
cd C:\programming\mijn-vak
~~~

Voer dan uit:

~~~bash
uv venv --python 3.14
~~~

We hebben hier de optie `--python 3.14` toegevoegd om de versie op te geven die je net hebt geïnstalleerd. Dat is handig als er meerdere Python-versies op je computer staan (en dat is waarschijnlijk zo).

### Wat doet `uv venv`?

Het commando maakt een map `.venv` in de vakmap. Die map moet blijven staan, maar je hoeft er niet in te kijken: `.venv` wordt automatisch door `uv` beheerd. Daarom:

- bewerk de bestanden erin niet met de hand
- hernoem of verplaats de map niet
- verwijder hem niet, tenzij je de omgeving opnieuw wilt aanmaken

### Installeren met `requirements.txt` [requirements]

Voer vanuit **binnen** de vakmap uit:

~~~bash
uv venv --python 3.14
~~~

We hebben hier de optie `--python 3.14` toegevoegd om de versie op te geven die je net hebt geïnstalleerd. Dat is handig als er meerdere Python-versies op je computer staan (en dat is waarschijnlijk zo).

Voer daarna uit:

~~~bash
uv pip install -r requirements.txt
~~~

Dit leest het requirements-bestand en installeert alle packages die erin genoemd worden.

Je hebt nu een map `.venv` in de vakmap. Die map moet blijven staan, maar je hoeft er niet in te kijken: `.venv` wordt automatisch door `uv` beheerd. Daarom:

- bewerk de bestanden erin niet met de hand
- hernoem of verplaats de map niet
- verwijder hem niet, tenzij je de omgeving opnieuw wilt aanmaken

### Installeren met `pyproject.toml` [pyproject]

Je hebt misschien een `zip`-bestand voor het vak gekregen, of alleen een `pyproject.toml`. Dat bestand bevat een lijst van de benodigde packages. Het kan gebruikt worden om automatisch een virtuele omgeving te maken.

Zorg dat je de bestanden uit de zip hebt uitgepakt in een geschikte vakmap, of dat je de gedownloade `pyproject.toml` daar hebt neergezet. Dan is het maar twee stappen:

~~~bash
cd ~/Programming/vak-met-project
uv sync
~~~

Het commando `sync` maakt de virtuele omgeving voor je en installeert de extra packages.

Je hebt nu een map `.venv` in de vakmap. Die map moet er staan, maar je hoeft er niet in te kijken: `.venv` wordt automatisch door `uv` beheerd. Daarom:

- bewerk de bestanden erin niet met de hand
- hernoem of verplaats de map niet
- verwijder hem niet, tenzij je de omgeving opnieuw wilt aanmaken

### Voordat je verdergaat: controleer of de omgeving bestaat

Na het opzetten van de virtuele omgeving zou je nu een mapstructuur als deze moeten hebben:

~~~text
programmeren/
└── mijn-vak/
    └── .venv/
~~~

Later kunnen je Python-bestanden ook in `mijn-vak` staan, bijvoorbeeld:

~~~text
programmeren/
└── mijn-vak/
    ├── .venv/
    ├── hello.py
    └── week1.py
~~~


## Python-programma's uitvoeren

Nu alles geïnstalleerd is, kun je de routine oppakken om je zelfgeschreven Python-programma's uit te voeren.


#### Nogmaals: werk vanuit de vakmap

Elke keer dat je aan een vak werkt, koppel je je shell aan de vakmap. Alleen dan pikt hij de packages op die je hebt geïnstalleerd.

Dus als je aan het vak werkt, begin je altijd met:

1. een terminal openen
2. naar je vakmap gaan (`cd`)
3. zo nodig naar een submap gaan
4. van daaruit commando's uitvoeren

En denk eraan, om naar je vakmap te gaan gebruik je:

~~~bash
cd ~/Programming/mijn-vak
~~~

Op Windows PowerShell:

~~~powershell
cd C:\programming\mijn-vak
~~~




## Commando's uitvoeren met `uv run`

Als je in de vakmap zit, gebruik je `uv run` om Python en gereedschap uit te voeren.

> Dit betekent dat je de virtuele omgeving **niet** handmatig hoeft te activeren. We noemen dit omdat sommige studenten al ervaring hebben met virtuele omgevingen. Meestal worden die eerst "geactiveerd" voor gebruik in de shell. Maar met `uv run` kunnen we dat voorlopig overslaan. Probeer het maar!

`uv run` zorgt ervoor dat:

- de juiste Python-versie voor dit vak gebruikt wordt
- de packages uit de omgeving van dit vak gebruikt worden
- je niet per ongeluk de systeembrede (globale) Python of packages gebruikt

Daarom gebruik je altijd de volgende werkwijze:

- ga naar de vakmap
- ga zo nodig naar een submap binnen de vakmap
- voer commando's uit met `uv run`

Voorbeeldpatroon:

~~~bash
uv run <commando>
~~~

Normaal gesproken is dat een Python-programma dat je zelf hebt geschreven, zoals:

~~~bash
uv run hello.py
~~~

Dat is alles! Je kunt `uv run` elke keer gebruiken om je programma's uit te voeren.


## Packages toevoegen aan je vakomgeving

Een **package** is een verzameling Python-code die door anderen geschreven is en die je in je eigen programma's kunt hergebruiken.

In plaats van alles vanaf nul te schrijven, installeer je packages die veelvoorkomende problemen oplossen.

Hier zijn een paar veelgebruikte packages die je kunt tegenkomen:

- `requests` – om data van internet te downloaden (bijvoorbeeld API's aanroepen)
- `numpy` – snel numeriek rekenen (arrays, wiskundige bewerkingen)
- `pandas` – werken met tabellen met data (zoals spreadsheets)
- `matplotlib` – grafieken en visualisaties maken
- `rich` – mooiere opmaak en kleuren in terminaluitvoer

Je installeert alleen de packages die je voor je vak nodig hebt.

### Globale versus lokale packages

Er zijn twee manieren om Python-packages te installeren:

- **Globale installatie**: packages worden één keer geïnstalleerd en gedeeld door je hele computer
- **Lokale installatie (virtuele omgeving)**: packages worden alleen voor één vak of project geïnstalleerd

Waarom globale installaties een probleem zijn:

- verschillende vakken hebben misschien verschillende versies van hetzelfde package nodig
- een package installeren of bijwerken kan andere projecten kapotmaken

Waarom lokale installaties beter zijn:

- elk vak heeft zijn eigen installatie
- geen conflicten tussen projecten
- makkelijker te beheren en te debuggen

In deze handleiding installeer je packages altijd **lokaal in de vakmap**.

### Packages installeren in de virtuele omgeving

Als je extra packages voor het vak nodig hebt, installeer je die vanuit **de vakmap**.

Bijvoorbeeld:

~~~bash
cd ~/Programming/mijn-vak
uv pip install requests
~~~

Dit voegt het package toe aan de omgeving van dat vak.

Je kunt ook meer dan één package tegelijk toevoegen:

~~~bash
uv pip install numpy pandas matplotlib
~~~

#### Packages toevoegen vanuit requirements [requirements]

Als je docent een `requirements.txt` heeft gegeven, hadden ze al bepaalde packages in gedachten die je nodig hebt. Voer dit commando één keer uit om de packages in je omgeving te installeren:

~~~bash
cd ~/Programming/mijn-vak
uv pip install -r requirements.txt
~~~

#### Packages toevoegen aan een project [pyproject]

Als je vak met een `pyproject.toml` werkt, moet je je package met een ander commando aan het project toevoegen:

~~~bash
cd ~/Programming/mijn-vak
uv add rich
~~~

Om projecten met `pyproject.toml` beter te begrijpen, lees je de [Projects guide](https://docs.astral.sh/uv/guides/projects/) op de website van **uv**.




## Aanbevolen werkwijze om een vak op te zetten

Voor elk nieuw vak:

- maak een nieuwe vaksubmap in je programmeermap (`~/Programming` of `C:\programming`)
- ga die submap in en maak een virtuele omgeving met `uv venv`
- bewaar je vakbestanden daar
- gebruik `uv run` vanuit die map
- voeg packages toe met `uv pip install ...` wanneer dat nodig is

### Voorbeeld van begin tot eind

#### macOS en Linux [mac/linux]

~~~bash
mkdir -p ~/Programming/python101
cd ~/Programming/python101
uv venv --python 3.14
uv pip install requests
uv run python
~~~

#### Windows PowerShell [windows]

~~~powershell
mkdir C:\programming\python101
cd C:\programming\python101
uv venv --python 3.14
uv pip install requests
uv run python
~~~

### Veelgemaakte fouten om te vermijden

Doe dit niet:

- projecten aanmaken in `Documenten`, op het `Bureaublad`, in `OneDrive` of in `iCloud Drive`
- projecten aanmaken in Downloads of andere tijdelijke mappen
- alle packages globaal installeren
- meerdere vakken in één map door elkaar zetten
- vergeten naar de vakmap te gaan voordat je commando's uitvoert


## Controleer je installatie

Weet je niet zeker of alles hierboven echt gelukt is? Plak het commando hieronder in je terminal. Het controleert of `uv` geïnstalleerd is, of het een recente genoeg Python-versie kan starten, of je een programmeermap op de juiste plek hebt, en of er geen vakwerk is achtergebleven in een map die gesynchroniseerd wordt.

#### macOS en Linux [mac/linux]

~~~bash
curl -LsSf https://www.proglab.nl/welkom/install/uv/nl/check.sh | bash
~~~

#### Windows PowerShell [windows]

~~~powershell
irm https://www.proglab.nl/welkom/install/uv/nl/check.ps1 | iex
~~~

Als er iets als mislukt of als waarschuwing wordt gemeld, los dat dan op en voer het commando opnieuw uit.

Dit is het einde van de tutorial. Als je vragen hebt, aarzel dan niet om andere studenten, je assistent, de docent of de helpdesk aan te spreken.
