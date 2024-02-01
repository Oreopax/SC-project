const validator = require('validator');

const validateFn = {
    ValidateRegister : function(req,res,next){

        regexuser= /^[a-zA-Z\d ]+$/
        regexpassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d ]+$/
        regexemail = /^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/

        var username=req.body.username;
        var email=req.body.email;
        var contact=req.body.contact;
        var password=req.body.password;

        if (regexuser.test(username) && regexemail.test(email) && validator.isNumeric(contact) && regexpassword.test(password) && password.length>7){
            next();
        }
        else{
            res.send(`{"Message":"Validation Failed"}`);
        }
    },
    ValidateReview : function(req,res,next){
        
        regex = /^[a-zA-Z0-9 ]+$/

        var review=req.body.review;

        if (regex.test(review)){
            next();
        }
        else{
            res.send(`{"Message":"Validation Failed"}`);
        }
    }
}

module.exports = validateFn;