---
layout: minprog
title: Minor Programmeren
---

<div class="rounded-lg border-0 d-none d-md-block"
        style="smin-height:calc(100vh - 112px - 3rem);">
    <!-- <div class="cosl-md text-center"> -->
        <img class="img-fluid roundeds-lg" style="stransform: translateX(50px) perspective(500px) rotateY(5deg);" src="{{ site.baseurl }}/assets/minprog/coding.jpeg">
    <!-- </div> -->
    <!-- <div class="d-none d-md-block col-md">
    </div> -->
</div>

<div class="row mt-md-3 my-md-5 row-cols-1 row-cols-md-2" style="">
    <div class="col">
        <img class="img-fluid rounded-lg" src="{{ site.baseurl }}/assets/minprog/eatingandcoding.jpeg">
    </div>
    <div class="col px-3 py-4 py-md-0">
        <h2 class="mb-3">Inhoud</h2>
        <p class="display-6">
            De minor Programmeren is 30 studiepunten en volg je standaard in een halfjaar. Je leert eerst uitgebreid de basis van programmeren (en meteen hoe een computer werkt), en daarna ga je je verdiepen in technieken die je nodig hebt om programmeren toe te passen in allerlei situaties.
        </p>
        <p class="display-6">
            We gebruiken de tijd om je heel veel zelf te laten programmeren, maar ook om je kennis te laten maken met de manier van werken en de taal van het vakgebied, zodat je niet alleen zelf programma's kunt schrijven, maar ook op een effectieve manier kunt samenwerken met andere programmeurs. 
        </p>
        <p class="display-6">
            Om mee te doen heb je <u>geen enkele voorkennis</u> van programmeren nodig, alleen de 
            motivatie en de tijd om vijf maanden heel hard te werken!
        </p>
        <p class="display-6">Er is ook een mogelijkheid om de vakken zelf in te plannen 
            verspreid over meerdere semesters. 
        </p>
    </div>
</div>


<div class="rounded-lg panel-bg panel-padded panel-content-50 text-light markered4 pdb">
    <div>
        <h2 class="display-4">Online lesmateriaal</h2>
        <p class="display-6">
            Voor al onze cursussen selecteren we het beste online lesmateriaal 
            om mee te leren programmeren, speciaal voor studenten zonder voorkennis.
            Het programma start met CS50, van Harvard.

        </p>
    </div>
    <div class="mt-5 pb-3 w-md-75">
        <div class="embed-responsive embed-responsive-16by9 border border-light">
            <iframe class="embed-responsive-item"  src="https://www.youtube-nocookie.com/embed/5dFxQRcsKpw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div>
</div>


<div class="row my-3 my-md-5 row-cols-1 row-cols-md-2 mb-0 mb-md-5">
    <div class="col">
        <img class="img-fluid rounded-lg" src="{{ site.baseurl }}/assets/minprog/college.jpeg">
    </div>
    <div class="col px-3 my-3 my-md-0">
        <h2 class="mb-3">Werkwijze</h2>
        <p class="display-6">
            Jouw dag bestaat uit heel veel programmeren en puzzelen, afgewisseld met
            groepsactiviteiten en videocolleges. Wij bieden je een fijne structuur om je helemaal
            te kunnen storten in het
            programmeren. Sommige opdrachten maak je met z'n twee&euml;n, maar de meeste doe je individueel, omdat we willen dat
            iedereen goed leert zelf problemen oplossen.
        </p>
        <p class="display-6">
            Je wordt daarbij ingedeeld in een team, waarmee je elke dag lief en
            leed kunt delen. Want programmeren kan, zeker in dit hoge tempo, flink frustrerend 
            zijn! Je team zal je niet alleen steunen, maar jullie denken ook met
            elkaar na over de aanpak. En je kunt elke dag terecht voor hulp bij &eacute;&eacute;n
            van de studentassistenten.
        </p>
        <p class="display-6">
            Het onderwijs vindt in normale omstandigheden op locatie in Amsterdam plaats en wordt niet online aangeboden.
        </p>
    </div>
</div>

