{
ALGORITHME leMorpion

//BUT faire le jeu du morpion (deux joueurs)
//ENTREE la case choisi par l'utilisateur
//SORTIE l'affichage du morpion en temps réel, la non-posibilité de sélection d'une case, et l'annonce du gagnant en fin de partie


TYPE forme = (X,O,I,_)														// Dans un premier temps je prépare mes énumération pour proteger le contenue des variables et n'avoir que se que je veut pouvoir y avoir
TYPE choix = (hg,hm,hd,mg,mm,md,bg,bm,bd,valider)

PROCEDURE initTableau (morpion : forme)									//Je fait ensuite une procedure qui prépare le contenue du tableau donc la partie visuel du tableau

	VAR
		i,j : ENTIER	

	DEBUT
	
		i <- 1
		j <- 1
																		//Pour se faire je parcours grace aux deux "POUR" les différentes lignes et je les remplie d'espace ou de traits pour l'effet visuel demandé
		POUR i de 1 a 5 FAIRE
			POUR j de 1 a 5 FAIRE
				SI (i modulo 2 = 0) ALORS
					morpion.[i.j] <- "_"
				SI (j modulo 2 = 0) ALORS
					morpion.[i.j] <- "I"
				SI (i modulo 2 <> 0) ALORS
					morpion.[i.j] <- " "
				SI (j modulo 2 <> 0) ALORS
					morpion.[i.j] <- " "

			FINPOUR
		FINPOUR
	FIN
FINPROCEDURE

PROCEDURE affichageMorpion (morpion : forme)						//Une fois le tableau initialisé je fait une procedure qui affiche le tableau comme il est en temps réel avec les modifications apportée

	DEBUT
		ECRIRE (morpion.[1.1],morpion.[1.2],morpion.[1.3],morpion.[1.4],morpion.[1.5])
		ECRIRE (morpion.[2.1],morpion.[2.2],morpion.[2.3],morpion.[2.4],morpion.[2.5])
		ECRIRE (morpion.[3.1],morpion.[3.2],morpion.[3.3],morpion.[3.4],morpion.[3.5])
		ECRIRE (morpion.[4.1],morpion.[4.2],morpion.[4.3],morpion.[4.4],morpion.[4.5])
		ECRIRE (morpion.[5.1],morpion.[5.2],morpion.[5.3],morpion.[5.4],morpion.[5.5])
	FIN

FINPROCEDURE

PROCEDURE jouer (morpion : forme,joueur : forme)					//Ici la procedure Jouer qui à la fois vérifi si la case est vide (donc est remplie d'un espace) et qui la remplie dans le cas ou elle est vide

	VAR
		choix : choixEmplacement

	DEBUT

		ECRIRE "Choisissez votre emplacement a l'aide des premieres lettre de celui, exemple : si hd = haut droit, bg = bas gauche, mm = milieu milieu ..."
		ECRIRE "h pour haut, m pour milieu, b pour bas ensuite une fois la premiere lettre entrer collé y la seconde : "
		ECRIRE "g pour gauche, m pour milieu, d pour droite."
		LIRE choix

		REPETER
			SI (choix = hg) ALORS
				SI (morpion.[1.1] = " ") ALORS
					morpion.[1.1] <- joueur
					choix <- valider									//Ici nous validons le choix pour pouvoir sortir de la boucle dans le cas ou les conditions sont respectée

			SI (choix = hm) ALORS
				SI (morpion.[1.3] = " ") ALORS
					morpion.[1.3] <- joueur
					choix <- valider

			SI (choix = hd) ALORS
				SI (morpion.[1.5] = " ") ALORS
					morpion.[1.5] <- joueur
					choix <- valider
			SI (choix = hg) ALORS
				SI (morpion.[3.1] = " ") ALORS
					morpion.[3.1] <- joueur
					choix <- valider

			SI (choix = hm) ALORS
				SI (morpion.[3.3] = " ") ALORS
					morpion.[3.3] <- joueur
					choix <- valider

			SI (choix = hd) ALORS
				SI (morpion.[3.5] = " ") ALORS
					morpion.[3.5] <- joueur
					choix <- valider
			SI (choix = hg) ALORS
				SI (morpion.[5.1] = " ") ALORS
					morpion.[5.1] <- joueur
					choix <- valider

			SI (choix = hm) ALORS
				SI (morpion.[5.3] = " ") ALORS
					morpion.[5.3] <- joueur
					choix <- valider

			SI (choix = hd) ALORS
				SI (morpion.[5.5] = " ") ALORS
					morpion.[5.5] <- joueur
					choix <- valider

				SINON
						ECRIRE "Veuillez saisir une autre case car celle-ci est prise."			//Dans le cas ou l'utilisateur se trompe de saisis nous lui faisons recommencer une nouvelle saisis jusqu'a en trouver une bonne
						affichageMorpion (morpion : forme)
						LIRE choix
		JUSQUA (choix = valider)

	FIN
FINPROCEDURE


// PROGRAMME PRINCIPAL


VAR
	cpt : ENTIER
	j1,j2,joueur : forme

	morpion : TABLEAU [1..5] [1..5] : forme

DEBUT

	cpt <- 1																		//CPT nous permet de savoir qui doit jouer entre le joueur un (impaires) et le joueur deux (paire)

	ECRIRE "Bienvenue sur le jeu du morpion"
	ECRIRE "Joueur 1 veuillez choisir la croix ou le rond en écrivant X ou O"		//Le joueur 1 choisi la Croix ou le Rond et le joueur 2 est assigné de l'autre possibilitée
	LIRE j1
	ECRIRE "Le Joueur 1 seras donc : ", j1

	SI (j1 = X) ALORS
		j2 <- "O"
		ECRIRE "Le Joueur 2 seras alors : ",j2
	SINON
		j2 <- "X"
		ECRIRE "Le Joueur 2 seras alors : ",j2
	FINSI

	initTableau (morpion : forme)												//Une fois les deux joueurs prévenue de leurs symbol nous initialisons le tableau vide
	affichageMorpion (morpion : forme)											//Nous affichons donc une premiere fois le tableau


	REPETER

		SI (cpt modulo 2 = 0)														//Si le joueur 2 (cpt Modulo 2 =0) doit jouer on lui demande ou veut-t-il placer son symbol
			ECRIRE "Au tour de : ",j2," de jouer."
			ECRIRE "Ou voullez vous placer votre ",j2," ?"
			joueur <- j2
			jouer (morpion : forme,joueur : forme)									//Une fois que tout est prêt on appelle alors la procedure jouer pour faire les vérifications et le remplissage
		SINON
			ECRIRE " Au tour de : ",j1," de jouer."									//De même pour le joueur 1
			ECRIRE "Ou voullez vous placer votre ",j1," ?"
			joueur <- j1
			jouer (morpion : forme,joueur : forme)
		FINSI

		cpt <- cpt +1

																					//Ici nous faisons les vérifications, nous vérifions si une des 8 possibilitées est remplie si oui alors la partie se termine et on annonce le vainqueur sinon si cpt = 10 donc le 9eme placement de symbol n'est pas gagnant alors 
																					//cpt prendras cpt + 1, donc aucuns des deux joueurs n'a fait d'allignement donc la partie est une égalitée.
	JUSQUA (((morpion.[1.1] = morpion.[3.1] = morpion.[5.1]) ET <> " ") OU ((morpion.[1.3] = morpion.[3.3] = morpion.[5.3]) ET <> " ") OU ((morpion.[1.5] = morpion.[3.5] = morpion.[5.5]) ET <> " ") OU ((morpion.[1.1] = morpion.[1.3] = morpion.[1.5]) ET <> " "
) OU ((morpion.[3.1] = morpion.[3.3] = morpion.[3.5]) ET <> " ") OU ((morpion.[5.1] = morpion.[5.3] = morpion.[5.5]) ET <> " ") OU ((morpion.[1.1] = morpion.[3.3] = morpion.[5.5]) ET <> " ") OU ((morpion.[5.1] = morpion.[3.3] = morpion.[1.5]) ET <> " ")) OU (cpt = 10)

	SI (cpt <> 10) ALORS 															// Ici on annonce le gnagnant ou l'égalitée
		ECRIRE "Félicitation a : ",joueur," pour avoir gagné la partie !"
	SINON
		ECRIRE "Egalitée ! aucun gagnant sur cette partie !"
	FINSI
FIN
}

