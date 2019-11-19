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


#include <algorithm>


map<string,Stat> getStatCourses(Database& db){
	map<string,Stat> courses;
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* turma = db.schedules[i];
		map<string,Stat>::iterator it = courses.find(turma->course);

		if ( turma->assigned ){
			string block = turma->assigned->block;
			int value = turma->end - turma->ini;
			if ( it != courses.end() ){
				it->second.add(block, value);
			} else {
				Stat novo;
				novo.add(block,value);
				courses.insert( std::pair<string,Stat>(turma->course,novo) );
			}
		}
	}
	return courses;
}


map<string,Stat> getStatDepartments(Database& db){
	map<string,Stat> courses;
	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* turma = db.schedules[i];
		map<string,Stat>::iterator it = courses.find(turma->department);

		if ( turma->assigned ){
			string block = turma->assigned->block;
			int value = turma->end - turma->ini;
			if ( it != courses.end() ){
				it->second.add(block, value);
			} else {
				Stat novo;
				novo.add(block,value);
				courses.insert( std::pair<string,Stat>(turma->department,novo) );
			}
		}
	}
	return courses;
}





void renderInit(){
	cout << "\\documentclass[12pt]{article}\n";
	cout << "\\usepackage[utf8]{inputenc}\n";
	cout << "\\usepackage{tikz}\n";
	cout << "\\usepackage{multicol}\n";
	cout << "\\usepackage{float}\n";

	cout << "\\title{Ensalamento 2018}\n";

	cout << "\\begin{document}\n";

	cout << "\\def\\angle{0}\n";
	cout << "\\def\\radius{3}\n";
	cout << "\\def\\cyclelist{{\"orange\",\"blue\",\"red\",\"green\"}}\n";
	cout << "\\newcount\\cyclecount \\cyclecount=-1\n";
	cout << "\\newcount\\ind \\ind=-1\n";

}

void renderEnd(){
	cout << "\\end{document}\n";
}


void renderGraphicsInit(){

	cout << "\\begin{tikzpicture}[nodes = {font=\\sffamily}]\n";
	cout << "  \\foreach \\percent/\\name in {\n";
	cout << "      46.6/Chrome\n";
}

void renderGraphicsEnd(){
	cout << "    } {\n";
	cout << "      \\ifx\\percent\\empty\else               \n";
	cout << "        \\global\\advance\cyclecount by 1     \n";
	cout << "        \\global\\advance\ind by 1            \n";
	cout << "        \\ifnum3<\\cyclecount                 \n";
	cout << "          \\global\\cyclecount=0              \n";
	cout << "          \\global\\ind=0                     \n";
	cout << "        \\fi\n";
	cout << "        \\pgfmathparse{\\cyclelist[\\the\\ind]} % Get color from cycle list\n";
	cout << "        \\edef\\color{\\pgfmathresult}         %   and store as \\color\n";
	cout << "        % Draw angle and set labels\n";
	cout << "        \\draw[fill={\\color!50},draw={\\color}] (0,0) -- (\\angle:\\radius)\n";
	cout << "          arc (\\angle:\\angle+\\percent*3.6:\\radius) -- cycle;\n";
	cout << "        \\node at (\\angle+0.5*\\percent*3.6:0.7*\\radius) {\\percent\\,\\%};\n";
	cout << "        \\node[pin=\\angle+0.5*\\percent*3.6:\\name]\n";
	cout << "          at (\\angle+0.5*\percent*3.6:\\radius) {};\n";
	cout << "        \\pgfmathparse{\\angle+\\percent*3.6}  % Advance angle\n";
	cout << "        \\xdef\\angle{\\pgfmathresult}         %   and store in \\angle\n";
	cout << "      \\fi\n";
	cout << "    };\n";
	cout << "\\end{tikzpicture}\n";
}


void generateLatex(Database& db) {

	static int total[DAYSIZE][WEEKSIZE];
	for (int i=0;i<WEEKSIZE; i++){
		for (int j=0;j<DAYSIZE; j++){
			total[i][j] = 0;
		}
	}

	for (size_t i=0; i<db.schedules.size(); i++){
		Turma* sched = db.schedules[i];
		if ( sched->do_malloc_room ){ //&& sched->suggested != "" ){
			int ini  = sched->ini;
			int day  = sched->dia;
			int size = sched->end-sched->ini;
			for (int tt=0;tt<size;tt++){
				total[ini+tt][day] += 1;
			}
		}
	}


	renderInit();

	cout << "\\section{Salas}\n";
	printf("Total de Salas: %ld\n",db.rooms.size());
	printf("\\begin{multicols}{4} \\begin{itemize}\n");
	for (size_t i=0; i<db.rooms.size(); i++){
		cout << "\t\\item " << db.rooms[i]->code << endl;
	}
	printf("\\end{itemize} \\end{multicols}\n");

	printf("\\section{Turmas}\n");
	printf("TOTAL:\n");
	printf("\\begin{table}[H]\n");
	printf("\\begin{tabular}{l|llllll}\n");
	printf("&seg&ter&qua&qui&sex&sab\\\\\n");
	for (int hour=7;hour<DAYSIZE; hour++){
		printf("%2d:30 & ", hour);
		for (int day=2;day<WEEKSIZE-1; day++){
			printf("%3d & ", total[hour][day] );
		}
		printf("%3d \\\\", total[hour][7] );
		printf("\n");
	}
	printf("\\end{tabular}\n");
	printf("\\end{table}\n");

	{
		printf("\\section{Departamentos}\n");
		map<string,Stat> departments =  getStatDepartments(db);
		map<string,Stat>::iterator it = departments.begin();
		for (; it!=departments.end(); ++it ){
			string name = it->first;
			std::replace( name.begin(), name.end(), '_', ' ');
			cout << "\\subsection{" << name << "}\n";

			map<string,int>::iterator it2 = it->second.begin();
			//cout << "\\begin{description}\n";
			for (; it2!=it->second.end(); ++it2 ){
				renderGraphicsInit();
				//cout << "\t \\item[" << it2->first << "] " << it2->second << "\n";
				renderGraphicsEnd();
			}
			//cout << "\\end{description}\n";
		}
	}


	{
		printf("\\section{Cursos}\n");
		map<string,Stat> courses =  getStatCourses(db);
		map<string,Stat>::iterator it = courses.begin();
		for (; it!=courses.end(); ++it ){
			cout << "\\subsection{Curso " << it->first << "}\n";

			map<string,int>::iterator it2 = it->second.begin();
			cout << "\\begin{description}\n";
			for (; it2!=it->second.end(); ++it2 ){
				cout << "\t \\item[" << it2->first << "] " << it2->second << "\n";
			}
			cout << "\\end{description}\n";
		}
	}


	renderEnd();

}
