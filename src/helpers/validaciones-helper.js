export default class ValidacionesHelper {
    getIntegerOrDefault = (value, defaultValue) => {
        if (isNaN(parseInt(value,10)) || parseInt(value,10) === undefined || parseInt(value,10) === null){
            return defaultValue;
        } else return parseInt(value,10);
    };

    getStringOrDefault = (value, defaultValue) => {
        if (value === undefined || value === null || value === ""){
            return defaultValue;
        } else return value;
    };
}