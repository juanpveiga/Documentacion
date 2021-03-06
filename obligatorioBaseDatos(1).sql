USE [master]
GO
/****** Object:  Database [Obligatorio_Base_Datos]    Script Date: 17/11/2016 8:06:47 ******/
CREATE DATABASE [Obligatorio_Base_Datos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Obligatorio_Base_Datos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Obligatorio_Base_Datos.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Obligatorio_Base_Datos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Obligatorio_Base_Datos_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Obligatorio_Base_Datos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET ARITHABORT OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET  MULTI_USER 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Obligatorio_Base_Datos] SET  READ_WRITE 
GO

DROP TABLE HOTEL;
DROP TABLE Cadena;
DROP TABLE Pertenece;
DROP TABLE Servicio_Extra;
DROP TABLE Dispone;


CREATE TABLE Hotel
(	
    Id_Hotel		NUMERIC (5), 
	Nom_Hotel		VARCHAR(30) NOT NULL,
	Num_Estrellas	VARCHAR(30) NOT NULL,
	Total_Habitacion	NUMERIC(5) NOT NULL,
	Hab_Disponible	NUMERIC (5),
	Pais VARCHAR(30),
	Ciudad VARCHAR(30),
	Districto VARCHAR(30),
	Direccion	VARCHAR(50) NOT NULL,
	Plano VARCHAR (50),
	Porcentaje_Sena INT,
	
Constraint	PK_Hotel PRIMARY KEY(Id_Hotel)
);


CREATE TABLE Cadena
(	Nom_Cadena	VARCHAR(30),
	
	Constraint	PK_Cadena PRIMARY KEY(Nom_Cadena) 
);

CREATE TABLE Pertenece
(	Nom_Cadena		VARCHAR(30),
	Id_Hotel	NUMERIC(5) NOT NULL,

	Constraint	PK_Pertenece PRIMARY KEY(Id_Hotel),
	Constraint Fk_Pertenece_Hotel FOREIGN kEY (Id_Hotel)REFERENCES Hotel(Id_Hotel),

);



CREATE TABLE Servicio_Extra
(	Nom_Serv_Extra		VARCHAR(30),
	Constraint	PK_Servicio_Extra PRIMARY KEY(Nom_Serv_Extra),
);

CREATE TABLE Dispone
(	Nom_Serv_Extra		VARCHAR(30),
    Id_Hotel	NUMERIC(5),
    Costo INT NOT NULL,
	Fecha_Vigencia		DATE UNIQUE,
	Constraint		PK_ PRIMARY KEY (Id_Hotel,Nom_Serv_Extra,Fecha_Vigencia),
	Constraint		FK_Dispone_Servicio_Extra FOREIGN KEY (Nom_Serv_Extra) REFERENCES Servicio_Extra(Nom_Serv_Extra),
	Constraint		FK_Dispone_Hotel FOREIGN KEY (Id_Hotel) REFERENCES Hotel(Id_Hotel)
);

CREATE TABLE Tipo_Habitacion
(	Num_Camas NUMERIC(2) NOT NULL,
	Matrimonial	 CHAR(2) NOT NULL,
	Total_Hab NUMERIC(5),
	
	Constraint		PK_Tipo_Habitacion PRIMARY KEY (Num_Camas,Matrimonial),

);



CREATE TABLE Regimen
(	
Tipo_Regimen VARCHAR (30),

	Constraint	PK_Regimen PRIMARY KEY (Tipo_Regimen),

);

CREATE TABLE Servicio
(	
    Num_Camas NUMERIC(2),
    Matrimonial	 CHAR(2),
    Tipo_Regimen VARCHAR (30),
   
	Constraint	PK_Servicio PRIMARY KEY ( Num_Camas,Matrimonial,Tipo_Regimen),
	Constraint	FK_Servicio_Tipo_Habitacion FOREIGN KEY ( Num_Camas,Matrimonial) REFERENCES Tipo_Habitacion( Num_Camas,Matrimonial),
	Constraint	FK_Servicio_Regimen FOREIGN KEY ( Tipo_Regimen) REFERENCES Regimen( Tipo_Regimen),
	
);

