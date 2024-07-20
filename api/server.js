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
    // Assuming req.body contains the new post object
    const data = JSON.parse(fs.readFileSync('db.json', 'utf8'));
    const newPost = req.body;
    data.posts.push(newPost);
    fs.writeFileSync('db.json', JSON.stringify(data, null, 2));
    res.status(201).json(newPost);
});

// Custom route to handle DELETE requests
server.delete('/company/:id', (req, res) => {
    const data = JSON.parse(fs.readFileSync('db.json', 'utf8'));
    const postId = parseInt(req.params.id);
    data.posts = data.posts.filter(post => post.id !== postId);
    fs.writeFileSync('db.json', JSON.stringify(data, null, 2));
    res.status(200).json({});
});

server.use(router);

server.listen(3000, () => {
    console.log('JSON Server is running');
});

module.exports = server;