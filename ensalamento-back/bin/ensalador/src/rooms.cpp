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

using namespace std;

/*-------------------------------------------------------------------------------------*/


/*======================================  SALA  =======================================*/

void Sala::setFree(){
	for (int i=0; i<WEEKSIZE; i++){
		for(int j=0; j<DAYSIZE; j++){
			occupied[i][j] = 0;
			occupied2[i][j].clear();
		}
	}
}


/*void Sala::setOcc(int day, int ini, int end){
	for (int j = ini; j < end; j++){
		occupied[day][j] += 1;
	}
}*/


void Sala::setOcc(Turma* sched){
	int day = sched->dia;
	for (int j = sched->ini; j < sched->end; j++){
		occupied[day][j] += 1;
		occupied2[day][j].push_back(sched);
	}
}


bool Sala::isOk(){
	bool res = true;
	for (int j=0; j<WEEKSIZE; j++){
		for (int i=0; i<DAYSIZE; i++){
			if ( occupied[j][i] > 1 ){
				std::cout << "[ERROR-conflito]: " << this->code  << " em " << j << " " << i << ":30\n";
				res = false;
			}
		}
	}
	return res;
}


bool Sala::isFree(int day, int ini, int _size){
	int size = ini+_size;
	size = (size>=DAYSIZE) ? DAYSIZE : size;
	for (int i=ini; i<size; i++){
		if ( occupied[day][i] > 0 )
			return false;
	}
	return true;
}




void Sala::print(){
	std::cout << this->code << "\n";
	std::map < std::string, size_t > st_department;
	std::map < std::string, size_t > st_course;
	for (int i=7; i<24; i++){
		printf("%02d:30 ",i);
		for (int j=2; j<WEEKSIZE; j++){
			std::vector<Turma*>& schedules = this->occupied2[j][i];
			if ( schedules.size() == 1 ){
				printf("%16s ", schedules[0]->code.substr(0,13).c_str());
			} else if ( schedules.size() > 2 ){
				printf("%15s* ", schedules[0]->code.substr(0,13).c_str());
			} else {
				printf("%16d",0);
			}

			for ( size_t i=0; i<schedules.size(); i++ ){
				string department = schedules[i]->department;
				std::map < std::string, size_t >::iterator it = st_department.find( department );
				if ( it != st_department.end() ){
					it->second += 1;
				} else {
					st_department.insert( std::pair<std::string,size_t>(department,1)  );
				}

				string course = schedules[i]->course;
				std::map < std::string, size_t >::iterator itc = st_course.find( course );
				if ( itc != st_course.end() ){
					itc->second += 1;
				} else {
					st_course.insert( std::pair<std::string,size_t>(course,1)  );
				}
			}

		}
		printf("\n");
	}

	printf("Departamentos:\n");
	std::map < std::string, size_t >::iterator it = st_department.begin();
	for(; it != st_department.end(); ++it ){
		cout << "\t" << it->first << ": " << it->second << ";\n";
	}

	printf("Cursos:\n");
	std::map < std::string, size_t >::iterator itc = st_course.begin();
	for(; itc != st_course.end(); ++itc ){
		cout << "\t" << itc->first << ": " << itc->second << ";\n";
	}

	printf("\n\n\n");
}


void Sala::printAsYaml(){
	std::cout << this->code << ":\n";
	std::map < std::string, size_t > st_department;
	std::map < std::string, size_t > st_course;
	printf("   data:\n");
	for (int i=7; i<24; i++){
		printf("      \"%02d:30\": [",i);
		std::vector<Turma*>& schedules = this->occupied2[2][i];
		if ( schedules.size() == 0 ){
			printf("0");
		} else if ( schedules.size() == 1 ){
			printf("%d", schedules[0]->klass_id);
		} else {
			printf("[%d", schedules[0]->klass_id);
			for (size_t a=1;a<schedules.size();a++){
				printf(",%d", schedules[a]->klass_id);
			}
			printf("]");
		}



		for (int j=3; j<WEEKSIZE; j++){
			schedules = this->occupied2[j][i];
			if ( schedules.size() == 0 ){
				printf(",0");
			} else if ( schedules.size() == 1 ){
				printf(",%d", schedules[0]->klass_id);
			} else {
				printf(",[%d", schedules[0]->klass_id);
				for (size_t a=1;a<schedules.size();a++){
					printf(",%d", schedules[a]->klass_id);
				}
				printf("]");
			}

			for ( size_t i=0; i<schedules.size(); i++ ){
				string department = schedules[i]->department;
				std::map < std::string, size_t >::iterator it = st_department.find( department );
				if ( it != st_department.end() ){
					it->second += 1;
				} else {
					st_department.insert( std::pair<std::string,size_t>(department,1)  );
				}

				string course = schedules[i]->course;
				std::map < std::string, size_t >::iterator itc = st_course.find( course );
				if ( itc != st_course.end() ){
					itc->second += 1;
				} else {
					st_course.insert( std::pair<std::string,size_t>(course,1)  );
				}
			}

		}
		printf("]\n");
	}

	if ( st_department.size() > 0 ){
		printf("   departments:\n");
		std::map < std::string, size_t >::iterator it = st_department.begin();
		for(; it != st_department.end(); ++it ){
			cout << "      " << it->first << ": " << it->second << ";\n";
		}
	}

	if ( st_course.size() > 0 ){
		printf("   courses:\n");
		std::map < std::string, size_t >::iterator itc = st_course.begin();
		for(; itc != st_course.end(); ++itc ){
			cout << "      " << itc->first << ": " << itc->second << ";\n";
		}
	}

	printf("\n\n\n");
}


/*-------------------------------------------------------------------------------------*/
