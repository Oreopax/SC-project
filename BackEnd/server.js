

var app = require('./controller/app')
var hostname = "127.0.0.1"
var port = 8081;

app.listen(port, hostname, function () {
    console.log(`Server hosted at http://${hostname}:${port}`)
})