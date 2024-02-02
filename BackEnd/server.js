const https = require('https')
const path = require('path')
const fs = require('fs')

var app = require('./controller/app')
var hostname = "127.0.0.1"
var port = 8081;

/* app.listen(port, hostname, function () {
    console.log(`Server hosted at http://${hostname}:${port}`)
}) */

const sslServer = https.createServer({
    key : fs.readFileSync(path.join(__dirname, 'cert', 'key.pem')),
    cert: fs.readFileSync(path.join(__dirname, 'cert', 'cert.pem')),
}, app )

sslServer.listen(port, ()=> console.log(`Server hosted at https://${hostname}:${port}`))