PROGRAM leMorpion;
uses crt;

//BUT faire le jeu du morpion (deux joueurs)
//ENTREE la case choisi par l'utilisateur
//SORTIE l'affichage du morpion en temps réel, la non-posibilité de sélection d'une case, et l'annonce du gagnant en fin de partie

Type
	 forme=(X,O,I,_);																			// Dans un premier temps je prépare mes énumération pour proteger le contenue des variables et n'avoir que se que je veut pouvoir y avoir
	 choix=(hg,hm,hd,mg,mm,md,bg,bm,bd,valider);

PROCEDURE initTableau (morpion : forme);														//Je fait ensuite une procedure qui prépare le contenue du tableau donc la partie visuel du tableau

	VAR
		i,j : INTEGER;

	BEGIN
		i:=1;
		j:=1;
																								//Pour se faire je parcours grace aux deux "POUR" les différentes lignes et je les remplie d'espace ou de traits pour l'effet visuel demandé
		FOR i := 1 TO 5 DO
			BEGIN
				FOR j := 1 TO 5 DO
					BEGIN
						IF (i MOD 2 = 0) THEN
							morpion.[i.j] := '_';
						IF (j MOD 2 = 0) THEN
							morpion.[i.j] := 'I';
						IF (i MOD 2 <> 0) THEN
							morpion.[i.j] := ' ';
						IF (j MOD 2 <> 0) THEN
							morpion.[i.j] := ' ';

					END;
			END;
	END;

