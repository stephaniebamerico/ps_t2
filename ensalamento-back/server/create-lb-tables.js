var server = require('./server');
var path = require('path');
var app = require(path.resolve(__dirname, '../server/server'));
var models = require(path.resolve(__dirname,'../common/models/models.js'))
var ds = app.datasources.ensalamento;
var lbTables = models.models;
ds.automigrate(lbTables, function(er) {
  if (er) throw er;
  console.log('Loopback tables [' - lbTables - '] created in ', ds.adapter.name);
  ds.disconnect();
});

