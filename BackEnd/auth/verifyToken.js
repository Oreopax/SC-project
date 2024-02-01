var jwt = require('jsonwebtoken');
var config = require('../config');

const verifyFn = {
    verifyToken: function(req, res, next) {
        console.log(req.headers);
    
        var token = req.headers['authorization']; //retrieve authorization header's content
        console.log(token);
    
        if (!token || !token.includes('Bearer')) { //process the token
    
            res.status(403);
            return res.send({ auth: 'false', message: 'Not authorized!' });
        } else {
            token = token.split('Bearer ')[1]; //obtain the token's value
            //console.log(token);
            jwt.verify(token, config.key, function (err, decoded) { //verify token
                if (err) {
                    res.status(403);
                    return res.json({ auth: false, message: 'Not authorized!' });
                } else {
                    console.log(decoded)
                    req.userid = decoded.userid; //decode the userid and store in req for use
                    req.type = decoded.type; //decode the role and store in req for use
                    next();
                }
            });
        }        
    },

    verifyAdmin: function (req, res, next) {
        if (req.role === 'admin') {
            next();
        } else {
            res.status(403);
            res.send(`{"Message":"Not Authorized as Admin"}`);
        }
    }
}

module.exports = verifyFn;