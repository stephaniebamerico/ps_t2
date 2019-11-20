const path  = require('path');
const app = require(path.resolve(__dirname, '../server/server'));
var async = require('async');
const {Ensalador, EnsaladorPart, Schedule, ScheduleCollection, Room, RoomColection, CurrentSchedule} = require(path.resolve(__dirname,'../bin/ensalador/ensalador.js'));
var _turmas = []
function get_time(name,t) {
    var i = (Date.now()-t) / 1000
    console.log(name+": "+i);
}
pre_ensalamento(function(err){
    process.exit(err ? 1 : 0);
})
function getScheduleInstance(h, cb){
  var Horario = app.models.Horario;
  Horario.iterate(h.id,_turmas, (err,horarioCode,horarioSize,horarioCoord,horarioCurso,bloco) => {
      //Horario.getCode(h.id,_turmas, (err,horarioCode) => {
    if(err) return cb(err,null);
      //console.log("Codes: ",horarioCode,"\tId: ",h.id);
      //Horario.getTotalSize(h.id,_turmas, (err,horarioSize) => {
      //if(err) return cb(err,null);  
      // TODO: Type, klass_id, department and course must be corrected
      var schedule = new Schedule({
          code: horarioCode,
          id: h.id,
          day: h.dia,
          ini: parseInt(h.horario_inicial),
          end: parseInt(h.horario_final),
          size: horarioSize,
          type: 0,
          log: horarioCoord.lng,
          block: bloco,
          lat: horarioCoord.lat,
          course: horarioCurso,
          department: "dinf",
          klass_id: 1
      });
      cb(null,schedule);
  });
}


async function getAllSchedulesInstances(newEnsalamento,cb){
  var Horario = app.models.Horario;

  // TODO: Filter by parameters specified by user
  var queryHorario = {};

    var queryTurma = {
      include: ["horarios","cursos"]
    };
    var turmas = await app.models.Turma.find(queryTurma);
    _turmas = turmas
    Horario.find(queryHorario, function(err, horarios){
        // Transform the horarios to objects
        horarios = horarios.map(h => {return h.toJSON()});

        // Transform all Horario instances in Schedule (Ensalador)
        async.map(horarios, getScheduleInstance, (err, schedules) => {
            cb(err, new ScheduleCollection(newEnsalamento.id,schedules));
        });
    });

}

function getAllRoomsInstances(newEnsalamento,cb){
  var Sala = app.models.Sala;
  var querySala = {};
  Sala.find(querySala, function(err, salas){
    if(err) return cb(err,null);
    var rooms = salas.map(s => {
      s = s.toJSON();

      // TODO: type must be an integer, but the model Sala contains a string
      return new Room({
        code: s.codigo,
        id: s._id,
        type: 1,
        size: s.capacidade,
        block: s.blocoCod,
        lat: s.localizacao.lat,
        log: s.localizacao.lng
      });
    });

    cb(err, new RoomColection(newEnsalamento.id,rooms));
  });
}

async function get_user(res) {
    var user_id = res.req.accessToken.userId;
    const Usuario = app.models.Usuario;
    return await Usuario.findById(user_id);

}

function pre_ensalamento(cb) {
    var Horario = app.models.Horario;
    // TODO: insert user id when create ensalamento instance
    app.models.Ensalamento.create({}, function(err, newEnsalamento){
          if(err) return cb(err,null);
        getAllRoomsInstances(newEnsalamento,(err, rooms) => {
            if(err) return cb(err,null);
          getAllSchedulesInstances(newEnsalamento,(err,schedules) => {
              if(err) return cb(err,null);
            
            // Save the files into ensalador/ensalador_executions
            // The id of new ensalamento is the identifier of
            // yaml new files
            rooms.save();
            schedules.save();
            var dataCurrent = schedules.toJSON().schedules.map(s =>{
                return new Schedule(s)
            });
            var current = new CurrentSchedule(newEnsalamento.id, dataCurrent);
            current.save();
            
            // Heuristic used to execute
            // Here you can specify the parameters of algorithm
            var parts = [
              new EnsaladorPart("Open", "open"),
              new EnsaladorPart("Final", "exec",{day: [2,3,4,5,6,7]}),
              new EnsaladorPart("Close", "close")
            ];
            
            var e = new Ensalador(
              parts,
              rooms.getFilePath(),
              schedules.getFilePath(),
              current.getFilePath(),
            );
    
            e.execute((err,schedules) => {
              if(err) return cb(err,null);
              async.each(schedules,
                (s,cb_s) => {
                  var query = {where:{id: s.id}};
                  Horario.findOne(query, (err, h) => {
                    if(err) return cb(err,null);
                      if(!s.assigned)
                          console.log(s);
                      else
                        h.updateAttribute("salaCode", s.assigned, err => {
                      cb_s(err);
                    });
                  });
                },
                (err) => {
                  // If everything is ok
                  cb(err,schedules);
                }
              );
            });
          })
        });
    });
}
