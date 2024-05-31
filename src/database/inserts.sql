INSERT INTO public.provinces(
	name, full_name, latitude, longitude, display_order, id)
	VALUES ('Buenos Aires', 'Buenos Aires', -34.6037, -58.3816, 1, 1),
	('Catamarca', 'Catamarca', -28.4696, -65.7852, 2, 2),
	('Chaco', 'Chaco', -26.8406, -60.7658, 3, 3),
	('Chubut', 'Chubut', -43.3002, -65.1023, 4, 4),
	('Córdoba', 'Córdoba', -31.4201, -64.1888, 5, 5),
	('Corrientes', 'Corrientes', -27.4691, -58.8309, 6, 6),
	('Entre Ríos', 'Entre Ríos', -32.0575, -59.0844, 7, 7),
	('Formosa', 'Formosa', -26.1852, -58.1752, 8, 8),
	('Jujuy', 'Jujuy', -24.1858, -65.2995, 9, 9),
	('La Pampa', 'La Pampa', -36.6167, -64.2833, 10, 10),
	('La Rioja', 'La Rioja', -29.4111, -66.8507, 11, 11),
	('Mendoza', 'Mendoza', -32.8895, -68.8458, 12, 12),
	('Misiones', 'Misiones', -27.4676, -55.8977, 13, 13),
	('Neuquén', 'Neuquén', -38.9526, -68.0591, 14, 14),
	('Río Negro', 'Río Negro', -41.1335, -71.3103, 15, 15),
	('Salta', 'Salta', -24.7859, -65.4117, 16, 16),
	('San Juan', 'San Juan', -31.5375, -68.5364, 17, 17),
	('San Luis', 'San Luis', -33.3016, -66.3378, 18, 18),
	('Santa Cruz', 'Santa Cruz', -50.0000, -69.0000, 19, 19),
	('Santa Fe', 'Santa Fe', -31.6107, -60.6973, 20, 20),
	('Santiago del Estero', 'Santiago del Estero', -27.7951, -64.2615, 21, 21),
	('Tierra del Fuego', 'Tierra del Fuego', -54.8000, -68.3000, 22, 22),
	('Tucumán', 'Tucumán', -26.8083, -65.2176, 23, 23);

INSERT INTO public.provinces(
	name, full_name, latitude, longitude, display_order, id)
	VALUES ('Buenos Aires', 'Buenos Aires', -34.6037, -58.3816, 1, 1),
	('Catamarca', 'Catamarca', -28.4696, -65.7852, 2, 2),
	('Chaco', 'Chaco', -26.8406, -60.7658, 3, 3),
	('Chubut', 'Chubut', -43.3002, -65.1023, 4, 4),
	('Córdoba', 'Córdoba', -31.4201, -64.1888, 5, 5),
	('Corrientes', 'Corrientes', -27.4691, -58.8309, 6, 6),
	('Entre Ríos', 'Entre Ríos', -32.0575, -59.0844, 7, 7),
	('Formosa', 'Formosa', -26.1852, -58.1752, 8, 8),
	('Jujuy', 'Jujuy', -24.1858, -65.2995, 9, 9),
	('La Pampa', 'La Pampa', -36.6167, -64.2833, 10, 10),
	('La Rioja', 'La Rioja', -29.4111, -66.8507, 11, 11),
	('Mendoza', 'Mendoza', -32.8895, -68.8458, 12, 12),
	('Misiones', 'Misiones', -27.4676, -55.8977, 13, 13),
	('Neuquén', 'Neuquén', -38.9526, -68.0591, 14, 14),
	('Río Negro', 'Río Negro', -41.1335, -71.3103, 15, 15),
	('Salta', 'Salta', -24.7859, -65.4117, 16, 16),
	('San Juan', 'San Juan', -31.5375, -68.5364, 17, 17),
	('San Luis', 'San Luis', -33.3016, -66.3378, 18, 18),
	('Santa Cruz', 'Santa Cruz', -50.0000, -69.0000, 19, 19),
	('Santa Fe', 'Santa Fe', -31.6107, -60.6973, 20, 20),
	('Santiago del Estero', 'Santiago del Estero', -27.7951, -64.2615, 21, 21),
	('Tierra del Fuego', 'Tierra del Fuego', -54.8000, -68.3000, 22, 22),
	('Tucumán', 'Tucumán', -26.8083, -65.2176, 23, 23);


