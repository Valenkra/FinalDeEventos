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

INSERT INTO public.event_categories(id, name, display_order) VALUES (1,'Conciertos', 1);
INSERT INTO public.event_categories(id, name, display_order) VALUES (2,'Conferencias', 2);
INSERT INTO public.event_categories(id, name, display_order) VALUES (3,'Festivales', 3);
INSERT INTO public.event_categories(id, name, display_order) VALUES (4,'Talleres de Arte', 4);
INSERT INTO public.event_categories(id, name, display_order) VALUES (5,'Cursos de Cocina', 5);
INSERT INTO public.event_categories(id, name, display_order) VALUES (6,'Exposiciones', 6);
INSERT INTO public.event_categories(id, name, display_order) VALUES (7,'Eventos Deportivos', 7);
INSERT INTO public.event_categories(id, name, display_order) VALUES (8,'Ferias', 8);
INSERT INTO public.event_categories(id, name, display_order) VALUES (9,'Encuentros Culturales', 9);
INSERT INTO public.event_categories(id, name, display_order) VALUES (10,'Charlas', 10);


INSERT INTO public.event_locations(
    id, name, full_address, max_capacity, latitude, longitude, id_creator_user, id_location)
VALUES 
(1, 'Conferencia de Marketing', 'Av. Libertador 123', 100, -34.6037, -58.3816, 1, 87),
(2, 'Taller de Fotografía', 'Calle Principal 456', 120, -28.4696, -65.7852, 2, 88),
(3, 'Fiesta de Fin de Año', 'Av. Belgrano 789', 150, -26.8406, -60.7658, 3, 89),
(4, 'Concierto de Jazz', 'Plaza Principal, 1001', 200, -43.3002, -65.1023, 4, 90),
(5, 'Curso de Cocina', 'Av. Libertador 246', 80, -31.4201, -64.1888, 5, 91),
(6, 'Feria de Artesanías', 'Calle Independencia 789', 180, -27.4691, -58.8309, 6, 92),
(7, 'Concurso de Pintura', 'Av. Belgrano 1234', 250, -32.0575, -59.0844, 7, 93),
(8, 'Presentación de Libro', 'Av. Mitre 567', 100, -26.1852, -58.1752, 8, 94),
(9, 'Exposición de Arte', 'Calle San Martín 1010', 150, -24.1858, -65.2995, 9, 95),
(10, 'Feria del Libro', 'Plaza Principal 456', 120, -36.6167, -64.2833, 10, 96),
(11, 'Show de Stand-up', 'Av. Rivadavia 789', 200, -29.4111, -66.8507, 11, 97),
(12, 'Taller de Escritura', 'Calle Belgrano 246', 80, -32.8895, -68.8458, 12, 98),
(13, 'Exposición de Fotografía', 'Calle Principal 1010', 180, -27.4676, -55.8977, 13, 99),
(14, 'Festival de Cine', 'Av. San Martín 789', 250, -38.9526, -68.0591, 14, 100),
(15, 'Torneo de Ajedrez', 'Av. Belgrano 1234', 100, -41.1335, -71.3103, 15, 101),
(16, 'Concierto de Rock', 'Av. Libertador 567', 150, -24.7859, -65.4117, 16, 102),
(17, 'Festival de Tango', 'Plaza Principal 789', 180, -31.5375, -68.5364, 17, 103),
(18, 'Exposición de Esculturas', 'Av. Libertador 1010', 200, -33.3016, -66.3378, 18, 104),
(19, 'Concierto de Música Clásica', 'Calle Principal 123', 250, -50.0000, -69.0000, 19, 105),
(20, 'Feria de Diseño', 'Calle 123, Ciudad', 120, -31.6107, -60.6973, 20, 106);


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

INSERT INTO public.users(first_name, last_name, username, password) VALUES 
	('Paula', 'Morales', 'paulamorales', 'passpass'),
	('Fernando', 'Ortega', 'fernandoortega', 'passwordpass'),
	('Verónica', 'Ramírez', 'veronicaramirez', 'passpass123'),
	('Daniel', 'Flores', 'danielflores', 'passwordpass123'),
	('Carmen', 'González', 'carmengonzalez', 'passpasspass'),
	('Rosa', 'Jiménez', 'rosajimenez', 'pass123pass'),
	('Pablo', 'Cabrera', 'pablocabrera', '123pass123'),
	('Marcela', 'Vargas', 'marcelavargas', 'passpass123'),
	('Alberto', 'Romero', 'albertoromero', '123456789'),
	('Silvia', 'Navarro', 'silvianavarro', '987654321'),
	('Lorenzo', 'Cruz', 'lorenzocruz', 'passwordpassword'),
	('Raquel', 'Ortiz', 'raquelortiz', 'passwordpassword123'),
	('Gonzalo', 'Rivas', 'gonzalorivas', 'passwordpassword456'),
	('Cristina', 'Moreno', 'cristinamoreno', 'passwordpassword789'),
	('Mario', 'Álvarez', 'marioalvarez', 'password123456'),
	('Eva', 'Fuentes', 'evafuentes', '123456abcdef'),
	('José', 'Santos', 'josesantos', 'abcdef123456'),
	('Isabel', 'Vega', 'isabelvega', 'passwordabcdef'),
	('Roberto', 'Serrano', 'robertoserrano', 'abcdefpassword'),
	('Natalia', 'Blanco', 'nataliablanco', 'passwordabcdef123'),
	('Gabriel', 'Iglesias', 'gabrieliglesias', '123456password'),
	('Alicia', 'Molina', 'aliciamolina', 'password123456'),
	('Martín', 'Castro', 'martincastro', 'abcdef123456'),
	('Victoria', 'Herrera', 'victoriaherrera', 'password123456789');


