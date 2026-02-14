/* package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Modèle représentant un paiement dans le système
 */
/* public class Paiement {

    // Énumération pour les statuts de paiement
    public enum StatutPaiement {
        EN_ATTENTE("en_attente"),
        REUSSI("reussi"),
        ECHOUE("echoue"),
        ANNULE("annule"),
        REMBOURSE("rembourse");

        private final String valeur;

        StatutPaiement(String valeur) {
            this.valeur = valeur;
        }

        public String getValeur() {
            return valeur;
        }

        public static StatutPaiement fromString(String valeur) {
            for (StatutPaiement statut : StatutPaiement.values()) {
                if (statut.valeur.equals(valeur)) {
                    return statut;
                }
            }
            throw new IllegalArgumentException("Statut paiement inconnu: " + valeur);
        }
    }

    // Énumération pour les méthodes de paiement
    public enum MethodePaiement {
        CARTE_BANCAIRE("carte_bancaire"),
        PAYPAL("paypal"),
        VIREMENT("virement"),
        STRIPE("stripe"),
        SIMULATION("simulation");

        private final String valeur;

        MethodePaiement(String valeur) {
            this.valeur = valeur;
        }

        public String getValeur() {
            return valeur;
        }

        public static MethodePaiement fromString(String valeur) {
            for (MethodePaiement methode : MethodePaiement.values()) {
                if (methode.valeur.equals(valeur)) {
                    return methode;
                }
            }
            throw new IllegalArgumentException("Méthode paiement inconnue: " + valeur);
        }
    }

    private int id;
    private int reservationId;
    private String numeroTransaction;
    private BigDecimal montant;
    private String devise;
    private MethodePaiement methodePaiement;
    private StatutPaiement statut;
    private String referenceExterne; // ID transaction Stripe/PayPal
    private String messageErreur;
    private Timestamp datePaiement;
    private Timestamp dateCreation;
    private Timestamp dateModification;

    // Informations de la réservation (pour les jointures)
    private String numeroReservation;
    private String clientNom;
    private String clientPrenom;
    private String clientEmail;
    private String destinationNom;

    // Constructeurs
    public Paiement() {
        this.devise = "EUR";
        this.statut = StatutPaiement.EN_ATTENTE;
        this.dateCreation = new Timestamp(System.currentTimeMillis());
    }

    public Paiement(int reservationId, BigDecimal montant, MethodePaiement methodePaiement) {
        this();
        this.reservationId = reservationId;
        this.montant = montant;
        this.methodePaiement = methodePaiement;
        this.numeroTransaction = genererNumeroTransaction();
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public String getNumeroTransaction() {
        return numeroTransaction;
    }

    public void setNumeroTransaction(String numeroTransaction) {
        this.numeroTransaction = numeroTransaction;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public MethodePaiement getMethodePaiement() {
        return methodePaiement;
    }

    public void setMethodePaiement(MethodePaiement methodePaiement) {
        this.methodePaiement = methodePaiement;
    }

    public StatutPaiement getStatut() {
        return statut;
    }

    public void setStatut(StatutPaiement statut) {
        this.statut = statut;
        this.dateModification = new Timestamp(System.currentTimeMillis());
    }

    public String getReferenceExterne() {
        return referenceExterne;
    }

    public void setReferenceExterne(String referenceExterne) {
        this.referenceExterne = referenceExterne;
    }

    public String getMessageErreur() {
        return messageErreur;
    }

    public void setMessageErreur(String messageErreur) {
        this.messageErreur = messageErreur;
    }

    public Timestamp getDatePaiement() {
        return datePaiement;
    }

    public void setDatePaiement(Timestamp datePaiement) {
        this.datePaiement = datePaiement;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Timestamp getDateModification() {
        return dateModification;
    }

    public void setDateModification(Timestamp dateModification) {
        this.dateModification = dateModification;
    }

    // Propriétés de jointure
    public String getNumeroReservation() {
        return numeroReservation;
    }

    public void setNumeroReservation(String numeroReservation) {
        this.numeroReservation = numeroReservation;
    }

    public String getClientNom() {
        return clientNom;
    }

    public void setClientNom(String clientNom) {
        this.clientNom = clientNom;
    }

    public String getClientPrenom() {
        return clientPrenom;
    }

    public void setClientPrenom(String clientPrenom) {
        this.clientPrenom = clientPrenom;
    }

    public String getClientEmail() {
        return clientEmail;
    }

    public void setClientEmail(String clientEmail) {
        this.clientEmail = clientEmail;
    }

    public String getDestinationNom() {
        return destinationNom;
    }

    public void setDestinationNom(String destinationNom) {
        this.destinationNom = destinationNom;
    }

    // Méthodes utilitaires
    public String getClientNomComplet() {
        if (clientPrenom != null && clientNom != null) {
            return clientPrenom + " " + clientNom;
        }
        return "Client non défini";
    }

    public boolean isPaiementReussi() {
        return statut == StatutPaiement.REUSSI;
    }

    public boolean isPaiementEnAttente() {
        return statut == StatutPaiement.EN_ATTENTE;
    }

    public boolean isPaiementEchoue() {
        return statut == StatutPaiement.ECHOUE;
    }

    public String getStatutLibelle() {
       // return switch (statut) {
           // case EN_ATTENTE -> "En attente";
            //case REUSSI -> "Réussi";
            //case ECHOUE -> "Échec";
            //case ANNULE -> "Annulé";
            //case REMBOURSE -> "Remboursé";
        //};
    // }
/*
    public String getMethodePaiementLibelle() {
        return switch (methodePaiement) {
            case CARTE_BANCAIRE -> "Carte bancaire";
            case MethodePaiement.PAYPAL -> "PayPal";
            case VIREMENT -> "Virement bancaire";
            case STRIPE -> "Stripe";
            case SIMULATION -> "Simulation";
        };
    }
    +/
 */

    /**
     * Génère un numéro de transaction unique
     */
   /* private String genererNumeroTransaction() {
        return "PAY-" + System.currentTimeMillis();
    }

    /**
     * Marquer le paiement comme réussi
     */
    /* public void marquerReussi(String referenceExterne) {
        this.statut = StatutPaiement.REUSSI;
        this.referenceExterne = referenceExterne;
        this.datePaiement = new Timestamp(System.currentTimeMillis());
        this.dateModification = new Timestamp(System.currentTimeMillis());
        this.messageErreur = null;
    }

    /**
     * Marquer le paiement comme échoué
     */
    /* public void marquerEchoue(String messageErreur) {
        this.statut = StatutPaiement.ECHOUE;
        this.messageErreur = messageErreur;
        this.dateModification = new Timestamp(System.currentTimeMillis());
    }

    /**
     * Annuler le paiement
     */
    /* public void annuler(String raison) {
        this.statut = StatutPaiement.ANNULE;
        this.messageErreur = raison;
        this.dateModification = new Timestamp(System.currentTimeMillis());
    }

    @Override
    public String toString() {
        return "Paiement{" +
                "id=" + id +
                ", numeroTransaction='" + numeroTransaction + '\'' +
                ", montant=" + montant +
                ", statut=" + statut +
                ", methodePaiement=" + methodePaiement +
                ", dateCreation=" + dateCreation +
                '}';
    }
} */