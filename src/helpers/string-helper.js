import moment from "moment";

export const MAXCHARS = 100;

export default class StringHelper {
    minChars = (str) => {
        return (str.length > 2 === true);
    }
    
    verifyEmail = (email) => {
        let emailProp = email.split('@');
        if(emailProp.length === 2){
            let emailStructure = emailProp[1].split('.');
            if(emailStructure.length === 2) return true;
            else return false;
        } else return false;
    }

    verifyDate = (date) => {
        let formats = [
            moment.ISO_8601,
            "YYYY/MM/DD",
        ]
        return moment(date, formats, true).isValid();
    }

    toLower = (str) => {
        let myStr = `${str}`;
        return myStr.toLowerCase();
    }

    maxChars = (str) => {
        return (str.length > MAXCHARS === false);
    }
}