import express from "express";
import cors from "cors";
import EventRouter from "./src/controllers/event-controller.js";
import UserRouter from "./src/controllers/user-controller.js";
import ProvinceRouter from "./src/controllers/province-controller.js";
import LocationRouter from "./src/controllers/location-controller.js";
import ELocationRouter from "./src/controllers/event-category-controller.js";
import ECategoryRouter from "./src/controllers/event-category-controller.js";
const app = express();
const port = 3000;

// Agrego los Middlewares
app.use(cors()); // Middleware de CORS
app.use(express.json()); // Middleware para parsear y comprender JSON

app.get("/", (req, res) => {
    res.status(200).send('¡Ya estoy respondiendo!');
});

app.use("/api/event", EventRouter);
app.use("/api/user", UserRouter);
app.use("/api/province", ProvinceRouter);
app.use("/api/location", LocationRouter);
app.use("/api/event-location", ELocationRouter);
app.use("/api/event-category", ECategoryRouter);

app.listen(port, () => {
    console.log("Escuchando conexión en el puerto " + port);
}) 