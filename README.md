# 🧮 Matrice Application

**Matrice Application** est une application multiplateforme développée avec **Flutter et Dart**, conçue pour faciliter les calculs mathématiques classiques et les opérations sur les matrices à travers une interface graphique simple et intuitive.

Le projet vise à rendre les opérations mathématiques plus accessibles, tout en proposant une expérience utilisateur personnalisable.

---

## ✨ Fonctionnalités

### 🔢 Calculatrice classique
- Addition
- Soustraction
- Multiplication
- Division
- Modulo

### 📐 Calcul matriciel
- Addition de matrices
- Soustraction de matrices
- Multiplication de matrices
- Transposée d'une matrice

### 🎨 Personnalisation
- Personnalisation de la couleur de l'interface.
- Gestion du thème de l'application.
- Sauvegarde des préférences utilisateur.

### 🧭 Navigation
- Interface organisée pour accéder aux différents outils de calcul.
- Navigation entre les fonctionnalités.
- Page de présentation de l'application.

---

## 🛠️ Technologies utilisées

| Technologie | Utilisation |
|---|---|
| Flutter | Développement multiplateforme |
| Dart | Langage de programmation |
| Provider | Gestion de l'état et du thème |
| SharedPreferences | Persistance des préférences utilisateur |
| Material Design | Interface utilisateur |

---

## 📂 Structure du projet

```text
bleou_matrices_application_2_0_0/
│
├── android/                 # Configuration Android
├── macos/                   # Configuration macOS
├── web/                     # Version Web
├── windows/                 # Configuration Windows
│
├── lib/
│   ├── core/
│   │   └── services/        # Services de navigation et stockage
│   │
│   ├── data/
│   │   └── datasources/     # Sources de données locales
│   │
│   ├── theme/               # Gestion du thème
│   ├── about_page.dart      # Page À propos
│   ├── main_color_picker.dart
│   └── main.dart            # Point d'entrée de l'application
│
├── test/                    # Tests
├── pubspec.yaml             # Dépendances du projet
├── pubspec.lock             # Versions des dépendances
└── README.md
```

---

## ⚙️ Installation et configuration

### Prérequis

Avant de commencer, assurez-vous de disposer des éléments suivants :

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Git](https://git-scm.com/downloads)
- Un éditeur de code : [Visual Studio Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)

### 1. Cloner le dépôt

```bash
git clone https://github.com/Christ-Bleou/matrice-application.git
```

### 2. Accéder au projet

```bash
cd matrice-application
```

### 3. Installer les dépendances

```bash
flutter pub get
```

### 4. Vérifier la configuration Flutter

```bash
flutter doctor
```

### 5. Lancer l'application

```bash
flutter run
```

---

## 🌐 Exécution sur différentes plateformes

Flutter permet de cibler plusieurs plateformes.

**Version Web :**

```bash
flutter run -d chrome
```

**Version Android :**

```bash
flutter run -d android
```

**Version Windows :**

```bash
flutter run -d windows
```

Pour générer une version Web :

```bash
flutter build web
```

Les fichiers générés seront disponibles dans :

```text
build/web/
```

---

## 🧪 Analyse et qualité du code

Pour analyser le projet :

```bash
flutter analyze
```

Pour exécuter les tests :

```bash
flutter test
```

---

## 🚀 Évolutions envisagées

Quelques pistes d'amélioration possibles :

- Calcul du déterminant d'une matrice.
- Calcul de l'inverse d'une matrice.
- Calcul du rang d'une matrice.
- Amélioration de la visualisation des résultats.
- Historique des opérations.
- Exportation des résultats.

---

## 👨‍💻 Auteur

**Bléou Christ-Marie Martin**

Étudiant en Computer Science — Institut Ivoirien de Technologie (IIT).

Développement logiciel, applications multiplateformes et mathématiques appliquées.

---

## 📄 Licence

Aucune licence open source n'est actuellement spécifiée pour ce projet.

---

*Développé avec Flutter 💙 et une passion pour les mathématiques et le développement logiciel.*