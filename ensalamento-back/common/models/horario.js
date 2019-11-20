'use strict';
var app = require('../../server/server');

function get_time(name,t) {
    var i = (Date.now()-t) / 1000
    console.log(name+": "+i);
}
module.exports = function(Horario) {

  Horario.getCode = async function(horario_id,turmas, cb){

    // TODO: Also, collect all Evento instances 

    // Query the model Turma and find all instances related to horario_id
    // The Horario model cannot be used directly because
    // the hasAndBelongsToMany is in Turma model

      var codes = turmas.map(t => {
        var horarios_turma = t.horarios;

        // Create an array with the codes of turmas
        // If the turma is not related with horario_id, then the code
        console.log("Horarios -----------------")
        // is an empty string 
        for(var h in horarios_turma){
        //for(var h=0; h < horarios_turma.length; h++){
            var horario = horarios_turma[h];
            if(horario.id == horario_id) {
                console.log("horario: ",horario)
                console.log("turma: ",t.id, "horario_id: ",horario_id, "t.codigo: ",t.codigo);
                return t.codigo;
            } 

        }
        return "";

    });
      // Filter and join codes with "-"
      codes = codes.filter(c => {
          return c != "";
      });
      //      if (!codes.length)
      //          console.log("codes - getCode: ",codes,"\thorario_id: ",horario_id)
      cb(null,codes.join("-"));
      
  }

  Horario.getTotalSize = function(horario_id,turmas, cb){

    // Query the model Turma and find all instances related to horario_id
    // The Horario model cannot be used directly because
    // the hasAndBelongsToMany is in Turma model

      // Create an array with the size (need to scheduled) of turmas
      // If the turma is not related with horario_id, then the size is 0
      var sizes = turmas.map(t => {
        var horarios_turma = t.horarios;
        for(var h in horarios_turma){
            var horario = horarios_turma[h];
            if(horario.id == horario_id) return t.vagas;
        }
        return 0;
      });
      // Sum all sizes
      cb(null, sizes.reduce((acc,size)=>{return acc+size},0));
  }
  
    Horario.iterate = async function(horario_id, turmas,cb) {
        var codes = [];
        var vagas = 0;
        var cursos = []
        for(var i=0; i< turmas.length; i++) {
            var t = turmas[i];
            var horarios_turma;
            if (turmas[i].horarios_list)
                horarios_turma = turmas[i].horarios_list;
            else {
                var horarios_turma = await t.horarios.find()
                turmas[i].horarios_list = horarios_turma;
            }

            for(var h in horarios_turma){
                var horario = horarios_turma[h]
                if(horario.id == horario_id) {
                    codes.push(t.codigo);
                    vagas += t.vagas;
                    cursos.push(t.cursos);
                    if(horario_id % 100 == 0)
                        console.log(horario_id)
                }

            }
        }

        // pega o primeiro curso e obtém o bloco relacionado a este curso e ai
        // pega a coordenada do curso
        // coordenada nao estiver definida, define como o ponto 0
        var coord = {"lat":0.0,"lng":0.0};
        var curso = "21A";
        var bloco_cod = "";
         if(cursos && cursos[0]) {
             curso = await cursos[0].get()
             if(curso) {
                 var bloco = await curso.bloco.get()
                 curso = curso.codigo
                 // se o bloco, e os campos localizacao e codigo não forem nulo
                 // então seta bloco_cod e coord, caso contrário mantém valor
                 // padrão.
                 if (bloco && bloco.localizacao && bloco.codigo) {
                     bloco_cod = bloco.codigo
                     coord =  bloco.localizacao;

                 }
             }
             
         } 
        console.log(codes.join("-"),vagas,coord,curso,bloco_cod)
        cb(null,codes.join("-"),vagas,coord,curso,bloco_cod);
    }

};
