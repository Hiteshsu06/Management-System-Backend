const jsonServer = require('json-server');
const fs = require('fs');
const path = require('path');
const server = jsonServer.create();
const middlewares = jsonServer.defaults();
const router = jsonServer.router('db.json');

server.use(middlewares);

// Middleware to parse JSON body
server.use(jsonServer.bodyParser);

// Custom route to handle POST requests
server.post('/company', (req, res) => {
    const data = JSON.parse(fs.readFileSync('db.json', 'utf8'));
    const newCompany = req.body;
    
    // Generate a new ID (assuming IDs are unique and sequential)
    newCompany.id = (data.company.length + 1).toString(); 
    
    data.company.push(newCompany);
    fs.writeFileSync('db.json', JSON.stringify(data, null, 2));
    
    res.status(201).json(newCompany);
});

// Custom route to handle DELETE requests
server.delete('/company/:id', (req, res) => {
    const data = JSON.parse(fs.readFileSync('db.json', 'utf8'));
    const companyId = req.params.id;
    
    // Remove the company with the specified ID
    data.company = data.company.filter(company => company.id !== companyId);
    
    fs.writeFileSync('db.json', JSON.stringify(data, null, 2));
    
    res.status(200).json({});
});

server.use(router);

server.listen(3000, () => {
    console.log('JSON Server is running');
});

module.exports = server;