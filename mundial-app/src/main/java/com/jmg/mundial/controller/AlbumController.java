
package com.jmg.mundial.controller;

import com.jmg.mundial.config.ConexionDB;
import com.jmg.mundial.model.AlbumPais;
import com.jmg.mundial.view.VALBUM;

import javax.swing.*;
import java.sql.ResultSet;
import java.sql.SQLException;


public class AlbumController {


    public static void inicializarAlbum(VALBUM valbum) throws ClassNotFoundException, SQLException
    {
        java.sql.Statement statement = ConexionDB.getConexion().createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM albumpais ");
        
        AlbumPais[] paise = new AlbumPais[4];
        int i=0;
        while(rs.next()&&i<4)
        {
            AlbumPais albumnes = new AlbumPais(rs.getInt("codigoalbum"),rs.getString("nombre_pais"),rs.getString("nacionalidad"));
            paise[i]=albumnes;
            i++;
        }
        valbum.setPaises(paise);
        valbum.show();
       AlbumController H = new AlbumController();
       H.cargarFiguritas(valbum.getPaises()[0].getNombre_pais(),valbum);
    
    }
   
    public void inicializar(VALBUM valbum)
    {
          String ii  = ("/VISTA/FIGURAS/Vacio.jpg");
          ImageIcon a = new ImageIcon(getClass().getResource(ii));
                                 
         valbum.getPanelfigurital1().setIcon(a);
         valbum.getPanelfigurital2().setIcon(a);
         valbum.getPanelfigurital3().setIcon(a);
         valbum.getPanelfigurital4().setIcon(a);
         valbum.getPanelfigurital5().setIcon(a);
         valbum.getPanelfigurital6().setIcon(a);
         valbum.getPanelfigurital7().setIcon(a);
         valbum.getPanelfigurital8().setIcon(a);
         valbum.getPanelfigurital9().setIcon(a);
         valbum.getPanelfigurital10().setIcon(a);
         valbum.getPanelfigurital11().setIcon(a);
         valbum.getPanelfigurital12().setIcon(a);
         valbum.getPanelfigurital13().setIcon(a);
         valbum.getPanelfigurital14().setIcon(a);
         valbum.getPanelfigurital15().setIcon(a);
         valbum.getPanelfigurital16().setIcon(a);
         valbum.getPanelfigurital17().setIcon(a);
         valbum.getPanelfigurital18().setIcon(a);
         valbum.repaint();
         
    }
    
    
    
    public void cargarFiguritas(String pais, VALBUM valbum) throws ClassNotFoundException, SQLException
    {
        int j=0;
      
        this.inicializar(valbum);
         String ii = "";
               
            if(valbum.getJ().getPartida().getPartidafiguritas()!=null)
            {
               while(j<valbum.getJ().getPartida().getPartidafiguritas().getFigurita().length)
               {
                   
                 if(valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j]!=null) 
                 {
                   if(pais.equals(valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getAlbumpais().getNombre_pais()))
                   {
                            
                         switch(valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getNumero())
                            {

                                case 1:
                               
                                    ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon a = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital1().setIcon(a);
                                    break;
                                case 2:
                                      ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                  ImageIcon b = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital2().setIcon(b);
                                    break;
                                 case 3:
                                      ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon c = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital3().setIcon(c);
                                    break;
                                  case 4:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon d = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital4().setIcon(d);
                                    break;
                                  case 5:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon e = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital5().setIcon(e);
                                    break;
                                  case 6:
                                      ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon f = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital6().setIcon(f);
                                    break;
                                  case 7:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon g = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital7().setIcon(g);
                                    break;
                                  case 8:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                  ImageIcon  h = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital8().setIcon(h);
                                    break;
                                  case 9:
                                      ii = "/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg";
                                      
                                   ImageIcon i = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital9().setIcon(i);
                                    break;
                                  case 10:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon k = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital10().setIcon(k);
                                    break;
                                  case 11:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                  ImageIcon  m = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital11().setIcon(m);
                                    break;
                                   case 12:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon n = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital12().setIcon(n);
                                    break;
                                  case 13:
                                       ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon o = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital13().setIcon(o);
                                    break;
                                  case 14:
                                      ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon p = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital14().setIcon(p);
                                    break;
                                   case 15:
                                      ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                   ImageIcon q = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital15().setIcon(q);
                                    break;
                                   case 16:
                                      ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                  ImageIcon t = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital16().setIcon(t);
                                    break;
                                        case 17:
                                      ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                  ImageIcon  r = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital17().setIcon(r);
                                    break;
                                             case 18:
                                     ii  = ("/VISTA/FIGURAS/" + valbum.getJ().getPartida().getPartidafiguritas().getFigurita()[j].getRutaimagen() + " (Copy).jpg");
                                  ImageIcon s = new ImageIcon(getClass().getResource(ii));
                                    valbum.getPanelfigurital18().setIcon(s);
                                    break;
                                     
                            }
                         
                     
                            
                   }
                               
                 }             
                   j++;
               }
               valbum.repaint();
           }
    }
}
