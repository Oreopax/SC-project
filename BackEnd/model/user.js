

const db = require("./databaseConfig");
var config = require('../config.js');
var jwt = require('jsonwebtoken');

const userDB = {

  //Add new user to database
  addNewUser: (username, email, contact, password, type, profile_pic_url, callback) => {

    //Connects
    var dbConn = db.getConnection();
    dbConn.connect(function (err) {

      //Return error
      if (err) {

        return callback(err, null)

      } else {

        //Sql query
        dbConn.query(`
      insert into user 
      (username, email, contact, password, type, profile_pic_url) values
      (?, ?, ?, ?, ?, ?);`, [username, email, contact, password, type, profile_pic_url], function (err, results) {

          //End connection
          dbConn.end();

          if (err)
            console.log(err)

          return callback(err, results)
        });

      }

    });

  },

  //Get all user
  getAllUser: callback => {

    //Connects
    var dbConn = db.getConnection();
    dbConn.connect(function (err) {

      //Return error
      if (err) {

        return callback(err, null)

      } else {

        //Sql query
        dbConn.query(`
            SELECT 
            u.userid, 
            u.username, 
            u.email, 
            u.contact, 
            u.type, 
            u.profile_pic_url, 
            u.created_at 
            FROM user u;`, [], function (err, results) {

          //End connection
          dbConn.end();

          if (err)
            console.log(err)

          return callback(err, results)
        });

      }

    });

  },

  //Get user by userid
  getUser: (userid, callback) => {

    //Connects
    var dbConn = db.getConnection();
    dbConn.connect(function (err) {

      //Return error
      if (err) {

        return callback(err, null)

      } else {

        //Sql query
        dbConn.query(`
        SELECT 
        u.userid, 
        u.username, 
        u.email, 
        u.contact, 
        u.type, 
        u.profile_pic_url, 
        u.created_at 
        FROM user u 
        WHERE u.userid = ?;`, [userid], function (err, results) {

          //End connection
          dbConn.end();

          if (err)
            console.log(err)

          return callback(err, results)
        });

      }

    });

  },

  //Update user 
  updateUser: (username, email, contact, password, type, profile_pic_url, userid, oldPassword, callback) => {

    //Connects
    var dbConn = db.getConnection();
    dbConn.connect(function (err) {

      //Return error
      if (err) {
        return callback(err, null)
      } else {

        //Sql query
        dbConn.query(`
        Update user set 
        username=?, 
        email=?, 
        contact=?, 
        password=?, 
        type=?, 
        profile_pic_url=?
        where userid=? and password=?;`, [username, email, contact, password, type, profile_pic_url, userid, oldPassword], function (err, results) {

          //End connection
          dbConn.end();

          if (err)
            console.log(err)

          return callback(err, results)
        });

      }

    });

  },

  loginUser: function (username, password, callback) {

    var conn = db.getConnection();

    conn.connect(function (err) {
      if (err) {
        console.log(err);
        return callback(err, null);
      }
      else {
        let sql = 'select * from user where username=? and password=?';

        conn.query(sql, [username, password], function (err, result) {
          conn.end();

          if (err) {
            console.log("Err: " + err);
            return callback(err, null);
          } else {

            if (result.length == 1) {
              token = jwt.sign({
                userid: result[0].userid,
                type: result[0].type,
              }, config.key, {
                expiresIn: 86400 //expires in 24 hrs
              });
              return callback(null, result, token);

            } else {

              var err2 = new Error("UserID/Password does not match.");
              err2.statusCode = 500;
              return callback(err2, null, null);

            }
          }
        });

      }
    });
  },

};

module.exports = userDB;