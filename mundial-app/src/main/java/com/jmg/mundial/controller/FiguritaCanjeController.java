/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.controller;

import com.jmg.mundial.model.AlbumPais;
import com.jmg.mundial.model.Figurita;
import com.jmg.mundial.model.Partida;
import com.jmg.mundial.view.VCANJE;

import javax.swing.*;
import java.sql.*;
/**
 *
 * @author Jonathan
 */
public class FiguritaCanjeController {

    public FiguritaCanjeController() {
    }
    
    public static void CANJEARFIGURITA(Partida part, Figurita figuritarepetida, Figurita figuritascanje) throws ClassNotFoundException, SQLException
    {
       // CANJEAR(in codigo_partida int,nombre_jugador_rep varchar(50), nombre_pais_rep varchar(50),nombre_jugador_can varchar(50),nombre_pais_can varchar(50),out mensaje varchar(120))
       if((figuritarepetida!=null)&&(figuritascanje!=null))
       {
        Class.forName("com.mysql.jdbc.Driver");         
        java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL","root", "");
        CallableStatement proc = conn.prepareCall("CALL CANJEAR(?,?,?,?) ");
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
    
    public void INICIALIZARFIGURITAS(VCANJE canj, boolean canje, String nombrejug ) throws ClassNotFoundException, SQLException
    {
        Class.forName("com.mysql.jdbc.Driver");         
        java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL","root", "");
        java.sql.Statement statement = conn.createStatement();
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
    
    public static void inicializarcomboscanje(VCANJE aThis) throws ClassNotFoundException, SQLException {
       
        int contador=0;
        Class.forName("com.mysql.jdbc.Driver");         
        java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL","root", "");
        java.sql.Statement statement = conn.createStatement();
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
}
