'use strict';

const http = require('http');
const fs = require('fs');
const express = require('express');

const PORT = 7172;
const app = express();

const RESPONSE_CONTENT_TYEP = {'Content-Type': 'application/json; charset=utf-8'};

app.get('/', (req, res) => {
   res.send(Date.now() + ' : node serve running...');
});

app.get('/countries', (req, res) => {
    let content = fs.readFileSync('data/countries.json');
    res.writeHead(200, RESPONSE_CONTENT_TYEP);
    res.write(content);
    res.end();
});

app.get('/countries/:search', (req, res) => {
    let json = fs.readFileSync('data/countries.json');
    let jsonContent = JSON.parse(json);
    let result = [];
    let searchPattern = req.params.search;

    for(var key in jsonContent) {
        const country = jsonContent[key];
        searchPattern = searchPattern.toLowerCase();

        if(searchPattern && searchPattern === key.toLowerCase() || searchPattern === country['name'].toLowerCase()) { //Level-1 equals match
            result.push(country)
        }
    }

    if(result.length == 0) {
        for(var key in jsonContent) {
            const country = jsonContent[key];

            if(searchPattern && country && key.toLowerCase().indexOf(searchPattern)> 0 ||
                country['name'].toLowerCase().indexOf(searchPattern) > 0) { //Level-2 like match
                result.push(country)
            }
        }
    }

    res.writeHead(200, RESPONSE_CONTENT_TYEP);
    res.write(JSON.stringify(result));
    res.end();
});

app.listen(PORT, function(){
    console.log(`Running Node Server on Port:${PORT}`);
})