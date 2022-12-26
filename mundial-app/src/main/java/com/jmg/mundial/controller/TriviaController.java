/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.controller;


import com.jmg.mundial.model.*;
import com.jmg.mundial.view.VJUGARPOR;
import com.jmg.mundial.view.VPREGUNTAS;

import javax.swing.*;
import java.sql.*;
import java.util.Random;

public class TriviaController {

    private static int retornarvalorrandom(String nivel) throws ClassNotFoundException, SQLException {
        int topepreguntas = 0;
        Class.forName("com.mysql.jdbc.Driver");
        try (java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "")) {
            java.sql.Statement statement = conn.createStatement();
            ResultSet rs;

            rs = statement.executeQuery("SELECT count(*) as cant FROM preguntas");

            if (rs.next()) {
                topepreguntas = rs.getInt("cant");
            }
            rs.close();
        }
        return topepreguntas;
    }

    public static VPREGUNTAS crearpregunta(Figurita fig, ComboFigurita nivel, Partida partida, VJUGARPOR A) throws ClassNotFoundException, SQLException {
        Respuesta[] respu;
        int topepreguntas = 0;
        String difi;
        if (fig == null) {
            difi = nivel.getDificultadcombo();
            topepreguntas = retornarvalorrandom(difi);
        } else {
            difi = fig.getDificultad();
            topepreguntas = retornarvalorrandom(difi);
        }
        Pregunta preguntitas = null;

        VPREGUNTAS tablapreguntas = new VPREGUNTAS();

        if (topepreguntas != 0) {
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "");
            java.sql.Statement statement = conn.createStatement();
            ResultSet rs;
            int i;
            Random rnd = new Random();
            int pregun = (int) (rnd.nextDouble() * (topepreguntas - 1) + 1);


            rs = statement.executeQuery("SELECT  preguntas.PREGUNTA AS PREG, " + "preguntas.NIVELDIFICULTAD AS NIVEL, respuestas.RESPUESTA AS RESP, " + "respuestas.CORRECTA AS CORREC FROM preguntas,respuestas " + "WHERE  " + "preguntas.CODIGOPREGUNTA = respuestas.CODIGOPREGUNTA and " + "preguntas.CODIGOPREGUNTA='" + pregun + "'");
            i = 0;

            respu = new Respuesta[5];

            if (rs.next()) {
                preguntitas = new Pregunta(rs.getString("PREG"), rs.getString("NIVEL"));

                tablapreguntas.setTxtpregunta(preguntitas.getPregunta());

                Respuesta resp = new Respuesta();
                resp.setRespuesta(rs.getString("RESP"));
                resp.setCorrecta(rs.getBoolean("CORREC"));

                respu[i] = resp;
                while (rs.next()) {

                    i++;
                    resp = new Respuesta();

                    resp.setRespuesta(rs.getString("RESP"));
                    resp.setCorrecta(rs.getBoolean("CORREC"));

                    respu[i] = resp;
                }
                preguntitas.setRespuestas(respu);

                tablapreguntas.setOpcion1(preguntitas.getRespuestas()[0].getRespuesta());
                tablapreguntas.setOpcion2(preguntitas.getRespuestas()[1].getRespuesta());
                tablapreguntas.setOpcion3(preguntitas.getRespuestas()[2].getRespuesta());
                tablapreguntas.setOpcion4(preguntitas.getRespuestas()[3].getRespuesta());
                tablapreguntas.setOpcion5(preguntitas.getRespuestas()[4].getRespuesta());


            }


            if (fig == null) {
                tablapreguntas.iniciarpregunta(preguntitas, nivel, true, partida, A);

            } else {
                tablapreguntas.iniciarpregunta(preguntitas, fig, false, partida, A);

            }


        }
        return tablapreguntas;
    }


    public static void verificarrespuesta(Partida part, boolean figcombo, Object comboyfigu, String respuesta, Pregunta preg) throws ClassNotFoundException, SQLException {
        int i = 0, control = 0;
        String men = "INCORRECTO";
        while (i < preg.getRespuestas().length) {
            if ((respuesta.equals(preg.getRespuestas()[i].getRespuesta())) & (preg.getRespuestas()[i].isCorrecta() == true)) {
                control = 1;
                i = preg.getRespuestas().length;
                men = "CORRECTO";
                JOptionPane.showMessageDialog(null, men);
                Class.forName("com.mysql.jdbc.Driver");
                try (java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "")) {
                    if (figcombo == true) /*quiere decir que es un combo*/ {
                        CallableStatement proc = conn.prepareCall("CALL GANARCOMBO(?,?,?)");
                        proc.setString("nombre_combo", ((ComboFigurita) comboyfigu).getNombrecombo());
                        proc.setInt("codigo_partida", part.getCodigopartida());
                        proc.registerOutParameter("mensaje", Types.VARCHAR);
                        proc.execute();
                        JOptionPane.showMessageDialog(null, "Felicitaciones, ganó un combo");
                    } else {
                        CallableStatement proc = conn.prepareCall("CALL GANARFIGURITA(?,?,?) ");

                        proc.setString("nombre_figurita", ((Figurita) comboyfigu).getNombrejugador());
                        proc.setInt("codigo_partida", part.getCodigopartida());
                        proc.registerOutParameter("mensaje", Types.VARCHAR);
                        proc.execute();
                        String man = proc.getString("mensaje");
                        JOptionPane.showMessageDialog(null, man);
                    }
                }
                part.inicializartodo();

            }
            i++;
        }
        if (control == 0) {
            JOptionPane.showMessageDialog(null, men);
        }


    }
}