CREATE TABLE Tarifa
(	
     Num_Camas NUMERIC(2),
     Matrimonial	 CHAR(2),
     Tipo_Regimen VARCHAR (30),
	 Fecha_Vigencia		DATE,
	 Id_Hotel	NUMERIC(5),
	 Costo INT,
	 

	Constraint	PK_Dedica PRIMARY KEY (Num_Camas,Matrimonial,Tipo_Regimen, Id_Hotel,Fecha_Vigencia),
	Constraint	FK_Tarifa_Tipo_Habitacion FOREIGN KEY (Num_Camas,Matrimonial) REFERENCES Tipo_Habitacion(Num_Camas,Matrimonial),
	Constraint	FK_Tarifa_Regimen FOREIGN KEY (Tipo_Regimen) REFERENCES Regimen(Tipo_Regimen),
	Constraint	FK_Tarifa_Hotel FOREIGN KEY ( Id_Hotel) REFERENCES Hotel( Id_Hotel),
);

CREATE TABLE Rige
(	 Num_Camas NUMERIC(2),
     Matrimonial	 CHAR(2),
     Tipo_Regimen VARCHAR (30),
	 Id_Hotel	NUMERIC(5),


	Constraint	PK_Rige PRIMARY KEY (Num_Camas,Matrimonial,Tipo_Regimen, Id_Hotel),
	Constraint	FK_Rige_Hotel FOREIGN KEY (Id_Hotel) REFERENCES Hotel(Id_Hotel),
	Constraint	FK_Rige_Tipo_Habitacion FOREIGN KEY (Num_Camas,Matrimonial) REFERENCES Tipo_Habitacion(Num_Camas,Matrimonial),
	Constraint	FK_Rige_Regimen FOREIGN KEY (Tipo_Regimen) REFERENCES Regimen(Tipo_Regimen),
	
);

CREATE TABLE Reserva
(	
    Id_Reserva NUMERIC (5),
	Num_Personas NUMERIC (2)NOT NULL,
	Estado VARCHAR (10) NOT NULL,
	E_Mail VARCHAR (30) NOT NULL,
	Pago INT,
	Fecha_Reserva DATE NOT NULL,
	Constraint	PK_Reserva PRIMARY KEY (Id_Reserva),
	
);

CREATE TABLE Tiene
(	 Id_Reserva NUMERIC (5),
     Num_Camas NUMERIC(2),
     Matrimonial	 CHAR(2),
     Tipo_Regimen VARCHAR (30),
	 Id_Hotel	NUMERIC(5),
	 Cantidad INT,
	 Fecha_Ingreso DATE NOT NULL,
	 Fecha_Salida DATE NOT NULL,
	 Observaciones VARCHAR(50),
	Constraint	PK_Tiene PRIMARY KEY (Num_Camas,Matrimonial,Tipo_Regimen, Id_Hotel,Id_Reserva),
	Constraint	FK_Tiene_Hotel FOREIGN KEY (Id_Hotel) REFERENCES Hotel(Id_Hotel),
	Constraint	FK_Tiene_Tipo_Habitacion FOREIGN KEY (Num_Camas,Matrimonial) REFERENCES Tipo_Habitacion(Num_Camas,Matrimonial),
	Constraint	FK_Tiene_Regimen FOREIGN KEY (Tipo_Regimen) REFERENCES Regimen(Tipo_Regimen),
	Constraint	FK_Tiene_Reserva FOREIGN KEY (Id_Reserva) REFERENCES Reserva(Id_Reserva),
	CHECK(Fecha_Ingreso <= Fecha_Salida)
);





CREATE TABLE Prepago
(	 Id_Reserva NUMERIC (5),
	Constraint 	PK_Prepago PRIMARY KEY (Id_Reserva),
	
);

CREATE TABLE Usuario
(	 
    E_Mail VARCHAR (30) NOT NULL,
	Contrasena CHAR (8) NOT NULL,
   
	Constraint 	PK_Usuario PRIMARY KEY (E_Mail),
	
);

CREATE TABLE Huesped
(	
    Id_Huesped 	INT NOT NULL,
	Nom_Huesped	VARCHAR(30) NOT NULL,
	Apellido_Pat		VARCHAR(30),
	Apellido_Mat		VARCHAR(30),
    Pais	VARCHAR(30),
	Num_Documento INT,
	TipoDocumento VARCHAR (20),
	Fecha_Nacimiento 	DATE,
	
	Constraint 	PK_Huesped PRIMARY KEY ( Id_Huesped),
	
);

