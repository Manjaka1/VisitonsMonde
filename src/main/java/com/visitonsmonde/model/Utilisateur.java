package com.visitonsmonde.model;

import java.sql.Timestamp;

public class Utilisateur {

    // Attributs
    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String motDePasse;
    private String role; // 'CLIENT' ou 'ADMIN'
    private boolean estActif;
    private Timestamp dateInscription;
    private Timestamp dateDerniereConnexion;
    private String tokenReinitialisation;
    private Timestamp expirationToken;

    // Constructeurs
    public Utilisateur() {
        this.dateInscription = new Timestamp(System.currentTimeMillis());
        this.role = "CLIENT";
        this.estActif = true;
    }

    public Utilisateur(String nom, String prenom, String email, String motDePasse) {
        this();
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.motDePasse = motDePasse;
    }

    public Utilisateur(int id, String nom, String prenom, String email,
                       String motDePasse, Timestamp dateInscription) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.dateInscription = dateInscription;
        this.role = "CLIENT";
        this.estActif = true;
    }

    public Utilisateur(int id, String nom, String prenom, String email,
                       String motDePasse, String role, boolean estActif,
                       Timestamp dateInscription, Timestamp dateDerniereConnexion,
                       String tokenReinitialisation, Timestamp expirationToken) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.role = role;
        this.estActif = estActif;
        this.dateInscription = dateInscription;
        this.dateDerniereConnexion = dateDerniereConnexion;
        this.tokenReinitialisation = tokenReinitialisation;
        this.expirationToken = expirationToken;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getEmail() {
        return email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public String getRole() {
        return role;
    }

    public boolean isEstActif() {
        return estActif;
    }

    public Timestamp getDateInscription() {
        return dateInscription;
    }

    public Timestamp getDateDerniereConnexion() {
        return dateDerniereConnexion;
    }

    public String getTokenReinitialisation() {
        return tokenReinitialisation;
    }

    public Timestamp getExpirationToken() {
        return expirationToken;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setEstActif(boolean estActif) {
        this.estActif = estActif;
    }

    public void setDateInscription(Timestamp dateInscription) {
        this.dateInscription = dateInscription;
    }

    public void setDateDerniereConnexion(Timestamp dateDerniereConnexion) {
        this.dateDerniereConnexion = dateDerniereConnexion;
    }

    public void setTokenReinitialisation(String tokenReinitialisation) {
        this.tokenReinitialisation = tokenReinitialisation;
    }

    public void setExpirationToken(Timestamp expirationToken) {
        this.expirationToken = expirationToken;
    }

    // Méthode pour vérifier si l'utilisateur est admin
    public boolean isAdmin() {
        return "ADMIN".equals(role);
    }

    // Méthodes utiles
    public String getNomComplet() {
        return prenom + " " + nom;
    }

    public boolean emailValide() {
        return email != null && email.contains("@") && email.contains(".");
    }

    public boolean motDePasseValide() {
        return motDePasse != null && motDePasse.length() >= 6;
    }

    public boolean estNouvelUtilisateur() {
        if (dateInscription == null) return false;

        long maintenant = System.currentTimeMillis();
        long inscription = dateInscription.getTime();
        long diff = maintenant - inscription;
        long trentejours = 30L * 24L * 60L * 60L * 1000L;

        return diff <= trentejours;
    }

    public boolean isClient() {
        return "CLIENT".equals(role);
    }

    public boolean peutSeConnecter() {
        return estActif;
    }

    public boolean tokenReinitialisationValide() {
        return tokenReinitialisation != null &&
                expirationToken != null &&
                expirationToken.after(new Timestamp(System.currentTimeMillis()));
    }

    // Méthodes Object
    @Override
    public String toString() {
        return "Utilisateur{" +
                "id=" + id +
                ", nomComplet='" + getNomComplet() + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                ", estActif=" + estActif +
                ", dateInscription=" + dateInscription +
                ", dateDerniereConnexion=" + dateDerniereConnexion +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Utilisateur that = (Utilisateur) obj;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}
