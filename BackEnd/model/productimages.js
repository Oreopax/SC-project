

const db = require("./databaseConfig");

const productImagesDB = {

  //Add new product image to database
  addImage: (productid, name, type, path, callback) => {

    //Connects
    var dbConn = db.getConnection();
    dbConn.connect(function (err) {

      //Return error
      if (err) {

        return callback(err, null)

      } else {

        //Sql query
        dbConn.query(`
      insert into productimages 
      (productid, name, type, path)
      values(?, ?, ?, ?);`, [productid, name, type, path], function (err, results) {

          //End connection
          dbConn.end();

          if (err)
            console.log(err)

          return callback(err, results)
        });

      }

    });

  },

  //Get product image by productid
  getProductImage: (productid, callback) => {

    //Connects
    var dbConn = db.getConnection();
    dbConn.connect(function (err) {

      //Return error
      if (err) {

        return callback(err, null)

      } else {

        //Sql query
        dbConn.query(`
        select name, type, path from productimages
        where productid=?`, [productid], function (err, results) {

          //End connection
          dbConn.end();

          if (err)
            console.log(err)

          return callback(err, results)
        });

      }

    });

  },

};

module.exports = productImagesDB;