CREATE TABLE Telefono_Huesped
(	
    Id_Huesped 	INT,
	Telefono	VARCHAR(30) NOT NULL,
	
	
	Constraint 	PK_Telefono_Huesped PRIMARY KEY (Id_Huesped,Telefono),
	Constraint 	FK_Telefono_Huesped_Huesped FOREIGN KEY (Id_Huesped) REFERENCES Huesped(Id_Huesped),
);

CREATE TABLE Email_Huesped
(	
    Id_Huesped 	INT,
	E_Mail	VARCHAR(30) NOT NULL,
	
	
	Constraint 	PK_Email_Huesped PRIMARY KEY (Id_Huesped,E_Mail),
	Constraint 	FK_Email_Huesped_Huesped FOREIGN KEY (Id_Huesped) REFERENCES Huesped(Id_Huesped),
);


CREATE TABLE Es
(	
    Id_Huesped 	INT NOT NULL,
	E_Mail	VARCHAR(30) NOT NULL,
	
	
	Constraint 	PK_Es PRIMARY KEY (E_Mail),
	Constraint 	FK_Es_Huesped FOREIGN KEY (Id_Huesped) REFERENCES Huesped(Id_Huesped),
	Constraint 	FK_Es_Usuario FOREIGN KEY (E_Mail) REFERENCES Usuario(E_Mail),
);



CREATE TABLE Habitacion
(	
    Id_Hotel	NUMERIC(5),
	Num_Habitacion INT,
    Caracteristicas VARCHAR(50),
	Plazas INT,
	Num_Camas NUMERIC(2),
    Matrimonial	 CHAR(2),
	
	
	Constraint 	PK_Habitacion PRIMARY KEY ( Id_Hotel,Num_Habitacion),
	Constraint 	FK_Habitacion_Hotel FOREIGN KEY (Id_Hotel) REFERENCES Hotel(Id_Hotel),
	
);


CREATE TABLE Ocupacion
(	
    Id_Hotel	NUMERIC(5),
	Num_Habitacion INT,
    Fecha_Desde DATE,
	Fecha_Hasta DATE,
	
	
	Constraint 	PK_Ocupacion PRIMARY KEY ( Id_Hotel,Num_Habitacion,Fecha_Desde),
	Constraint 	FK_Ocupacion_Hotel FOREIGN KEY (Id_Hotel) REFERENCES Hotel(Id_Hotel),
	Constraint 	FK_Habitacion_Habitacion FOREIGN KEY (Id_Hotel,Num_Habitacion) REFERENCES Habitacion(Id_Hotel,Num_Habitacion),
);


CREATE TABLE Asigna
(	
    Id_Hotel	NUMERIC(5),
	Num_Habitacion INT,
    Fecha_Desde DATE,
	Id_Huesped 	INT,
	
	
	Constraint 	PK_Asigna PRIMARY KEY ( Id_Hotel,Num_Habitacion,Fecha_Desde,Id_Huesped),
	Constraint 	FK_Asigna_Hotel FOREIGN KEY (Id_Hotel) REFERENCES Hotel(Id_Hotel),
	Constraint 	FK_Asigna_Habitacion FOREIGN KEY (Id_Hotel,Num_Habitacion) REFERENCES Habitacion(Id_Hotel,Num_Habitacion),
	Constraint 	FK_Asigna_Ocupacion FOREIGN KEY (Id_Hotel,Num_Habitacion,Fecha_Desde) REFERENCES Ocupacion(Id_Hotel,Num_Habitacion,Fecha_Desde),
);



CREATE TABLE Corresponde
(	
    Id_Hotel	NUMERIC(5),
	Num_Habitacion INT,
    Fecha_Desde DATE,
	Id_Reserva NUMERIC (5),
	
	
	Constraint 	PK_Corresponde PRIMARY KEY ( Id_Hotel,Num_Habitacion,Fecha_Desde),
	Constraint 	FK_Corresponde_Hotel FOREIGN KEY (Id_Hotel) REFERENCES Hotel(Id_Hotel),
	Constraint 	FK_Corresponde_Habitacion FOREIGN KEY (Id_Hotel,Num_Habitacion) REFERENCES Habitacion(Id_Hotel,Num_Habitacion),
	Constraint 	FK_Corresponde_Reserva FOREIGN KEY (Id_Reserva) REFERENCES Reserva(Id_Reserva),
);





