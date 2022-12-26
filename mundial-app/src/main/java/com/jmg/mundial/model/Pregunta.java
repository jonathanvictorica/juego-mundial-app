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
public class Pregunta {
    private String pregunta;
    private Respuesta[] respuestas;
    private String niveldificultad;

    public Pregunta(String pregunta, String niveldificultad) {
        this.pregunta = pregunta;
        this.niveldificultad = niveldificultad;
        
    }

    
    

    
   
    
    
}
