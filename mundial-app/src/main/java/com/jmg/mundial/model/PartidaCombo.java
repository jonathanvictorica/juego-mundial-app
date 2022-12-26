/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.model;

import lombok.Getter;
import lombok.Setter;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@Getter
@Setter
public class PartidaCombo {
    private Partida partidas;
    private ComboFigurita[] combos;

    public PartidaCombo(Partida partidas, ComboFigurita[] combos) {
        this.partidas = partidas;
        this.combos = combos;
    }


    
   public static PartidaCombo inicializarpartida(Partida parti) throws ClassNotFoundException, SQLException
   {
           ArrayList<ComboFigurita> com = new ArrayList<>();
           Class.forName("com.mysql.jdbc.Driver");         
           java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL","root", "");
           java.sql.Statement statement = conn.createStatement();
           ResultSet rs;
           
           rs = statement.executeQuery("SELECT combos.codigocombo as codigocombo,combos.nombrecombo AS nombrecombo,combos.dificultadcombo as dificultad, combos.imagencombo as imagen FROM combos,partidacombo WHERE combos.codigocombo = partidacombo.codigocombo and partidacombo.codigopartida = '" + parti.getCodigopartida() + "'");
           ComboFigurita combito;
           while(rs.next())
           {
              combito = new ComboFigurita(rs.getInt("codigocombo"),rs.getString("nombrecombo"),rs.getString("dificultad"),rs.getString("imagen"));
               com.add(combito);
           }
            PartidaCombo partidaCOM;
           if(!com.isEmpty())
           {
               if(com.size()==1)
               {
                   ComboFigurita[] COMBJ = new ComboFigurita[2];
                    
                    
                        COMBJ[0]=com.get(0);
                       COMBJ[1]=null;
                    
                      partidaCOM = new PartidaCombo(parti,COMBJ);
               }
               else
               {
                    ComboFigurita[] COMBJ = new ComboFigurita[com.size()];
                    int i=0;

                    while(i<com.size())
                    {
                        COMBJ[i]=com.get(i);
                        i++;
                    }
                      partidaCOM = new PartidaCombo(parti,COMBJ);
               }
           }
           else
           {
            partidaCOM = new PartidaCombo(parti,null);
           }
          return partidaCOM;
               
      
   }
    
}
