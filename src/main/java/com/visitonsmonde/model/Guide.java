package com.visitonsmonde.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Guide {
    private int id;
    private String nom;
    private String prenom;
    private String specialite;
    private int experienceAnnees;
    private String languesParlees;
    private String photo;
    private String description;
    private BigDecimal noteMoyenne;
    private String email;
    private String telephone;
    private Date dateEmbauche;

    // NOUVEAUX ATTRIBUTS
    private String statut;
    private Integer utilisateurId;
    private Timestamp dateInscription;

    // Constructeur par défaut
    public Guide() {
    }

    // Constructeur complet
    public Guide(int id, String nom, String prenom, String specialite,
                 int experienceAnnees, String languesParlees, String photo,
                 String description, BigDecimal noteMoyenne, String email,
                 String telephone, Date dateEmbauche) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.specialite = specialite;
        this.experienceAnnees = experienceAnnees;
        this.languesParlees = languesParlees;
        this.photo = photo;
        this.description = description;
        this.noteMoyenne = noteMoyenne;
        this.email = email;
        this.telephone = telephone;
        this.dateEmbauche = dateEmbauche;
    }

    // Getters et Setters
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

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public int getExperienceAnnees() {
        return experienceAnnees;
    }

    public void setExperienceAnnees(int experienceAnnees) {
        this.experienceAnnees = experienceAnnees;
    }

    public String getLanguesParlees() {
        return languesParlees;
    }

    public void setLanguesParlees(String languesParlees) {
        this.languesParlees = languesParlees;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getNoteMoyenne() {
        return noteMoyenne;
    }

    public void setNoteMoyenne(BigDecimal noteMoyenne) {
        this.noteMoyenne = noteMoyenne;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Date getDateEmbauche() {
        return dateEmbauche;
    }

    public void setDateEmbauche(Date dateEmbauche) {
        this.dateEmbauche = dateEmbauche;
    }

    // NOUVEAUX GETTERS/SETTERS
    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Integer getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(Integer utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public Timestamp getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription(Timestamp dateInscription) {
        this.dateInscription = dateInscription;
    }

    public String getNomComplet() {
        return prenom + " " + nom;
    }

    @Override
    public String toString() {
        return "Guide{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", specialite='" + specialite + '\'' +
                ", experienceAnnees=" + experienceAnnees +
                ", statut='" + statut + '\'' +
                ", noteMoyenne=" + noteMoyenne +
                '}';
    }
}