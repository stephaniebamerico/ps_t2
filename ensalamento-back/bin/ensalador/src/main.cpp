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
#include <cstring>
#include <iostream>


using namespace std;

/*-------------------------------------------------------------------------------------*/


/*=====================================================================================*/

void main_open(Database& db){
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* sched = db.schedules[i];
		if ( !sched->yaml["assigned"] ){
			sched->yaml["do_malloc"] = 'y';
		}
	}
	db.save();
}


void main_close(Database& db, std::string filename){
	ofstream out;

	db.statistics();

	out.open (filename,ios::trunc);
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* sched = db.schedules[i];
		if ( sched->do_malloc_room ){
			out << " ";
			if( sched->yaml["assigned"] && sched->yaml["assigned"].as<std::string>() != "" ){
				out << sched->yaml["assigned"].as<std::string>();
			} else {
				out << "###";
			}
			out << " " << *sched << endl;
		}
	}
	out.close();
}



void main_close2(Database& db, std::string filename){
	ofstream out;
	out.open (filename,ios::trunc);
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* sched = db.schedules[i];
		if ( sched->do_malloc_room ){
			if( sched->yaml["assigned"] && sched->yaml["assigned"].as<std::string>() != "" ){
				out << sched->yaml["assigned"].as<std::string>();
			} else {
				out << "###";
			}
			out << " " << sched->id << endl;
		}
	}
	out.close();
}


void main_accept(Database& db){
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* sched = db.schedules[i];
		if ( sched->yaml["do_malloc"] && sched->yaml["do_malloc"].as<string>() == "y" ){
			if ( sched->yaml["suggested"] ){
				sched->yaml["assigned"] = sched->yaml["suggested"].as<std::string>();
			}
		}
		//sched->yaml.remove("assigned");
		/*if ( sched->yaml["suggested"] ){
			if ( sched->department == "hidraulica_e_saneamento" ){
				sched->yaml["assigned"]  = "";
				sched->yaml["suggested"] = "";
			} else {
				sched->yaml["assigned"] = sched->yaml["suggested"].as<std::string>();
			}

		} else {
			sched->yaml["assigned"] = "";
		}*/
	}
	db.save();
}


void main_clear_all(Database& db){
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* sched = db.schedules[i];
		sched->yaml["do_malloc"] = "y";
		if ( sched->yaml["assigned"] ){
			sched->yaml["assigned"] = "";
			//sched->yaml.remove("assigned");
		}
	}
	db.save();
}


void main_exec(Database& database, std::string _arg){
	YAML::Node arg;
	if ( _arg != ""){
		cerr << _arg << endl;
		arg = YAML::Load( _arg );
	}
	/*vector<int> days;
	YAML::Node arg_day = arg["day"];
	for (size_t i=0; i<arg_day.size(); i++){
		days.push_back( arg_day[i].as<int>() );
	}*/

	vector<string> blocks;
	if ( arg["blocks"] ){
		YAML::Node arg_blocks = arg["blocks"];
		if ( arg_blocks.IsScalar() ){
			blocks.push_back( arg_blocks.as<std::string>() );
		} else if ( arg_blocks.IsSequence() ){
			for (size_t i=0; i<arg_blocks.size(); i++){
				blocks.push_back( arg_blocks[i].as<std::string>() );
			}
		}
	}

	vector<string> courses;
	if ( arg["courses"] ){
		YAML::Node arg_courses = arg["courses"];
		if ( arg_courses.IsScalar() ){
			courses.push_back( arg_courses.as<std::string>() );
		} else if ( arg_courses.IsSequence() ){
			for (size_t i=0; i<arg_courses.size(); i++){
				courses.push_back( arg_courses[i].as<std::string>() );
			}
		}
	}

	int total=0, wi_room=0, no_room=0;
	for (size_t day=2; day<8; day++){
		cout << "Dia " << day << endl;
		Ensalador ens(database, day, blocks, courses);
		ens.execute(4);
		ens.execute(3);
		ens.execute(2);

		ens.schedules.statistics(cout, total, wi_room, no_room);
		ens.schedules.stat_suggest();
	}

	cout << "### Total: " << total << "; WiRoom: " << wi_room << "; NoRoom: " << no_room << endl;

	database.save();
	database.resting();

}







struct Stat : map<string,int> {
	size_t unknown;
	size_t total;

	Stat(){this->unknown = this->total = 0;}

	void add( string name, int value ){
		map<string,int>::iterator it = this->find(name);
		if ( it != this->end() ){
			it->second += value;
		} else {
			this->insert( std::pair<string,int>(name,value) );
		}
		this->total += value;
	}

