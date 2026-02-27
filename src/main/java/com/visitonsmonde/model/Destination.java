package com.visitonsmonde.model;


import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Représente une destination touristique.
 * Correspond exactement à la table "destinations" de la base de données.
 */
public class Destination {

    // Les mêmes colonnes que dans votre table BDD
    private Integer id;
    private String nom;
    private String description;
    private String image;
    private String pays;           // Nom du pays (pour l'affichage)
    private Integer paysId;        // ID du pays (clé étrangère)
    private Integer nbPhotos;
    private BigDecimal prix;
    private LocalDateTime dateCreation;
    private LocalDateTime dateModification;
    private Integer typeTourId;       // ID du type de tour
    private String typeTour;          // Nom du type de tour


    // Constructeur vide (obligatoire)
    public Destination() {
    }

    // Constructeur pour créer une nouvelle destination
    public Destination(String nom, String pays, BigDecimal prix) {
        this.nom = nom;
        this.pays = pays;
        this.prix = prix;
        this.nbPhotos = 0; // valeur par défaut
    }

    // Getters et Setters (obligatoires pour accéder aux données)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public Integer getPaysId() {
        return paysId;
    }

    public void setPaysId(Integer paysId) {
        this.paysId = paysId;
    }

    public Integer getNbPhotos() {
        return nbPhotos;
    }

    public void setNbPhotos(Integer nbPhotos) {
        this.nbPhotos = nbPhotos;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }

    public LocalDateTime getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }

    public LocalDateTime getDateModification() {
        return dateModification;
    }

    public void setDateModification(LocalDateTime dateModification) {
        this.dateModification = dateModification;
    }

    // Getters et Setters pour typeTourId et typeTour
    public Integer getTypeTourId() {
        return typeTourId;
    }

    public void setTypeTourId(Integer typeTourId) {
        this.typeTourId = typeTourId;
    }

    public String getTypeTour() {
        return typeTour;
    }

    public void setTypeTour(String typeTour) {
        this.typeTour = typeTour;
    }

    // Méthode pour affichage simple
    @Override
    public String toString() {
        return "Destination: " + nom + " (" + pays + ") - " + prix + "€" +
                (typeTour != null ? " - " + typeTour : "");
    }
}
