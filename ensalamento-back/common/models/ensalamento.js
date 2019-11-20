'use strict';
const _         = require('lodash');
const { fork }      = require('child_process');
const loopback  = require('loopback');

var async = require('async');

var path = require("path");

var app = require('../../server/server');

const {Ensalador, EnsaladorPart, Schedule, ScheduleCollection, Room, RoomColection, CurrentSchedule} = require(path.resolve(__dirname,'../../bin/ensalador/ensalador.js'));
var _turmas = []
function get_time(name,t) {
    var i = (Date.now()-t) / 1000
    console.log(name+": "+i);
}

async function get_user(res) {
    var user_id = res.req.accessToken.userId;
    const Usuario = app.models.Usuario;
    return await Usuario.findById(user_id);

}

module.exports = function(Ensalamento) {
  Ensalamento.ensalar = function(cb) {
    var Horario = app.models.Horario;
    console.log("------------------------------------------------------")
    // TODO: insert user id when create ensalamento instance
    fork("/app/server/pre_ensalamento.js",[JSON.stringify({})]);
      cb(null, "requisição submetida");
  };
/**
 * upload planilha do sie
 * @param {string} delimiter separador de campos do csv
 * @param {string} semester semestre label
 * @param {date} letiveInit inicio do periodo letivo
 * @param {date} letiveEnd fim do periodo letivo
 * @param {Function(Error, string)} callback
 */


Ensalamento.upload = async function(req, res) {
    var status = "ok";
    const Container = app.models.container;
    const FileUpload = app.models.FileUpload;
    const Semestre = app.models.Semestre;
    const container_name = `turma-${Math.round(Date.now())}-${Math.round(Math.random() * 1000)}`;

    // create a container (directory) for upload file
    var container = await Container.createContainer({name:container_name});
    // upload file (copy file in request to container)
    var arg1 = await Container.upload(req,res,{container:container.name});
    var args = arg1.fields //arguments as semester, letiveinit ... etc
    console.log(args)
    // create semester instance
    var semestre = {"semestre":args.semester}
    var s = await Semestre.create(semestre);

    var file =  await Container.getFiles(container.name,{});
    // create a instance of models FileUpload
    var file_upload = await FileUpload.create({
        'date': new Date(),
        'container_name':container.name,
        'letive_init': new Date(args.letiveInit),
        'letive_end': new Date(args.letiveEnd),
        "semestre": s.semestre,
        'status':"Em andamento"
    });
    //get user by token
    var user = await get_user(res);

    // fork process of populate data
    var param = {
       "fileUpload": file_upload.id,
       "root": app.datasources.container.settings.root,
       "container": container.name,
       "letive_init": file_upload.letive_init,
       "letive_end": file_upload.letive_end,
       "delimiter": (args.delimiter) ?args.delimiter : ";",
       "user": user.nome,
       "semester": semestre.semestre,
       "file": file[0].name
    };

    fork("/app/server/turma-import.js",[JSON.stringify(param)]);
    return file_upload;
};

};