PROCEDURE affichageMorpion (morpion : forme);													//Une fois le tableau initialisé je fait une procedure qui affiche le tableau comme il est en temps réel avec les modifications apportée

	BEGIN
		WRITELN (morpion.[1.1],morpion.[1.2],morpion.[1.3],morpion.[1.4],morpion.[1.5]);
		WRITELN (morpion.[2.1],morpion.[2.2],morpion.[2.3],morpion.[2.4],morpion.[2.5]);
		WRITELN (morpion.[3.1],morpion.[3.2],morpion.[3.3],morpion.[3.4],morpion.[3.5]);
		WRITELN (morpion.[4.1],morpion.[4.2],morpion.[4.3],morpion.[4.4],morpion.[4.5]);
		WRITELN (morpion.[5.1],morpion.[5.2],morpion.[5.3],morpion.[5.4],morpion.[5.5]);
	END;

END;

PROCEDURE jouer (morpion : forme,joueur : forme);												//Ici la procedure Jouer qui à la fois vérifi si la case est vide (donc est remplie d'un espace) et qui la remplie dans le cas ou elle est vide			

	VAR
		choix : choixEmplacement;

	BEGIN

		WRITELN ("Choisissez votre emplacement a l'aide des premieres lettre de celui, exemple : si hd = haut droit, bg = bas gauche, mm = milieu milieu ...");
		WRITELN ("h pour haut, m pour milieu, b pour bas ensuite une fois la premiere lettre entrer collé y la seconde : ");
		WRITELN ("g pour gauche, m pour milieu, d pour droite.");
		READLN (choix);

		REPEAT
			IF (choix = hg) THEN
				IF (morpion.[1.1] = ' ') THEN
					morpion.[1.1] := joueur;
					choix := valider;															//Ici nous validons le choix pour pouvoir sortir de la boucle dans le cas ou les conditions sont respectée

			IF (choix = hm) THEN
				IF (morpion.[1.3] = ' ') THEN
					morpion.[1.3] := joueur;
					choix := valider;

			IF (choix = hd) THEN
				IF (morpion.[1.5] = ' ') THEN
					morpion.[1.5] := joueur;
					choix := valider;
			IF (choix = mg) THEN
				IF (morpion.[3.1] = ' ') THEN
					morpion.[3.1] := joueur;;
					choix := valider;;

			IF (choix = mm) THEN
				IF (morpion.[3.3] = ' ') THEN
					morpion.[3.3] := joueur;
					choix := valider;

			IF (choix = md) THEN
				IF (morpion.[3.5] = ' ') THEN
					morpion.[3.5] := joueur;
					choix := valider;

			IF (choix = bg) THEN
				IF (morpion.[5.1] = ' ') THEN
					morpion.[5.1] := joueur;
					choix := valider;

			IF (choix = bm) THEN
				IF (morpion.[5.3] = ' ') THEN
					morpion.[5.3] := joueur;
					choix := valider;

			IF (choix = bd) THEN
				IF (morpion.[5.5] = ' ') THEN
					morpion.[5.5] := joueur;
					choix := valider

				ELSE
						WRITELN ("Veuillez saisir une autre case car celle-ci est prise.");			//Dans le cas ou l'utilisateur se trompe de saisis nous lui faisons recommencer une nouvelle saisis jusqu'a en trouver une bonne
						affichageMorpion (morpion : forme);
						READLN (choix);
		UNTIL (choix = valider);

	END;
