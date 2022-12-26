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
public class Respuesta {
    private String respuesta;
    private boolean correcta;

    public Respuesta(String respuesta, boolean correcta) {
        this.respuesta = respuesta;
        this.correcta = correcta;
    }

    public Respuesta() {
        
    }


    
    
}
