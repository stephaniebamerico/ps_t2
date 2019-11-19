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

struct Database {//makes the classroom assignment all classes needed
	Rooms  rooms;
	Turmas schedules;
	TurmasIndex index;//map containing the assignements for each class
	std::string db_current;
	std::string db_schedules_origin;

	YAML::Node yaml_rooms;
	YAML::Node yaml_schedules;

	double max_dist;
	double factor_dist;
	double factor_free;


	Database(){}
	Database(std::string rooms_file, std::string schedules_file, std::string db_current){
		this->db_current = db_current;
		this->loadRooms( rooms_file );
		this->db_schedules_origin = schedules_file;
	}

	void loadOrigin(){
		this->loadSchedules( db_schedules_origin );
	}

	void loadCurrent(){
		this->loadSchedules( db_current );
	}

	inline void setFactors(double dist, double free, double max){
		this->factor_dist = dist;
		this->factor_free = free;
		this->max_dist = max;
	}

	bool loadRooms(std::string rooms_file);//load the classroom vector with data from input
	bool loadSchedules(std::string filename);


	void FillMap(Semana* week);//fill the map with pointers to the classes to be assigned


	double CalcDist(Sala& r, Turma& t);//calculates the euclidian distance between the classroom and the central location of the class
	double CalcFree(Sala& r, Turma& t);//calculates how much free space the classroom will have if assigned to a class
	double isAvaliable(Sala& r, Turma& t);//verify if the classroom is avaliable for use in the timeslot needed by the class
	double CalcCusto(Sala& r, Turma& t);//calculates the cost of assigning a class to a classroom


	bool  isOk();


	void resting();


	void statistics();

	void printRooms(){
		for (size_t i=0; i<rooms.size(); i++){
			rooms[i]->printAsYaml();
		}
	}


	void save();
};

/*-------------------------------------------------------------------------------------*/
