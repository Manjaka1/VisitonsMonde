package com.visitonsmonde.util;

public class GenerateHashes {
    public static void main(String[] args) {
        String[][] users = {
                {"1", "password123"},
                {"2", "rahary"},
                {"3", "katenosy"},
                {"4", "admin123"},
                {"5", "admin123"},
                {"6", "jeanboto"},
                {"7", "nomenafranck"},
                {"8", "admin123"},
                {"9", "Guide123"},
                {"10", "Guide123"},
                {"11", "Guide123"},
                {"12", "Guide123"}
        };

        System.out.println("-- Copie ces requêtes dans phpMyAdmin :\n");

        for (String[] user : users) {
            String hash = PasswordUtil.hashPassword(user[1]);
            System.out.println("UPDATE utilisateurs SET mot_de_passe = '" + hash + "' WHERE id = " + user[0] + "; -- " + user[1]);
        }
    }
}