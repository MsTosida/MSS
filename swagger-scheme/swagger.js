const swaggerAutogen = require('swagger-autogen')();

const doc = {
    info: {
        title: 'Lab17',
        description: 'Lab17 Node js Swagger'
    },
    host: 'localhost:3000'
};

const outputFile = './swagger-output.json';
const routes = ['./17-01.js'];


swaggerAutogen(outputFile, routes, doc);