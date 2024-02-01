

const db = require("./databaseConfig");
var config = require('../config.js');
var jwt = require('jsonwebtoken');

const userDB = {

  //Add new user to database
  addNewUser: (username, email, contact, hashedPassword, type, profile_pic_url, callback) => {

    // Connects
    var dbConn = db.getConnection();
    dbConn.connect(function (err) {

        // Return error
        if (err) {
            return callback(err, null)
        } else {

            // SQL query
            dbConn.query(`
                insert into user 
                (username, email, contact, password, type, profile_pic_url) values
                (?, ?, ?, ?, ?, ?);`, 
                [username, email, contact, hashedPassword, type, profile_pic_url], 
                function (err, results) {

                    // End connection
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



loginUser: function (username, callback) {
    var conn = db.getConnection();

    conn.connect(function (err) {
        if (err) {
            console.log(err);
            return callback(err, null);
        } else {
            let sql = 'select * from user where username=?';

            conn.query(sql, [username], function (err, result) {
                conn.end();

                if (err) {
                    console.log("Err: " + err);
                    return callback(err, null);
                } else {
                    if (result.length == 1) {
                        // Assuming the password comparison is done earlier and the user is verified.
                        // Generate and return the JWT token
                        let token = jwt.sign({
                            userid: result[0].userid,
                            type: result[0].type,
                        }, config.key, {
                            expiresIn: 86400 //expires in 24 hrs
                        });
                        return callback(null, result, token);

                    } else {
                        var err2 = new Error("User not found.");
                        err2.statusCode = 404;
                        return callback(err2, null, null);
                    }
                }
            });
        }
    });
},

  // Get user by username
getUserByUsername: (username, callback) => {

  // Connects
  var dbConn = db.getConnection();
  dbConn.connect(function (err) {

      // Return error
      if (err) {
          return callback(err, null);
      } else {

          // SQL query
          dbConn.query(`
          SELECT 
          u.username, 
          u.password
          FROM user u 
          WHERE u.username = ?;`, [username], function (err, results) {

              // End connection
              dbConn.end();

              if (err)
                  console.log(err);

              return callback(err, results);
          });
      }
  });
},


};

module.exports = userDB;