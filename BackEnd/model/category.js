const db = require("./databaseConfig");

const categoryDB = {

    //Add new category to database
    addNewCategory: (category, description, callback) => {

        //Connects
        var dbConn = db.getConnection();
        dbConn.connect(function (err) {

            //Return error
            if (err) {

                return callback(err, null)

            } else {

                //Sql query
                dbConn.query(`insert into category (category, description) values(?, ?);`, [category, description], function (err, results) {

                    //End connection
                    dbConn.end();

                    if (err)
                        console.log(err)

                    return callback(err, results)
                });

            }

        });

    },

    //Get all category
    getAllCategory: callback => {

        //Connects
        var dbConn = db.getConnection();
        dbConn.connect(function (err) {

            //Return error
            if (err) {

                return callback(err, null)

            } else {

                //Sql query
                dbConn.query(`SELECT * FROM category;`, [], function (err, results) {

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

module.exports = categoryDB;
