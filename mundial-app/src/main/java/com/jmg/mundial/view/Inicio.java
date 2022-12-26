
package com.jmg.mundial.view;


import com.jmg.mundial.controller.PartidaController;
import com.jmg.mundial.model.Partida;

import javax.swing.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class Inicio extends JFrame {


    public Inicio() {
        initComponents();
    }


    public boolean validarrango() {
        boolean puede = false;
        if (this.txtnombrejugador.getText().equals("") == false) {
            puede = true;

        } else {
            JOptionPane.showMessageDialog(null, "Debe ingresar primero el nombre del jugador.");
        }
        if (this.txtnombrejugador.getText().length() > 20) {
            JOptionPane.showMessageDialog(null, "Debe ingresar otro nombre con una longitud maxima de 20 caracteres.");
            puede = false;
            this.vaciarcaja();
        }
        return puede;

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        panelImage1 = new org.edisoncor.gui.panel.PanelImage();
        cmdiniciarpartida = new javax.swing.JButton();
        cmdretomarpartida = new javax.swing.JButton();
        cmdeliminarpartida = new javax.swing.JButton();
        cmdeliminarpartida1 = new javax.swing.JButton();
        txtnombrejugador = new javax.swing.JTextField();
        labelRect1 = new org.edisoncor.gui.label.LabelRect();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        panelImage1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/VISTA/FIGURAS/INICIO.jpg"))); // NOI18N
        panelImage1.setMaximumSize(null);

        cmdiniciarpartida.setText("INICIAR PARTIDA");
        cmdiniciarpartida.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdiniciarpartidaActionPerformed(evt);
            }
        });

        cmdretomarpartida.setText("RETOMAR PARTIDA");
        cmdretomarpartida.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdretomarpartidaActionPerformed(evt);
            }
        });

        cmdeliminarpartida.setText("ELIMINAR PARTIDA");
        cmdeliminarpartida.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdeliminarpartidaActionPerformed(evt);
            }
        });

        cmdeliminarpartida1.setText("SALIR DEL JUEGO");
        cmdeliminarpartida1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdeliminarpartida1ActionPerformed(evt);
            }
        });

        labelRect1.setBackground(new java.awt.Color(0, 51, 51));
        labelRect1.setText("Ingrese Jugador");
        labelRect1.setFont(new java.awt.Font("Arial", 0, 14)); // NOI18N

        javax.swing.GroupLayout panelImage1Layout = new javax.swing.GroupLayout(panelImage1);
        panelImage1.setLayout(panelImage1Layout);
        panelImage1Layout.setHorizontalGroup(
                panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(panelImage1Layout.createSequentialGroup()
                                .addContainerGap()
                                .addComponent(cmdiniciarpartida, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(cmdretomarpartida, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(cmdeliminarpartida, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(cmdeliminarpartida1, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(22, 22, 22))
                        .addGroup(panelImage1Layout.createSequentialGroup()
                                .addGap(157, 157, 157)
                                .addGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                                        .addComponent(labelRect1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addComponent(txtnombrejugador, javax.swing.GroupLayout.PREFERRED_SIZE, 184, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        panelImage1Layout.setVerticalGroup(
                panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(panelImage1Layout.createSequentialGroup()
                                .addGap(99, 99, 99)
                                .addComponent(labelRect1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(txtnombrejugador, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 168, Short.MAX_VALUE)
                                .addGroup(panelImage1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                        .addComponent(cmdeliminarpartida1)
                                        .addComponent(cmdiniciarpartida)
                                        .addComponent(cmdeliminarpartida)
                                        .addComponent(cmdretomarpartida))
                                .addGap(18, 18, 18))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(panelImage1, javax.swing.GroupLayout.PREFERRED_SIZE, 623, javax.swing.GroupLayout.PREFERRED_SIZE)
        );
        layout.setVerticalGroup(
                layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(panelImage1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void cmdeliminarpartida1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdeliminarpartida1ActionPerformed
        System.exit(WIDTH);
    }//GEN-LAST:event_cmdeliminarpartida1ActionPerformed

    private void cmdeliminarpartidaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdeliminarpartidaActionPerformed
        try {

            if (this.validarrango() == true) {
                new PartidaController().eliminarpartida(txtnombrejugador.getText());
            }
            this.vaciarcaja();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Inicio.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_cmdeliminarpartidaActionPerformed

    private void cmdretomarpartidaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdretomarpartidaActionPerformed
        try {
            if (this.validarrango() == true) {
                Partida partidanueva = new PartidaController().retomarpartida(this.txtnombrejugador.getText());
                if (partidanueva != null) {
                    VJUGARPOR nuevaventana = new VJUGARPOR();
                    nuevaventana.inicializarvjugador(partidanueva, this);

                    nuevaventana.show();
                }
            }
            this.vaciarcaja();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Inicio.class.getName()).log(Level.SEVERE, null, ex);
        }        // TODO add your handling code here:
    }//GEN-LAST:event_cmdretomarpartidaActionPerformed

    private void cmdiniciarpartidaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdiniciarpartidaActionPerformed
        try {
            if (this.validarrango() == true) {
                Partida partidanueva = new PartidaController().crearnuevapartida(txtnombrejugador.getText());
                if (partidanueva != null) {

                    VJUGARPOR nuevaventana = new VJUGARPOR();
                    nuevaventana.inicializarvjugador(partidanueva, this);

                    nuevaventana.show();
                }
            }
            this.vaciarcaja();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Inicio.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_cmdiniciarpartidaActionPerformed

    public void vaciarcaja() {
        this.txtnombrejugador.setText("");
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton cmdeliminarpartida;
    private javax.swing.JButton cmdeliminarpartida1;
    private javax.swing.JButton cmdiniciarpartida;
    private javax.swing.JButton cmdretomarpartida;
    private org.edisoncor.gui.label.LabelRect labelRect1;
    private org.edisoncor.gui.panel.PanelImage panelImage1;
    private javax.swing.JTextField txtnombrejugador;
    // End of variables declaration//GEN-END:variables
}
