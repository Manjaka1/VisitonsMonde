package com.visitonsmonde.model;

import java.util.Date;

public class Testimonial {
    private int id;
    private String nom;
    private String ville;
    private String pays;
    private int note;
    private String commentaire;
    private String photo;
    private Date datePublication;
    private boolean estActif;

    // Constructeurs
    public Testimonial() {}

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }

    public String getPays() { return pays; }
    public void setPays(String pays) { this.pays = pays; }

    public int getNote() { return note; }
    public void setNote(int note) { this.note = note; }

    public String getCommentaire() { return commentaire; }
    public void setCommentaire(String commentaire) { this.commentaire = commentaire; }

    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }

    public Date getDatePublication() { return datePublication; }
    public void setDatePublication(Date datePublication) { this.datePublication = datePublication; }

    public boolean isEstActif() { return estActif; }
    public void setEstActif(boolean estActif) { this.estActif = estActif; }

    public String getLocation() {
        if (ville != null && pays != null) {
            return ville + ", " + pays;
        }
        return pays != null ? pays : "";
    }
}