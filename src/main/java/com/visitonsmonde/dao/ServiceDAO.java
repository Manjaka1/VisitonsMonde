package com.visitonsmonde.dao;


import com.visitonsmonde.model.Service;
import com.visitonsmonde.config.DAOFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO (Data Access Object) pour gérer les services dans la base de données
 * Cette classe fait le pont entre la base de données MySQL et notre application Java
 * Elle contient toutes les opérations CRUD (Create, Read, Update, Delete) pour les services
 */
public class ServiceDAO {

    /**
     * Méthode privée pour obtenir une connexion à la base de données
     * On utilise DAOFactory pour centraliser la configuration de connexion
     * @return Connection une connexion active à la base de données
     * @throws SQLException si la connexion échoue
     */
    private Connection getConnection() throws SQLException {
        // DAOFactory.getConnection() va nous donner une connexion configurée
        // avec les bons paramètres (URL, username, password)
        return DAOFactory.getConnection();
    }

    /**
     * Créer un nouveau service dans la base de données
     * @param service L'objet Service à insérer (sans ID, car il sera auto-généré)
     * @return true si la création a réussi, false sinon
     */
    public boolean create(Service service) {
        // La requête SQL pour insérer un nouveau service
        // On n'insère pas l'ID (auto-increment) ni la date_creation (CURRENT_TIMESTAMP)
        String sql = "INSERT INTO services (nom, description, icone) VALUES (?, ?, ?)";

        try (
                // On obtient une connexion (elle se fermera automatiquement grâce au try-with-resources)
                Connection connection = getConnection();
                // PreparedStatement évite les injections SQL et permet de récupérer l'ID généré
                PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            // On remplace les ? par les vraies valeurs
            stmt.setString(1, service.getNom());        // Premier ? = nom du service
            stmt.setString(2, service.getDescription()); // Deuxième ? = description
            stmt.setString(3, service.getIcone());      // Troisième ? = icône (ex: "fa fa-globe")

            // On exécute la requête et on récupère le nombre de lignes affectées
            int result = stmt.executeUpdate();

            // Si result > 0, ça veut dire qu'une ligne a été insérée
            if (result > 0) {
                // On récupère l'ID auto-généré par MySQL
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    // On met à jour l'objet service avec son nouvel ID
                    service.setId(generatedKeys.getInt(1));
                }

                // On récupère aussi la date de création générée automatiquement
                Service created = findById(service.getId());
                if (created != null) {
                    service.setDateCreation(created.getDateCreation());
                }

                // Tout s'est bien passé !
                return true;
            }
        } catch (SQLException e) {
            // Si erreur SQL, on l'affiche dans la console
            System.err.println("Erreur lors de la création du service : " + e.getMessage());
        }

