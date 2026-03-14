package com.visitonsmonde.model;

import java.sql.Timestamp;
import java.util.Date;

public class Blog {
    private int id;
    private String titre;
    private String auteur;
    private Date datePublication;
    private String image;
    private String descriptionCourte;
    private String contenu;
    private int likes;
    private int commentaires;
    private boolean actif;
    private Timestamp createdAt;

    // Constructeur vide
    public Blog() {
    }

    // Constructeur complet
    public Blog(int id, String titre, String auteur, Date datePublication, String image,
                String descriptionCourte, String contenu, int likes, int commentaires,
                boolean actif, Timestamp createdAt) {
        this.id = id;
        this.titre = titre;
        this.auteur = auteur;
        this.datePublication = datePublication;
        this.image = image;
        this.descriptionCourte = descriptionCourte;
        this.contenu = contenu;
        this.likes = likes;
        this.commentaires = commentaires;
        this.actif = actif;
        this.createdAt = createdAt;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getAuteur() {
        return auteur;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }

    public Date getDatePublication() {
        return datePublication;
    }

    public void setDatePublication(Date datePublication) {
        this.datePublication = datePublication;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescriptionCourte() {
        return descriptionCourte;
    }

    public void setDescriptionCourte(String descriptionCourte) {
        this.descriptionCourte = descriptionCourte;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getCommentaires() {
        return commentaires;
    }

    public void setCommentaires(int commentaires) {
        this.commentaires = commentaires;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Blog{" +
                "id=" + id +
                ", titre='" + titre + '\'' +
                ", auteur='" + auteur + '\'' +
                ", datePublication=" + datePublication +
                ", image='" + image + '\'' +
                ", likes=" + likes +
                ", commentaires=" + commentaires +
                ", actif=" + actif +
                '}';
    }
}