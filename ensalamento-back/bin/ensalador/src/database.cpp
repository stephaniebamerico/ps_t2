/*================================  LICENSE  ====================================
# Copyright (C) 2017 - Centro de Computação Cientifica e Software Livre (C3SL)
#    Clarissa Pereira <cdp13@inf.ufpr.br>
#    Daniela Ivanchechen
#    Felipe Bombardelli <felipebombardelli@gmail.com>
#    Rafael Castilho <rsc15@inf.ufpr.br>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-----------------------------------------------------------------------------*/


/*=====================================  HEADER  ======================================*/

#include "ensalador.hpp"
#include <munkres/munkres.h>
#include <munkres/matrix.h>
#include <cstring>

using namespace std;

/*-------------------------------------------------------------------------------------*/


/*=====================================================================================*/


bool Database::loadRooms(string filename){//function that adds the classroms from the input into the vector of classroms to be assigned
//cout << "Carregando " << filename << endl;
	this->yaml_rooms = YAML::LoadFile(filename);//YAML base node, in this case, the input file
	if (this->yaml_rooms.IsNull()) return false;

	YAML::Node yaml_rooms = this->yaml_rooms["rooms"];//YAML node, in this case, the first node in the "rooms" sections of the input
	if (yaml_rooms.IsNull()) return false;

	for (size_t i=0; i<yaml_rooms.size(); i++){
		Sala* room = new Sala(yaml_rooms[i]);
		this->rooms.push_back(room);//and adds it to the classroom vector
	}
	return true;
}


bool Database::loadSchedules(std::string filename){
//cout << "Carregando " << filename << endl;
	this->yaml_schedules = YAML::LoadFile(filename);//YAML base node, the input file
	if (this->yaml_schedules.IsNull()) return false;

	YAML::Node schedules = yaml_schedules["schedules"];//YAML node, the "schedules" section of the input file
	if (schedules.IsNull()) return false;

	for (size_t i=0; i<schedules.size(); i++){
		Turma* sched = new Turma(schedules[i]);
		if( schedules[i]["assigned"] ){
			string code = schedules[i]["assigned"].as<std::string>();
			if ( code != "" ){
				sched->setAssigned(this->rooms.find(code));
			}
		}
		this->schedules.push_back(sched);
	}
	return true;
}




double Database::CalcDist(Sala& s, Turma& t){//uses real world coordinates to calculate the euclidian distance betwen 2 classrooms
	double X,X1,X2,Y,Y1,Y2,Z,Z1,Z2,dist;
	X1 = s.getLat();
	X2 = t.getLat();
	Y1 = s.getLon();
	Y2 = t.getLon();

	X = X1 - X2;
	Y = Y1 - Y2;

	Z1 = X * X;
	Z2 = Y * Y;

	Z = Z1 + Z2;

	dist = sqrt(Z) * 100000.0;//(*100000.0) Convert the distance to meters

//cout << t.code << " " << s.code << " " << dist << endl;
	return dist;
}

double Database::CalcFree(Sala& s, Turma& t){//calculates how much of the classroom is filled by the supposed size of the class scheduled
	double free =  s.getCap() - t.getNv();
	double norm = (free/(double)s.getCap()) * NORM_FATOR;
	return norm;
}

/*double Database::isAvaliable(Sala& s, Turma& t){//Verifys if the classroom is empty at the time needed for the scheduled class
	bool isNot=false;//initiate by assuming the classroom is avaliable
	for (int j= t.ini;j<t.end;j++){//for as long as the class will need the room
		isNot = isNot || s.getOcc(j);//should the classroom be unavaliable, at some point s.getocc() will return true, and is not will perpetualy become true
	}
	if(isNot){//if it's not avaliable, return a high assignment cost
		return OCCUPIED;
	}
	else{//else there's no cost to the assignment in terms of avaliability
		return 0.0;
	}
}*/

double Database::CalcCusto(Sala& s, Turma& t){//calculates the cost of allocating classroom s to class t based on distance between classroom and geografical center of the class, capacity/size of the classroom/class, avaliability of the classroom and classroom sugestions
	double dist = CalcDist(s,t);
	double dist_norm = (dist/this->max_dist) * NORM_FATOR;
	double free = CalcFree(s,t);


	//double suggested = 20;
	if (  s.code == t.suggested ){
		return 0;
		//suggested = 0;
	} else {
		if (s.getCap() < t.getNv())
			return NOMOREROOM;
	}


	double custo =  dist_norm*this->factor_dist + free*this->factor_free;// + suggested;

	Turmas inUse = this->index.find(t.klass_id);
	for ( size_t i=0; i<inUse.size(); ++i){
		Turma* it = inUse[i];//takes a class on the map of assignments already done
		if( it->id != t.id ){
			if(it->assigned != NULL){
				if (it->assigned->id == s.id){//if the class has already been assigned to the same classroom in another day, the cost of assinment is lower, thus helping assure the assignments will remain the same through the week
					custo -= 5;
				}
			}
		}
	}

	//cout << t.code << " " << s.code << " " << dist_norm << "[" << dist << "] + " << free  << "+" << suggested << "=" << custo << endl;

	return (custo<0) ? 0 : custo;
}



bool Database::isOk(){
	for (size_t i=0; i<this->rooms.size(); i++){
		if ( !this->rooms[i]->isOk() ){
			//cout << "[ERROR-conflito]: " << this->rooms[i]->code << endl;
		}
	}
	return true;
}


void Database::resting(){
	int wi_room = 0, no_room = 0;
	for (size_t i=0; i<this->schedules.size(); i++){
		if ( this->schedules[i]->assigned == NULL )
			no_room += 1;
		else
			wi_room += 1;
	}
	std::cout << "With: " << wi_room << "; NoRoom: " << no_room << std::endl;
}

void Database::statistics(){
	std::map <std::string,Turmas> smap;

	for (size_t i=0; i<this->schedules.size(); i++){
		Turma* sched = this->schedules[i];
		smap[ sched->department ].push_back(sched);
	}

	/*std::map<std::string,int>::iterator it;
	for (it = smap.begin(); it!=smap.end(); it++) {
		std::cout << "    " << it->first << std::endl;
		it->second.statistics(std::cout);
	}*/
}

void Database::save(){
	std::ofstream fout( db_current, std::fstream::trunc );
	YAML::Emitter out;
	out << this->yaml_schedules;
	fout << out.c_str();
	//fout << this->yaml_schedules;
	fout.close();
}

/*-------------------------------------------------------------------------------------*/
