---
layout: minprog
title: Minor Programmeren
---

<div class="rounded-lg border-0"
        style="min-height:calc(100vh - 112px - 3rem);">
    <div class="cosl-md text-center">
        <img class="img-fluid" style="stransform: translateX(50px) perspective(500px) rotateY(5deg);" src="{{ site.baseurl }}/assets/minprog/ide.png">
    </div>
    <div class="d-none d-md-block col-md">
    </div>
</div>

<div class="row mt-3 my-md-5 row-cols-1 row-cols-md-2" style="">
    <div class="col">
        <img class="img-fluid rounded-lg" src="{{ site.baseurl }}/assets/minprog/bots.jpeg">
    </div>
    <div class="col px-4 px-md-3 py-4 py-md-0">
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
    </div>
</div>


<div class="rounded-lg panel-bg panel-padded panel-content-50 text-light markered4 pdb">
    <div>
        <h2 class="display-4">Online lesmateriaal</h2>
        <p class="display-6">
            Voor al onze cursussen selecteren we het beste online lesmateriaal 
            om mee te leren programmeren, speciaal voor studenten zonder voorkennis.

        </p>
    </div>
    <div class="mt-5 pb-3 w-md-75">
        <div class="embed-responsive embed-responsive-16by9 border border-light">
            <iframe class="embed-responsive-item"  src="https://www.youtube-nocookie.com/embed/5dFxQRcsKpw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div>
</div>


<div class="row my-3 my-md-5 row-cols-1 row-cols-md-2 mb-5">
    <div class="col">
        <img class="img-fluid rounded-lg" src="{{ site.baseurl }}/assets/minprog/college.jpeg">
    </div>
    <div class="col px-4 px-md-3 my-4 my-md-0">
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

<div class="panel panel-padded  rounded-lg text-center bg-light mb-0" style="">
    
    <h2 class="display-3 markesred px-4 mb-5 pt-3 pb-0">Vakken</h2>
    
    <p class="display-6 w-50 mx-auto">Dit zijn de vakken die je volgt tijdens de Minor Programmeren. Elk vak is 6 studiepunten, dus kost je ongeveer 160 uur aan gefocust studeren.
        De meeste studenten vinden onze vakken veel zwaarder dan die van hun eigen opleiding (maar ook leuker!).</p>

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
                    <p class="text-muted">Niveau: {{ course.niveau }}</p>
                </div>
            </div>
        </div>  
        {% endif %}
        {% endfor %}
        </div>
    </div>

    <p class="display-6 w-50 mx-auto">Als je de hele minor in één semester wil doen, dan kun je je gewoon voor alle vakken inschrijven. Wil je parttime doen, dan volg je eerst Programmeren 1 en 2, en in het volgende semester de overige vakken. Let op: het laatste vak (Algoritmen en Heuristieken) is in alle gevallen een fulltimevak waarbij je overdags geen andere vakken of werk kunt plannen.</p>


</div>


