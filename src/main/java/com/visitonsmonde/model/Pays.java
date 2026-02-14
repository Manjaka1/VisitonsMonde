package com.visitonsmonde.model;

import java.sql.Timestamp;

/**
 * Modèle représentant un pays dans la base de données.
 * Correspond EXACTEMENT à la table 'pays' de votre BDD tourisme_db.
 */
public class Pays {

    // Attributs correspondant aux colonnes de la table 'pays'
    private int id;
    private String nom;
    private String code;
    private String continent;

    // Attributs additionnels présents dans votre classe existante
    // (même s'ils ne sont pas en BDD, ils peuvent être utiles)
    private String capitale;
    private String langue;
    private String monnaie;
    private String description;
    private String drapeau;
    private Timestamp dateCreation;

    // Constructeurs
    public Pays() {}

    // Constructeur avec paramètres principaux (correspond à votre BDD)
    public Pays(String nom, String code, String continent) {
        this.nom = nom;
        this.code = code;
        this.continent = continent;
    }

    // Constructeur avec ID (utilisé par DAO)
    public Pays(int id, String nom, String code, String continent) {
        this.id = id;
        this.nom = nom;
        this.code = code;
        this.continent = continent;
    }

    // Getters et Setters pour les 4 attributs principaux (BDD)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getContinent() {
        return continent;
    }

    public void setContinent(String continent) {
        this.continent = continent;
    }

    // Getters et Setters pour les attributs additionnels
    public String getCapitale() {
        return capitale;
    }

    public void setCapitale(String capitale) {
        this.capitale = capitale;
    }

    public String getLangue() {
        return langue;
    }

    public void setLangue(String langue) {
        this.langue = langue;
    }

    public String getMonnaie() {
        return monnaie;
    }

    public void setMonnaie(String monnaie) {
        this.monnaie = monnaie;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDrapeau() {
        return drapeau;
    }

    public void setDrapeau(String drapeau) {
        this.drapeau = drapeau;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

    // Méthodes utilitaires
    public String getNomComplet() {
        if (capitale != null && !capitale.isEmpty()) {
            return nom + " (Capitale: " + capitale + ")";
        }
        return nom;
    }

    public String getAffichage() {
        return nom + " (" + code + ")" +
                (continent != null ? " - " + continent : "");
    }

    public boolean isValide() {
        return nom != null && !nom.trim().isEmpty() &&
                code != null && !code.trim().isEmpty() &&
                code.trim().length() >= 2 && code.trim().length() <= 3; // Ajoute .trim()
    }

    @Override
    public String toString() {
        return "Pays{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", code='" + code + '\'' +
                ", continent='" + continent + '\'' +
                ", capitale='" + capitale + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Pays pays = (Pays) obj;
        return id == pays.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}