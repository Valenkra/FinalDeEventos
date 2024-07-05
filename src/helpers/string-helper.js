export default class StringHelper {
    minChars = (str) => {
        return (str.length > 3 === true);
    }
    
    verifyEmail = (email) => {
        let emailProp = email.split('@');
        if(emailProp.length === 2){
            let emailStructure = emailProp[1].split('.');
            if(emailStructure.length === 2) return true;
            else return false;
        } else return false;
    }
}