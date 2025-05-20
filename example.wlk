class Corsa {
  var property color 
  var position = new Position(x=4, y=7) // game.at(0,0)
  const pasoPor = []
  method capacidad() = 4
  method velocidadMaxima() = 150
  method peso() = 1300
}

//new Corsa(color = "rojo")
// var liste = [1,2,3,4]
//const listaDeAutos = [new Corsa(color="rojo")]
//listaDeAutos.add(new Corsa(color="rojo")]
//const primerCorsa = listaDeAutos.get(0)

class Kwid {
  var property tieneTanqueAdicional
  method capacidad() = if(tieneTanqueAdicional) 4 else 3
  method velocidadMaxima() = if(tieneTanqueAdicional) 120 else 110
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

object comodo {
  method capacidad() = 5
  method peso() = 700
}
object popular {
  method capacidad()= 12
  method peso()= 1000
}

object pulenta {
  method peso() = 800
  method velocidad() = 130
}
object bataton {
  method peso() = 500
  method velocidad() = 80 
}

class Especial {
  var property capacidad 
  const velocidadMaxima // una vez que le asigno un valor, despues no lo puedo modificar.
  var property peso   
  var property color
  method velocidadMaxima() = velocidadMaxima.min(topeVelocidadMaxima.tope()) 
}

object topeVelocidadMaxima {
  var property tope = 200

}

// const especial1 = new Especial( capacidad = 4, peso = 1500, color = "verde", velocidadMaxima =210)
// const especial2 = new Especial( capacidad = 4, peso = 1500, color = "azul", velocidadMaxima =180)

class Dependencia {
  const flota = []
  var property empleados = 0
  method agregarAFlota(rodado) {flota.add(rodado)}
  method  quitarDeFlota(rodado) {flota.remove(rodado)}
  method pesoTotalFlota() = flota.sum({ r => r.peso()})
  method estaBienEquipada() = self.tieneAlMenos3Rodados() && self.todosVanAlMenosA100()
  method tieneAlMenos3Rodados() = flota.size() >2
  method todosVanAlMenosA100() = flota.all({r => r.velocidadMaxima() 100})
  method tieneAlMenosRodados(cantidad) = flota.size() > cantidad

  method capacidadTotalEnColor(color) = self.rodadosDeColor(color).sum({r=> r.capacidad()})
  method rodadosDeColor(color) = flota.filter({r=>r.color() == color})  
  method colorDelRodadoMasRapido() = self.rodadoMasRapido().color()
  method rodadoMasRapido() = flota.max({r=> r.velocidadMaxima()}) 
  method capacidadFaltante() = (empleados - self.capacidadDeLaFlota()).max(0)
  method capacidadDeLaFlota() = flota.sum({r=> r.capacidad()})
  method esGrande() = empleados >= 40 && self.tieneAlMenosRodados(5)
}