<div class="rounded-lg panel-bg panel-padded text-light markered4 pdb p-4">
    <div class="row align-items-center">
        <div class="col-md-3">
            <img class="" src="{{ site.baseurl }}/assets/minprog/mayla-kersten.jpg" style="  object-fit: cover; height: 200px; width:200px">
        </div>
        <div class="col-md-9">
            <blockquote class="lead mt-4 mt-md-0">"Gelukkig heb ik me niet laten afschrikken, want ik vond het zó interessant. Zeker, de werkdruk is best pittig, maar je leert uitgebreid de basis van het programmeren."</blockquote>
            <p>
                Mayla &mdash; oud-student en daarna assistent van de minor
            </p>
        </div>
    </div>
</div>

<div class="panel panel-padded  rounded-lg text-center bg-light mb-0" style="">
    
    <h2 class="display-3 markesred px-4 mb-5 pt-3 pb-0">Vakken</h2>
    
    <p class="display-6 w-50 mx-auto">Dit zijn de vakken die je volgt tijdens de Minor Programmeren. Elk vak is 6 studiepunten, dus kost je ongeveer 160 uur aan gefocust studeren.
        De meeste studenten vinden onze vakken zwaarder dan die van hun eigen opleiding (maar ook leuker!).</p>

    <div class="w-75-centered mt-5 text-left ">
        <div class="row row-cols-1 row-cols-md-2">
        {% assign courses = site.courses | sort: "order" %}
        {% for course in courses %}
        {% if course.curriculum == "Minor Programmeren" %}
        <div class="col mb-4 px-0 px-md-3">
            <div class="card mb-3 bg-transparent border-0 h-100" style="smax-width: 540px;">
                <div class="card-body">
                    <h5 class="card-title mb-0">{{ course.name }}</h5>
                    <p class="text-muted small">{{ course.periode }}</p>
                    <p class="card-text mt-3">{{ course.content | markdownify }}</p>
                    {% for speed in course.info %}
                    <!--p class="card-text mb-1">
                        <a href="{{ speed.studiegids }}">Studiegids {{ speed.speed | capitalize }} &rarr;</a>
                    </p-->
                    {% endfor %}
                    <!-- <p class="text-muted">Niveau: {{ course.niveau }}</p> -->
                </div>
            </div>
        </div>  
        {% endif %}
        {% endfor %}
        </div>
    </div>

    <h3 class="display-4 markesred px-4 mb-5 pt-3 pb-0">Planning</h3>
    
    <p class="display-6 w-50 mx-auto">
        Alle vakken worden zowel in semester 1 als in semester 2 aangeboden.
        Als je de hele minor in één semester wil doen, dan kun je je gewoon voor alle vakken inschrijven. Wil je parttime doen, dan schrijf je je eerst in voor de vakken Programmeren 1 en 2, en in het volgende semester voor de overige vakken.
    </p>

    <p class="my-5"><img src="{{ site.baseurl }}/assets/minprog/vakken@2x.png" style="width:100%"></p>

    <p class="display-6 w-50 mx-auto">
         Let op: het laatste vak (Algoritmen en Heuristieken) is in alle gevallen een fulltime-vak waarbij je overdags geen andere vakken of werk kunt plannen. Dit geldt dus ook als je de vakken verspreidt over meerdere semesters.
    </p>

</div>


