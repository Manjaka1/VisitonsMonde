package com.visitonsmonde.model;


import java.sql.Timestamp;

/**
 *
 * @author manjaka
 */
public class TypeTour {

    // Attributs
    private int id;
    private String nom;
    private String description;
    private String image;
    private Timestamp dateCreation;

    // Constructeurs
    public TypeTour() {
        this.dateCreation = new Timestamp(System.currentTimeMillis());
    }

    public TypeTour(String nom, String description, String image) {
        this();
        this.nom = nom;
        this.description = description;
        this.image = image;
    }

    public TypeTour(int id, String nom, String description, String image, Timestamp dateCreation) {
        this.id = id;
        this.nom = nom;
        this.description = description;
        this.image = image;
        this.dateCreation = dateCreation;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getDescription() {
        return description;
    }

    public String getImage() {
        return image;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

    // Méthodes utiles

    /**
     * Vérifie si le type de tour a une description
     */
    public boolean aUneDescription() {
        return description != null && !description.trim().isEmpty();
    }

    /**
     * Vérifie si le type de tour a une image
     */
    public boolean aUneImage() {
        return image != null && !image.trim().isEmpty();
    }

    /**
     * Retourne une description courte (100 premiers caractères)
     */
    public String getDescriptionCourte() {
        if (description == null) return "";

        if (description.length() <= 100) {
            return description;
        }

        return description.substring(0, 97) + "...";
    }

    /**
     * Vérifie si c'est un type de tour familial
     */
    public boolean estFamilial() {
        if (nom == null) return false;
        return nom.toLowerCase().contains("family") || nom.toLowerCase().contains("famille");
    }

    /**
     * Vérifie si c'est un type de tour de weekend
     */
    public boolean estWeekend() {
        if (nom == null) return false;
        return nom.toLowerCase().contains("weekend") || nom.toLowerCase().contains("week-end");
    }

    /**
     * Vérifie si c'est un type de tour historique
     */
    public boolean estHistorique() {
        if (nom == null) return false;
        return nom.toLowerCase().contains("historical") || nom.toLowerCase().contains("historique");
    }

    /**
     * Vérifie si c'est un type de tour de plage
     */
    public boolean estPlage() {
        if (nom == null) return false;
        return nom.toLowerCase().contains("beach") || nom.toLowerCase().contains("plage");
    }

    /**
     * Vérifie si c'est un type de tour d'aventure
     */
    public boolean estAventure() {
        if (nom == null || description == null) return false;
        String texte = (nom + " " + description).toLowerCase();
        return texte.contains("aventure") || texte.contains("adventure") ||
                texte.contains("road trip") || texte.contains("nature");
    }

    /**
     * Retourne le chemin complet de l'image
     */
    public String getCheminImage() {
        if (image == null) return "img/default-tour.jpg";
        return "img/" + image;
    }

    // Méthodes Object
    @Override
    public String toString() {
        return "TypeTour{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", description='" + getDescriptionCourte() + '\'' +
                ", image='" + image + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        TypeTour typeTour = (TypeTour) obj;
        return id == typeTour.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}