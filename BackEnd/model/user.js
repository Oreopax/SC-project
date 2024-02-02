

const db = require("./databaseConfig");
var config = require('../config.js');
var jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

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



  loginUser: function (username, password, callback) {
    var conn = db.getConnection();

    conn.connect(function (err) {
        if (err) {
            console.log("Database connection error:", err);
            return callback(err, null);
        } else {
            let sql = 'SELECT * FROM user WHERE username=?';
            console.log("Attempting to query database for user:", username);

            conn.query(sql, [username], function (err, result) {
                if (err) {
                    console.log("Database query error:", err);
                    conn.end();
                    return callback(err, null);
                } else {
                    console.log("Database query successful. Number of users found:", result.length);
                    if (result.length == 1) {
                        const userData = result[0];
                        console.log("User data retrieved:", userData);

                        // Check if the user is currently banned
                        console.log("Checking ban status. Ban until:", userData.ban_until, "Current Time:", new Date().toISOString());
                        if (userData.ban_until && new Date(userData.ban_until) > new Date()) {
                            console.log("User is currently banned.");
                            conn.end();
                            var err2 = new Error("Your account is temporarily banned.");
                            err2.statusCode = 403;
                            return callback(err2, null, null);
                        }

                        bcrypt.compare(password, userData.password, function (err, isMatch) {
                            console.log("Password comparison result:", isMatch);
                            if (err || !isMatch) {
                                console.log("Password does not match or error occurred:", err);
                                let updateSql = 'UPDATE user SET failed_login_attempts = failed_login_attempts + 1 WHERE username = ?';
                                conn.query(updateSql, [username], function(err) {
                                    conn.end();
                                    if (err) {
                                        console.log("Error updating failed login attempts:", err);
                                        return callback(err, null);
                                    }
                                    return callback(new Error("Username or password is incorrect."), null, null);
                                });
                            } else {
                                let resetSql = 'UPDATE user SET failed_login_attempts = 0 WHERE username = ?';
                                  conn.query(resetSql, [username], function(err) {
                                      if (err) {
                                          conn.end();
                                          console.log("Error resetting failed login attempts:", err);
                                          return callback(err, null);
                                      }

                                      let token = jwt.sign({
                                          userid: userData.userid,
                                          type: userData.type,
                                      }, config.key, {
                                          expiresIn: 86400 //expires in 24 hrs
                                      });
                                      console.log("Login successful. Token generated.");

                                      conn.end();
                                      return callback(null, result, token);
                                  });

                            }
                        });
                    } else {
                        console.log("User not found.");
                        conn.end();
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
incrementFailedLoginAttempts: function (username, callback) {
  var conn = db.getConnection();
  conn.connect(function (err) {
      if (err) {
          console.log(err);
          return callback(err);
      } else {
          let sql = 'UPDATE user SET failed_login_attempts = failed_login_attempts + 1 WHERE username = ?';
          conn.query(sql, [username], function (err, result) {
              if (err) {
                  console.log("Err: " + err);
                  conn.end();
                  return callback(err);
              }

              // Check if failed attempts have reached the threshold
              sql = 'SELECT failed_login_attempts FROM user WHERE username = ?';
              conn.query(sql, [username], function (err, result) {
                  if (err) {
                      console.log("Err: " + err);
                      conn.end();
                      return callback(err);
                  }

                  if (result[0].failed_login_attempts >= 5) {
                      // User has reached the threshold, ban the user for 24 hours
                      let banTime = new Date();
                      banTime.setHours(banTime.getHours() + 24);

                      sql = 'UPDATE user SET ban_until = ? WHERE username = ?';
                      conn.query(sql, [banTime, username], function (err, result) {
                          conn.end();
                          if (err) {
                              console.log("Err: " + err);
                              return callback(err);
                          }
                          return callback(null);
                      });
                  } else {
                      conn.end();
                      return callback(null);
                  }
              });
          });
      }
  });
},

resetFailedLoginAttempts: function (username, callback) {
  var conn = db.getConnection();
  conn.connect(function (err) {
      if (err) {
          console.log(err);
          return callback(err);
      } else {
          let sql = 'UPDATE user SET failed_login_attempts = 0, ban_until = NULL WHERE username = ?';
          conn.query(sql, [username], function (err, result) {
              conn.end();
              if (err) {
                  console.log("Err: " + err);
                  return callback(err);
              } else {
                  return callback(null);
              }
          });
      }
  });
},



};

module.exports = userDB;