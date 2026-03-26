package com.visitonsmonde.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Factory pour gérer les connexions à la base de données.
 * Centralise la configuration JDBC et fournit des connexions aux DAO.
 */
public class DAOFactory {

    // Configuration de la base de données
    private static final String JDBC_URL = "jdbc:mysql://localhost:8889/tourisme_db?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "root";
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    // Bloc statique pour charger le driver une seule fois
    static {
        try {
            Class.forName(JDBC_DRIVER);
            System.out.println("✅ Driver MySQL chargé avec succès");
        } catch (ClassNotFoundException e) {
            System.err.println(" Erreur chargement driver MySQL : " + e.getMessage());
            throw new RuntimeException("Driver MySQL non trouvé", e);
        }
    }

    /**
     * Obtient une nouvelle connexion à la base de données.
     *
     * @return Connection active vers la base
     * @throws SQLException si erreur de connexion
     */
    public static Connection getConnection() throws SQLException {
        try {
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
            System.out.println("🔗 Connexion établie à la base de données");
            return connection;
        } catch (SQLException e) {
            System.err.println(" Erreur connexion base de données : " + e.getMessage());
            throw e;
        }
    }

    /**
     * Teste la connexion à la base de données.
     *
     * @return true si la connexion fonctionne
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            System.out.println(" Test de connexion réussi");
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println(" Test de connexion échoué : " + e.getMessage());
            return false;
        }
    }

    /**
     * Ferme proprement une connexion.
     *
     * @param connection la connexion à fermer
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("🔒 Connexion fermée");
            } catch (SQLException e) {
                System.err.println("⚠ Erreur fermeture connexion : " + e.getMessage());
            }
        }
    }

    /**
     * Point d'entrée pour tester la factory.
     */
    public static void main(String[] args) {
        System.out.println("=== TEST DAO FACTORY ===");

        // Test 1: Chargement du driver
        System.out.println("\n📦 Driver chargé automatiquement");

        // Test 2: Test de connexion
        System.out.println("\n Test de connexion :");
        boolean connected = testConnection();

        if (connected) {
            System.out.println(" DAOFactory prête à être utilisée");
        } else {
            System.out.println(" Problème de configuration de la base");
        }

        // Test 3: Connexion manuelle
        System.out.println("\n Test connexion manuelle :");
        try {
            Connection conn = getConnection();
            System.out.println("   → Connexion obtenue : " + conn.getClass().getSimpleName());
            closeConnection(conn);
        } catch (SQLException e) {
            System.err.println("   → Erreur : " + e.getMessage());
        }

        System.out.println("\n Tests terminés !");
    }
}