<div class="panel-bg panel-padded panel-content-50">
    <h2 class="display-3 marksered px-4 mb-5 pt-3 pb-0">Regels en Toelating</h2>
    <h3 class="mt-4 mb-3">Aanwezigheid minor</h3>
    <p class="display-6">
        Als je de hele minor in &eacute;&eacute;n semester wil doen dan moet je rekening houden
        met een verplichte dagelijkse aanwezigheid en werkgroepen. Gezien de werkdruk is het niet mogelijk om
        andere vakken te volgen die overdags geroosterd zijn. Je krijgt dus ook geen uitzondering
        voor het bijwonen van andere colleges en wij houden hiermee geen rekening in de groepsindeling.
    </p>
    <h3 class="mt-4 mb-3">Aanwezigheid losse vakken</h3>
    <p class="display-6">
    Doe je de minor verspreid over meerdere semesters,
        dan zul je enkele verplichte werkgroepen per week hebben. Hiervoor worden bij de start
        verschillende opties aangeboden zodat je het om je andere vakken heen kunt plannen.
        Het laatste vak, Algoritmen en Heuristieken, is 
        wel altijd een fulltime-vak, dus daar kun je geen andere vakken naast volgen.
    </p>
    <h3 class="mt-4 mb-3">Toelatingseisen</h3>
    <p class="display-6">
        De minor Programmeren is toegankelijk voor studenten van universiteit en hbo; mocht je nog geen derdejaars-student zijn bij de start van de minor, mail dan even voor overleg. Studenten uit het vakgebied van de ICT (met veel programmeren in het curriculum) kunnen niet meedoen met deze minor.
    </p>
    <h3 class="mt-4 mb-3">Beschikbare plekken</h3>
    <p class="display-6">
        We hebben nog nooit eerder studenten hoeven weigeren. Door omstandigheden (zoals Corona) kan het
        toch zijn dat we een limiet stellen. In dat geval zal de aanmelding worden gesloten
        en zullen we per mail uitleggen hoe we de plekken verdelen. Het is daarom altijd belangrijk om een plan B te hebben, zelfs al wil je gewoon héél graag deze minor doen.
    </p>
    <h3 class="mt-4 mb-3">Bijvak</h3>
    <p class="display-6">
        Studeer je nog niet aan de UvA? Dan kun je meestal bijvakker worden zonder extra collegegeld te betalen. Let op dat je voor inschrijving als bijvakker wel een vwo-diploma met wiskunde moet hebben, of een hbo-propedeuse. Na je aanmelding helpen we je door alle benodigde stappen heen.
        De toelatingsprocedure voor niet-UvA-studenten kan een maand in beslag nemen dus 
        je moet in dit geval uiterlijk 6 weken van tevoren je aanmelding starten.
    </p>
    <h3 class="mt-4 mb-3">Benodigdheden</h3>
    <p class="display-6">
        Om mee te doen aan deze minor heb je een eigen laptop nodig. Dit hoeft geen
        gloednieuw exemplaar te zijn. Mac, Windows of Linux zijn allemaal prima. Sommige Chromebooks zijn ook geschikt. Een goedwerkende
        wifi-verbinding is wel heel belangrijk. Aanwezigheid is verplicht dus alleen thuis
        een computer hebben is niet voldoende. Mocht je budget-problemen hebben (of acuut een
         kapotte laptop), neem dan contact met ons op en leg gerust je situatie uit. We helpen je dan verder.
    </p>

    <h3 class="mt-4 mb-3">Jaarindeling en startdata 2023&mdash;2024</h3>
    <p class="display-6">
        Het eerste semester loopt van 4 september t/m 2 februari, en het tweede semester loopt van 5 februari t/m 28 juni.
        <ul>
            <li>Als je een complete minor doet, dan duurt deze altijd van de eerste tot en met de laatste dag van het semester.</li>
            <li>Let op dat in het eerste semester <u>geen</u> herfstvakantie is ingeroosterd, zoals bij sommige andere opleidingen.</li>
            <li>In het tweede semester is de meivakantie van 27 april t/m 4 mei. Alle andere weken zijn lesweken.</li>
            <li>Vraag vooraf advies als je om bijzondere redenen afwezig gaat zijn. We kunnen dan een schatting maken of dit werkbaar is en hoeveel punten je gaat missen.</li>
        </ul>
    </p>
</div>