	void addUnknown ( int value ){
		this->unknown += value;
		this->total   += value;
	}

	void print(ostream& out, int ident=0){
		out << "\n";
		out << "    total: " << this->total << endl;
		out << "    noroom: " << this->unknown << endl;
		out << "    wiroom: " <<  endl;
		map<string,int>::iterator it = this->begin();
		for(; it != this->end(); ++it ){
			for (int i=0; i<ident+1; i++){out << "    ";}
			out << "- {block: " << it->first << ", value: " << it->second << "}\n";
		}
		//out << "}\n";
	}
};

void statisticasCourse(Database& db) {
	map<string,Stat> courses;
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* turma = db.schedules[i];
		map<string,Stat>::iterator it = courses.find(turma->course);
		if ( it == courses.end() ){
			Stat novo;
			courses.insert( std::pair<string,Stat>(turma->course,novo) );
			it = courses.find(turma->course);
		}

		//int value = turma->end - turma->ini;
		if ( turma->isAssigned() ){
			if ( turma->assigned != NULL ){
				string block = turma->assigned->block;
				it->second.add(block, 1);
			} else {
				it->second.add("unknown", 1);
			}
		} else {
			it->second.addUnknown(1);
		}
	}

	//std::ofstream ofs(stdout);
	//ofs.open ("stat_courses.yaml", std::ofstream::out | std::ofstream::app);
	map<string,Stat>::iterator it = courses.begin();
	for(; it != courses.end(); ++it ){
		cout << it->first << ": ";
		it->second.print(cout,1);
		cout << "\n\n";
	}
}


void statisticasDepartment(Database& db) {
	map<string,Stat> departments;
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* turma = db.schedules[i];
		map<string,Stat>::iterator it = departments.find(turma->department);
		if ( it == departments.end() ){
			Stat novo;
			departments.insert( std::pair<string,Stat>(turma->department,novo) );
			it = departments.find(turma->department);
		}

		//int value = turma->end - turma->ini;
		if ( turma->isAssigned() ){
			if ( turma->assigned != NULL ){
				string block = turma->assigned->block;
				it->second.add(block, 1);
			} else {
				it->second.add("unknown", 1);
			}
		} else {
			it->second.addUnknown(1);
		}
	}


	//std::ofstream ofs(stdout);
	//ofs.open ("stat_courses.yaml", std::ofstream::out | std::ofstream::app);
	map<string,Stat>::iterator it = departments.begin();
	for(; it != departments.end(); ++it ){
		cout << it->first << ": ";
		it->second.print(cout,1);
		cout << "\n\n";
	}
}



struct Week {
	int rooms;
	int total[8][24];
	int morning, total_morning;
	int afternoon, total_afternoon;
	int night, total_night;

	Week(){
		morning = afternoon = night = 0;
		rooms = 0;
		for (int day=0; day<8; day++){
			for (int hour=0; hour<24; hour++){
				total[day][hour] = 0;
			}
		}
	}

	void addRoom(Room* room){
		this->rooms += 1;
		for (int day=2; day<8; day++){
			for (int i=7; i<24; i++){
				std::vector<Turma*>& schedules = room->occupied2[day][i];
				this->total[day][i] += (schedules.size() > 0) ? 1 : 0;
			}
		}
	}


	string calcParcials(int ini, int end){
		int sum[8] = {0,0,0,0,0,0,0,0};
		for (int day=2;day<8;day++){
			for (int hour=ini; hour<end; hour++){
				sum[day] += total[day][hour];
			}
		}
		char buffer[1024];
		sprintf(
			buffer, "%d,%d,%d,%d,%d,%d",
			sum[2],sum[3],sum[4],sum[5],sum[6],sum[7]
		);
		return buffer;
	}




	string calcParcials(int day){
		int morning=0,after=0,night=0;
		for (int hour=7; hour<11; hour++){
			morning += total[day][hour];
		}
		for (int hour=13; hour<19; hour++){
			after += total[day][hour];
		}
		for (int hour=19; hour<23; hour++){
			night += total[day][hour];
		}
		char buffer[1024];
		sprintf(buffer,"%d,%d,%d",morning,after,night);
		return buffer;
	}

	void show(){
		printf("   rooms: %d\n", rooms);
		int total_morning = 4*this->rooms; // 7:30 - 11:30 * qtde salas
		int total_after   = 6*this->rooms; // 13:30 - 18:30 * qtde salas
		int total_night   = 4*this->rooms; // 19:30 - 22:30 * qtde salas

		printf("   total: [%d,%d,%d]\n", total_morning, total_after, total_night);
		printf("   resume:\n");
		printf("      morning: [%s]\n",this->calcParcials(7,11).c_str());
		printf("      after: [%s]\n",this->calcParcials(13,19).c_str());
		printf("      night: [%s]\n",this->calcParcials(19,23).c_str());

		printf("   data:\n");
		for (int hour=7; hour<24; hour++){
			printf("      \"%02d:30\": [%2d", hour, total[2][hour] );
			for (int day=3; day<WEEKSIZE; day++){
				printf(",%2d",total[day][hour]);
			}
			printf("]\n");
		}
	}
};


