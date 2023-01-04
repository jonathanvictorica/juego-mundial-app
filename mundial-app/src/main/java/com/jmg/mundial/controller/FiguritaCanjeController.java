/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.controller;

import com.jmg.mundial.config.ConexionDB;
import com.jmg.mundial.model.AlbumPais;
import com.jmg.mundial.model.Figurita;
import com.jmg.mundial.model.Partida;
import com.jmg.mundial.view.VCANJE;

import javax.swing.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
/**
 *
 * @author Jonathan
 */
public class FiguritaCanjeController {


    public static void canjearfigurita(Partida part, Figurita figuritarepetida, Figurita figuritascanje) throws ClassNotFoundException, SQLException
    {
       if((figuritarepetida!=null)&&(figuritascanje!=null))
       {
           CallableStatement proc = ConexionDB.getConexion().prepareCall("CALL CANJEAR(?,?,?,?) ");
        proc.setInt("codigo_partida", part.getCodigopartida());
        proc.setString("nombre_jugador_rep", figuritarepetida.getNombrejugador());
        proc.setString("nombre_jugador_can", figuritascanje.getNombrejugador());
        proc.registerOutParameter("mensaje", Types.VARCHAR);
        proc.execute();
        String men =  proc.getString("mensaje");
        JOptionPane.showMessageDialog(null, men);
        part.inicializartodo();
        
       }
       else
       {
           String men =  "Debe seleccionar una figurita repetida y otra de canje";
        JOptionPane.showMessageDialog(null, men);
       }
    }
    
    public static void inicializarCombosCanje(VCANJE aThis) throws ClassNotFoundException, SQLException {

        int contador = 0;
        java.sql.Statement statement = ConexionDB.getConexion().createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM figuritasrepetidas,figuritas,albumpais WHERE albumpais.codigoalbum = figuritas.CODIGOALBUM AND figuritasrepetidas.codigofigurita= figuritas.codigofigurita and figuritasrepetidas.codigopartida='" + aThis.getVentanajugarpor().getPartida().getCodigopartida() + "'");
       aThis.getCboRepetido().removeAll();
       while(rs.next()) {
                aThis.getCboRepetido().addItem(rs.getString("nombrejugador"));
                 contador++;
        }

       aThis.getCbofaltante().removeAll();
       ResultSet ra = statement.executeQuery("SELECT * FROM figuritas WHERE codigofigurita NOT IN (SELECT CODIGOFIGURITA FROM figuritasrepetidas WHERE codigopartida=" + aThis.getVentanajugarpor().getPartida().getCodigopartida() + ")");
       while(ra.next()) {
                aThis.getCbofaltante().addItem(ra.getString("nombrejugador"));

        }

       if(contador==0)
       {
            aThis.getCboRepetido().removeAll();

          JOptionPane.showMessageDialog(null, "No tenes figuritas repetidas para canjear");
          aThis.getVentanajugarpor().show();
           aThis.hide();
       }



    }
    
    public void inicializarFiguritas(VCANJE canj, boolean canje, String nombrejug ) throws ClassNotFoundException, SQLException
    {
        java.sql.Statement statement = ConexionDB.getConexion().createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM figuritasinicializadas WHERE  FJUGADOR ='" + nombrejug + "'");
       Figurita fig =null;
        if (rs.next()) {
               AlbumPais alb = new AlbumPais(rs.getInt("ACODIGO"), rs.getString("APAIS"), rs.getString("ANACIONALIDAD"));
               fig = new Figurita(rs.getString("FJUGADOR"),alb,rs.getString("FIMAGEN"),rs.getString("FDIFICULTAD"));
        }

        if(fig!=null)
        {
                if(canje==true) //figurita de canje
                {
                     canj.setFiguritacanje(fig);

                      String ii = "/VISTA/FIGURAS/" + canj.getFiguritacanje().getRutaimagen() + " (Copy).jpg";
                      ImageIcon a = new ImageIcon(getClass().getResource(ii));
                        canj.getLblfigurita2().setIcon(a);
                       canj.getLblDificultadcanje().setText(canj.getFiguritacanje().getDificultad());



                }
                else //figurita repetida
                {
                    canj.setFiguritarepetida(fig);
                     String ii = "/VISTA/FIGURAS/" + canj.getFiguritarepetida().getRutaimagen() + " (Copy).jpg";
                      ImageIcon a = new ImageIcon(getClass().getResource(ii));
                      canj.getLblfigurita1().setIcon(a);
                        canj.getLblDificultadRepetido().setText(canj.getFiguritarepetida().getDificultad());
                }
        }
    }
}
