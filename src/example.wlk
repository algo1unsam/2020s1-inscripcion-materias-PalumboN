class Carrera {

	var property materias = [] // V

	method agregarMateria(_materia) {
		materias.add(_materia)
	}

}

class Estudiante {

	var property materiasAprobadas = []
	var property carrerasEnLasQueEstaInscripto = []

	method agregarCarrera(_carrera) {
		carrerasEnLasQueEstaInscripto.add(_carrera)
	}

	method ingresarMateriaYNotaDeAprobacion(_materia, _nota) {
		if (self.aproboUnaMateria(_materia)) self.error("La materia ya esta registrada como aprobada") else materiasAprobadas.add(new MateriaAprobada(materia = _materia, nota = _nota))
	}

	method cantidadDeMateriasAprobadas() = materiasAprobadas.size()

	method promedio() {
		const sumaNotas = materiasAprobadas.sum({ n => n.nota() })
		return sumaNotas / self.cantidadDeMateriasAprobadas()
	}

	method aproboUnaMateria(unaMateria) = materiasAprobadas.any({ m => m.materia() == unaMateria }) // TRUE

	method materiasDeLasCarrerasEnLasQueEstaInscripto() = carrerasEnLasQueEstaInscripto.map({ m => m.materia() }).flatten() // Coleccion nueva de la coleccion de materias, luego le hago flatten para unir

//	method materiasALasQueSeInscribio() = self.materiasEnLasQueEstaInscripto()
//
//	method materiasEnLasQueEstaEnListaDeEspera() = self.materiasEnLaQueEstaEnListaDeEspera()

	method estaInscriptoEnCarrera(_carrera) = carrerasEnLasQueEstaInscripto.contains(_carrera)

	method materiasQuePuedeCursarDeUnaCarrera(carrera) {
		if (self.estaInscriptoEnCarrera(carrera)) carrera.materias() else self.error("No esta inscripto a la carrera")
	}

	method cumpleRequisitos(_materia) = _materia.requisitos().all({ m => self.aproboUnaMateria(m) })

}

class Materia {

	var property estudiantesInscriptos = []
	var property listaDeEspera = [] // V
	var property requisitos = []
	var property cupo = 3

	const estudiantes = []


	method inscriptos() { return estudiantes.take(cupo) }
	method listaDeEspera() { return estudiantes.drop(cupo) }

	method materiasQueRequiereTenerAprobadas(materia) {
		requisitos.add(materia)
	}

	method inscribirAEstudiante(_estudiante) {
		if (not self.cumpleCondicionesParaInscribirse(_estudiante)) {
			self.error("No cumple condiciones para inscribirse a la materia")
		}
		estudiantes.add(_estudiante)		
//		if (self.cupo() > 0) {
//			estudiantesInscriptos.add(_estudiante)
//		} else {
//			listaDeEspera.add(_estudiante)
//		}
	}

	method cumpleCondicionesParaInscribirse(_estudiante) = not self.yaEstaInscripto(_estudiante) && not _estudiante.aproboUnaMateria(self) && _estudiante.cumpleRequisitos(self)

	method yaEstaInscripto(_estudiante) = estudiantesInscriptos.contains(_estudiante)

	method darDeBaja(_estudiante) {
//		estudiantesInscriptos.remove(_estudiante)
//		if (self.hayEstudiantesEnListaDeEspera()) {
//			estudiantesInscriptos.add(listaDeEspera.first())
//			listaDeEspera.remove(listaDeEspera.first())
//		}
		estudiantes.remove(_estudiante)
	}

	method hayEstudiantesEnListaDeEspera() = listaDeEspera.size() >= 1

	method estudiantesEnListaDeEspera() = listaDeEspera

	method estudiantesInscriptos() = estudiantesInscriptos

}

class MateriaAprobada {

	var property materia
	var property nota

}

