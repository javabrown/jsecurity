# satellite-node server
Dockerized Node based rest API for lightweight contents, property files, config files contents etc...


####**Build local Docker Image:**

`docker build -t <any-tag-name> .`  
    _Example_: `docker build -t my-satellite-node` .



**Run local Docker Image:**

`docker run -p <win-port:docker-port> <image-tag-name>`
    _Example_: `docker run -p 7172:7172 my-satellite-node`


**Manage/Kill Existing Running Image**

`docker ps -a`
`docker kill <image-id>`

**Test application:**

`   localhost:7172/countries/india`
 