INSERT INTO public.event_locations(
    name, full_address, max_capacity, latitude, longitude, id_creator_user, id_location)
VALUES 
('Conferencia de Marketing', 'Av. Libertador 123', 100, -34.6037, -58.3816, 1, 87),
('Taller de Fotografía', 'Calle Principal 456', 120, -28.4696, -65.7852, 2, 88),
('Fiesta de Fin de Año', 'Av. Belgrano 789', 150, -26.8406, -60.7658, 3, 89),
('Concierto de Jazz', 'Plaza Principal, 1001', 200, -43.3002, -65.1023, 4, 90),
('Curso de Cocina', 'Av. Libertador 246', 80, -31.4201, -64.1888, 5, 91),
('Feria de Artesanías', 'Calle Independencia 789', 180, -27.4691, -58.8309, 6, 92),
('Concurso de Pintura', 'Av. Belgrano 1234', 250, -32.0575, -59.0844, 7, 93),
('Presentación de Libro', 'Av. Mitre 567', 100, -26.1852, -58.1752, 8, 94),
('Exposición de Arte', 'Calle San Martín 1010', 150, -24.1858, -65.2995, 9, 95),
('Feria del Libro', 'Plaza Principal 456', 120, -36.6167, -64.2833, 10, 96),
('Show de Stand-up', 'Av. Rivadavia 789', 200, -29.4111, -66.8507, 11, 97),
('Taller de Escritura', 'Calle Belgrano 246', 80, -32.8895, -68.8458, 12, 98),
('Exposición de Fotografía', 'Calle Principal 1010', 180, -27.4676, -55.8977, 13, 99),
('Festival de Cine', 'Av. San Martín 789', 250, -38.9526, -68.0591, 14, 100),
('Torneo de Ajedrez', 'Av. Belgrano 1234', 100, -41.1335, -71.3103, 15, 101),
('Concierto de Rock', 'Av. Libertador 567', 150, -24.7859, -65.4117, 16, 102),
('Festival de Tango', 'Plaza Principal 789', 180, -31.5375, -68.5364, 17, 103),
('Exposición de Esculturas', 'Av. Libertador 1010', 200, -33.3016, -66.3378, 18, 104),
('Concierto de Música Clásica', 'Calle Principal 123', 250, -50.0000, -69.0000, 19, 105),
('Feria de Diseño', 'Calle 123, Ciudad', 120, -31.6107, -60.6973, 20, 106);

INSERT INTO public.tags(name) VALUES ('Mucha gente');
INSERT INTO public.tags(name) VALUES ('Poca gente');
INSERT INTO public.tags(name) VALUES ('Deportes');
INSERT INTO public.tags(name) VALUES ('Cultural');
INSERT INTO public.tags(name) VALUES ('Educación');
INSERT INTO public.tags(name) VALUES ('Arte');
INSERT INTO public.tags(name) VALUES ('Música');
INSERT INTO public.tags(name) VALUES ('Familiar');
INSERT INTO public.tags(name) VALUES ('Entretenimiento');
INSERT INTO public.tags(name) VALUES ('Gastronomía');


INSERT INTO public.event_categories(name, display_order) VALUES ('Conciertos', 1);
INSERT INTO public.event_categories(name, display_order) VALUES ('Conferencias', 2);
INSERT INTO public.event_categories(name, display_order) VALUES ('Festivales', 3);
INSERT INTO public.event_categories(name, display_order) VALUES ('Talleres de Arte', 4);
INSERT INTO public.event_categories(name, display_order) VALUES ('Cursos de Cocina', 5);
INSERT INTO public.event_categories(name, display_order) VALUES ('Exposiciones', 6);
INSERT INTO public.event_categories(name, display_order) VALUES ('Eventos Deportivos', 7);
INSERT INTO public.event_categories(name, display_order) VALUES ('Ferias', 8);
INSERT INTO public.event_categories(name, display_order) VALUES ('Encuentros Culturales', 9);
INSERT INTO public.event_categories(name, display_order) VALUES ('Charlas', 10);
