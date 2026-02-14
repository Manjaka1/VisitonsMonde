package com.visitonsmonde.service;

import jakarta.mail.*;


import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

    // Configuration email (à adapter selon ton serveur SMTP)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "noreply@visitonsmonde.com"; // Email expéditeur
    private static final String EMAIL_PASSWORD = "ton_mot_de_passe_app"; // Mot de passe d'application Gmail
    private static final boolean USE_TLS = true;

    /**
     * Envoyer un email simple
     */
    public static boolean sendEmail(String destinataire, String sujet, String contenu) {
        try {
            // Configuration des propriétés SMTP
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", String.valueOf(USE_TLS));
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);

            // Authentification
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
                }
            });

            // Création du message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM, "VisitonsMonde"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinataire));
            message.setSubject(sujet);
            message.setContent(contenu, "text/html; charset=utf-8");

            // Envoi
            Transport.send(message);

            System.out.println("✅ Email envoyé à : " + destinataire);
            return true;

        } catch (Exception e) {
            System.err.println("❌ Erreur envoi email à " + destinataire + " : " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Email d'approbation guide
     */
    public static boolean envoyerEmailApprobation(String destinataire, String nomGuide) {
        String sujet = "🎉 Félicitations ! Votre candidature a été approuvée";

        String contenu = String.format("""
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                <div style="background: linear-gradient(135deg, #667eea 0%%, #764ba2 100%%); padding: 40px; text-align: center;">
                    <h1 style="color: white; margin: 0;">🎉 Félicitations !</h1>
                </div>
                
                <div style="padding: 40px; background: #f8f9fa;">
                    <h2 style="color: #2c3e50;">Bonjour %s,</h2>
                    
                    <p style="font-size: 16px; line-height: 1.6; color: #555;">
                        Nous avons le plaisir de vous informer que votre candidature en tant que guide touristique 
                        a été <strong style="color: #28a745;">approuvée</strong> !
                    </p>
                    
                    <div style="background: white; padding: 20px; border-radius: 10px; margin: 20px 0;">
                        <h3 style="color: #667eea;">✅ Votre compte est maintenant actif</h3>
                        <p style="color: #555;">
                            Vous pouvez dès maintenant vous connecter à votre espace guide et commencer à accueillir vos premiers clients.
                        </p>
                    </div>
                    
                    <div style="text-align: center; margin: 30px 0;">
                        <a href="http://localhost:8080/VisitonsMonde_war_exploded/espace-guide" 
                           style="background: #28a745; color: white; padding: 15px 30px; 
                                  text-decoration: none; border-radius: 5px; display: inline-block;">
                            Accéder à mon espace guide
                        </a>
                    </div>
                    
                    <p style="color: #777; font-size: 14px;">
                        Bienvenue dans l'équipe VisitonsMonde ! 🌍
                    </p>
                </div>
                
                <div style="background: #2c3e50; padding: 20px; text-align: center;">
                    <p style="color: white; margin: 0; font-size: 12px;">
                        © 2026 VisitonsMonde - Tous droits réservés
                    </p>
                </div>
            </div>
            """, nomGuide);

        return sendEmail(destinataire, sujet, contenu);
    }

    /**
     * Email de refus guide
     */
    public static boolean envoyerEmailRefus(String destinataire, String nomGuide) {
        String sujet = "Votre candidature VisitonsMonde";

        String contenu = String.format("""
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                <div style="background: linear-gradient(135deg, #667eea 0%%, #764ba2 100%%); padding: 40px; text-align: center;">
                    <h1 style="color: white; margin: 0;">VisitonsMonde</h1>
                </div>
                
                <div style="padding: 40px; background: #f8f9fa;">
                    <h2 style="color: #2c3e50;">Bonjour %s,</h2>
                    
                    <p style="font-size: 16px; line-height: 1.6; color: #555;">
                        Nous vous remercions pour l'intérêt que vous portez à VisitonsMonde.
                    </p>
                    
                    <p style="font-size: 16px; line-height: 1.6; color: #555;">
                        Après étude de votre candidature, nous sommes au regret de vous informer que 
                        nous ne pouvons pas donner suite à votre demande pour le moment.
                    </p>
                    
                    <div style="background: white; padding: 20px; border-radius: 10px; margin: 20px 0;">
                        <p style="color: #555;">
                            Nous vous encourageons à postuler à nouveau dans le futur lorsque vous aurez 
                            acquis plus d'expérience ou de certifications supplémentaires.
                        </p>
                    </div>
                    
                    <p style="color: #777; font-size: 14px;">
                        Nous vous souhaitons beaucoup de succès dans vos projets futurs.
                    </p>
                    
                    <p style="color: #555;">
                        Cordialement,<br>
                        L'équipe VisitonsMonde
                    </p>
                </div>
                
                <div style="background: #2c3e50; padding: 20px; text-align: center;">
                    <p style="color: white; margin: 0; font-size: 12px;">
                        © 2026 VisitonsMonde - Tous droits réservés
                    </p>
                </div>
            </div>
            """, nomGuide);

        return sendEmail(destinataire, sujet, contenu);
    }
}