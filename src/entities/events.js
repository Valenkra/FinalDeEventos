class Events {
    constructor(id, nombre, descripcion, fecha, duracion,
            precio, permitidoAInscribirse, capacidad, id_event_category,
            id_category_location, id_creator_user){
        this.id = id,
        this.nombre = nombre,
        this.descripcion = descripcion,
        this.fecha = fecha,
        this.duracion = duracion,
        this.precio = precio,
        this.permitidoAInscribirse = permitidoAInscribirse,
        this.capacidad = capacidad,
        this.id_event_category = id_event_category,
        this.id_category_location = id_category_location, 
        this.id_creator_user = id_creator_user;
    }
}