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
public class Figurita {
    private String nombrejugador;
    private AlbumPais albumpais;

    private String rutaimagen;
    private String dificultad;
    private String posicion;
    private int numero;
    
    public Figurita(String nombrejugador, AlbumPais albumpais, String rutaimagen, String dificultad) {
        this.nombrejugador = nombrejugador;
        this.albumpais = albumpais;
        
        this.rutaimagen = rutaimagen;
        this.dificultad = dificultad;
    }


    
}
