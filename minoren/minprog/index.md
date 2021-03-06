---
layout: minprog
title: Minor Programmeren
---

<div class="position-relative text-center d-flex flex-column justify-content-center"
        style="min-height:calc(100vh - 112px);">
    <div class="my-5">
        <img class="img-fluid" style="max-width:30vw" src="{{ site.baseurl }}/assets/logos/programmeren.svg">
    </div>
    <div>
        <h1 class="display-4 d-inline" style="font-size:5.5rem;">Minor Programmeren</h1>
        <h1 class="mt-3" style="font-size:1.5rem;"><small>Leer in vijf maanden programmeren en maak kennis met de basis van informatica</small></h1>
    </div>
</div>


<div class="row my-5 row-cols-1 row-cols-md-2" style="">
    <div class="col">
        <img class="img-fluid" src="{{ site.baseurl }}/assets/minprog/bots.jpeg">
    </div>
    <div class="col">
        <h1>Inhoud</h1>
        <p class="display-6">
            De minor Programmeren is 30 studiepunten en volg je standaard in een halfjaar. Je leert eerst uitgebreid de basis van programmeren (en meteen hoe een computer werkt), daarna ga je je specialiseren in het ontwikkelen van webapplicaties of wetenschappelijk programmeren.
        </p>
        <p class="display-6">
            We gebruiken de tijd om je heel veel zelf te laten programmeren, maar ook om je kennis te laten maken met de manier van werken en de taal van het vakgebied, zodat je niet alleen zelf programma's kunt schrijven, maar ook op een effectieve manier kunt samenwerken met andere programmeurs. 
        </p>
        <p class="display-6">
            Om mee te doen heb je geen enkele voorkennis van programmeren nodig, alleen een 
            motivatie om vijf maanden heel hard te werken!
        </p>
    </div>
</div>


<div class="panel-bg panel-padded panel-content-50 text-light" style="background-color:#0E1F2B;">
    <div>
        <h1 class="display-4">Online lesmateriaal</h1>
        <p class="display-6">
            Voor al onze cursussen selecteren we het beste online lesmateriaal 
            om mee te leren programmeren, speciaal voor studenten zonder voorkennis.

        </p>
    </div>
    <div class="mt-5 w-md-75">
        <div class="embed-responsive embed-responsive-16by9 border border-light">
            <iframe class="embed-responsive-item"  src="https://www.youtube-nocookie.com/embed/5dFxQRcsKpw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div>
</div>


<div class="row my-5 row-cols-1 row-cols-md-2" style="">
    <div class="col">
        <img class="img-fluid" src="{{ site.baseurl }}/assets/minprog/college.jpeg">
    </div>
    <div class="col">
        <h1>Werkwijze</h1>
        <p class="display-6">
            Jouw dag bestaat uit heel veel programmeren en puzzelen, afgewisseld met
            groepsactiviteiten en videocolleges. Wij bieden je een fijne structuur om je helemaal
            te kunnen storten in het
            programmeren. De opdrachten zijn in het begin juist individueel, omdat we willen dat
            iedereen goed leert zelf problemen oplossen.
        </p>
        <p class="display-6">
        
            Maar dat betekent niet dat je het helemaal
            in je eentje moet doen! Je wordt ingedeeld in een team, waarmee je elke dag lief en
            leed kunt delen. Want programmeren kan, zeker in dit hoge tempo, flink frustrerend 
            zijn! Je team zal je niet alleen steunen, maar jullie denken ook met
            elkaar na over de aanpak. En je kunt elke dag terecht voor hulp bij &eacute;&eacute;n
            van de studentassistenten.
        </p>
    </div>
</div>


