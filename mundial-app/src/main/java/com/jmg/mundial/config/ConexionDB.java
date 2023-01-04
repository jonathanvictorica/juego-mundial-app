package com.jmg.mundial.config;


import javax.swing.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConexionDB {

    private static ConexionDB INSTANCE = null;


    private Connection conexion;

    private ConexionDB() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String servidor = "jdbc:mysql://localhost:3306/MUNDIAL";
            String usuarioDB = "root";
            String passwordDB = "";

            conexion = (Connection) DriverManager.getConnection(servidor, usuarioDB, passwordDB);

        } catch (ClassNotFoundException ex) {
            mostrarmensajebasededatos();
            conexion = null;
        } catch (SQLException ex) {
            mostrarmensajebasededatos();
            conexion = null;
        } catch (Exception ex) {
            mostrarmensajebasededatos();
            conexion = null;
        }

    }

    public static Connection getConexion() {
        if (INSTANCE == null) {
            INSTANCE = new ConexionDB();
        }

        return INSTANCE.conexion;
    }

    public static void mostrarmensajebasededatos() {
        JOptionPane.showMessageDialog(null, "Lo sentimos. En este momento nuestro servidor no esta disponible. Vuelva a entrar más tarde");
        System.exit(0);
    }
}