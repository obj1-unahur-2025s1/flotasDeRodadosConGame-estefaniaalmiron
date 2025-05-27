import wollok.game.*

class Corsa {
    var property color
    method initialize() {
        if(!coloresValidos.listaColores().contains(color)) {
            self.error(color.toString() + " no es un color válido")
        }  
    }
    method capacidad() = 4
    method velocidadMaxima() = 150
    method peso() = 1300

}

class Kwid {
    var property tieneTanqueAdicional
    method capacidad() = if(tieneTanqueAdicional) 3 else 4
    method velocidadMaxima() = if(tieneTanqueAdicional) 110 else 120
    method peso() = 1200 + if(tieneTanqueAdicional) 150 else 0
    method color() = "azul"
}

object trafic {
    var property interior = comodo
    var property motor = pulenta
    method capacidad() = interior.capacidad()
    method velocidadMaxima() = motor.velocidad()
    method peso() = 4000 + interior.peso() + motor.peso()
    method color() = "blanco"
}

class Especial {
    var property capacidad
    var property peso
    var property color
    const velocidadMaxima 
    method initialize() {
        if(not coloresValidos.listaColores().contains(color)) {
            self.error(color.toString() + " no es un color válido")
        }  
    }
    method velocidadMaxima() = 
        velocidadMaxima.min(topeVelocidadMaxima.tope())
}

object topeVelocidadMaxima {
    var property tope = 200
}

object pulenta {
    method peso() = 800
    method velocidad() = 130
}

object bataton {
    method peso() = 500
    method velocidad() = 80
}
object comodo {
    method capacidad() = 5
    method peso() = 700
}

object popular {
    method capacidad() = 12
    method peso() = 1000
}

class Dependencia {
    const flota = []
    const pedidos = #{}
    var property empleados = 0
    method agregarPedido(unPedido) {pedidos.add(unPedido)}
    method quitarPedido(unPedido) {pedidos.remove(unPedido)}  
    method agregarAFlota(rodado) {flota.add(rodado)}
    method quitarDeFlota(rodado) {flota.remove(rodado)}
    method pesoTotalFlota() = flota.sum({r=>r.peso()})
    method estaBienEquipada() = 
        self.tieneAlMenosRodados(3) && self.todosVanAlMenosA100()

    method tieneAlMenosRodados(cantidad) = flota.size() >= cantidad
    method todosVanAlMenosA100() = flota.all({r=>r.velocidadMaxima()>=100})
    method capacidadTotalEnColor(color) = 
        self.rodadosDeColor(color).sum({r=>r.capacidad()})
    method rodadosDeColor(color) = flota.filter({r=>r.color() == color})
    method colorDelRodadoMasRapido() = self.rodadoMasRapido().color()
    method rodadoMasRapido() = flota.max({r=>r.velocidadMaxima()})
    method capacidadFaltante() = (empleados - self.capacidadDeLaFlota()).max(0)
    method capacidadDeLaFlota() = flota.sum({r=>r.capacidad()})
    method esGrande() = empleados >= 40 && self.tieneAlMenosRodados(5)
    method totalPasajerosEnPedidos() = pedidos.sum({p=>p.pasajeros()})
    method pedidosNoPuedenSerSatisfechos() = 
        pedidos.filter({p=> not self.hayAlgunRodadoQueSatisfaceUnPedido(p)})
    method hayAlgunRodadoQueSatisfaceUnPedido(unPedido) =
        flota.any({r=>unPedido.puedeSatisfacer(r)})
    
    method todosLosPedidosTienenIncompatible(unColor) =
        pedidos.all({p=>p.coloresIncompatibles().contains(unColor)})
    
    method relajarTodosLosPedidos(){
        pedidos.forEach({p=>p.relajar()})
    }
}
object coloresValidos {
    const property listaColores = #{"rojo","verde","azul","blanco","negro","beige"}
}
class Pedido{
    var property distanciaARecorrer 
    var tiempoMaximo 
    var property pasajeros   
    const property coloresIncompatibles = #{ }

    method acelerar(){tiempoMaximo = 1.max(tiempoMaximo - 1 )}
    method relajar(){tiempoMaximo = tiempoMaximo + 1  }
    method initialize() {
        if(!distanciaARecorrer.between(1,1000)) {
            self.error(distanciaARecorrer.toString() + " no es valida")
        }
        if(!tiempoMaximo.between(1,1000)) {
            self.error(tiempoMaximo.toString() + " no es valida")
        }
        if(!pasajeros.between(1,100)) {
            self.error(pasajeros.toString() + " no es valida")
        }
    }
    method agregarColorIncompatible(unColor){
        if(!self.coloresIncompatibles().contains(unColor)){
            self.error(unColor.toString() + " no es un color valido")
        }
        coloresIncompatibles.add(unColor)
    }  
    method velocidadRequerida() = distanciaARecorrer / tiempoMaximo

    method puedeSatisfacer(auto) =
        self.velocidadRequerida() + 10 <= auto.velocidadMaxima() and
        self.pasajeros() <= auto.capacidad() and
        !self.coloresIncompatibles().contains(auto.color()) // method colorIncompatible(unColor) = coloresIncompatibles     
 

}
