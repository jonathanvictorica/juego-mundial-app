/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.model;

import lombok.Getter;
import lombok.Setter;

import java.sql.SQLException;

@Getter
@Setter
public class Partida {
    private int codigopartida;
    private String nombrejugador;
    private String estado;
    private PartidaCombo partidacombo = null;
    private PartidaFigurita partidafiguritas = null;

    public Partida(int codigopartida, String nombrejugador, String estado) {
        this.codigopartida = codigopartida;
        this.nombrejugador = nombrejugador;
        this.estado = estado;
    }

    public Partida(int codigopartida, String nombrejugador, String estado, PartidaCombo partidacombo, PartidaFigurita partidafiguritas) {
        this.codigopartida = codigopartida;
        this.nombrejugador = nombrejugador;
        this.estado = estado;
        this.partidacombo = partidacombo;
        this.partidafiguritas = partidafiguritas;
    }


    
    public void inicializartodo() throws ClassNotFoundException, SQLException
    {
             PartidaCombo partidacom = PartidaCombo.inicializarpartida(this);
             PartidaFigurita partidafiritas = PartidaFigurita.inicializarpartida(this);
            
             this.setPartidacombo(partidacom); 
             this.setPartidafiguritas(partidafiritas);
          
                     
     }
}
