const async = require('async');

const { exec } = require('child_process');

const fs = require('fs');

const yaml = require('js-yaml');

const path = require("path");

String.prototype.replaceAll = function(search, replacement) {
  var target = this;
  return target.split(search).join(replacement);
};


class Room{
  /**
   * @param {Object}  roomObject Object that contain the follow props
   * @param {String}  code Code of room
   * @param {Integer} code Id of room
   * @param {String}  type Type of room
   * @param {Integer} size Size of room
   * @param {String}  block Block of room
   * @param {Float}   lat Latitude of room
   * @param {Float}   lat Longitude of room
   */
  constructor(roomObject){
    this.code = roomObject.code;
    this.id = roomObject.id;
    this.type = roomObject.type;
    this.size = roomObject.size;
    this.block = roomObject.block;
    this.lat = roomObject.lat;
    this.log = roomObject.log;
  }

  toJSON(){
    var obj = {
      "code": this.code,
      "id": this.id,
      "type": this.type,
      "size": this.size,
      "block": this.block,
      "lat": this.lat,
      "log": this.log,
    };

    // Remove undefined props (usefull when transform into YAML)
    Object.keys(obj).forEach(key => {
      if (obj[key] === undefined) {
        delete obj[key];
      }
    });
    return obj;
  }
}

class RoomColection{
  /**
   * @param {Integer} id Id of RoomCollection used to create file
   * @param {Room[]}  rooms List of rooms instance
   */
  constructor(id,rooms){
    this.id = id;
    this.rooms = rooms;
  }

  toJSON(){
    return {
      "rooms": this.rooms.map( room => {return room.toJSON()} ),
      "id": this.id
    };
  }

  getFilePath(){
    var file_name = "rooms_"+this.id+".yaml";
    var file_path = path.resolve(
      __dirname+'/ensalador_executions/', file_name
    );
    return file_path;
  }


  // Save this instance into ensalador_executions
  // The file can be tracked by this instance id

  // If path is defined, then save the yaml into specified path
  // The name of file must be specified in this case
  save(path){
    var file_path = path || this.getFilePath();
    var obj = this.toJSON();
    var stylesDump = {
      '!!null': 'canonical' // dump null as ~
    };
    fs.writeFileSync(
      file_path,
      yaml.dump(obj, {flowLevel:2})
    );
  }

  // Load an rooms.yaml file and create an instance of this class
  static load(file_path){
    var doc = yaml.safeLoad(fs.readFileSync(file_path, 'utf8'));
    var id = doc.id;
    var rooms = doc.rooms.map(room => {
      return new Room(room);
    })
    return new RoomColection(id, rooms);
  }
}

class Schedule{
  /**
   * @param {Object}  scheduleObject Object that contain the follow props
   * @param {Integer} scheduleObject.id Id of schedule
   * @param {Integer} scheduleObject.ini Hour that schedule init
   * @param {Integer} scheduleObject.end Hour that schedule end
   * @param {Integer} scheduleObject.day Day of schedule
   * @param {String}  scheduleObject.code Code of event scheduled
   * @param {Integer} scheduleObject.klass_id Id of event scheduled
   * @param {String}  scheduleObject.course Code of event course
   * @param {String}  scheduleObject.block Name of room block
   * @param {String}  scheduleObject.department Name of block department
   * @param {String}  scheduleObject.type Type of room
   * @param {String}  scheduleObject.assigned Name of room assigned
   * @param {String}  scheduleObject.size Size of room
   * @param {String}  scheduleObject.log Longitude of room
   * @param {String}  scheduleObject.lat Latitude of room
   */
  constructor(scheduleObject){
    this.ini = scheduleObject.ini;
    this.end = scheduleObject.end;
    this.day = scheduleObject.day;
    this.code = scheduleObject.code;
    this.id = scheduleObject.id;
    this.klass_id = scheduleObject.klass_id;
    this.course = scheduleObject.course;
    this.block = scheduleObject.block;
    this.department = scheduleObject.department;
    this.type = scheduleObject.type;
    this.assigned = scheduleObject.assigned;
    this.size = scheduleObject.size;
    this.log = scheduleObject.log;
    this.lat = scheduleObject.lat;
  }

  toJSON(){
    var obj = {
      "ini": this.ini,
      "end": this.end,
      "day": this.day,
      "code": this.code,
      "id": this.id,
      "klass_id": this.klass_id,
      "course": this.course,
      "block": this.block,
      "department": this.department,
      "type": this.type,
      "assigned": this.assigned,
      "size": this.size,
      "log": this.log,
      "lat": this.lat
    };

    // Remove undefined props (usefull when transform into YAML)
    Object.keys(obj).forEach(key => {
      if (obj[key] === undefined) {
        delete obj[key];
      }
    });
    return obj;
  }
}

class ScheduleCollection{
  /**
   * @param {Integer}  id Id of ScheduleCollection used to create file
   * @param {Schedule[]} schedules List of schedules instance
   */
  constructor(id,schedules){
    this.id = id;
    this.schedules = schedules;
  }

  toJSON(){
    return {
      "schedules": this.schedules.map(schedule => {return schedule.toJSON()}),
      "id": this.id
    }
  }

  getFilePath(){
    var file_name = "schedules_"+this.id+".yaml";
    var file_path = path.resolve(
      __dirname+'/ensalador_executions/', file_name
    );
    return file_path;
  }

  
  // Save this instance into ensalador_executions
  // The file can be tracked by this instance id

  // If path is defined, then save the yaml into specified path
  // The name of file must be specified in this case
  save(path){
    var file_path = path || this.getFilePath();
    var obj = this.toJSON();
    fs.writeFileSync(file_path, yaml.dump(obj, {flowLevel:2}));
  }
  
