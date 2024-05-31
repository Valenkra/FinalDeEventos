CREATE PROCEDURE BuscarEvento(name character varying, category character varying, startdate date, tag character varying)
LANGUAGE SQL
BEGIN ATOMIC
  SELECT * FROM public.events
	INNER JOIN event_categories EC ON public.events.id_event_category = public.event_categories.id
END;