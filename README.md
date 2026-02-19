# Tourisme
# Tourisme
# Tourisme
# 🌍 VisitonsMonde - Plateforme de Réservation de Voyages

![Java](https://img.shields.io/badge/Java-17-orange?style=flat&logo=java)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue?style=flat)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat&logo=mysql)
![Tomcat](https://img.shields.io/badge/Tomcat-10.1-yellow?style=flat&logo=apache-tomcat)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.0-purple?style=flat&logo=bootstrap)

## 📖 Description

**VisitonsMonde** est une plateforme web complète de réservation de voyages développée en Java EE. Le projet permet aux utilisateurs de découvrir des destinations, de réserver des voyages avec ou sans guide, et de gérer leurs réservations en ligne.

Le site propose également un espace administrateur pour gérer les destinations, les guides, les réservations et le contenu (blog, témoignages, galerie).

---

## ✨ Fonctionnalités Principales

### 👤 Espace Utilisateur
- ✅ **Authentification** : Inscription, connexion, gestion de profil
- ✅ **Destinations** : Navigation et recherche de destinations par pays
- ✅ **Réservations** : Système complet de réservation avec choix de guide optionnel
- ✅ **Mes Réservations** : Historique et suivi des réservations
- ✅ **Blog** : Articles de voyage avec pagination
- ✅ **Témoignages** : Avis clients en carousel
- ✅ **Galerie** : Photos organisées par catégories

### 👨‍💼 Espace Guide
- ✅ **Inscription Guide** : Formulaire de candidature
- ✅ **Profil Guide** : Gestion des informations (spécialités, langues, photos)
- ✅ **Réservations assignées** : Visualisation des voyages à venir

### 🔐 Espace Administrateur
- ✅ **Dashboard** : Statistiques en temps réel (Chart.js)
- ✅ **Gestion Destinations** : CRUD complet
- ✅ **Gestion Guides** : Validation, activation/désactivation
- ✅ **Gestion Réservations** : Suivi et modification de statut
- ✅ **Gestion Contenu** : Blog, témoignages, galerie

---

## 🏗️ Architecture

### Pattern MVC (Model-View-Controller)
```
src/
├── main/
│   ├── java/com/visitonsmonde/
│   │   ├── config/          # Configuration (DAOFactory)
│   │   ├── model/           # Entités métier (Destination, Guide, Reservation, etc.)
│   │   ├── dao/             # Data Access Objects
│   │   ├── servlet/         # Contrôleurs (Servlets)
│   │   └── util/            # Classes utilitaires (EmailService, PasswordUtil)
│   └── webapp/
│       ├── css/             # Styles Bootstrap + custom
│       ├── js/              # Scripts JavaScript
│       ├── img/             # Images
│       ├── lib/             # Bibliothèques (Owl Carousel, Lightbox)
│       ├── *.jsp            # Vues (pages JSP)
│       └── WEB-INF/
```

### Modèle de Données

**Principales Entités :**
- `Utilisateur` : Clients, Guides, Admins
- `Destination` : Voyages disponibles
- `Guide` : Guides touristiques
- `Reservation` : Réservations clients
- `BlogPost` : Articles de blog
- `Testimonial` : Témoignages clients
- `GalleryImage` : Photos avec catégories

---

## 🛠️ Technologies Utilisées

### Backend
- **Java 17** (Amazon Corretto)
- **Jakarta EE 10** (Servlets, JSP)
- **MySQL 8.0** - Base de données relationnelle
- **Apache Tomcat 10.1** - Serveur d'applications
- **JDBC** - Accès aux données
- **BCrypt** - Hachage de mots de passe
- **JavaMail** - Envoi d'emails

### Frontend
- **Bootstrap 5.0** - Framework CSS responsive
- **JavaScript / jQuery 3.6**
- **Owl Carousel** - Carousels
- **Lightbox** - Galerie d'images
- **Chart.js** - Graphiques dashboard
- **Font Awesome 5** - Icônes

### Outils
- **IntelliJ IDEA** - IDE
- **Git / GitHub** - Versioning
- **Maven** - Gestion des dépendances (optionnel)
- **MAMP** - Environnement local MySQL

---

## 📦 Installation & Déploiement

### Prérequis

- Java JDK 17+ (Amazon Corretto recommandé)
- Apache Tomcat 10.1+
- MySQL 8.0+ ou MariaDB
- Un IDE Java (IntelliJ IDEA, Eclipse, NetBeans)

### Étapes d'installation

#### 1. Cloner le projet
```bash
git clone https://github.com/Manjaka1/VisitonsMonde.git
cd VisitonsMonde
```

#### 2. Configurer la base de données

**a) Créer la base de données :**
```sql
CREATE DATABASE tourisme_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

**b) Importer le schéma et les données :**

Exécuter les scripts SQL dans l'ordre :
1. `database/schema.sql` - Structure des tables
2. `database/data.sql` - Données d'exemple

**c) Configurer la connexion :**

Éditer `src/main/java/com/visitonsmonde/config/DAOFactory.java` :
```java
private static final String URL = "jdbc:mysql://localhost:3306/tourisme_db";
private static final String USER = "root";
private static final String PASSWORD = "root"; // Votre mot de passe MySQL
```

#### 3. Déployer sur Tomcat

**Option A - Via IntelliJ IDEA :**
1. Ouvrir le projet dans IntelliJ
2. Configurer Tomcat : `Run > Edit Configurations > + > Tomcat Server > Local`
3. Déployer : `Deployment tab > + > Artifact > VisitonsMonde:war exploded`
4. Démarrer le serveur

**Option B - Déploiement manuel :**
1. Compiler le projet en WAR
2. Copier le WAR dans `TOMCAT_HOME/webapps/`
3. Démarrer Tomcat
4. Accéder à `http://localhost:8080/VisitonsMonde/`

#### 4. Comptes de test

**Admin :**
- Email : `admin@visitonsmonde.com`
- Mot de passe : `admin123`

**Client :**
- Email : `client@test.com`
- Mot de passe : `client123`

**Guide :**
- Email : `guide@test.com`
- Mot de passe : `guide123`

---

## 📸 Captures d'écran

### Page d'accueil
![Accueil](screenshots/home.png)

### Destinations
![Destinations](screenshots/destinations.png)

### Dashboard Admin
![Dashboard](screenshots/dashboard.png)

---

## 🎯 Fonctionnalités Techniques

### Sécurité
- ✅ Hachage BCrypt pour les mots de passe
- ✅ Sessions sécurisées
- ✅ Protection contre les injections SQL (PreparedStatement)
- ✅ Validation des entrées utilisateur
- ✅ Gestion des rôles (CLIENT, GUIDE, ADMIN)

### Performance
- ✅ Connection pooling via DAOFactory singleton
- ✅ Requêtes SQL optimisées avec index
- ✅ Chargement lazy des images
- ✅ Pagination des résultats

### UX/UI
- ✅ Design responsive (mobile-first)
- ✅ Feedback utilisateur (messages success/erreur)
- ✅ Formulaires avec validation client/serveur
- ✅ Spinner de chargement

---

## 🗂️ Structure de la Base de Données

**12 tables principales :**
```
utilisateurs (id, email, mot_de_passe_hash, nom, prenom, role, est_admin)
destinations (id, nom, pays, description, prix, image, nb_photos)
guides (id, nom, prenom, specialite, experience_annees, langues_parlees, statut)
reservations (id, utilisateur_id, destination_id, guide_id, date_depart, statut, prix_total)
blog_posts (id, titre, contenu, image, auteur, date_publication, est_publie)
testimonials (id, nom, ville, pays, note, commentaire, photo, est_actif)
gallery_categories (id, nom, slug, ordre)
gallery_images (id, titre, image, category_id, ordre)
pays (id, nom, code)
+ tables de gestion
```

---

## 🤝 Contribution

Ce projet est développé dans le cadre d'un projet académique.

**Auteur :** Manjaka  
**GitHub :** [@Manjaka1](https://github.com/Manjaka1)

---

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

---

## 🙏 Remerciements

- Template HTML : [Travela by HTML Codex](https://htmlcodex.com)
- Bootstrap Team
- Communauté Java EE

---

## 📞 Contact

Pour toute question sur ce projet :
- 📧 Email : manjaka@example.com
- 🔗 LinkedIn : https://www.linkedin.com/in/yves-manjakatsara-01314675/
- 💼 Portfolio : 

---

**⭐ Si ce projet vous a été utile, n'hésitez pas à lui donner une étoile sur GitHub ! ⭐**
