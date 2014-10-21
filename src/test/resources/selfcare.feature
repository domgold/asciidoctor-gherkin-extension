# language: fr
Fonctionnalité: Changer son mot de passe ou récupérer son cuid.
  
  Selfcare pour utilisateurs ayant oublier son mot de passe ou cuid.
  L utilisateur peut soit récupérer son cuid via mail, soit réinitialiser son mot de passe, s il est purement Guardian.
  Pour les utilisateurs Gassi ou MPA ils sont redirigé vers la page selfcare Gassi ou MPA.

  Plan du scénario: Réinitialiser son mot de passe
    Etant donné un utilisateur avec le cuid '<cuid>' et l adresse mail '<adresse_mail_utilisateur>'
    Quand l utilisateur accède à la page '/selfcare.jsp'
    Et l utilisateur clique sur le lien avec le titre 'oubli/modification* de mot de passe'
    Et l utilisateur entre la chaine '<cuid>' dans le champ de texte portant le nom 'critere'
    Et l utilisateur entre la chaine '123456' dans le champ de texte portant le nom 'captcha'
    Et l utilisateur clique sur le lien avec le titre 'valider'
    Alors la page suivante contient le texte '<adresse_mail_utilisateur>'
    Et l utilisateur a recu un mail contenant le hash
    Quand l utilisateur clique sur le lien reçu par mail
    Et l utilisateur entre la chaine '<nouveau_mdp>' dans le champ de texte portant le nom 'newpassword'
    Et l utilisateur entre la chaine '<nouveau_mdp>' dans le champ de texte portant le nom 'confirmpassword'
    Et l utilisateur clique sur le bouton portant le titre 'Valider'
    Alors la page suivante contient le texte 'Votre nouveau mot de passe a été enregistré.'
    Et le mot de passe de l utilisateur '<cuid>' est '<nouveau_mdp>'

    Exemples: 
      | cuid     | adresse_mail_utilisateur | nouveau_mdp |
      | self0003 | self0003@orange.com      | Azerty1&    |

  Plan du scénario: Récupérer son cuid par mail.
    Etant donné un utilisateur avec le cuid '<cuid>' et l adresse mail '<adresse_mail_utilisateur>'
    Quand l utilisateur accède à la page '/selfcare.jsp'
    Et l utilisateur clique sur le lien avec le titre 'oubli d'Identifiant (CUID)'
    Et l utilisateur entre la chaine '<adresse_mail_utilisateur>' dans le champ de texte portant le nom 'critere'
    Et l utilisateur entre la chaine '123456' dans le champ de texte portant le nom 'captcha'
    Et l utilisateur clique sur le lien avec le titre 'valider'
    Alors la page suivante contient le texte '<adresse_mail_utilisateur>'
    Et l utilisateur a recu un mail contenant son cuid '<cuid>'

    Exemples: 
      | cuid     | adresse_mail_utilisateur | type utilisateur |
      | self0001 | self0001@orange.com      | Gassi / Guardian |
      | self0002 | self0002@orange.com      | Guardian / MPA   |
      | self0003 | self0003@orange.com      | Guardian         |

  Plan du scénario: Utilisateur Gassi/Guardian : tenter de réinitialiser son mot de passe
    Etant donné un utilisateur avec le cuid '<cuid>' et l adresse mail '<adresse_mail_utilisateur>'
    Quand l utilisateur accède à la page '/selfcare.jsp'
    Et l utilisateur clique sur le lien avec le titre 'oubli/modification* de mot de passe'
    Et l utilisateur entre la chaine '<cuid>' dans le champ de texte portant le nom 'critere'
    Et l utilisateur entre la chaine '123456' dans le champ de texte portant le nom 'captcha'
    Et l utilisateur clique sur le lien avec le titre 'valider'
    Alors la page suivante contient le texte '<texte attendu>'

    Exemples: 
      | cuid     | adresse_mail_utilisateur | type utilisateur | texte attendu                                                             | texte mail |
      | self0001 | self0001@orange.com      | Gassi / Guardian | Votre compte étant un compte GASSI, vous devez utiliser le selfcare GASSI |            |


  Plan du scénario: Utilisateur MPA/Guardian : tenter de réinitialiser son mot de passe
    Etant donné un utilisateur avec le cuid '<cuid>' et l adresse mail '<adresse_mail_utilisateur>'
    Quand l utilisateur accède à la page '/selfcare.jsp'
    Et l utilisateur clique sur le lien avec le titre 'oubli/modification* de mot de passe'
    Et l utilisateur entre la chaine '<cuid>' dans le champ de texte portant le nom 'critere'
    Et l utilisateur entre la chaine '123456' dans le champ de texte portant le nom 'captcha'
    Et l utilisateur clique sur le lien avec le titre 'valider'
    Alors la page suivante contient le texte 'il contient le lien "Mot de Passe Attitude" pour gérer votre mot de passe, accessible également à cette adresse'
    Et la page suivante contient le texte '<adresse_mail_utilisateur>'
    Et l utilisateur a recu un mail contenant le texte '<texte mail>'

    Exemples: 
      | cuid     | adresse_mail_utilisateur | type utilisateur | texte mail                                              |
      | self0002 | self0002@orange.com      | Guardian / MPA   | self0002 est utilisateur de la "Mot de Passe Attitude". |

  Plan du scénario: Tenter de réinitialiser le mot de passe sans hash
    Etant donné un utilisateur anonyme
    Quand l utilisateur charge le fichier html suivant
      """
      <html>
      <head>
      </head>
      <body>
      <form 
      	NAME="form_modif_password" 
      	METHOD="POST"
      	ACTION="<baseurl>/servlet/ft.gassi.bureau.web.servlet.command.CommandHandlerServlet">
      		<input name="cmd" value="reinitpwd"> 
      		<input name="user_uid" value="<cuid>" />
      		<input name="smauthreason" value="0" />
      <input type="text" name="newpassword" svalue="<nouveau_mdp>"/></div>
            <input type="text" name="confirmpassword" value="<nouveau_mdp>"/>
      <input type="submit" value="submit" name="ChangerMotDePasse" />
      </form>
      </body>
      </html>
      """
    Et l utilisateur clique sur le bouton portant le titre 'submit'
    Alors la page suivante contient le texte 'NO PARAMETER [hash] found in request !'

    Exemples: 
      | cuid     | nouveau_mdp |
      | gass0001 | Azerty1&    |

  Plan du scénario: Tenter de réinitialiser le mot de passe avec un hash aléatoire
    Etant donné un utilisateur anonyme
    Quand l utilisateur charge le fichier html suivant
      """
      <html>
      <head>
      </head>
      <body>
      <form 
      	NAME="form_modif_password" 
      	METHOD="POST"
      	ACTION="<baseurl>/servlet/ft.gassi.bureau.web.servlet.command.CommandHandlerServlet">
      		<input name="cmd" value="reinitpwd"> 
      		<input name="user_uid" value="<cuid>" />
      		<input name="smauthreason" value="0" />
      		<input name="hash" value="<hash>" />
      		<input type="text" name="newpassword" svalue="<nouveau_mdp>"/></div>
            <input type="text" name="confirmpassword" value="<nouveau_mdp>"/>
      <input type="submit" value="submit" name="ChangerMotDePasse" />
      </form>
      </body>
      </html>
      """
    Et l utilisateur clique sur le bouton portant le titre 'submit'
    Alors la page suivante contient le texte 'Couple cuid/hash non valide'

    Exemples: 
      | cuid     | nouveau_mdp | hash          |
      | gass0001 | Azerty1&    | hashaleatoire |