<div class="panel-bg panel-padded panel-content-50">
    <h2 class="display-3 marksered px-4 mb-5 pt-3 pb-0">Regels en Toelating</h2>
    <h3 class="mt-4 mb-3">Aanwezigheid Fulltime</h3>
    <p class="display-6">
        Als je de hele minor in &eacute;&eacute;n semester wil doen dan moet je rekening houden
        met een verplichte dagelijkse aanwezigheid en werkgroepen. Gezien de werkdruk is het niet mogelijk om
        andere vakken te volgen die overdags geroosterd zijn. Je krijgt dus ook geen uitzondering
        voor het bijwonen van andere colleges en wij houden hiermee geen rekening in de groepsindeling.
    </p>
    <h3 class="mt-4 mb-3">Aanwezigheid Parttime</h3>
    <p class="display-6">
    Doe je de minor verspreid over meerdere semesters,
        dan zul je enkele verplichte werkgroepen per week hebben. Hiervoor worden bij de start
        verschillende opties aangeboden zodat je het om je andere vakken heen kunt plannen.
        Het laatste vak, Algoritmen en Heuristieken, is 
        altijd een fulltime-vak, dus daar kun je geen andere vakken naast volgen.
    </p>
    <h3 class="mt-4 mb-3">Toelatingseisen</h3>
    <p class="display-6">
        De minor Programmeren is toegankelijk voor studenten uit het derde jaar of hoger van universiteit en hbo (we checken het aantal EC dat je gehaald hebt; mocht je studiepunten missen, mail dan even voor overleg). Studenten uit het vakgebied van de ICT kunnen niet meedoen met deze minor. Kom je van het hbo, kijk dan ook eens bij <a href="https://www.kiesopmaat.nl/modules/31fr/-/141551/">deze minor</a> met vergelijkbare inhoud, maar specifiek op hbo-niveau.
    </p>
    <h3 class="mt-4 mb-3">Beschikbare plekken</h3>
    <p class="display-6">
        In principe is er op dit moment onbeperkt plek. Door omstandigheden (zoals Corona) kan het
        toch zijn dat we een limiet stellen. In dat geval zal de aanmelding worden gesloten
        en zullen we per mail uitleggen hoe we de plekken verdelen. Het is daarom altijd belangrijk om een plan B te hebben, zelfs al wil je gewoon héél graag deze minor doen. Het is niet mogelijk een plek te reserveren.
    </p>
    <h3 class="mt-4 mb-3">Bijvak</h3>
    <p class="display-6">
        Studeer je nog niet aan de UvA? Dan kun je meestal bijvakker worden zonder extra collegegeld te betalen. Let op dat je voor inschrijving als bijvakker wel een vwo-diploma met wiskunde moet hebben, of een hbo-propedeuse. Na je aanmelding helpen we je door alle benodigde stappen heen.
        De toelatingsprocedure voor niet-UvA-studenten kan meer dan een maand in beslag nemen dus 
        je dan uiterlijk 2 maanden van tevoren je aanmelding starten.
    </p>
    <h3 class="mt-4 mb-3">Benodigdheden</h3>
    <p class="display-6">
        Om mee te doen aan deze minor heb je een eigen laptop nodig. Dit hoeft geen
        gloednieuw exemplaar te zijn. Mac, Windows of Linux zijn allemaal prima. Een goedwerkende
        wifi-verbinding is wel heel belangrijk. Aanwezigheid is verplicht dus alleen thuis
        een computer hebben is niet voldoende. Mocht je budget-problemen hebben (of acuut een
         kapotte laptop), neem dan contact met ons op en leg gerust je situatie uit. Waarschijnlijk
        kunnen we wel een oplossing bedenken.
    </p>

    <h3 class="mt-4 mb-3">Jaarindeling en startdata</h3>
    <p class="display-6">
        Het eerste semester loopt van 5 september t/m 3 februari, en het tweede semester loopt van 6 februari t/m 30 juni. Als je een complete minor doet, dan duurt deze altijd van de eerste tot en met de laatste dag van het semester. Let op dat in het eerste semester <u>geen</u> herfstvakantie is ingeroosterd, zoals bij sommige andere opleidingen. Een complete kalender van het academisch jaar 2022-2023 <a href="https://www.uva.nl/onderwijs/bachelor/praktische-zaken/academische-kalender/academische-kalender.html">vind je hier</a>.
    </p>
</div>


<div class="rounded-lg py-5 min-vh-75 v-center text-center markered3">
    <div class="px-4">
        <h2 class="display-2 text-center mb-4 text-lisght">Aanmelden</h2>
        <p class="w-50 mx-auto mb-5" style="font-size:1.2rem;">
            Om je aanmelding voor de minor Programmeren te starten vul je eerst je persoonlijke gegevens in. Daarna helpen we je verder met alle stappen van je aanmelding. Er is nog voldoende ruimte!
        </p>
        <p class="mb-5">
            <a class="btn btn-outline-dark btn-lg">Aanmelden kan binnenkort weer</a>
        </p>
        <!--p class="mb-0 w-75 mx-auto">
            Aanmelden voor het eerste semester van studiejaar 2021/2022 kan vanaf 1 mei. Inschrijving voor de vakken kan vervolgens vanaf 11 juni, tijdens de normale vakinschrijving van de UvA.
        </p-->
    </div>
</div>


<div class="panel-bg panel-padded panel-content-50">
    <h2 class="display-4">Vragen</h2>
    <p class="display-6">
        Heb je nog vragen? Stuur een e-mail naar <a href="mailto:help@mprog.nl">help@mprog.nl</a>. E&eacute;n van de docenten of assistenten zal je te woord staan.
    </p>
</div>

