package com.visitonsmonde.model;


import java.sql.Timestamp;

/**
 *
 * @author manjaka
 */
public class Service {

    private int id;
    private String nom;
    private String description;
    private String icone;
    private Timestamp dateCreation;

    // Constructeurs
    public Service() {
    }

    public Service(String nom, String description, String icone) {
        this.nom = nom;
        this.description = description;
        this.icone = icone;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIcone() {
        return icone;
    }

    public void setIcone(String icone) {
        this.icone = icone;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

    // Méthodes utilitaires
    @Override
    public String toString() {
        return "Service{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                ", icone='" + icone + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Service service = (Service) obj;
        return id == service.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}
