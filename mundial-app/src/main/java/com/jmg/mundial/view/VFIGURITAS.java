package com.jmg.mundial.view;

import com.jmg.mundial.controller.FiguritaController;
import com.jmg.mundial.model.Figurita;
import org.edisoncor.gui.panel.PanelImage;

import javax.swing.*;
import java.awt.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.jmg.mundial.controller.FiguritaController.figuritaElegida;

/**
 * @author Jonathan
 */
public class VFIGURITAS extends javax.swing.JFrame {

    private VJUGARPOR c;
    private Figurita f = null;

    public VFIGURITAS() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        panelImage1 = new org.edisoncor.gui.panel.PanelImage();
        cmdJugar = new javax.swing.JButton();
        lblPais = new javax.swing.JLabel();
        lblNacionalidad = new javax.swing.JLabel();
        lblPosición = new javax.swing.JLabel();
        lblNombrejugador = new javax.swing.JLabel();
        cboFiguritasver = new javax.swing.JComboBox();
        lblfiguritasver = new javax.swing.JLabel();
        cmdSalir = new javax.swing.JButton();
        lblImagenver = new org.edisoncor.gui.panel.PanelImage();
        lblColeccionado = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        panelImage1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/VISTA/FIGURAS/CMDFIGURITAS.jpg"))); // NOI18N

