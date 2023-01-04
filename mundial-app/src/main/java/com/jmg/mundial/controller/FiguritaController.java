package com.jmg.mundial.controller;

import com.jmg.mundial.config.ConexionDB;
import com.jmg.mundial.model.AlbumPais;
import com.jmg.mundial.model.Figurita;
import com.jmg.mundial.model.Partida;
import com.jmg.mundial.view.VFIGURITAS;
import com.jmg.mundial.view.VJUGARPOR;
import com.jmg.mundial.view.VPREGUNTAS;

import javax.swing.*;
import java.sql.ResultSet;
import java.sql.SQLException;


public class FiguritaController {


    public static void figuritaElegida(Figurita comboelegido, Partida partida, VJUGARPOR A) throws ClassNotFoundException, SQLException {
        VPREGUNTAS preguntas = new TriviaController().crearPregunta(comboelegido, null, partida, A);

        preguntas.show();


    }

    public static void llenarComboFiguritas(VFIGURITAS vfiguritas) throws ClassNotFoundException, SQLException {
        java.sql.Statement statement = ConexionDB.getConexion().createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM figuritas");
        vfiguritas.getCboFiguritasver().removeAllItems();
        while (rs.next()) {
            vfiguritas.getCboFiguritasver().addItem(rs.getString("nombrejugador"));
        }
    }

    public void prepararFigurita(String nombrefigurita, VFIGURITAS vfiguritas) throws ClassNotFoundException, SQLException {

        java.sql.Statement statement = ConexionDB.getConexion().createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM figuritasinicializadas WHERE  FJUGADOR ='" + nombrefigurita + "'");
        Figurita fig = null;
        if (rs.next()) {
            AlbumPais alb = new AlbumPais(rs.getInt("ACODIGO"), rs.getString("APAIS"), rs.getString("ANACIONALIDAD"));
            fig = new Figurita(rs.getString("FJUGADOR"), alb, rs.getString("FIMAGEN"), rs.getString("FDIFICULTAD"));
            fig.setPosicion(rs.getString("posicion"));
            fig.setNumero(rs.getInt("pose"));
        }
        vfiguritas.setF(fig);

        if (fig != null) {
            /*controlamos la pantalla*/

            String ii = "/VISTA/FIGURAS/" + fig.getRutaimagen() + " (Copy).jpg";
            ImageIcon a = new ImageIcon(getClass().getResource(ii));
            vfiguritas.getLblImagenver().setIcon(a);

            vfiguritas.getLblNombrejugador().setText("Nombre del Jugador: " + fig.getNombrejugador());
            vfiguritas.getLblPais().setText("Pais: " + fig.getAlbumpais().getNombre_pais());
            vfiguritas.getLblNacionalidad().setText("Nacionalidad: " + fig.getAlbumpais().getNacionalidad());
            vfiguritas.getLblPosición().setText("Posicion: " + fig.getPosicion());

            int control = 0;
            int i = 0;
            if (vfiguritas.getC().getPartida().getPartidafiguritas() != null) {
                while (i < vfiguritas.getC().getPartida().getPartidafiguritas().getFigurita().length) {
                    if (fig.getNombrejugador().equals(vfiguritas.getC().getPartida().getPartidafiguritas().getFigurita()[i].getNombrejugador())) {
                        control = 1;
                        i = vfiguritas.getC().getPartida().getPartidafiguritas().getFigurita().length;
                    }
                    i++;
                }
            }
            if (control == 0) {
                vfiguritas.getLblColeccionado().setText("Esta figurita no esta en su Colección");
            } else {
                vfiguritas.getLblColeccionado().setText("Figurita Coleccionada");
            }

            vfiguritas.actualizarPantalla();
        }




    }
}