  // Load an schedules.yaml file and create an instance of this class
  static load(file_path){
    var doc = yaml.safeLoad(fs.readFileSync(file_path, 'utf8'));
    var id = doc.id;
    var schedules = doc.schedules.map(schedule => {
      return new Schedule(schedule);
    })
    return new ScheduleCollection(id, schedules);
  }
}

class CurrentSchedule extends ScheduleCollection{
  getFilePath(){
    var file_name = "current_"+this.id+".yaml";
    var file_path = path.resolve(
      __dirname+'/ensalador_executions/', file_name
    );
    return file_path;
  }
}

class EnsaladorPart{

  /**
   * @param {String} name The name of the part (does not affect the flow)
   * @param {String} operation Operation used on ensalador binary
   *               run "./ensalador" to se the options
   * @param {Object} option (Optional) Specify the options of "operation" 
   */
  constructor(name, operation, option){
    this.name = name;
    this.operation = operation;
    this.option = option;
  }

  optionToString(){
    // If there is no option, add an empty string
    if(this.option == {} || this.option == undefined) return "";

    // Otherwise, parse the Object to an json without quotes and spacement
    // equal to 1. The spacement is necessary because the ensalador binary
    // break
    return "\""+JSON.stringify(this.option,null,1).replaceAll("\"","")+"\"";
  }

  toStringCommand(){
    return this.operation.toString()+" "+ this.optionToString();
  }
}

class Ensalador{
  
  /**
   * @param {EnsaladorPart[]} parts Pipeline of ensalador binary execution
   * @param {String} rooms_path Path to rooms.yaml file
   * @param {String} schedules_path Path to schedules.yaml file
   * @param {String} current_path Path to current.yaml file
   */
  constructor(parts, rooms_path, schedules_path, current_path){ 
    this.parts = parts;
    this.command = path.resolve(__dirname,'ensalador');
    this.command+= " "+rooms_path;
    this.command+= " "+schedules_path;
    this.command+= " "+current_path;
    this.create_log = true;
    this.current_path = current_path;
    console.log(current_path);
  }


  /**
   * Execute the ensalador binary with the parts specified on constructor
   */
  execute(cb){

    // Create the functions that will be called on async.waterfall
    // waterfall loses the context of this instance, then we use
    // .bind feature to attach the actual context
    var partsExec = this.parts.map(part =>{
      return async.apply(this.executePart.bind(this), part);
    });

    async.waterfall(
      partsExec,
      function(err) {
        var doc = yaml.safeLoad(fs.readFileSync(this.current_path, 'utf8'));
        cb(err, doc.schedules);
      }.bind(this)
    );
  }
  

  // Execute an specific part of Ensalador
  executePart(part, cb){
    this.runProcessSystem(
      this.command+" "+part.toStringCommand(),
      cb
    );
  }

  // Run an command on system as a different process
  runProcessSystem(command, cb){
    exec(command,{cwd: __dirname}, (error, stdout, stderr) => {
      if (error){
        if(this.create_log) console.error(`exec error: ${error}`);
        return;
      }
      if(this.create_log) console.log(`stdout: ${stdout}`);
      if(this.create_log) console.log(`stderr: ${stderr}`);
      cb();
    });
  }
}

module.exports = {Ensalador, EnsaladorPart, Schedule, ScheduleCollection, Room, RoomColection, CurrentSchedule};





// Example

// var rooms = new RoomColection(1,[
//   new Room({code: "sala1", id:1, type:1, size:50, block:'block1', lat:0.0, log:0.0}),
//   new Room({code: "sala2", id:2, type:1, size:50, block:'block2', lat:0.0, log:0.0}),
//   new Room({code: "sala3", id:3, type:1, size:50, block:'block2', lat:0.0, log:0.0}),
// ]);

// var schedules = new ScheduleCollection(1,[
//   new Schedule({code: "turma1", id:1, day:2, ini:3, end:4, klass_id:1,size:49,type:1, department:"d1", course:"c1"}),
//   new Schedule({code: "turma2", id:1, day:3, ini:1, end:2, klass_id:2,size:49,type:1, department:"d2", course:"c2"}),
//   new Schedule({code: "turma3", id:1, day:4, ini:1, end:2, klass_id:3,size:49,type:1, department:"d1", course:"c3"}),
//   new Schedule({code: "turma4", id:1, day:3, ini:1, end:2, klass_id:4,size:49,type:1, department:"d1", course:"c1"}),
// ]);


// Or you can load from specific yaml files
// var schedules = ScheduleCollection.load("schedules.yaml");
// var rooms = RoomColection.load("rooms.yaml");
// rooms.id = 1;
// schedules.id = 1;


// Create an curreny.yaml that is a copy of schedules.yaml
// You also can load an existent current.yaml
// var dataCurrent = schedules.toJSON().schedules.map(s => {return new Schedule(s)});
// var current = new CurrentSchedule(1, dataCurrent);

// Save the yaml into ensalador_executions
// rooms.save();
// schedules.save();
// current.save();


// Define the parts of ensalador (order to execute the commands)
// var parts = [
//   new EnsaladorPart("Open", "open"),
//   new EnsaladorPart("Final", "exec",{day: [2,3,4,5,6,7]}),
//   new EnsaladorPart("Close", "close")
// ];


// Instance and execute ensalador
// The result is in the current.yaml file created and can be accessed on
// callback of execute method
// var e = new Ensalador(
//   parts,
//   rooms.getFilePath(),
//   schedules.getFilePath(),
//   current.getFilePath(),
// );

// e.execute((err,schedules) => {
//   console.log(err,schedules);
// })