<div class="rounded-lg py-5 min-vh-75 v-center text-center markered3">
    <div class="px-4">
        <h2 class="display-2 text-center mb-4 text-lisght">Aanmelden</h2>
        <ol class="w-50 mx-auto text-left">
            <li>
                <p class="" style="font-size:1.2rem;">
                    Om je aan te melden voor de Minor Programmeren in studiejaar <b>2023-2024</b> vul je eerst een vrijblijvende vooraanmelding in. Voor deze minor is er geen selectie
                    dus je krijgt geen reactie. Je mag er in normale omstandigheden van uit gaan 
                    dat je direct geplaatst bent.
                </p>
                <p class="mb-5">
                    <a class="btn btn-outline-dark btn-lg" href="https://forms.office.com/Pages/ResponsePage.aspx?id=zcrxoIxhA0S5RXb7PWh05StZDK23dCxCgrv7HMsauLFUQlFXMkhDRUdFNlpSMTdLS1VSMFlYSVU1Ny4u" target="_blank">Start vooraanmelding</a>
                </p>
            </li>
            <li>
                <p style="font-size:1.2rem;">
                    Ben je nog geen UvA-student, maar wel bij een andere instelling voor hoger
                    onderwijs? Dan kun je je direct gaan aanmelden als bijvakker bij 
                    de UvA. Je kiest voor de aanmelding de opleiding <strong>Informatiekunde (bijvak/electives)</strong>.
                </p>
                <p class="mb-5">
                    <a class="btn btn-outline-dark btn-lg" href="https://www.uva.nl/onderwijs/bachelor/minors/minors.html" target="_blank">Schrijf je in als bijvakker</a>
                </p>
            </li>
            <li>
                <p class="mb-5" style="font-size:1.2rem;">
                    Ben je nog helemaal geen student bij een opleiding in het hoger onderwijs dan kun je contractstudent worden. Dit kost vaak
                    1200 euro per vak van 6 studiepunten. Wil je dit doen, dan kun je een 
                    <a href="mailto:help@mprog.nl">mail sturen</a> en we helpen je verder.
                    Wie al een bachelor volgt in het hoger onderwijs betaalt echter niets
                    extra voor een bijvakinschrijving zoals genoemd bij het vorige punt.
                </p>
            </li>
            <li>
                <p style="font-size:1.2rem;">
                    Tot slot kun je je definitief inschrijven voor de minorvakken.
                    Dit kan tijdens de normale vakinschrijving van de UvA <strong>tussen 4 december en 11 december 13:00</strong>. Ook na deze periode kun je je nog inschrijven, tot de start van het vak.
                </p>
                <p style="font-size:1.2rem;">
                    Gebruik de volgende links om de vakken toe te voegen aan de vakinschrijving. Dit werkt ook pas goed vanaf de genoemde datum.
                    <ul style="list-style-type:none; padding-left:0">
                        <li><a class="btn btn-outline-dark btn-lg mb-3" href="https://glass.uva.nl/planning-board/add?id=50621PRP6Y">
                            Aanmelden Programmeren 1
                        </a></li>
                        <li><a class="btn btn-outline-dark btn-lg mb-3" href="https://glass.uva.nl/planning-board/add?id=50622PRP6Y">
                            Aanmelden Programmeren 2
                        </a></li>
                        <li><a class="btn btn-outline-dark btn-lg mb-3" href="https://glass.uva.nl/planning-board/add?id=5062DATT6Y">
                            Aanmelden Datarepresentaties
                        </a></li>
                        <li><a class="btn btn-outline-dark btn-lg mb-3" href="https://glass.uva.nl/planning-board/add?id=5062PRPR6Y">
                            Aanmelden Programmeerproject
                        </a></li>
                        <li><a class="btn btn-outline-dark btn-lg mb-3" href="https://glass.uva.nl/planning-board/add?id=5062ALHE6Y">
                            Aanmelden Algoritmen en Heuristieken
                        </a></li>
                    </ul>
                </p>
                <p class="mb-5">
                    <a class="btn btn-outline-dark btn-lg" href="https://glass.uva.nl/" target="_blank">Ga naar GLASS om je inschrijvingen te beheren</a>
                </p>
            </li>
            <li>
                <p style="font-size:1.2rem;">
                    Na inschrijving ontvang je begin januari meer (praktische) informatie over de start van de
                    minor en de eerste vakken. Dit geldt ook voor de roosters, die niet eerder
                    bekend gemaakt kunnen worden. Voor fulltime geldt sowieso: elke dag aanwezig.
                </p>
            </li>
        </ol>
    </div>
</div>


<div class="panel-bg panel-padded panel-content-50">
    <h2 class="display-4">Vragen</h2>
    <p class="display-6">
        Heb je nog vragen? Stuur een e-mail naar <a href="mailto:help@mprog.nl">help@mprog.nl</a>. E&eacute;n van de docenten of assistenten zal je te woord staan.
    </p>
</div>

