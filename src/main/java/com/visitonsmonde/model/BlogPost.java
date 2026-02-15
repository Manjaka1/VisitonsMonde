package com.visitonsmonde.model;

import java.util.Date;

public class BlogPost {
    private int id;
    private String titre;
    private String contenu;
    private String image;
    private String auteur;
    private Date datePublication;
    private String categorie;
    private boolean estPublie;

    // Constructeurs
    public BlogPost() {}

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getContenu() { return contenu; }
    public void setContenu(String contenu) { this.contenu = contenu; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getAuteur() { return auteur; }
    public void setAuteur(String auteur) { this.auteur = auteur; }

    public Date getDatePublication() { return datePublication; }
    public void setDatePublication(Date datePublication) { this.datePublication = datePublication; }

    public String getCategorie() { return categorie; }
    public void setCategorie(String categorie) { this.categorie = categorie; }

    public boolean isEstPublie() { return estPublie; }
    public void setEstPublie(boolean estPublie) { this.estPublie = estPublie; }

    public String getExtrait() {
        if (contenu != null && contenu.length() > 150) {
            return contenu.substring(0, 150) + "...";
        }
        return contenu;
    }
}