void statBlock(Database& db){
	map<string,Week> blocks;

	for (size_t i=0; i<db.rooms.size(); i++){
		Room* room = db.rooms[i];
		map<string,Week>::iterator it = blocks.find(room->block);
		if ( it == blocks.end() ){
			Week novo;
			blocks.insert( std::pair<string,Week>(room->block,novo) );
			it = blocks.find(room->block);
		}
		it->second.addRoom(room);
	}

	map<string,Week>::iterator it = blocks.begin();
	for(; it != blocks.end(); ++it ){
		cout << it->first << ": \n";
		it->second.show();
		cout << endl;
	}

}


void statisticasTotal(Database& db) {
	static int total[DAYSIZE][WEEKSIZE][2];
	for (int i=0;i<WEEKSIZE; i++){
		for (int j=0;j<DAYSIZE; j++){
			total[i][j][0] = 0;
			total[i][j][1] = 0;
		}
	}

	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* sched = db.schedules[i];
		//if ( sched->do_malloc_room ){ //&& sched->suggested != "" ){
			int ini  = sched->ini;
			int day  = sched->dia;
			int size = sched->end-sched->ini;
			if ( sched->isAssigned() ){
				for (int tt=0;tt<size;tt++){
					total[ini+tt][day][0] += 1;
				}
			} else {
				for (int tt=0;tt<size;tt++){
					total[ini+tt][day][1] += 1;
				}
			}
		//}
	}

	/*for (size_t room_i=0; room_i<db.rooms.size(); room_i++){
		Room* room = db.rooms[room_i];
		for (int i=0;i<WEEKSIZE; i++){
			for (int day=0;day<DAYSIZE; day++){
				total[i][day] += room->occupied[i][day];
			}
		}
	}*/

	printf("salas: %ld\n",db.rooms.size());
	printf("total:\n");

	for (int hour=7;hour<DAYSIZE; hour++){
		printf("   \"%2d:30\": [ [%3d,%3d]", hour, total[hour][2][0], total[hour][2][1]);
		for (int day=3;day<WEEKSIZE; day++){
			printf(",[%3d,%3d]", total[hour][day][0], total[hour][day][1] );
		}
		printf("]\n");
	}
}


/*-------------------------------------------------------------------------------------*/



#include "latex.cpp"



/*======================================  MAIN  =======================================*/

int main(int argc, char *argv[]) {
	if ( argc < 5 ){
		printf("Syntax error: ensalador [open|close|accept|statRoom|statCourse|statTotal|exec|check]\n");
		printf("1) ensalador exec\n");
		printf("2) ensalador exec '{courses: [96A,98B], blocks: pf}'\n");
		return 1;
	}

	string cmd = argv[4];
	cerr << "Carregando o arquivo rooms.yaml\n";
	Database database((string)argv[1], (string)argv[2], (string)argv[3]);

	if ( cmd == "open" ){
		cerr << "Carregando o arquivo schedules.yaml\n";
		database.loadOrigin();
		main_open(database);
	} else {
		cerr << "Carregando o arquivo current.yaml\n";
		database.loadCurrent();
	}
	if ( cmd == "close" ) {
		main_close(database, "output.txt");
		main_close2(database, "binario.txt");

	} else if ( cmd == "accept" ){
		main_accept(database);

	} else if ( cmd == "statRoom" ){
		database.printRooms();

	} else if ( cmd == "statCourse"){
		statisticasCourse(database);

	} else if ( cmd == "statDepartment"){
		statisticasDepartment(database);

	} else if ( cmd == "statBlock"){
		statBlock(database);

	} else if ( cmd == "statTotal"){
		statisticasTotal(database);

	} else if ( cmd == "exec" ) {
		database.setFactors(10.0,1.0,500.0);
		string args = ( argc > 5 ) ? argv[5] : "";
		main_exec(database, args);

	} else if ( cmd == "latex" ){
		generateLatex(database);

	} else if ( cmd == "check" ) {
		if ( !database.isOk() ){
			cout << "Tem os seguintes conflitos\n";
		}
	} else if ( cmd == "clearAll"){
		main_clear_all(database);
	}

	return 0;
}

/*-------------------------------------------------------------------------------------*/
