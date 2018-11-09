var http = require('http');
var fs = require('fs');

http.createServer(function(req, res) {
    // res.writeHead(200, {'content':'text/html'});
    fs.readFile('data.tsv', function(err, data) {
        res.writeHead(200, {'Content-Type': 'text/json'});
        res.write(data);
        res.end();
    });

}).listen(7171);