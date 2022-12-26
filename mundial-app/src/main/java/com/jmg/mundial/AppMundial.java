package com.jmg.mundial;

import com.jmg.mundial.view.Inicio;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class AppMundial {

    public static void main(String args[]) {
        Inicio vis = new Inicio();
        vis.setLocationRelativeTo(vis);
        vis.show();
        SpringApplication.run(AppMundial.class, args);

    }
}
