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




/*====================================  ENSALADOR  ====================================*/


void Ensalador::loadSchedules(int day, std::vector<std::string>& courses){
	int total=0, removed=0;
	for (size_t i=0; i<database->schedules.size(); i++){
		Turma* sched = database->schedules[i];
		if ( sched->dia != day )
			continue;
		//if ( block.size()>0 && sched->block != block )
		//	continue;

		if ( courses.size() > 0 ){
			bool is_in_courses = false;
			for (size_t i_course=0; i_course<courses.size(); ++i_course){
				if ( sched->course == courses[i_course] ){
					is_in_courses = true;
					break;
				}
			}
			if ( is_in_courses == false ){
				continue;
			}
		}

		total += 1;
		if ( sched->yaml["assigned"] && sched->yaml["assigned"].as<std::string>() != "" ){
			removed += 1;
			continue;
		}

		// se a sala tiver menos que 11 alunos, nao ensala
		if ( sched->vagas < 11 ){
			removed += 1;
			continue;
		}

		//int ini = ((sched->ini%2)==0) ? sched->ini-1 : sched->ini;
		int size = sched->end - sched->ini;
		if (size >= 4){
			this->week4.at(sched->ini).push_back(sched);
		} else if (size == 3){
			this->week3.at(sched->ini).push_back(sched);
		} else {
			this->week2.at(sched->ini).push_back(sched);
		}
		this->schedules.push_back(sched);
	}

	cout << "loadSchedule{total: " << total << ", removed: " << removed << "}\n";
}


/*void Ensalador::loadSchedules(int day, std::string block, std::vector<std::string>& courses){
	int total=0, removed=0;
	for (size_t i=0; i<database->schedules.size(); i++){
		Turma* sched = database->schedules[i];
		if ( sched->dia != day )
			continue;
		//if ( block.size()>0 && sched->block != block )
		//	continue;

		if ( courses.size() > 0 ){
			bool is_in_courses = false;
			for (size_t i_course=0; i_course<courses.size(); ++i_course){
				if ( sched->course == courses[i_course] ){
					is_in_courses = true;
					break;
				}
			}
			if ( is_in_courses == false ){
				continue;
			}
		}

		total += 1;
		if ( sched->yaml["assigned"] && sched->yaml["assigned"].as<std::string>() != "" ){
			removed += 1;
			continue;
		}

//cout << sched->code << " - " << sched->course << endl;

		//int ini = ((sched->ini%2)==0) ? sched->ini-1 : sched->ini;
		int size = sched->end - sched->ini;
		if (size >= 4){
			this->week4.at(sched->ini).push_back(sched);
		} else if (size == 3){
			this->week3.at(sched->ini).push_back(sched);
		} else {
			this->week2.at(sched->ini).push_back(sched);
		}
		this->schedules.push_back(sched);
	}
	cout << "loadSchedule{total: " << total << ", removed: " << removed << "}\n";
}*/




void Ensalador::loadRooms(std::string block){
	for (size_t i=0; i<database->rooms.size(); i++){
		if ( block=="" || database->rooms[i]->block == block )
			this->rooms.push_back(database->rooms[i]);
	}
}



void Ensalador::execute(int size){
	for (int hour=0; hour<DAYSIZE; hour++){
		Rooms   freerooms = this->rooms.getFree(this->day,hour,size);
		Turmas* turmas    = &this->week2[hour];
		if ( size == 3 )
			turmas = &this->week3[hour];
		else if ( size >= 4 )
			turmas = &this->week4[hour];

		if ( turmas->size() == 0 || freerooms.size() == 0 )
			continue;

		//cout << freerooms.size() << " " << turmas->size() << " ";
		int size = freerooms.size() - turmas->size();
		if ( size < 0 ){
			cout << "[Error]: Vai faltar " << -size << " salas na hora " << hour << ":30\n";
		}
		//cout << endl;


		Munkres<double> munkres;
		Matrix<double> matrix = this->buildMatrix(freerooms, *turmas);
		munkres.solve(matrix);
		this->assignMatrix(matrix, freerooms, *turmas);
	}
}







Matrix<double> Ensalador::buildMatrix(Rooms& rooms, Turmas& turmas){
	int nrows = rooms.size();
	int ncols = turmas.size();
	Matrix<double> matrix(nrows, ncols);
	for ( int row = 0 ; row < nrows ; row++ ) {
		for ( int col = 0 ; col < ncols ; col++ ) {
			matrix(row,col) = this->database->CalcCusto(*rooms[row], *turmas[col]);
		}
	}
	return matrix;
}


void Ensalador::assignMatrix(Matrix<double>& matrix, Rooms& rooms, Turmas& turmas){
	int ncols = matrix.columns();
	int nrows = matrix.rows();
	for ( int i_room=0; i_room<nrows; i_room++ ) {
		for ( int i_sched=0; i_sched<ncols; i_sched++ ) {
			if ( matrix(i_room,i_sched) == 0 ){
				Turma* sched = turmas[i_sched];
				Sala*  room  = rooms[i_room];
				sched->setAssigned(room);
				//cout << room->code << " " << sched->code << endl;
				//cout << *room << endl;
			}
		}
	}
}


/*-------------------------------------------------------------------------------------*/
