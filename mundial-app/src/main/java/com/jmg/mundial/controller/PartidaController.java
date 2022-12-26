
package com.jmg.mundial.controller;


import com.jmg.mundial.model.Partida;

import javax.swing.*;
import java.sql.*;

/**
 * @author Jonathan
 */
public class PartidaController {

    public static void ganarpartida(Partida A) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "");
        CallableStatement proc = conn.prepareCall("CALL GANARPARTIDA(?) ");
        proc.setString("nombrepartida", A.getNombrejugador());
        proc.execute();
    }


    public static Partida crearnuevapartida(String nombrejugador) throws SQLException, ClassNotFoundException {
        Partida part = null;
        Class.forName("com.mysql.jdbc.Driver");
        try (java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "")) {
            CallableStatement proc = conn.prepareCall("CALL CREARPARTIDA(?,?) ");
            proc.setString("nombrepartida", nombrejugador);
            proc.registerOutParameter("mensaje", Types.VARCHAR);
            proc.execute();
            String men = proc.getString("mensaje");
            JOptionPane.showMessageDialog(null, men);
            if (proc.getString("mensaje").contains("exito")) {
                java.sql.Statement statement = conn.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM partida WHERE nombrejugador='" + nombrejugador + "'");
                if (rs.next()) {
                    part = new Partida(rs.getInt("codigopartida"), rs.getString("nombrejugador"), rs.getString("estado"));
                    part.inicializartodo();
                }
            }
        }
        return part;
    }

    public static Partida retomarpartida(String nombrejugador) throws SQLException, ClassNotFoundException {
        Partida part = null;
        Class.forName("com.mysql.jdbc.Driver");
        try (java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "")) {
            java.sql.Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM partida WHERE nombrejugador='" + nombrejugador + "'");
            String men = "Lo sentimos. Pero esta partida no existe";
            if (rs.next()) {
                part = new Partida(rs.getInt("codigopartida"), rs.getString("nombrejugador"), rs.getString("estado"));
                part.inicializartodo();
                men = "Partida Retomada";

            }

            JOptionPane.showMessageDialog(null, men);
        }

        return part;
    }

    public static void eliminarpartida(String nombrejugador) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        java.sql.Connection conn = (java.sql.Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/MUNDIAL", "root", "");
        CallableStatement proc = conn.prepareCall("CALL ELIMINARPARTIDA(?,?) ");
        proc.setString("nombrepartida", nombrejugador);
        proc.registerOutParameter("mensaje", Types.VARCHAR);
        proc.execute();
        String men = proc.getString("mensaje");
        JOptionPane.showMessageDialog(null, men);
    }


}
