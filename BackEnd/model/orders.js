

const db = require("./databaseConfig");

const orderDB = {

    //Add new product to database
    addOrder: (userid, cart, total, callback) => {

        var dbConn = db.getConnection();
        dbConn.connect(function (err) {

            //Return error
            if (err) {
                return callback(err, null)
            } else {

                cart = JSON.parse(cart)
                var valid = true;
                let totalPrice = 0;

                cart.forEach(({ discountPercentage: userDP, discountid: userDID, price: userP, productid: userPID, quantity: userQ }, index) => {

                    dbConn.query(`select p.productid, p.price,  d.discount_percentage
                from product p
                left join discount d on d.discountid = ? && p.productid = d.productid
                where p.productid = ?
                GROUP BY p.productid;`, [userDID, userPID], function (err, results) {

                        if (err)
                            console.log(err)

                        let { productid, price, discount_percentage } = results[0]
                        let discountPrice = discount_percentage == 0 || discount_percentage == null ? price : ((price / 100) * (100 - discount_percentage)).toFixed(2)

                        let checkDiscountPercentage = (userDP == discount_percentage) || ((userDP == 0 || userDP == null) && (discount_percentage == 0 || discount_percentage == null));
                        let checkTotalPrice = (discountPrice * userQ) == (userP * userQ);
                        if (checkDiscountPercentage && checkTotalPrice) {
                            totalPrice += (discountPrice * userQ)
                        } else {
                            valid = false;
                        }

                        if (index == cart.length - 1) {
                            if (totalPrice != total) valid = false
                            if (!valid) {
                                dbConn.end();
                                return callback({ message: "Data doesn't match! Please clear cart and try again" })
                            } else {
                                cart = JSON.stringify(cart)
                                //Sql query
                                dbConn.query(`
                          insert into orders 
                          (userid, cart, total)
                          values(?, ?, ?);`, [userid, cart, total], function (err, results) {

                                    //End connection
                                    dbConn.end();

                                    if (err)
                                        console.log(err)

                                    return callback(err, results)
                                });
                            }
                        }
                    });



                });



            }
        });
    },

    //Get product by userid
    getOrder: (userid, callback) => {

        //Connects
        var dbConn = db.getConnection();
        dbConn.connect(function (err) {

            //Return error
            if (err) {

                return callback(err, null)

            } else {

                //Sql query
                dbConn.query(`
                SELECT * FROM orders o where userid=?;`, [userid], function (err, results) {

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

module.exports = orderDB;