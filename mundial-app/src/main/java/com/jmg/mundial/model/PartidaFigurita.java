/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.model;

import com.jmg.mundial.view.VGANADOR;
import lombok.Getter;
import lombok.Setter;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@Getter
@Setter
public class PartidaFigurita {
    private Partida partida;
    private Figurita[] figurita;

    public PartidaFigurita(Partida partida, Figurita[] figurita) {
        this.partida = partida;
        this.figurita = figurita;
    }


    
    
   public static PartidaFigurita inicializarpartida(Partida parti) throws ClassNotFoundException, SQLException
   {
           PartidaFigurita partidafigu=null;
           ArrayList<Figurita> fig = new ArrayList<>();
           Class.forName("com.mysql.jdbc.Driver");         
           java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL","root", "");
           java.sql.Statement statement = conn.createStatement();
           ResultSet rs;
           rs = statement.executeQuery("SELECT albumpais.codigoalbum as codigoalbum, "
                   + "albumpais.nombre_pais as pais, albumpais.nacionalidad as naciona,"
                   + " figuritas.nombrejugador as nombrejugador , figuritas.direccionimagen as direccion, "
                   + "figuritas.dificultad  as dificultad,figuritas.pose as numero, figuritas.posicion as posicion FROM albumpais,partidafiguritas,"
                   + "figuritas WHERE albumpais.codigoalbum = figuritas.codigoalbum "
                   + "and partidafiguritas.codigofigurita = figuritas.codigofigurita "
                   + "and partidafiguritas.codigopartida = '" + parti.getCodigopartida() + "'");
           AlbumPais albumpais;
           Figurita figurete;
           while(rs.next())
           {
                albumpais = new AlbumPais(rs.getInt("codigoalbum"),rs.getString("pais"),rs.getString("naciona"));
                figurete = new Figurita(rs.getString("nombrejugador"),albumpais,rs.getString("direccion"),rs.getString("dificultad"));
                figurete.setNumero(rs.getInt("numero"));
                figurete.setPosicion(rs.getString("posicion"));
                fig.add(figurete);
           }
           int num = (int)fig.size();
           if(num!=0)
           {
                 if(num==1)
                 {
                    Figurita[] figu = new Figurita[2];
                    
                        figu[0]=fig.get(0);
                      figu[1]=null;
                    
                     partidafigu = new PartidaFigurita(parti,figu);
                     if(figu.length==72)
                     {
                           VGANADOR vganador = new VGANADOR();
                           vganador.show();
                     }
                 }
                 else
                 {
                    Figurita[] figu = new Figurita[num];
                    int i=0;

                    while(i<fig.size())
                    {
                        figu[i]=fig.get(i);
                        i++;
                    }
                     partidafigu = new PartidaFigurita(parti,figu);
                     if(figu.length==72)
                     {
                           VGANADOR vganador = new VGANADOR();
                     
                           vganador.setLocationRelativeTo(vganador);
                            vganador.show();
                     }
                 }
           }
          return partidafigu;
               
      
   }
}
