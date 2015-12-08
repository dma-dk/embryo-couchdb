# embryo-couchdb
Dockerized CouchDB installation for Embryonic e-Navigation Web applications


Simplest way to execute this image:

  [sudo] docker run -p 5984:5984 dmadk/embryo-couchdb

If using CouchDB in anything but the default configuration (which is recommended), you want to map a folder to the /data volume, e.g. /somefolder. In /somefolder/etc you will not be able to edit the CouchDB default.ini and local.ini folder, but you can add extra .ini files in the /somefolder/etc/local.d folder to extend and overwrite the default CouchDB configuration. I.e. add file 

  /somefolder/etc/local.d/myapp.ini. 

Having created the CouchDB ini file you can start up the docker image with a mounted /data volume, which will read your configuration from the ini file: 

  [sudo] docker run -d -P -v /somefolder/:/data dmadk/embryo-couchdb
