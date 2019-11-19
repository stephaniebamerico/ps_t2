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
/*########################################################################

ANY AND ALL COMMENTS MENTIONIG CLASS REFER TO A SCHEDULED CLASS, NOT THE CLASS STRUCTURE

########################################################################*/

struct Turma;

struct Sala{//class that stores information about a classroom
	std::string code;  //classroom name
	int id;            //code
	int size;
	int type;          //mesa com braço, mesa e carteira, prancheta, etc
	double lat;        //latitude coordinate for the classroom
	double lon;        //longitude coordinate for the classroom
	std::string block;

	int occupied[WEEKSIZE][DAYSIZE];//for each classroom there's a matrix that indicates  wheter the classroom is occupied in a certain timeslot
	std::vector<Turma*> occupied2[WEEKSIZE][DAYSIZE];


	//when a classroom is created the ocupation matrix starts with it beeing unoccupied for all existing timeslots
	Sala(){
		this->setFree();
	}

	Sala(YAML::Node node){
		id      = node["id"].as<unsigned int>();
		code    = node["code"].as<std::string>();
		size    = node["size"].as<unsigned int>();
		type    = node["type"].as<unsigned int>();
		lat     = node["lat"].as<double>();
		lon     = node["log"].as<double>();
		block   = node["block"].as<std::string>();
		this->setFree();
	}




	int         getId(){ return this->id; }
	std::string getName(){ return code; }

	double      getLon(){ return lon; }
	double      getLat(){ return lat; }
	int         getCap(){ return size; }

	bool        getOcc(int day, int hour){ return occupied[day][hour]; }


	void setFree();

	// set the classroom as occuppied in a specified timeslot
	//void setOcc(int day, int ini, int end);
	void setOcc(Turma* sched);


	bool isFree(int day, int ini, int _size);

	bool isOk();



	void print();
	void printAsYaml();

	friend std::ostream& operator<<(std::ostream& out, Sala& room){
		out << room.code;
		return out;
	}

};

typedef Sala Room;


/********************/


class Rooms : public std::vector <Sala*> {
	bool is_indexed;
	std::map <std::string,Sala*> index;

  public:
	Rooms(){
		is_indexed = false;
	}

	Sala* find(int id){
		for(unsigned int i = 0; i < this->size(); ++i){
			if ( this->at(i)->id == id){
				return this->at(i);
			}
		}
		return NULL;
	}

	Sala* find(std::string code){
		this->create_index();
		std::map<std::string,Sala*>::iterator it = index.find(code);
		return (it != index.end()) ? (it->second) : NULL;
	}

	void setAllFree(){
		for (size_t i=0; i<this->size(); i++){
			this->at(i)->setFree();
		}
	}

	Rooms getFree(int day, int hour, int size){
		Rooms free;
		for (size_t i=0; i<this->size(); i++){
			if ( this->at(i)->isFree(day, hour, size) ){
				free.push_back(this->at(i));
			}
		}
		return free;
	}



	friend std::ostream& operator<<(std::ostream& out, Rooms& rooms){
		for (size_t i=0; i<rooms.size(); i++){
			out << *rooms[i] << std::endl;
		}
		return out;
	}

  private:
	void create_index(){
		if ( is_indexed == false ){
			for (size_t i=0; i<this->size(); i++){
				index[ this->at(i)->code ] = this->at(i);
			}
			is_indexed = true;
		}
	}

};



/*-------------------------------------------------------------------------------------*/