END;


// PROGRAMME PRINCIPAL


VAR
	cpt : INTEGER;
	j1,j2,joueur : forme;

	morpion : ARRAY [1..5,1..5] OF forme;


BEGIN

	cpt := 1																					//CPT nous permet de savoir qui doit jouer entre le joueur un (impaires) et le joueur deux (paire)
	clrscr;

	WRITELN ("Bienvenue sur le jeu du morpion");
	WRITELN ("Joueur 1 veuillez choisir la croix ou le rond en écrivant X ou O");				//Le joueur 1 choisi la Croix ou le Rond et le joueur 2 est assigné de l'autre possibilitée
	READLN (j1);
	WRITELN ("Le Joueur 1 seras donc : ", j1);

	IF (j1 = X) THEN
		j2 := "O";
		WRITELN ("Le Joueur 2 seras alors : ",j2)
	ELSE
		j2 := "X";
		WRITELN ("Le Joueur 2 seras alors : ",j2);
	END;

	initTableau (morpion : forme);																//Une fois les deux joueurs prévenue de leurs symbol nous initialisons le tableau vide
	affichageMorpion (morpion : forme);															//Nous affichons donc une premiere fois le tableau


	REPEAT

		IF (cpt MOD 2 = 0)THEN																	//Si le joueur 2 (cpt Modulo 2 =0) doit jouer on lui demande ou veut-t-il placer son symbol
			WRITELN ("Au tour de : ",j2," de jouer.");
			WRITELN ("Ou voullez vous placer votre ",j2," ?");
			joueur := j2;
			jouer (morpion : forme,joueur : forme)												//Une fois que tout est prêt on appelle alors la procedure jouer pour faire les vérifications et le remplissage
		ELSE
			WRITELN (" Au tour de : ",j1," de jouer.");											//De même pour le joueur 1
			WRITELN ("Ou voullez vous placer votre ",j1," ?");
			joueur := j1;
			jouer (morpion : forme,joueur : forme);

		cpt := cpt + 1;

																							//Ici nous faisons les vérifications, nous vérifions si une des 8 possibilitées est remplie si oui alors la partie se termine et on annonce le vainqueur sinon si cpt = 10 donc le 9eme placement de symbol n'est pas gagnant alors 
																							//cpt prendras cpt + 1, donc aucuns des deux joueurs n'a fait d'allignement donc la partie est une égalitée.
	UNTIL (((morpion.[1.1] = morpion.[3.1] = morpion.[5.1]) AND <> " ") OR ((morpion.[1.3] = morpion.[3.3] = morpion.[5.3]) AND <> " ") OR ((morpion.[1.5] = morpion.[3.5] = morpion.[5.5]) AND <> " ") OR ((morpion.[1.1] = morpion.[1.3] = morpion.[1.5]) AND <>
" ") OR ((morpion.[3.1] = morpion.[3.3] = morpion.[3.5]) AND <> " ") OR ((morpion.[5.1] = morpion.[5.3] = morpion.[5.5]) AND <> " ") OR ((morpion.[1.1] = morpion.[3.3] = morpion.[5.5]) AND <> " ") OR ((morpion.[5.1] = morpion.[3.3] = morpion.[1.5]) AND <>
 " ")) OR (cpt = 10)

	IF (cpt <> 10) THEN 																	// Ici on annonce le gnagnant ou l'égalitée
		WRITELN ("Félicitation a : ",joueur," pour avoir gagné la partie !")
	ELSE
		WRITELN ("Egalitée ! aucun gagnant sur cette partie !");
END.
