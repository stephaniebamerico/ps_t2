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


/*=====================================================================================*/

struct Turma {// stores information about a class
	std::string code;  //disipline name as well as class code, e.g (ci055:A,te154:B:C)
	int     id;        //individual ID for each class
	int    dia;        //day in which the class meets
	int    ini;        //hour at which the meeting begins
	int    end;        //hour at which the meeting ends
	int    vagas;      //maximum amount of students the class can have
	int    klass_id;       //shared ID for diferent classes from the same discipline
	int    type;
	double lat;        //latitude coordinates
	double lon;        //longitude coordinates
	Sala*  assigned;   //classroom that has been assigned to the class
	std::string suggested;     //code of the classroom suggested for this class to be assigned to
	std::string block;
	std::string department;
	std::string course;
	std::string assigned_str;
	bool do_malloc_room;

	YAML::Node yaml;

	Turma(){}

	Turma(YAML::Node n){//initate class values based on a YAML node read from input
		this->id    = n["id"].as<unsigned int>();
		this->code  = n["code"].as<std::string>();
		this->dia   = n["day"].as<unsigned int>();
		this->ini   = n["ini"].as<unsigned int>();
		this->end   = n["end"].as<unsigned int>();
		this->vagas = n["size"].as<unsigned int>();
		this->klass_id  = n["klass_id"].as<unsigned int>();
		this->type  = n["type"].as<unsigned int>();
		this->lat   = (n["lat"]) ? n["lat"].as<double>() : 0.0;
		this->lon   = (n["log"]) ? n["log"].as<double>() : 0.0;
		this->department   = n["department"].as<std::string>();
		this->assigned  = NULL;
		this->assigned_str = (n["assigned"]) ? n["assigned"].as<std::string>() : "";
		this->course    = (n["course"]) ? n["course"].as<std::string>() : "";
		this->block     = (n["block"]) ? n["block"].as<std::string>() : "";
		this->suggested = (n["suggested"]) ? n["suggested"].as<std::string>() : "";
		this->yaml  = n;
		this->do_malloc_room = (n["do_malloc"]) ? true : false;
	}

	bool isAssigned(){
		if ( this->assigned != NULL )
			return true;
		if ( !this->assigned_str.empty() )
			return true;
		return false;
	}

	void setAssigned(Room* room){//set a classroom as the one assinged to this class
		if (!room) return;
		this->assigned = room;
		room->setOcc( this );
		//room->setOcc( this->dia, this->ini, this->end );
		this->yaml["assigned"] = room->code;
	}

	Sala * getAssigned(){//
		return assigned;
	}
	void setNewIni(int NI){//set new time to start the class, left unused
		ini = NI;
	}
	void setNewEnd(int NE){//set new time to end the class, left unused
		end = NE;
	}
	double getLat(){
		return lat;
	}
	double getLon(){
		return lon;
	}
	double getNv(){
		return vagas;
	}

	/*int getSuggestion(){
		return suggested;
	}*/

	void print(std::ostream& out){
		out << this->code;
	}
	friend std::ostream& operator<<(std::ostream& out, Turma& sched){
		out << sched.code;
		return out;
	}
};

//typedef Schedule Turma;


/***************/


struct Turmas : std::vector <Turma*> {//used to facilitate declarations in Semana

	void statistics(std::ostream& out, int& out_total, int& out_wi_room, int& out_no_room){
		std::map <std::string,int> smap;
		int no_room = 0;

		for (size_t i=0; i<this->size(); i++){
			Turma* sched = this->at(i);
			if ( sched->assigned ){
				smap[ sched->assigned->block ] += 1;
			} else {
				no_room += 1;
			}
		}

		std::map<std::string,int>::iterator it;
		for (it = smap.begin(); it!=smap.end(); it++) {
			out << "    " << it->first << " " << it->second << std::endl;
		}

		out_total   += this->size();
		out_wi_room += this->size() - no_room;
		out_no_room += no_room;
	}

	void stat_suggest(){
		int total=0, ok=0;

		for (size_t i=0; i<this->size(); i++){
			Turma* sched = this->at(i);
			if ( sched->assigned && sched->suggested != "" ){


				total += 1;
				if ( sched->assigned->code == sched->suggested )
					ok += 1;
				else
					std::cout << "[!] " << sched->suggested << " = " << sched->assigned->code << std::endl;
			}
		}
		std::cout << "Sugestionadas: " << total << "; Acertadas: " << ok << std::endl;
	}


	friend std::ostream& operator<<(std::ostream& out, Turmas& schedules){
		out << schedules.size() << std::endl;
		for (size_t i=0; i<schedules.size(); i++){
			out << *schedules[i] << std::endl;
		}
		return out;
	}
};



/*-------------------------------------------------------------------------------------*/



/*=====================================================================================*/

class Semana{//creates a matrix of class vectors, each class in the vector relative to the day of the class as well as the starting time of the class
	Turmas data[DAYSIZE];
  public:
	inline Turmas& at(int hour){//returns a vector of classes at a certain day and hour of the week
		return (data[hour]);
	}

	inline Turmas& operator[](int hour){
		return this->at(hour);
	}

	void clear(){
		for (int i=0; i<DAYSIZE; i++){
			this->data[i].clear();
		}
	}

	friend std::ostream& operator<<(std::ostream& out, Semana& week){
		for (int i=0; i<DAYSIZE; i++){
			out << week.data[i].size() << std::endl;
		}
		return out;
	}
};

/*-------------------------------------------------------------------------------------*/



/*=====================================================================================*/

class TurmasIndex{//map showing the general occupation of classrooms by classes, used to assure classes meeting more than once a week meet in the same classroom
	std::map <int,Turmas> share;

  public:
	void mark(Turma* sched){//mark in the map another classroom assigned to a class
		share[sched->klass_id].push_back(sched);
	}

	Turmas find(int id){//returns the vector containing class t, for comparison on the assignments on the other times the class has met in the week
		std::map<int,Turmas>::iterator it = share.find(id);
		if (it != share.end()){
			return (it->second);
		} else {
			Turmas empty;
			return empty;
		}
	}

	std::map<int,Turmas>& getShared(){
		return share;
	}
};

/*-------------------------------------------------------------------------------------*/
