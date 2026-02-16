package com.visitonsmonde.model;

import java.util.Date;

public class GalleryImage {
    private int id;
    private String titre;
    private String description;
    private String image;
    private int categoryId;
    private int ordre;
    private boolean estActif;
    private Date dateAjout;

    public GalleryImage() {}

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getOrdre() { return ordre; }
    public void setOrdre(int ordre) { this.ordre = ordre; }

    public boolean isEstActif() { return estActif; }
    public void setEstActif(boolean estActif) { this.estActif = estActif; }

    public Date getDateAjout() { return dateAjout; }
    public void setDateAjout(Date dateAjout) { this.dateAjout = dateAjout; }
}