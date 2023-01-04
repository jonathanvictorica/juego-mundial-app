
package com.jmg.mundial.controller;


import com.jmg.mundial.config.ConexionDB;
import com.jmg.mundial.model.Partida;

import javax.swing.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

/**
 * @author Jonathan
 */
public class PartidaController {

    public static void ganarPartida(Partida A) throws ClassNotFoundException, SQLException {
        CallableStatement proc = ConexionDB.getConexion().prepareCall("CALL GANARPARTIDA(?) ");
        proc.setString("nombrepartida", A.getNombrejugador());
        proc.execute();
    }


    public static Partida crearNuevaPartida(String nombrejugador) throws SQLException, ClassNotFoundException {
        Partida part = null;
        CallableStatement proc = ConexionDB.getConexion().prepareCall("CALL CREARPARTIDA(?,?) ");
            proc.setString("nombrepartida", nombrejugador);
            proc.registerOutParameter("mensaje", Types.VARCHAR);
            proc.execute();
            String men = proc.getString("mensaje");
            JOptionPane.showMessageDialog(null, men);
            if (proc.getString("mensaje").contains("exito")) {
                java.sql.Statement statement = ConexionDB.getConexion().createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM partida WHERE nombrejugador='" + nombrejugador + "'");
                if (rs.next()) {
                    part = new Partida(rs.getInt("codigopartida"), rs.getString("nombrejugador"), rs.getString("estado"));
                    part.inicializartodo();
                }
            }

        return part;
    }

    public static Partida retomarPartida(String nombrejugador) throws SQLException, ClassNotFoundException {
        Partida part = null;
        java.sql.Statement statement = ConexionDB.getConexion().createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM partida WHERE nombrejugador='" + nombrejugador + "'");
            String men = "Lo sentimos. Pero esta partida no existe";
            if (rs.next()) {
                part = new Partida(rs.getInt("codigopartida"), rs.getString("nombrejugador"), rs.getString("estado"));
                part.inicializartodo();
                men = "Partida Retomada";

            }

            JOptionPane.showMessageDialog(null, men);


        return part;
    }

    public static void eliminarPartida(String nombrejugador) throws ClassNotFoundException, SQLException {
        CallableStatement proc = ConexionDB.getConexion().prepareCall("CALL ELIMINARPARTIDA(?,?) ");
        proc.setString("nombrepartida", nombrejugador);
        proc.registerOutParameter("mensaje", Types.VARCHAR);
        proc.execute();
        String men = proc.getString("mensaje");
        JOptionPane.showMessageDialog(null, men);
    }


}