INSERT INTO public.events(
    id, name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location)
VALUES 
    (1, 'Concierto de Verano', '¡Disfruta de una noche llena de música en nuestro concierto de verano! Ven y únete a nosotros para una experiencia inolvidable.', 1, '2024-06-01', 120, 50.00, true, 100, 1, 1),
    (2, 'Taller de Cocina', 'Aprende a cocinar platos deliciosos de la mano de nuestros chefs expertos en nuestro taller de cocina. ¡No te lo pierdas!', 2, '2024-06-02', 90, 40.00, true, 80, 2, 2),
    (3, 'Sesión de Yoga al Aire Libre', 'Encuentra paz y equilibrio en nuestra sesión de yoga al aire libre. Desconéctate del estrés diario y conecta contigo mismo.', 3, '2024-06-03', 150, 60.00, true, 120, 3, 3),
    (4, 'Exposición de Arte Contemporáneo', 'Explora obras fascinantes de artistas contemporáneos en nuestra exposición de arte. ¡Descubre nuevas perspectivas y emociones!', 4, '2024-06-04', 180, 70.00, true, 150, 4, 4),
    (5, 'Torneo de Fútbol Local', 'Únete a la emoción del fútbol en nuestro torneo local. ¡Apoya a tu equipo favorito y disfruta de la competencia!', 5, '2024-06-05', 120, 50.00, true, 100, 5, 5),
    (6, 'Curso de Fotografía Básica', 'Descubre el mundo de la fotografía en nuestro curso básico. Aprende técnicas fundamentales y captura momentos inolvidables.', 6, '2024-06-06', 90, 40.00, true, 80, 6, 6),
    (7, 'Charla sobre Medio Ambiente', 'Únete a nuestra charla sobre medio ambiente y descubre cómo puedes contribuir a un futuro más sostenible. ¡Juntos podemos marcar la diferencia!', 7, '2024-06-07', 150, 60.00, true, 120, 7, 7),
    (8, 'Noche de Cine al Aire Libre', 'Disfruta de una noche bajo las estrellas con nuestra proyección de cine al aire libre. Trae tus mantas y palomitas para una experiencia inolvidable.', 8, '2024-06-08', 180, 70.00, true, 150, 8, 8),
    (9, 'Clase de Baile Latino', 'Aprende los pasos de baile más candentes en nuestra clase de baile latino. ¡Diviértete y libera tu energía con ritmos apasionados!', 9, '2024-06-09', 120, 50.00, true, 100, 9, 9);


INSERT INTO public.event_enrollments(
id, id_user, description, registration_date_time, attended, observations, rating, id_event)
VALUES 
(1, 1, 'First event enrollment', '2023-05-01', true, 'No observations', 4.5, 1),
(2, 2, 'Second event enrollment', '2023-05-02', false, 'Late arrival', 3.0, 2),
(3, 3, 'Third event enrollment', '2023-05-03', true, 'Good session', 5.0, 3),
(4, 4, 'Fourth event enrollment', '2023-05-04', true, 'Informative', 4.2, 4),
(5, 5, 'Fifth event enrollment', '2023-05-05', false, 'Had to leave early', 2.8, 5),
(6, 6, 'Sixth event enrollment', '2023-05-06', true, 'Well organized', 4.7, 6),
(7, 7, 'Seventh event enrollment', '2023-05-07', false, 'Missed due to illness', 1.0, 7),
(8, 8, 'Eighth event enrollment', '2023-05-08', true, 'Very engaging', 4.9, 8),
(9, 9, 'Ninth event enrollment', '2023-05-09', false, 'Could not attend', 0.0, 9),
(10, 10, 'Tenth event enrollment', '2023-05-10', true, 'Excellent', 5.0, 10),
(11, 11, 'Eleventh event enrollment', '2023-05-11', false, 'Schedule conflict', 2.0, 11),
(12, 12, 'Twelfth event enrollment', '2023-05-12', true, 'Useful insights', 4.3, 12),
(13, 13, 'Thirteenth event enrollment', '2023-05-13', true, 'Very informative', 4.8, 13),
(14, 14, 'Fourteenth event enrollment', '2023-05-14', false, 'Was not interested', 1.5, 14),
(15, 15, 'Fifteenth event enrollment', '2023-05-15', true, 'Good presentation', 4.0, 15),
(16, 16, 'Sixteenth event enrollment', '2023-05-16', true, 'Learned a lot', 4.6, 16),
(17, 17, 'Seventeenth event enrollment', '2023-05-17', false, 'Forgot about it', 1.0, 17),
(18, 18, 'Eighteenth event enrollment', '2023-05-18', true, 'Amazing experience', 5.0, 18),
(19, 19, 'Nineteenth event enrollment', '2023-05-19', true, 'Good but could be better', 3.5, 19),
(20, 20, 'Twentieth event enrollment', '2023-05-20', false, 'Technical issues', 2.3, 20);

INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (1, 15, 5);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (2, 18, 2);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (3, 17, 8);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (4, 14, 4);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (5, 12, 1);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (6, 19, 7);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (7, 20, 3);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (8, 11, 6);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (9, 13, 9);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (10, 16, 5);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (11, 12, 2);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (12, 15, 8);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (13, 14, 4);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (14, 20, 1);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (15, 17, 6);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (16, 19, 3);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (17, 16, 7);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (18, 11, 9);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (19, 13, 2);
INSERT INTO public.event_tags(id, id_tag, id_event) VALUES (20, 18, 5);