        // Si on arrive ici, c'est que ça n'a pas marché
        return false;
    }

    /**
     * Trouver un service par son ID
     * @param id L'identifiant unique du service à chercher
     * @return Le Service trouvé, ou null s'il n'existe pas
     */
    public Service findById(int id) {
        // Requête SQL pour chercher un service par son ID
        String sql = "SELECT * FROM services WHERE id = ?";

        try (
                // Connexion à la BDD
                Connection connection = getConnection();
                // On prépare la requête
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            // On remplace le ? par l'ID qu'on cherche
            stmt.setInt(1, id);

            // On exécute la requête et on récupère le résultat
            ResultSet rs = stmt.executeQuery();

            // Si on a trouvé une ligne
            if (rs.next()) {
                // On convertit la ligne SQL en objet Service
                return extractServiceFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche du service : " + e.getMessage());
        }

        // Si pas trouvé ou erreur, on retourne null
        return null;
    }

    /**
     * Récupérer TOUS les services de la base de données
     * Utile pour afficher la liste complète sur une page
     * @return Liste de tous les services, vide si aucun ou si erreur
     */
    public List<Service> findAll() {
        // On prépare une liste vide pour stocker les résultats
        List<Service> services = new ArrayList<>();

        // Requête pour tout récupérer, triés par ID
        String sql = "SELECT * FROM services ORDER BY id";

        try (
                Connection connection = getConnection();
                // Statement simple car pas de paramètres
                Statement stmt = connection.createStatement();
                // On exécute directement la requête
                ResultSet rs = stmt.executeQuery(sql)
        ) {
            // On parcourt toutes les lignes du résultat
            while (rs.next()) {
                // Pour chaque ligne, on crée un objet Service et on l'ajoute à la liste
                services.add(extractServiceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des services : " + e.getMessage());
        }

        // On retourne la liste (peut être vide mais jamais null)
        return services;
    }

    /**
     * Trouver un service par son nom EXACT
     * Attention : sensible à la casse (majuscules/minuscules)
     * @param nom Le nom exact du service à chercher
     * @return Le Service trouvé ou null
     */
    public Service findByNom(String nom) {
        // Requête pour chercher par nom exact
        String sql = "SELECT * FROM services WHERE nom = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            // On remplace le ? par le nom recherché
            stmt.setString(1, nom);

            ResultSet rs = stmt.executeQuery();

            // Si trouvé, on le retourne
            if (rs.next()) {
                return extractServiceFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche par nom : " + e.getMessage());
        }

        return null;
    }

    /**
     * Rechercher des services par mot-clé
     * Cherche dans le nom ET la description (recherche partielle)
     * Exemple : search("hotel") trouvera "Réservation d'Hôtels"
     * @param keyword Le mot-clé à chercher
     * @return Liste des services correspondants
     */
    public List<Service> search(String keyword) {
        List<Service> services = new ArrayList<>();

        // LIKE avec % permet de chercher le mot n'importe où dans le texte
        // On cherche dans le nom OU dans la description
        String sql = "SELECT * FROM services WHERE nom LIKE ? OR description LIKE ? ORDER BY nom";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            // On ajoute % avant et après le mot-clé pour chercher partout
            // Exemple : "hotel" devient "%hotel%"
            String searchPattern = "%" + keyword + "%";

            // On met le même pattern pour les deux ?
            stmt.setString(1, searchPattern); // Pour chercher dans le nom
            stmt.setString(2, searchPattern); // Pour chercher dans la description

            ResultSet rs = stmt.executeQuery();

            // On ajoute tous les résultats trouvés
            while (rs.next()) {
                services.add(extractServiceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche : " + e.getMessage());
        }

        return services;
    }

    /**
     * Récupérer les services les plus récents
     * Utile pour afficher "Nos nouveaux services" sur la page d'accueil
     * @param limit Le nombre maximum de services à retourner
     * @return Liste des N services les plus récents
     */
    public List<Service> findRecent(int limit) {
        List<Service> services = new ArrayList<>();

        // ORDER BY date_creation DESC = du plus récent au plus ancien
        // LIMIT ? = on limite le nombre de résultats
        String sql = "SELECT * FROM services ORDER BY date_creation DESC LIMIT ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            // On définit combien de services on veut (ex: 3, 5, 10...)
            stmt.setInt(1, limit);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                services.add(extractServiceFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des services récents : " + e.getMessage());
        }

        return services;
    }

    /**
     * Mettre à jour TOUTES les informations d'un service existant
     * L'ID ne change pas, la date_creation non plus
     * @param service L'objet Service avec les nouvelles valeurs
     * @return true si la mise à jour a réussi
     */
    public boolean update(Service service) {
        // On met à jour tout sauf l'ID et la date_creation
        String sql = "UPDATE services SET nom = ?, description = ?, icone = ? WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            // On remplace les ? par les nouvelles valeurs
            stmt.setString(1, service.getNom());        // Nouveau nom
            stmt.setString(2, service.getDescription()); // Nouvelle description
            stmt.setString(3, service.getIcone());      // Nouvelle icône
            stmt.setInt(4, service.getId());            // WHERE id = ?

            // executeUpdate() retourne le nombre de lignes modifiées
            // Si > 0, c'est que ça a marché
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du service : " + e.getMessage());
        }

        return false;
    }

    /**
     * Mettre à jour SEULEMENT l'icône d'un service
     * Pratique quand on veut juste changer l'icône sans toucher au reste
     * @param id L'ID du service à modifier
     * @param nouvelleIcone La nouvelle icône (ex: "fa fa-star")
     * @return true si succès
     */
    public boolean updateIcone(int id, String nouvelleIcone) {
        // Requête simple pour changer juste l'icône
        String sql = "UPDATE services SET icone = ? WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, nouvelleIcone); // La nouvelle icône
            stmt.setInt(2, id);               // Pour quel service

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour de l'icône : " + e.getMessage());
        }

        return false;
    }

    /**
     * Supprimer définitivement un service de la base de données
     * ATTENTION : Cette action est irréversible !
     * @param id L'ID du service à supprimer
     * @return true si la suppression a réussi
     */
    public boolean delete(int id) {
        // DELETE supprime définitivement la ligne
        String sql = "DELETE FROM services WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            // On indique quel service supprimer
            stmt.setInt(1, id);

            // Si executeUpdate() > 0, c'est qu'une ligne a été supprimée
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression du service : " + e.getMessage());
        }

        return false;
    }

    /**
     * Compter le nombre total de services dans la base
     * Utile pour les statistiques ou la pagination
     * @return Le nombre de services, ou 0 si erreur
     */
    public int count() {
        // COUNT(*) compte toutes les lignes
        String sql = "SELECT COUNT(*) FROM services";

        try (
                Connection connection = getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)
        ) {
            // Le résultat est sur la première ligne, première colonne
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du comptage des services : " + e.getMessage());
        }

        // Si erreur, on retourne 0
        return 0;
    }

    /**
     * Vérifier si un nom de service existe déjà
     * Utile pour éviter les doublons avant de créer un nouveau service
     * @param nom Le nom à vérifier
     * @return true si le nom existe déjà, false sinon
     */
    public boolean nomExists(String nom) {
        // On compte combien de services ont ce nom
        String sql = "SELECT COUNT(*) FROM services WHERE nom = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, nom);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Si le count > 0, c'est que le nom existe
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la vérification du nom : " + e.getMessage());
        }

        // En cas d'erreur, on dit que ça n'existe pas
        return false;
    }

    /**
     * Méthode privée utilitaire pour convertir une ligne SQL en objet Service
     * Évite la répétition de code dans toutes les méthodes de recherche
     * @param rs Le ResultSet positionné sur une ligne
     * @return Un objet Service avec toutes les données
     */
    private Service extractServiceFromResultSet(ResultSet rs) throws SQLException {
        // On crée un nouveau Service vide
        Service service = new Service();

        // On remplit tous les champs depuis la base de données
        service.setId(rs.getInt("id"));                     // Colonne id
        service.setNom(rs.getString("nom"));                // Colonne nom
        service.setDescription(rs.getString("description")); // Colonne description
        service.setIcone(rs.getString("icone"));            // Colonne icone
        service.setDateCreation(rs.getTimestamp("date_creation")); // Colonne date_creation

        // On retourne le service complet
        return service;
    }

    /**
     * Méthode main pour tester toutes les fonctionnalités du DAO
     * Lancez cette méthode directement pour vérifier que tout fonctionne
     */
    public static void main(String[] args) {
        System.out.println("=== TEST SERVICE DAO ===");
        System.out.println("Début des tests de la classe ServiceDAO...\n");

        // On crée une instance du DAO pour faire les tests
        ServiceDAO dao = new ServiceDAO();

        // TEST 1 : Compter combien de services existent
        System.out.println("--- Test 1: Comptage ---");
        int nbServices = dao.count();
        System.out.println("Nombre de services dans la base : " + nbServices);

        // TEST 2 : Récupérer et afficher tous les services
        System.out.println("\n--- Test 2: Liste complète ---");
        List<Service> tousLesServices = dao.findAll();
        System.out.println("Services trouvés : " + tousLesServices.size());

        // On affiche chaque service avec ses détails
        for (Service s : tousLesServices) {
            System.out.println("- [" + s.getIcone() + "] " + s.getNom());
            System.out.println("  Description : " + s.getDescription());
        }

        // TEST 3 : Rechercher des services contenant un mot-clé
        System.out.println("\n--- Test 3: Recherche par mot-clé ---");
        String motCle = "hotel";
        System.out.println("Recherche du mot '" + motCle + "' :");
        List<Service> resultatsRecherche = dao.search(motCle);

        if (resultatsRecherche.isEmpty()) {
            System.out.println("Aucun service trouvé avec ce mot-clé");
        } else {
            for (Service s : resultatsRecherche) {
                System.out.println("- Trouvé : " + s.getNom());
            }
        }

        // TEST 4 : Afficher les services les plus récents
        System.out.println("\n--- Test 4: Services récents ---");
        int nombre = 3;
        System.out.println("Les " + nombre + " services les plus récents :");
        List<Service> servicesRecents = dao.findRecent(nombre);

        for (Service s : servicesRecents) {
            System.out.println("- " + s.getNom() + " (créé le " + s.getDateCreation() + ")");
        }

        // TEST 5 : Chercher un service spécifique par son ID
        System.out.println("\n--- Test 5: Recherche par ID ---");
        int idRecherche = 1;
        Service serviceParId = dao.findById(idRecherche);

        if (serviceParId != null) {
            System.out.println("Service #" + idRecherche + " trouvé :");
            System.out.println("  Nom : " + serviceParId.getNom());
            System.out.println("  Icône : " + serviceParId.getIcone());
        } else {
            System.out.println("Aucun service avec l'ID " + idRecherche);
        }

        // TEST 6 : Créer, modifier et supprimer un service de test
        System.out.println("\n--- Test 6: Opérations CRUD complètes ---");

        // D'abord on vérifie que le nom n'existe pas déjà
        String nomTest = "Service Test Temporaire";
        if (dao.nomExists(nomTest)) {
            System.out.println("Un service '" + nomTest + "' existe déjà !");
        } else {
            // On crée un nouveau service
            Service nouveauService = new Service(
                    nomTest,
                    "Ceci est un service de test qui sera supprimé",
                    "fa fa-test"
            );

            System.out.println("Création du service de test...");
            if (dao.create(nouveauService)) {
                System.out.println("✓ Service créé avec succès, ID = " + nouveauService.getId());

                // On modifie son icône
                System.out.println("Modification de l'icône...");
                if (dao.updateIcone(nouveauService.getId(), "fa fa-check")) {
                    System.out.println("✓ Icône modifiée avec succès");
                }

                // On le supprime pour nettoyer
                System.out.println("Suppression du service de test...");
                if (dao.delete(nouveauService.getId())) {
                    System.out.println("✓ Service de test supprimé");
                }
            } else {
                System.out.println("✗ Échec de la création du service");
            }
        }

        System.out.println("\n=== TESTS TERMINÉS AVEC SUCCÈS ===");
    }
}