/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.view;

import com.jmg.mundial.controller.ComboFiguritaController;
import com.jmg.mundial.model.ComboFigurita;
import org.edisoncor.gui.panel.PanelImage;

import javax.swing.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Jonathan
 */
public class VCOMBOS extends javax.swing.JFrame {

    private VJUGARPOR A;
    public ComboFigurita COMBITOS;

    public VCOMBOS() {
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

        jComboBox1 = new javax.swing.JComboBox();
        panelImage = new org.edisoncor.gui.panel.PanelImage();
        lblcombo = new javax.swing.JLabel();
        cbocombo = new javax.swing.JComboBox();
        cmdjugar = new javax.swing.JButton();
        cmdsalir = new javax.swing.JButton();
        FIGURITA1 = new org.edisoncor.gui.panel.PanelImage();
        FIGURITA2 = new org.edisoncor.gui.panel.PanelImage();
        FIGURITA3 = new org.edisoncor.gui.panel.PanelImage();
        FIGURITA4 = new org.edisoncor.gui.panel.PanelImage();
        FIGURITA5 = new org.edisoncor.gui.panel.PanelImage();
        FIGURITA6 = new org.edisoncor.gui.panel.PanelImage();

        jComboBox1.setModel(new javax.swing.DefaultComboBoxModel(new String[]{"Item 1", "Item 2", "Item 3", "Item 4"}));

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        panelImage.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        panelImage.setIcon(new javax.swing.ImageIcon(getClass().getResource("/VISTA/FIGURAS/CMDCOMBOS.jpg"))); // NOI18N

        lblcombo.setText("COMBO A JUGAR");

        cbocombo.setToolTipText("");
        cbocombo.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cbocomboItemStateChanged(evt);
            }
        });
        cbocombo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cbocomboActionPerformed(evt);
            }
        });

        cmdjugar.setText("JUGAR");
        cmdjugar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdjugarActionPerformed(evt);
            }
        });

        cmdsalir.setText("SALIR");
        cmdsalir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdsalirActionPerformed(evt);
            }
        });

        FIGURITA1.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        javax.swing.GroupLayout FIGURITA1Layout = new javax.swing.GroupLayout(FIGURITA1);
        FIGURITA1.setLayout(FIGURITA1Layout);
        FIGURITA1Layout.setHorizontalGroup(
                FIGURITA1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 142, Short.MAX_VALUE)
        );
        FIGURITA1Layout.setVerticalGroup(
                FIGURITA1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 187, Short.MAX_VALUE)
        );

        FIGURITA2.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        javax.swing.GroupLayout FIGURITA2Layout = new javax.swing.GroupLayout(FIGURITA2);
        FIGURITA2.setLayout(FIGURITA2Layout);
        FIGURITA2Layout.setHorizontalGroup(
                FIGURITA2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 142, Short.MAX_VALUE)
        );
        FIGURITA2Layout.setVerticalGroup(
                FIGURITA2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 187, Short.MAX_VALUE)
        );

        FIGURITA3.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        javax.swing.GroupLayout FIGURITA3Layout = new javax.swing.GroupLayout(FIGURITA3);
        FIGURITA3.setLayout(FIGURITA3Layout);
        FIGURITA3Layout.setHorizontalGroup(
                FIGURITA3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 142, Short.MAX_VALUE)
        );
        FIGURITA3Layout.setVerticalGroup(
                FIGURITA3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 187, Short.MAX_VALUE)
        );

        FIGURITA4.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        javax.swing.GroupLayout FIGURITA4Layout = new javax.swing.GroupLayout(FIGURITA4);
        FIGURITA4.setLayout(FIGURITA4Layout);
        FIGURITA4Layout.setHorizontalGroup(
                FIGURITA4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 142, Short.MAX_VALUE)
        );
        FIGURITA4Layout.setVerticalGroup(
                FIGURITA4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 187, Short.MAX_VALUE)
        );

        FIGURITA5.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        javax.swing.GroupLayout FIGURITA5Layout = new javax.swing.GroupLayout(FIGURITA5);
        FIGURITA5.setLayout(FIGURITA5Layout);
        FIGURITA5Layout.setHorizontalGroup(
                FIGURITA5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 142, Short.MAX_VALUE)
        );
        FIGURITA5Layout.setVerticalGroup(
                FIGURITA5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 187, Short.MAX_VALUE)
        );

        FIGURITA6.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        javax.swing.GroupLayout FIGURITA6Layout = new javax.swing.GroupLayout(FIGURITA6);
        FIGURITA6.setLayout(FIGURITA6Layout);
        FIGURITA6Layout.setHorizontalGroup(
                FIGURITA6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 142, Short.MAX_VALUE)
        );
        FIGURITA6Layout.setVerticalGroup(
                FIGURITA6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGap(0, 187, Short.MAX_VALUE)
        );

        javax.swing.GroupLayout panelImageLayout = new javax.swing.GroupLayout(panelImage);
        panelImage.setLayout(panelImageLayout);
        panelImageLayout.setHorizontalGroup(
                panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, panelImageLayout.createSequentialGroup()
                                .addGroup(panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                        .addGroup(panelImageLayout.createSequentialGroup()
                                                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                                .addComponent(cmdsalir))
                                        .addGroup(javax.swing.GroupLayout.Alignment.LEADING, panelImageLayout.createSequentialGroup()
                                                .addGap(39, 39, 39)
                                                .addGroup(panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                                        .addGroup(panelImageLayout.createSequentialGroup()
                                                                .addComponent(FIGURITA4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 40, Short.MAX_VALUE)
                                                                .addComponent(FIGURITA5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                                .addGap(35, 35, 35)
                                                                .addComponent(FIGURITA6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                                                        .addComponent(cmdjugar, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, panelImageLayout.createSequentialGroup()
                                                                .addComponent(FIGURITA1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                                                .addComponent(FIGURITA2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                                .addGap(35, 35, 35)
                                                                .addComponent(FIGURITA3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                                .addGap(59, 59, 59))
                        .addGroup(panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addGroup(panelImageLayout.createSequentialGroup()
                                        .addGap(39, 39, 39)
                                        .addComponent(lblcombo, javax.swing.GroupLayout.PREFERRED_SIZE, 172, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                        .addComponent(cbocombo, javax.swing.GroupLayout.PREFERRED_SIZE, 323, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addContainerGap(61, Short.MAX_VALUE)))
        );
        panelImageLayout.setVerticalGroup(
                panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, panelImageLayout.createSequentialGroup()
                                .addGap(60, 60, 60)
                                .addGroup(panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addComponent(FIGURITA1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(FIGURITA2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(FIGURITA3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addGroup(panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                        .addComponent(FIGURITA4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(FIGURITA5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addComponent(FIGURITA6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 13, Short.MAX_VALUE)
                                .addComponent(cmdjugar, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(cmdsalir)
                                .addGap(19, 19, 19))
                        .addGroup(panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addGroup(panelImageLayout.createSequentialGroup()
                                        .addGap(22, 22, 22)
                                        .addGroup(panelImageLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                                .addComponent(lblcombo, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                .addComponent(cbocombo))
                                        .addGap(503, 503, 503)))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(panelImage, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );
        layout.setVerticalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(panelImage, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void cbocomboItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cbocomboItemStateChanged
        try {
            ComboFiguritaController ED = new ComboFiguritaController();
            ED.prepararCombo((String) this.cbocombo.getSelectedItem(), this);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(VCOMBOS.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_cbocomboItemStateChanged

    private void cbocomboActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cbocomboActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cbocomboActionPerformed

    private void cmdjugarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdjugarActionPerformed
        ComboFigurita C = new ComboFigurita();

        C.setNombrecombo((String) this.cbocombo.getSelectedItem());
        C.setDificultadcombo("Dificil");
        this.hide();
        try {
            new ComboFiguritaController().comboElegido(C, A.getPartida(), A);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(VCOMBOS.class.getName()).log(Level.SEVERE, null, ex);
        }

    }//GEN-LAST:event_cmdjugarActionPerformed

    private void cmdsalirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdsalirActionPerformed
        this.hide();
        A.show();
    }//GEN-LAST:event_cmdsalirActionPerformed

    /**
     * @param args the command line arguments
     */


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private org.edisoncor.gui.panel.PanelImage FIGURITA1;
    private org.edisoncor.gui.panel.PanelImage FIGURITA2;
    private org.edisoncor.gui.panel.PanelImage FIGURITA3;
    private org.edisoncor.gui.panel.PanelImage FIGURITA4;
    private org.edisoncor.gui.panel.PanelImage FIGURITA5;
    private org.edisoncor.gui.panel.PanelImage FIGURITA6;
    private javax.swing.JComboBox cbocombo;
    private javax.swing.JButton cmdjugar;
    private javax.swing.JButton cmdsalir;
    private javax.swing.JComboBox jComboBox1;
    private javax.swing.JLabel lblcombo;
    private org.edisoncor.gui.panel.PanelImage panelImage;
    // End of variables declaration//GEN-END:variables

    public void inicializar(VJUGARPOR aThis) throws ClassNotFoundException, SQLException {
        this.A = aThis;

        new ComboFiguritaController().inicializarVcombos(this);

        this.show();
        A.hide();
        if (this.cbocombo.getItemCount() == 0) {
            A.show();
            this.hide();
            JOptionPane.showMessageDialog(null, "No tenes más combos para jugar, solamente te quedan figuritas por colecccionar.");
        }


    }

    public VJUGARPOR getA() {
        return A;
    }

    public void setA(VJUGARPOR A) {
        this.A = A;
    }

    public ComboFigurita getCOMBITOS() {
        return COMBITOS;
    }

    public void setCOMBITOS(ComboFigurita COMBITOS) {
        this.COMBITOS = COMBITOS;
    }

    public JComboBox getCbocombo() {
        return cbocombo;
    }

    public void setCbocombo(JComboBox cbocombo) {
        this.cbocombo = cbocombo;
    }

    public JButton getCmdjugar() {
        return cmdjugar;
    }

    public void setCmdjugar(JButton cmdjugar) {
        this.cmdjugar = cmdjugar;
    }

    public JButton getCmdsalir() {
        return cmdsalir;
    }

    public void setCmdsalir(JButton cmdsalir) {
        this.cmdsalir = cmdsalir;
    }

    public JComboBox getjComboBox1() {
        return jComboBox1;
    }

    public void setjComboBox1(JComboBox jComboBox1) {
        this.jComboBox1 = jComboBox1;
    }


    public JLabel getLblcombo() {
        return lblcombo;
    }

    public void setLblcombo(JLabel lblcombo) {
        this.lblcombo = lblcombo;
    }

    public PanelImage getFIGURITA1() {
        return FIGURITA1;
    }

    public void setFIGURITA1(PanelImage FIGURITA1) {
        this.FIGURITA1 = FIGURITA1;
    }

    public PanelImage getFIGURITA2() {
        return FIGURITA2;
    }

    public void setFIGURITA2(PanelImage FIGURITA2) {
        this.FIGURITA2 = FIGURITA2;
    }

    public PanelImage getFIGURITA3() {
        return FIGURITA3;
    }

    public void setFIGURITA3(PanelImage FIGURITA3) {
        this.FIGURITA3 = FIGURITA3;
    }

    public PanelImage getFIGURITA4() {
        return FIGURITA4;
    }

    public void setFIGURITA4(PanelImage FIGURITA4) {
        this.FIGURITA4 = FIGURITA4;
    }

    public PanelImage getFIGURITA5() {
        return FIGURITA5;
    }

    public void setFIGURITA5(PanelImage FIGURITA5) {
        this.FIGURITA5 = FIGURITA5;
    }

    public PanelImage getFIGURITA6() {
        return FIGURITA6;
    }

    public void setFIGURITA6(PanelImage FIGURITA6) {
        this.FIGURITA6 = FIGURITA6;
    }


}
