
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------- PUNTO 1, EJERCICIO 1 ---------------------------------------------------------------------------

CREATE database Gestion_Universidad;

USE Gestion_Universidad;

CREATE TABLE Estudiantes (
    EstudianteID int PRIMARY KEY,
    NombreEstudiante varchar(100)
);

CREATE TABLE Cursos (
    CursoID int PRIMARY KEY,
    NombreCurso varchar(100),
    ProfesorID int
);

CREATE TABLE Profesores (
    ProfesorID int PRIMARY KEY,
    NombreProfesor varchar(100),
    Departamento varchar(100)
);

CREATE TABLE Inscripcion_Universidad (
    EstudianteID int,
    CursoID int,
    PRIMARY KEY (EstudianteID, CursoID),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------- PUNTO 1, EJERCICIO 2 ---------------------------------------------------------------------------

CREATE database Gestion_Hospital;

USE Gestion_Hospital;


CREATE TABLE Pacientes (
    PacienteID int PRIMARY KEY,
    NombrePaciente varchar(100),
    FechaNacimiento date
);

CREATE TABLE Medicos (
    MedicoID int PRIMARY KEY,
    NombreMedico varchar(100),
    Especialidad varchar(100)
);

CREATE TABLE Visitas (
    VisitaID int PRIMARY KEY AUTO_INCREMENT,
    PacienteID int,
    MedicoID int,
    FechaVisita datetime,
    FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID),
    FOREIGN KEY (MedicoID) REFERENCES Medicos(MedicoID)
);

CREATE TABLE Tratamientos (
    TratamientoID int PRIMARY KEY AUTO_INCREMENT,
    VisitaID int,
    DescripcionTratamiento varchar(255),
    Medicamento varchar(100),
    Dosis varchar(50),
    FOREIGN KEY (VisitaID) REFERENCES Visitas(VisitaID)
    
    
    
    