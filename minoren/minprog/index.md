---
layout: minprog
title: Minor Programmeren
---

<div class="panel panel-75vh  position-relative text-center d-flex flex-column" style="height:75vh">
    <img class="mb-5 img-fluid d-block" src="{{ site.baseurl }}/assets/logos/programmeren.svg">
    <div>
        <h1 class="display-4 d-inline" style="font-size:5.5rem;">Minor Programmeren</h1>
        <h1 class="" style="font-size:1.5rem;"><small>Leer in vijf maanden programmeren en ...</small></h1>
    </div>
</div>


We gebruiken de tijd om je heel veel zelf te laten programmeren, maar ook om je kennis te laten maken met de manier van werken en de taal van het vakgebied, zodat je niet alleen zelf programma's kunt schrijven maar ook op een effectieve manier kunt samenwerken met andere programmeurs. 

Als je je inschrijft voor de minor programmeren, kies je zelf de blokken waarin je de vakken gaat volgen en de werkgroepen waar je aanwezig bent. De vakken kennen een verplichte aanwezigheid van 12 uur per week: daarom kun je zelf een werkgroep kiezen die goed te combineren is met een ander vak in dezelfde periode. 

<div class="panel text-center bg-light px-3 py-5" style="margin-top:6rem;">
    
    <h1 class="display-3">Vakken</h1>
    
    <p class="display-6 w-50 mx-auto">Dit zijn de vakken die je volgt tijdens de Minor Kunstmatige Intelligentie. Elk vak is 6 studiepunten, dus ongeveer 160 uur aan studietijd.</p>

    <div class="w-75-centered mt-5 text-left row row-cols-1 row-cols-md-2">
        {% assign courses = site.courses | sort: "order" %}
        {% for course in courses %}
        {% if course.curriculum == "Minor KI" %}
        <div class="col mb-4 px-0 px-md-3">
            <div class="card mb-3 bg-light border-0 h-100" style="smax-width: 540px;">
                <div class="card-body psx-0 px-md-3">
                    <h5 class="card-title">{{ course.name }}</h5>
                    <p class="card-text">{{ course.content | markdownify }}</p>
                </div>
            </div>
        </div>  
        {% endif %}
        {% endfor %}
    </div>

</div>

<div class="row my-4" style="">
    <div class="col">
        <img class="img-fluid" src="/assets/home/bots.jpeg">
    </div>
    <div class="col">
        <img class="img-fluid" src="/assets/home/game.jpeg">
    </div>
</div>

Je zult veel samenwerken met de andere studenten in je werkgroep, die op dat moment hetzelfde onderdeel van de minor volgen. We gebruiken videocolleges van gerenommeerde Amerikaanse universiteiten, die je vaak samen zult kijken, maar als je wat sneller of langzamer gaat kun je dat ook zelfstandig doen. Wij bieden je verder de hele week uitstekende begeleiding door ervaren programmeurs en een vaste plek waar je je helemaal kunt storten op het programmeren.
