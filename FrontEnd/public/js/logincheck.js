
$(document).ready(function () {
    $("#userprofile").hide()
    $("#logincontainer").show()
    $("#logoutcontainer").hide()
    $("#admin").hide()

    const token = localStorage.getItem('JWT');
    const userData = localStorage.getItem("User");

    if (userData == null) return

    const { userid, type } = JSON.parse(userData)[0]

    const data = JSON.stringify({ userid, type })

    $.ajax({
        headers: { "authorization": "Bearer " + token },
        data: data,
        url: "http://localhost:8081/user/isloggedin",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        success: function (data, textStatus, xhr) {

            if (data != null) {
                isLoggedIn = true;
                let { userid, type } = data
                $("#logincontainer").hide()
                $("#logoutcontainer").show()
                $("#admin").hide()
                $("#userprofile").show()
                if (type.toLowerCase() == "admin") {
                    $("#admin").show()
                }
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            $("#userprofile").hide()
            $("#logincontainer").hide()
            $("#logoutcontainer").hide()
            $("#admin").hide()
        }
    })

    $("#logout").click(function () {
        let cart = localStorage.getItem("Cart")
        localStorage.clear();
        localStorage.setItem("Cart", cart)
    })

})

