📋 Todo App

Une application mobile Flutter de gestion de tâches (Todo List).
Elle permet d’ajouter, afficher, modifier et supprimer des tâches avec persistance locale grâce à SharedPreferences.

🚀 Fonctionnalités:
✅ Affichage des tâches : liste des tâches avec leur statut (complétée / non complétée)

➕ Ajout de tâches : possibilité d’ajouter une nouvelle tâche

🖊️ Édition : modifier le titre d’une tâche existante

🔄 Marquer comme complétée / non complétée

❌ Suppression : supprimer une tâche de la liste

💾 Persistance locale : les tâches sont sauvegardées sur l’appareil via SharedPreferences

🛠️ Technologies utilisées

Flutter
Dart
Provider
Shared Preferences

Architecture:
Le projet suit une organisation claire inspirée de MVVM et du Repository Pattern :
Models : définition des objets métiers (par ex. Task)
Repositories : couche d’accès aux données (TaskRepository, TaskRepositoryPrefs)
ViewModels : logique métier + gestion d’état (TaskViewModel)
Views (UI) : écrans et widgets Flutter (HomeScreen, etc.)
Cette séparation permet une meilleure maintenabilité et facilite les tests unitaires.

Exécution du projet
Prérequis
Flutter SDK (version stable recommandée)
Dart SDK
Un émulateur ou un appareil physique connecté

Étapes
Clonez le projet :
git clone https://github.com/ton-repo/todo_app.git
cd todo_app
Installez les dépendances :
flutter pub get
Lancez l’application :
    flutter run

❌ Difficultés rencontrées & solutions

    Persistance locale : problème initial avec la sérialisation des objets → solution : conversion en JSON pour sauvegarder dans SharedPreferences.

    Architecture : au début tout le code était mélangé → solution : adoption du Repository Pattern et séparation claire MVVM.

    Tests unitaires : erreurs liées à l’initialisation → solution : mise en place de mocks pour tester le TaskRepository.
    📌 Améliorations futures

Ajout de filtres (tâches actives, complétées, toutes)

Implémentation d’une base de données locale avec Sqflite

Notifications pour rappeler les tâches importantes

Support du thème clair/sombre