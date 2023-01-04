
package com.jmg.mundial.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.SQLException;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
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


    public void inicializartodo() throws ClassNotFoundException, SQLException
    {
             PartidaCombo partidacom = PartidaCombo.inicializarpartida(this);
             PartidaFigurita partidafiritas = PartidaFigurita.inicializarpartida(this);
            
             this.setPartidacombo(partidacom); 
             this.setPartidafiguritas(partidafiritas);
          
                     
     }
}
