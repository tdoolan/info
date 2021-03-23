---
layout: minprog
title: Minor Programmeren
---

<div class="rounded position-relative text-center d-flex flex-column justify-content-center markered3 p-3"
        style="min-height:calc(100vh - 112px - 1rem);">
    <!--div class="my-5">
        <img class="img-fluid" style="max-width:30vw" src="{{ site.baseurl }}/assets/logos/programmeren.svg">
    </div-->
    <div class="p-3">
        <h1 class="display-1 d-inline">Minor<br> Program<br>meren</h1>
        <h1 class="mt-5" style="font-size:1.5rem;"><small>Leer in vijf maanden programmeren en maak kennis met de basis van informatica en software engineering.</small></h1>
    </div>
</div>


<div class="row mt-3 my-md-5 row-cols-1 row-cols-md-2" style="">
    <div class="col">
        <img class="img-fluid rounded" src="{{ site.baseurl }}/assets/minprog/bots.jpeg">
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
            Om mee te doen heb je geen enkele voorkennis van programmeren nodig, alleen de 
            motivatie en de tijd om vijf maanden heel hard te werken!
        </p>
    </div>
</div>


<div class=" rounded panel-bg panel-padded panel-content-50 text-light markered4 pdb">
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


<div class="row my-3 my-md-5 row-cols-1 row-cols-md-2">
    <div class="col">
        <img class="img-fluid rounded" src="{{ site.baseurl }}/assets/minprog/college.jpeg">
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
            Je wordt daarnaast ingedeeld in een team, waarmee je elke dag lief en
            leed kunt delen. Want programmeren kan, zeker in dit hoge tempo, flink frustrerend 
            zijn! Je team zal je niet alleen steunen, maar jullie denken ook met
            elkaar na over de aanpak. En je kunt elke dag terecht voor hulp bij &eacute;&eacute;n
            van de studentassistenten.
        </p>
    </div>
</div>


<div class="row my-3 my-md-4 row-cols-1 row-cols-md-2">
    <div class="col text-left text-md-right px-4 px-md-3 my-4 my-md-0">
        <h2 class="mb-3">Fulltime of parttime</h2>
        <p class="display-6">
            Wil je de minor in &eacute;&eacute;n semester doen, dan is dit <strong>fulltime</strong> en zul je
            vijf dagen per week van 9 tot 5 met de minor bezig zijn. Er is dan dus geen tijd
            voor bijbaantjes en andere vakken! Een keuze die je bewust moet maken. Je studeert
            dagelijks samen met je team, waar mogelijk op locatie, en anders met een videoverbinding.
        </p>
        <p class="display-6">
            Wil je de minor verspreiden over meer dan vijf maanden, dan kun je de meeste vakken <strong>parttime</strong> volgen. We gaan
            er vanuit dat je zo'n 20 uur per week kwijt bent aan de vakken. Dat is nog steeds een
            flinke last! Een deel van die tijd ga je aan de slag met je team van medestudenten en
            woon je het mentoraat bij. Wekelijkse deadlines horen er ook bij.
        </p>
    </div>
    <div class="col">
        <img class="img-fluid rounded" src="{{ site.baseurl }}/assets/home/bots.jpeg">
    </div>
</div>


<div class="panel panel-padded  rounded text-center bg-light mb-0" style="">
    
    <h2 class="display-4 markered mb-5">Vakken</h2>
    
    <p class="display-6 w-50 mx-auto">Dit zijn de vakken die je volgt tijdens de Minor Programmeren. Elk vak is 6 studiepunten, dus kost je ongeveer 160 uur aan gefocuste studie.
        De meeste studenten vinden onze vakken zwaarder dan die van hun eigen studie (maar ook leuker!).</p>

    <div class="w-75-centered mt-5 text-left ">
        <div class="row row-cols-1 row-cols-md-2">
        {% assign courses = site.courses | sort: "order" %}
        {% for course in courses %}
        {% if course.curriculum == "Minor Programmeren" %}
        <div class="col mb-4 px-0 px-md-3">
            <div class="card mb-3 bg-transparent border-0 h-100" style="smax-width: 540px;">
                <div class="card-body">
                    <h5 class="card-title mb-0">{{ course.name }}</h5>
                    <p class="text-muted">Niveau: {{ course.niveau }}</p>
                    <p class="card-text mt-3">{{ course.content | markdownify }}</p>
                    {% for speed in course.info %}
                    <p class="card-text mb-1">
                        <a href="{{ speed.studiegids }}">Studiegids {{ speed.speed | capitalize }} &rarr;</a>
                    </p>
                    {% endfor %}
                </div>
            </div>
        </div>  
        {% endif %}
        {% endfor %}
        </div>
    </div>

