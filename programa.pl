% Aquí va el código.

necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).
necesidad(integridadFisica, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).
necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).
necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).
necesidad(felicidad, autorrealizacion).
necesidad(libertad, autorrealizacion).

% 1) autorrealizacion, 2) reconocimiento, 3) social, 4) entretenimiento 5) seguridad, 6) fisiologico

nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).


% Punto 2 

separacion(Necesidad1, Necesidad2, CantDeSeparacion):-
    necesidad(Necesidad1, Nivel),
    necesidad(Necesidad2, Nivel2),
    cuantosEntremedio(Nivel, Nivel2, CantDeSeparacion).


cuantosEntremedio(Nivel, Nivel2, 0):-
    Nivel = Nivel2.
cuantosEntremedio(Nivel, Nivel2, CantDeSeparacion):-
    nivelSuperior(Nivel2, NivelIntermedio),
    cuantosEntremedio(Nivel, NivelIntermedio, CantDeSepAnt),
    CantDeSeparacion is CantDeSepAnt+1.


% Punto 3

necesita(carla, alimentacion).
necesita(carla, descanso).
necesita(carla, empleo).
necesita(juan, afecto).
necesita(juan, exito).
necesita(roberto, amistad).
necesita(manuel, libertad).
necesita(charly, afecto).

% Punto 4

necesidadMasJerarquica(Persona, Necesidad):-
    necesita(Persona, Necesidad),
    not((necesita(Persona, OtraNecesidad), necesidadMasNivel(OtraNecesidad, Necesidad))).

necesidadMasNivel(Necesidad, OtraNecesidad):-
    separacion(OtraNecesidad, Necesidad, CantDeSeparacion),
    CantDeSeparacion > 0.


% Punto 5

nivel(Nivel):- necesidad(_, Nivel).

persona(Persona):- necesita(Persona, _).

necesitaAlgoPrevioA(Persona,Necesidad):-
    necesita(Persona,OtraNecesidad),
    separacion(OtraNecesidad,Necesidad,Separacion),
    Separacion > 0.

completoNivel(Persona, Nivel):-
    nivel(Nivel),
    persona(Persona),
    not(nivelConNecesidades(Persona,Nivel)).

nivelConNecesidades(Persona, Nivel):-
    necesita(Persona, Necesidad),
    necesidad(Necesidad, Nivel).
nivelConNecesidades(Persona, Nivel):-
    necesidad(Necesidad, Nivel),
    necesitaAlgoPrevioA(Persona,Necesidad).

% Punto 6 

cumpleMaslow(Persona):-
    necesita(Persona, Necesidad),
    forall(necesita(Persona, OtraNecesidad), mismoNivel(OtraNecesidad, Necesidad)).

mismoNivel(Necesidad, OtraNecesidad):-
    separacion(Necesidad, OtraNecesidad, 0).

noCumpleMaslow(Persona):-
    necesita(Persona, Necesidad),
    necesita(Persona, OtraNecesidad),
    separacion(Necesidad, OtraNecesidad, Separacion),
    Separacion > 1.