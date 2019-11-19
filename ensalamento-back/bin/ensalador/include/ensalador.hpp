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

#pragma once

#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <vector>
#include <iostream>
#include <yaml-cpp/yaml.h>
#include <cmath>
#include <munkres/munkres.h>
#include <munkres/matrix.h>


#define NORM_FATOR 1.0
#define NOMOREROOM 30000
#define DAYSIZE 24
#define WEEKSIZE 8
#define OCCUPIED 50000

extern double FATOR_DIST;
extern double FATOR_FREE;
extern double MAX_DISTANCE;
extern bool   WithPrio;
extern bool   doYaml;
extern bool   reverse;


#include "rooms.hpp"
#include "others.hpp"
#include "database.hpp"

/*-------------------------------------------------------------------------------------*/


/*=====================================================================================*/

struct Ensalador {
	Database* database;

	int day;
	Rooms  rooms;
	Turmas schedules;
	Semana week2, week3, week4;//matrix containig the classes

	Ensalador(Database& database, int day, std::string block=""){
		this->day = day;
		this->database = &database;
		this->loadSchedules(day);
		this->loadRooms(block);
	}


	Ensalador(Database& database, int day, std::vector<std::string> blocks){
		this->day = day;
		this->database = &database;
		if ( blocks.size() == 0 ){
			this->loadRooms();
		} else {
			for (size_t i=0; i<blocks.size(); i++){
				std::string block = blocks[i];
				this->loadRooms(block);
			}
		}
		this->loadSchedules(day);
	}

	Ensalador(Database& database, int day, std::vector<std::string>& blocks, std::vector<std::string>& courses){
		this->day = day;
		this->database = &database;
		if ( blocks.size() == 0 ){
			this->loadRooms();
		} else {
			for (size_t i=0; i<blocks.size(); i++){
				std::string block = blocks[i];
				this->loadRooms(block);
			}
		}

		this->loadSchedules(day,courses);
	}


	//load class matrix with info from input
	void loadSchedules(int day){
		std::vector<std::string> courses;
		this->loadSchedules(day,courses);
	}
	void loadSchedules(int day,std::vector<std::string>& courses);
	//void loadSchedules(int day, std::string block, std::vector<std::string>& courses);

	void loadRooms(std::string block="");

	void execute(int size);

  private:
	Matrix<double> buildMatrix(Rooms& rooms, Turmas& turmas);
	void          assignMatrix(Matrix<double>& matrix, Rooms& rooms, Turmas& turmas);
};

/*-------------------------------------------------------------------------------------*/
