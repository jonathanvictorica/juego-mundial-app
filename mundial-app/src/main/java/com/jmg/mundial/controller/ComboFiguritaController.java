/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.controller;


import com.jmg.mundial.model.*;
import com.jmg.mundial.view.VCOMBOS;
import com.jmg.mundial.view.VJUGARPOR;
import com.jmg.mundial.view.VPREGUNTAS;

import javax.swing.*;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ComboFiguritaController {

    public ComboFiguritaController() {
    }

    public static void comboelegido(ComboFigurita comboelegido, Partida partida, VJUGARPOR A) throws ClassNotFoundException, SQLException {
        VPREGUNTAS preguntas = new TriviaController().crearpregunta(null, comboelegido, partida, A);

        preguntas.show();

    }

    public void prepararcombo(String nombrecombo, VCOMBOS vcombos) throws ClassNotFoundException, SQLException {
        ComboFigurita COMBITOS = null;
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "");
        java.sql.Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery("SELECT * from combofigu where cnombre = '" + nombrecombo + "'");

        Figurita[] FIG = new Figurita[6];


        int i = 0;
        if (rs.next()) {

            ComboFigurita COM = new ComboFigurita(rs.getInt("CCODIGO"), rs.getString("CNOMBRE"), rs.getString("CDIFICULTAD"), rs.getString("CIMAGEN"));
            AlbumPais AL = new AlbumPais(rs.getInt("ACODIGO"), rs.getString("APAIS"), rs.getString("ANACIONALIDAD"));
            Figurita figu = new Figurita(rs.getString("FJUGADOR"), AL, rs.getString("FIMAGEN"), rs.getString("FDIFICULTAD"));
            FIG[i] = figu;
            i++;


            while (rs.next()) {
                AL = new AlbumPais(rs.getInt("ACODIGO"), rs.getString("APAIS"), rs.getString("ANACIONALIDAD"));
                figu = new Figurita(rs.getString("FJUGADOR"), AL, rs.getString("FIMAGEN"), rs.getString("FDIFICULTAD"));
                FIG[i] = figu;
                i++;
            }

            COM.setFiguritascombo(FIG);
            COMBITOS = COM;


            vcombos.setCOMBITOS(COMBITOS);
            String ii;

            /*controlamos la pantalla*/
            ii = "/VISTA/FIGURAS/" + vcombos.COMBITOS.getFiguritascombo()[0].getRutaimagen() + " (Copy).jpg";
            ImageIcon a = new ImageIcon(getClass().getResource(ii));
            vcombos.getFIGURITA1().setIcon(a);

            ii = "/VISTA/FIGURAS/" + vcombos.COMBITOS.getFiguritascombo()[1].getRutaimagen() + " (Copy).jpg";
            ImageIcon b = new ImageIcon(getClass().getResource(ii));
            vcombos.getFIGURITA2().setIcon(b);

            ii = "/VISTA/FIGURAS/" + vcombos.COMBITOS.getFiguritascombo()[2].getRutaimagen() + " (Copy).jpg";
            ImageIcon c = new ImageIcon(getClass().getResource(ii));
            vcombos.getFIGURITA3().setIcon(c);

            ii = "/VISTA/FIGURAS/" + vcombos.COMBITOS.getFiguritascombo()[3].getRutaimagen() + " (Copy).jpg";
            ImageIcon d = new ImageIcon(getClass().getResource(ii));
            vcombos.getFIGURITA4().setIcon(d);

            ii = "/VISTA/FIGURAS/" + vcombos.COMBITOS.getFiguritascombo()[4].getRutaimagen() + " (Copy).jpg";
            ImageIcon e = new ImageIcon(getClass().getResource(ii));
            vcombos.getFIGURITA5().setIcon(e);

            ii = "/VISTA/FIGURAS/" + vcombos.COMBITOS.getFiguritascombo()[5].getRutaimagen() + " (Copy).jpg";
            ImageIcon f = new ImageIcon(getClass().getResource(ii));
            vcombos.getFIGURITA6().setIcon(f);


            vcombos.repaint();


            /*asignar imagenes*/


        }
    }

    public static void inicializarvcombos(VCOMBOS aThis) throws ClassNotFoundException, SQLException {

        Class.forName("com.mysql.jdbc.Driver");

        java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "");
        java.sql.Statement statement = conn.createStatement();
        aThis.getCbocombo().removeAllItems();
        try (ResultSet rs = statement.executeQuery("SELECT * FROM combos")) {

            while (rs.next()) {
                aThis.getCbocombo().addItem(rs.getString("nombrecombo"));

            }
        }

        PartidaCombo comboshechos = aThis.getA().getPartida().getPartidacombo();
        int i = 0;
        if (aThis.getA().getPartida().getPartidacombo().getCombos() != null) {

            while (i < aThis.getA().getPartida().getPartidacombo().getCombos().length) {

                if (comboshechos.getCombos()[i] != null) {
                    aThis.getCbocombo().removeItem(comboshechos.getCombos()[i].getNombrecombo());
                }
                i++;

            }
        }
    }

}
    
    

    

