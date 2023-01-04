
package com.jmg.mundial.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AlbumPais {
    private int codigoalbum;
    private String nombre_pais;
    private String nacionalidad;

    public AlbumPais(int codigoalbum, String nombre_pais, String nacionalidad) {
        this.codigoalbum = codigoalbum;
        this.nombre_pais = nombre_pais;
        this.nacionalidad = nacionalidad;
    }


    
    
    
}