</div>


<div class="panel-bg panel-padded panel-content-50">
    <h2 class="display-4 mb-4 markered text-center w-auto mx-auto">Toelating</h2>
    <p class="display-6">
        De minor Programmeren is toegankelijk voor studenten uit het derde jaar of hoger van universiteit en soms ook hbo (maar niet voor studenten uit het vakgebied van de ICT). We geven les op academisch niveau.
    </p>
    <h3 class="mt-4 mb-3">Bijvak</h3>
    <p class="display-6">
        Studeer je nog niet aan de UvA? Dan kun je meestal bijvakker worden zonder extra collegegeld te betalen. Let op dat je voor inschrijving als bijvakker wel een vwo-diploma of een hbo-propedeuse moet hebben. Na je aanmelding helpen we je door alle benodigde stappen heen.
        De toelatingsprocedure voor niet-UvA-studenten kan meer dan een maand in beslag nemen.
    </p>
    
    <h3 class="mt-4 mb-3">Benodigdheden</h3>
    <p class="display-6">
        Om mee te doen aan deze minor heb je een eigen laptop nodig. Dit hoeft geen
        gloednieuw exemplaar te zijn. Mac, Windows of Linux zijn allemaal prima. Een goedwerkende
        wifi-verbinding is wel heel belangrijk.
    </p>

    <h3 class="mt-4 mb-3">Jaarindeling en startdata</h3>
    <p class="display-6">
        Het eerste semester loopt van 6 september t/m 4 februari, en het tweede semester loopt van 7 februari t/m 1 juli. Als je een complete minor doet, dan duurt deze altijd van de eerste tot en met de laatste dag van het semester. Let op dat in het eerste semester geen herfstvakantie is ingeroosterd, zoals bij sommige andere opleidingen. Een complete kalender van het academisch jaar 2021-2022 <a href="https://www.uva.nl/onderwijs/bachelor/praktische-zaken/academische-kalender/academische-kalender.html">vind je hier</a>.
    </p>
</div>


<div class=" rounded py-5 min-vh-75 v-center text-center markered3">
    <div class="px-4">
        <h2 class="display-3 text-center mb-4 text-light">Aanmelden</h2>
        <p class="w-50 mx-auto mb-5" style="font-size:1.2rem;">
            Om je aanmelding voor de minor Programmeren te starten vul je eerst op deze website je gegevens in. Daarna helpen we je verder met alle stappen van je aanmelding.
            Er vindt geen selectie plaats, dus als je je aanmeldt via deze site en daarna je inschrijving bij de UvA en voor de minorvakken voltooit, dan ben je verzekerd van een plek (uitgezonderd calamiteiten).
        </p>
        <p class="mb-5 w-50 mx-auto">
            Aanmelden voor semester 1 van studiejaar 2021/2022 kan vanaf medio april. Inschrijving voor de vakken kan vanaf eind mei. Hou deze website in de gaten.
        </p>
        <p class="mb-0">
            <a class="btn btn-outline-dark btn-lg disabled">Aanmelden is nu niet mogelijk</a>
        </p>
    </div>
</div>


<div class="panel-bg panel-padded panel-content-50">
    <h2 class="display-4">Vragen</h2>
    <p class="display-6">
        Heb je nog vragen? Stuur een e-mail naar <a href="mailto:help@mprog.nl">help@mprog.nl</a>. E&eacute;n van de docenten of assistenten zal je te woord staan.
    </p>
</div>