<div class="row my-4" style="">
    <div class="col">
        <h1>Fulltime of parttime</h1>
        <p class="display-6">
            Wil je de minor in &eacute;&eacute;n semester doen, dan is dit <strong>fulltime</strong> en zul je
            vijf dagen per week van 9 tot 5 met de minor bezig zijn. Er is dan dus geen tijd
            voor bijbaantjes en andere vakken! Een keuze die je bewust moet maken. Je studeert
            dagelijks samen met je team, waar mogelijk op locatie en anders met een videoverbinding.
        </p>
        <p class="display-6">
            Wil je de minor verspreiden over meer dan vijf maanden, dan kun je de meeste vakken <strong>parttime</strong> volgen. We gaan
            er vanuit dat je zo'n 20 uur per week aan de vakken kwijt bent. Dat is nog steeds een
            flinke last! Een deel van die tijd ga je aan de slag met je team van medestudenten en
            woon je het mentoraat bij. Wekelijkse deadlines en laten zien van je programma's
            horen er ook bij.
        </p>
    </div>
    <div class="col">
        <img class="img-fluid" src="{{ site.baseurl }}/assets/home/bots.jpeg">
    </div>
</div>


<div class="panel panel-padded text-center bg-light mb-0" style="">
    
    <h1 class="display-4">Vakken</h1>
    
    <p class="display-6 w-50 mx-auto">Dit zijn de vakken die je volgt tijdens de Minor Programmeren. Elk vak is 6 studiepunten, dus ongeveer 160 uur aan studietijd.</p>

    <div class="w-75-centered mt-5 text-left ">
        <div class="row row-cols-1 row-cols-md-2">
        {% assign courses = site.courses | sort: "order" %}
        {% for course in courses %}
        {% if course.curriculum == "Minor Programmeren" %}
        <div class="col mb-4 px-0 px-md-3">
            <div class="card mb-3 bg-light border-0 h-100" style="smax-width: 540px;">
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
    <h1 class="display-4">Toelating</h1>
    <p class="display-6">
        De minor Programmeren is toegankelijk voor studenten van universiteit en soms ook hbo uit het derde jaar of hoger (maar niet voor studenten uit het vakgebied van de ICT). Studeer je nog niet aan de UvA? Dan kun je bijvakker worden zonder extra collegegeld te betalen. Let op dat je voor inschrijving als bijvakker wel een vwo-diploma of een hbo-propedeuse moet hebben. Na je aanmelding helpen we je door alle benodigde stappen heen.
    </p>
    
    <h2>Benodigdheden</h2>
    <p class="display-6">
        Om mee te doen aan deze minor heb je een eigen laptop nodig. Dit hoeft geen
        gloednieuw exemplaar te zijn. Mac, Windows of Linux zijn allemaal prima. Een goedwerkende
        wifi-verbinding is wel heel belangrijk.
    </p>

    <h2>Jaarindeling en startdata</h2>
    <p class="display-6">
        Het eerste semester loopt van 31 augustus t/m 29 januari, en het tweede semester loopt van 1 februari t/m 25 juni. Als je een complete minor doet, dan duurt deze altijd van de eerste tot de laatste dag van het semester. Let op dat in het eerste semester geen herfstvakantie is. Een complete kalender van het academisch jaar 2020-2021 <a href="https://www.uva.nl/onderwijs/bachelor/praktische-zaken/academische-kalender/academische-kalender.html">vind je hier</a>.
    </p>
</div>


<div class=" min-vh-75 v-center text-center bg-warning">
    <div class="px-4">
        <h1 class="display-3 text-center mb-4">Aanmelden</h1>
        <p class="w-50 mx-auto mb-5" style="font-size:1.2rem;">
            Om je aanmelding te starten voor de minor Programmeren vul je eerst op deze website je gegevens in. Daarna helpen we je verder met alle stappen van je aanmelding.
            Er vindt geen selectie plaats, dus als je je aanmeldt via deze site en daarna ingeschreven bent voor de UvA en voor de minorvakken, dan ben je verzekerd van een plek (calamiteiten uitgezonderd).
        </p>
        <p>
            Aanmelden voor 2020/2021 semester 2 is niet meer mogelijk.
        </p>
        <p class="mb-0">
            <a class="btn btn-outline-dark btn-lg disabled">Aanmelden voor het tweede semester</a>
        </p>
    </div>
</div>


<div class="panel-bg panel-padded panel-content-50">
    <h1 class="display-4">Vragen</h1>
    <p class="display-6">
        Heb je nog vragen? Stuur een e-mail naar <a href="mailto:help@mprog.nl">help@mprog.nl</a>. E&eacute;n van de docenten of assistenten zal je te woord staan.
    </p>
</div>