        cmdJugar.setText("JUGAR");
        cmdJugar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdJugarActionPerformed(evt);
            }
        });

        lblPais.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblPais.setForeground(Color.WHITE);
        lblPais.setText("País");

        lblNacionalidad.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblNacionalidad.setForeground(Color.WHITE);
        lblNacionalidad.setText("Nacionalidad");

        lblPosición.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblPosición.setForeground(Color.WHITE);
        lblPosición.setText("Posición");

        lblNombrejugador.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblNombrejugador.setForeground(Color.WHITE);
        lblNombrejugador.setText("Nombre de Jugador");

        cboFiguritasver.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cboFiguritasverItemStateChanged(evt);
            }
        });

        lblfiguritasver.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblfiguritasver.setForeground(Color.WHITE);
        lblfiguritasver.setText("Figuritas");

        cmdSalir.setText("VOLVER");
        cmdSalir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdSalirActionPerformed(evt);
            }
        });

        lblImagenver.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        lblImagenver.setIcon(new javax.swing.ImageIcon(getClass().getResource("/VISTA/FIGURAS/izethajrovic (Copy).jpg"))); // NOI18N

        javax.swing.GroupLayout lblImagenverLayout = new javax.swing.GroupLayout(lblImagenver);
        lblImagenver.setLayout(lblImagenverLayout);
        lblImagenverLayout.setHorizontalGroup(lblImagenverLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addGap(0, 142, Short.MAX_VALUE));
        lblImagenverLayout.setVerticalGroup(lblImagenverLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addGap(0, 187, Short.MAX_VALUE));

        lblColeccionado.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        lblColeccionado.setForeground(Color.WHITE);
        lblColeccionado.setText("País");

        javax.swing.GroupLayout panelImage1Layout = new javax.swing.GroupLayout(panelImage1);
        panelImage1.setLayout(panelImage1Layout);
        panelImage1Layout.setHorizontalGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addGroup(panelImage1Layout.createSequentialGroup().addContainerGap(52, Short.MAX_VALUE).addGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addGroup(panelImage1Layout.createSequentialGroup().addGap(0, 0, Short.MAX_VALUE).addComponent(cmdSalir).addGap(25, 25, 25)).addGroup(panelImage1Layout.createSequentialGroup().addGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addComponent(lblfiguritasver, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE).addComponent(lblImagenver, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)).addGap(0, 0, Short.MAX_VALUE).addGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false).addComponent(lblPais, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE).addComponent(cboFiguritasver, 0, 367, Short.MAX_VALUE).addComponent(lblNacionalidad).addComponent(lblPosición).addComponent(lblNombrejugador).addComponent(cmdJugar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE).addComponent(lblColeccionado, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)).addGap(44, 44, 44)))));
        panelImage1Layout.setVerticalGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addGroup(javax.swing.GroupLayout.Alignment.TRAILING, panelImage1Layout.createSequentialGroup().addGap(20, 20, 20).addGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE).addComponent(lblfiguritasver).addComponent(cboFiguritasver, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)).addGap(40, 40, 40).addGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false).addGroup(panelImage1Layout.createSequentialGroup().addComponent(lblNombrejugador).addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addComponent(lblNacionalidad).addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addComponent(lblPosición).addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addComponent(lblPais).addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED).addComponent(lblColeccionado).addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE).addComponent(cmdJugar)).addComponent(lblImagenver, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)).addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE).addComponent(cmdSalir).addContainerGap()));

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addComponent(panelImage1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE));
        jPanel1Layout.setVerticalGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addComponent(panelImage1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE));
        layout.setVerticalGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING).addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public PanelImage getPanelImage1() {
        return panelImage1;
    }

    public void setPanelImage1(PanelImage panelImage1) {
        this.panelImage1 = panelImage1;
    }


    public PanelImage getLblImagenver() {
        return lblImagenver;
    }

    public void setLblImagenver(PanelImage lblImagenver) {
        this.lblImagenver = lblImagenver;
    }

    private void cmdSalirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdSalirActionPerformed
        this.c.show();
        this.hide();
    }//GEN-LAST:event_cmdSalirActionPerformed

    private void cboFiguritasverItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cboFiguritasverItemStateChanged
        try {

            new FiguritaController().prepararFigurita((String) this.cboFiguritasver.getSelectedItem(), this);

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(VFIGURITAS.class.getName()).log(Level.SEVERE, null, ex);
        }

    }//GEN-LAST:event_cboFiguritasverItemStateChanged


    private void cmdJugarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdJugarActionPerformed
        try {
            figuritaElegida(f, c.getPartida(), c);
            this.hide();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(VFIGURITAS.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_cmdJugarActionPerformed

    /**
     * @param c
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    public void inicializar(VJUGARPOR c) throws ClassNotFoundException, SQLException {
        try {

            this.c = c;
            new FiguritaController().llenarComboFiguritas(this);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(VFIGURITAS.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public JComboBox getCboFiguritasver() {
        return cboFiguritasver;
    }

    public void setCboFiguritasver(JComboBox cboFiguritasver) {
        this.cboFiguritasver = cboFiguritasver;
    }

    public JButton getCmdJugar() {
        return cmdJugar;
    }

    public void setCmdJugar(JButton cmdJugar) {
        this.cmdJugar = cmdJugar;
    }

    public JLabel getLblColeccionado() {
        return lblColeccionado;
    }

    public void setLblColeccionado(JLabel lblColeccionado) {
        this.lblColeccionado = lblColeccionado;
    }


    public JLabel getLblNacionalidad() {
        return lblNacionalidad;
    }

    public void setLblNacionalidad(JLabel lblNacionalidad) {
        this.lblNacionalidad = lblNacionalidad;
    }

    public JLabel getLblNombrejugador() {
        return lblNombrejugador;
    }

    public void setLblNombrejugador(JLabel lblNombrejugador) {
        this.lblNombrejugador = lblNombrejugador;
    }

    public JLabel getLblPais() {
        return lblPais;
    }

    public void setLblPais(JLabel lblPais) {
        this.lblPais = lblPais;
    }

    public JLabel getLblPosición() {
        return lblPosición;
    }

    public void setLblPosición(JLabel lblPosición) {
        this.lblPosición = lblPosición;
    }

    public JLabel getLblfiguritasver() {
        return lblfiguritasver;
    }

    public void setLblfiguritasver(JLabel lblfiguritasver) {
        this.lblfiguritasver = lblfiguritasver;
    }


    public VJUGARPOR getC() {
        return c;
    }

    public void setC(VJUGARPOR c) {
        this.c = c;
    }

    public Figurita getF() {
        return f;
    }

    public void setF(Figurita f) {
        this.f = f;
    }

    public JButton getCmdSalir() {
        return cmdSalir;
    }

    public void setCmdSalir(JButton cmdSalir) {
        this.cmdSalir = cmdSalir;
    }

    public JComboBox getjComboBox1() {
        return cboFiguritasver;
    }

    public void setjComboBox1(JComboBox jComboBox1) {
        this.cboFiguritasver = jComboBox1;
    }

    public JLabel getjLabel1() {
        return lblfiguritasver;
    }

    public void setjLabel1(JLabel jLabel1) {
        this.lblfiguritasver = jLabel1;
    }


    public JLabel getjLabel3() {
        return lblNombrejugador;
    }

    public void setjLabel3(JLabel jLabel3) {
        this.lblNombrejugador = jLabel3;
    }

    public JLabel getjLabel4() {
        return lblPosición;
    }

    public void setjLabel4(JLabel jLabel4) {
        this.lblPosición = jLabel4;
    }

    public JLabel getjLabel5() {
        return lblPais;
    }

    public void setjLabel5(JLabel jLabel5) {
        this.lblPais = jLabel5;
    }


    public JPanel getjPanel1() {
        return jPanel1;
    }

    public void actualizarPantalla() {
        this.repaint();
    }

    public void setjPanel1(JPanel jPanel1) {
        this.jPanel1 = jPanel1;
    }

    public JButton getTxtJugar() {
        return cmdJugar;
    }

    public void setTxtJugar(JButton txtJugar) {
        this.cmdJugar = txtJugar;
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox cboFiguritasver;
    private javax.swing.JButton cmdJugar;
    private javax.swing.JButton cmdSalir;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JLabel lblColeccionado;
    private org.edisoncor.gui.panel.PanelImage lblImagenver;
    private javax.swing.JLabel lblNacionalidad;
    private javax.swing.JLabel lblNombrejugador;
    private javax.swing.JLabel lblPais;
    private javax.swing.JLabel lblPosición;
    private javax.swing.JLabel lblfiguritasver;
    private org.edisoncor.gui.panel.PanelImage panelImage1;
    // End of variables declaration//GEN-END:variables
}
