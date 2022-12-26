/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jmg.mundial.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ComboFigurita {
    private int codigocombo;
    private String nombrecombo;
    private String dificultadcombo;
    private String imagencombo;
    private Figurita[] figuritascombo;

    public ComboFigurita() {
    }

    
    public ComboFigurita(int codigocombo, String nombrecombo, String dificultadcombo, String imagencombo, Figurita[] figuritascombo) {
        this.codigocombo = codigocombo;
        this.nombrecombo = nombrecombo;
        this.dificultadcombo = dificultadcombo;
        this.imagencombo = imagencombo;
        this.figuritascombo = figuritascombo;
    }

    public ComboFigurita(int codigocombo, String nombrecombo, String dificultadcombo, String imagencombo) {
        this.codigocombo = codigocombo;
        this.nombrecombo = nombrecombo;
        this.dificultadcombo = dificultadcombo;
        this.imagencombo = imagencombo;
    }

    
    

    
    
}
