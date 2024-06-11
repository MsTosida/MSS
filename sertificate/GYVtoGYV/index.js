let app = require('express')();
let https = require('https');
let fs = require('fs');

let options = {
    key: fs.readFileSync('res-kis.key'),
    passphrase: 'password',
    cert: fs.readFileSync('res-kis.crt')
};

app.use((req, res, next) => {
    console.log("middleware 1");
    next();
});

app.get('/', (req, res, next) => {
    console.log("middleware 2");
    res.end("Hello from HTTPS!");
})

https.createServer(options, app).listen(3000, () => {
    console.log("Server is running at https://localhost:3000");
});