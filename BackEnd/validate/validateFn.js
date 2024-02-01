const validator = require('validator');

const validateFn = {
    ValidateRegister : function(req,res,next){

        regexuser = /^[a-zA-Z0-9 ]+$/

        var username=req.body.username;
        var email=req.body.email;
        var role=req.body.role;
        var password=req.body.password;

        if (validator.isAlphanumeric(username) && validator.isEmail(email) && (role=='user' || role=='admin') && validator.isAlphanumeric(password) && password.length>7){
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