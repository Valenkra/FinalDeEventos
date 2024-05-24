class Event_enrollments {
    constructor(id, id_event, id_user, descripcion, registration_date_time,
            attended, observations, rating){
        this.id = id,
        this.id_event = id_event,
        this.id_user = id_user,
        this.descripcion = descripcion,
        this.registration_date_time = registration_date_time,
        this.attended = attended,
        this.observations = observations,
        this.rating = rating;
    }
}

export default Event_enrollments;