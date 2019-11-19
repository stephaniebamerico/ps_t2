#!/bin/bash
arq=$1
########################################################
##	Arquitetura		########################
TOTAL=$(grep " ta" $arq | wc -l )
CT=$(grep " ta" $arq| grep "ct-"|wc -l )
EQ=$(grep " ta" $arq| grep "eq-"|wc -l )
PA=$(grep " ta" $arq| grep "pa-"|wc -l )
PC=$(grep " ta" $arq| grep "pc-"|wc -l ) 
PD=$(grep " ta" $arq| grep "pd-"|wc -l )
PE=$(grep " ta" $arq| grep "pe-"|wc -l )
PF=$(grep " ta" $arq| grep "pf-"|wc -l )
PG=$(grep " ta" $arq| grep "pg-"|wc -l )
PH=$(grep " ta" $arq| grep "ph-"|wc -l ) 
PK=$(grep " ta" $arq| grep "pk-"|wc -l )
PL=$(grep " ta" $arq| grep "pl-"|wc -l )
PM=$(grep " ta" $arq| grep "pm-"|wc -l )
PQ=$(grep " ta" $arq| grep "pq-"|wc -l )
PR=$(grep " ta" $arq| grep "pr-"|wc -l )
T=$(grep " ta" $arq| grep "t-"|wc -l )
bio=$(grep " ta" $arq| grep "bio" | wc -l)
E=$(grep " ta" $arq| grep "### " | wc -l)
echo -n "Arquitetura: Total -> $TOTAL  | PD(centro) -> $PD "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Construção Civil	#############################
TOTAL=$(grep " tc" $arq | wc -l )
CT=$(grep " tc" $arq| grep " ct-"|wc -l )
EQ=$(grep " tc" $arq| grep " eq-"|wc -l )
PA=$(grep " tc" $arq| grep " pa-"|wc -l )
PC=$(grep " tc" $arq| grep " pc-"|wc -l ) 
PD=$(grep " tc" $arq| grep " pd-"|wc -l )
PE=$(grep " tc" $arq| grep " pe-"|wc -l )
PF=$(grep " tc" $arq| grep " pf-"|wc -l )
PG=$(grep " tc" $arq| grep " pg-"|wc -l )
PH=$(grep " tc" $arq| grep " ph-"|wc -l ) 
PK=$(grep " tc" $arq| grep " pk-"|wc -l )
PL=$(grep " tc" $arq| grep " pl-"|wc -l )
PM=$(grep " tc" $arq| grep " pm-"|wc -l )
PQ=$(grep " tc" $arq| grep " pq-"|wc -l )
PR=$(grep " tc" $arq| grep " pr-"|wc -l )
T=$(grep " tc" $arq| grep " t-"|wc -l )
bio=$(grep " tc" $arq| grep " bio" | wc -l)
E=$(grep " tc" $arq| grep "### " | wc -l)

echo -n "Construção civil: Total -> $TOTAL  | PF(centro) -> $PF "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  "" 
#####################################################
##	Engenharia Ambiental	#########################
TOTAL=$(grep " tea" $arq | wc -l )
CT=$(grep " tea" $arq| grep " ct-"|wc -l )
EQ=$(grep " tea" $arq| grep " eq-"|wc -l )
PA=$(grep " tea" $arq| grep " pa-"|wc -l )
PC=$(grep " tea" $arq| grep " pc-"|wc -l ) 
PD=$(grep " tea" $arq| grep " pd-"|wc -l )
PE=$(grep " tea" $arq| grep " pe-"|wc -l )
PF=$(grep " tea" $arq| grep " pf-"|wc -l )
PG=$(grep " tea" $arq| grep " pg-"|wc -l )
PH=$(grep " tea" $arq| grep " ph-"|wc -l ) 
PK=$(grep " tea" $arq| grep " pk-"|wc -l )
PL=$(grep " tea" $arq| grep " pl-"|wc -l )
PM=$(grep " tea" $arq| grep " pm-"|wc -l )
PQ=$(grep " tea" $arq| grep " pq-"|wc -l )
PR=$(grep " tea" $arq| grep " pr-"|wc -l )
T=$(grep " tea" $arq| grep " t-"|wc -l )
bio=$(grep " tea" $arq| grep " bio" | wc -l)
E=$(grep " tea" $arq| grep "### "| wc -l)
echo -n "Engenharia Ambiental: Total -> $TOTAL  | PM(centro) -> $PM "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#############################################
##	Engenharia de Bioprocessos e biotecnologia	#########################
TOTAL=$(grep " teb" $arq | wc -l )
CT=$(grep " teb" $arq| grep " ct-"|wc -l )
EQ=$(grep " teb" $arq| grep " eq-"|wc -l )
PA=$(grep " teb" $arq| grep " pa-"|wc -l )
PC=$(grep " teb" $arq| grep " pc-"|wc -l ) 
PD=$(grep " teb" $arq| grep " pd-"|wc -l )
PE=$(grep " teb" $arq| grep " pe-"|wc -l )
PF=$(grep " teb" $arq| grep " pf-"|wc -l )
PG=$(grep " teb" $arq| grep " pg-"|wc -l )
PH=$(grep " teb" $arq| grep " ph-"|wc -l ) 
PK=$(grep " teb" $arq| grep " pk-"|wc -l )
PL=$(grep " teb" $arq| grep " pl-"|wc -l )
PM=$(grep " teb" $arq| grep " pm-"|wc -l )
PQ=$(grep " teb" $arq| grep " pq-"|wc -l )
PR=$(grep " teb" $arq| grep " pr-"|wc -l )
T=$(grep " teb" $arq| grep " t-"|wc -l )
bio=$(grep " teb" $arq| grep " bio" | wc -l)
E=$(grep " teb" $arq| grep "### "| wc -l)

echo -n "Engenharia de Bioprocessos e Biotecnologia: Total -> $TOTAL  | EQ(centro) -> $EQ "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  "" 
#############################################
##	Engenharia de Produção		########################
TOTAL=$(grep " tp" $arq | wc -l )
CT=$(grep " tp" $arq| grep " ct-"|wc -l )
EQ=$(grep " tp" $arq| grep " eq-"|wc -l )
PA=$(grep " tp" $arq| grep " pa-"|wc -l )
PC=$(grep " tp" $arq| grep " pc-"|wc -l ) 
PD=$(grep " tp" $arq| grep " pd-"|wc -l )
PE=$(grep " tp" $arq| grep " pe-"|wc -l )
PF=$(grep " tp" $arq| grep " pf-"|wc -l )
PG=$(grep " tp" $arq| grep " pg-"|wc -l )
PH=$(grep " tp" $arq| grep " ph-"|wc -l ) 
PK=$(grep " tp" $arq| grep " pk-"|wc -l )
PL=$(grep " tp" $arq| grep " pl-"|wc -l )
PM=$(grep " tp" $arq| grep " pm-"|wc -l )
PQ=$(grep " tp" $arq| grep " pq-"|wc -l )
PR=$(grep " tp" $arq| grep " pr"|wc -l )
T=$(grep " tp" $arq| grep " t-"|wc -l )
bio=$(grep " tp" $arq| grep " bio" | wc -l)
E=$(grep " tp" $arq| grep "### "| wc -l)
echo -n "Engenharia de Produção: Total -> $TOTAL  | PM(centro) -> $PM "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Engenharia Elétrica		########################
TOTAL=$(grep " te" $arq |grep -v " teb"| wc -l )
CT=$(grep " te" $arq|grep -v " teb"| grep " ct-"|wc -l )
EQ=$(grep " te" $arq|grep -v " teb"| grep " eq-"|wc -l )
PA=$(grep " te" $arq|grep -v " teb"| grep " pa-"|wc -l )
PC=$(grep " te" $arq|grep -v " teb"| grep " pc-"|wc -l ) 
PD=$(grep " te" $arq|grep -v " teb"| grep " pd-"|wc -l )
PE=$(grep " te" $arq|grep -v " teb"| grep " pe-"|wc -l )
PF=$(grep " te" $arq|grep -v " teb"| grep " pf-"|wc -l )
PG=$(grep " te" $arq|grep -v " teb"| grep " pg-"|wc -l )
PH=$(grep " te" $arq|grep -v " teb"| grep " ph-"|wc -l ) 
PK=$(grep " te" $arq|grep -v " teb"| grep " pk-"|wc -l )
PL=$(grep " te" $arq|grep -v " teb"| grep " pl-"|wc -l )
PM=$(grep " te" $arq|grep -v " teb"| grep " pm-"|wc -l )
PQ=$(grep " te" $arq|grep -v " teb"| grep " pq-"|wc -l )
PR=$(grep " te" $arq|grep -v " teb"| grep " pr-"|wc -l )
T=$(grep " te" $arq|grep -v " teb"| grep " t-"|wc -l )
bio=$(grep " te" $arq|grep -v " teb"| grep " bio" | wc -l)
E=$(grep " te" $arq|grep -v " teb"| grep "### "| wc -l)
echo -n "Engenharia Elétrica: Total -> $TOTAL  | PK(centro) -> $PK "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Engenharia Mecanica		########################
TOTAL=$(grep " tm" $arq | wc -l )
CT=$(grep " tm" $arq| grep " ct-"|wc -l )
EQ=$(grep " tm" $arq| grep " eq-"|wc -l )
PA=$(grep " tm" $arq| grep " pa-"|wc -l )
PC=$(grep " tm" $arq| grep " pc-"|wc -l ) 
PD=$(grep " tm" $arq| grep " pd-"|wc -l )
PE=$(grep " tm" $arq| grep " pe-"|wc -l )
PF=$(grep " tm" $arq| grep " pf-"|wc -l )
PG=$(grep " tm" $arq| grep " pg-"|wc -l )
PH=$(grep " tm" $arq| grep " ph-"|wc -l ) 
PK=$(grep " tm" $arq| grep " pk-"|wc -l )
PL=$(grep " tm" $arq| grep " pl-"|wc -l )
PM=$(grep " tm" $arq| grep " pm-"|wc -l )
PQ=$(grep " tm" $arq| grep " pq-"|wc -l )
PR=$(grep " tm" $arq| grep " pr"|wc -l )
T=$(grep " tm" $arq| grep " t-"|wc -l )
bio=$(grep " tm" $arq| grep " bio" | wc -l)
E=$(grep " tm" $arq| grep "### "| wc -l)
echo -n "Engenharia Mecanica: Total -> $TOTAL  | PG(centro) -> $PG "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Engenharia Quimica	########################
TOTAL=$(grep " tq" $arq | wc -l )
CT=$(grep " tq" $arq| grep " ct-"|wc -l )
EQ=$(grep " tq" $arq| grep " eq-"|wc -l )
PA=$(grep " tq" $arq| grep " pa-"|wc -l )
PC=$(grep " tq" $arq| grep " pc-"|wc -l ) 
PD=$(grep " tq" $arq| grep " pd-"|wc -l )
PE=$(grep " tq" $arq| grep " pe-"|wc -l )
PF=$(grep " tq" $arq| grep " pf"|wc -l )
PG=$(grep " tq" $arq| grep " pg-"|wc -l )
PH=$(grep " tq" $arq| grep " ph-"|wc -l ) 
PK=$(grep " tq" $arq| grep " pk-"|wc -l )
PL=$(grep " tq" $arq| grep " pl-"|wc -l )
PM=$(grep " tq" $arq| grep " pm-"|wc -l )
PQ=$(grep " tq" $arq| grep " pq-"|wc -l )
PR=$(grep " tq" $arq| grep " pr-"|wc -l )
T=$(grep " tq" $arq| grep " t-"|wc -l )
bio=$(grep " tq" $arq| grep " bio" | wc -l)
E=$(grep " tq" $arq| grep "### "| wc -l)

echo -n "Engenharia Quimica: Total -> $TOTAL  | EQ(centro) -> $EQ "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Estatistica		########################
TOTAL=$(grep " ce" $arq | wc -l )
CT=$(grep " ce" $arq| grep " ct-"|wc -l )
EQ=$(grep " ce" $arq| grep " eq-"|wc -l )
PA=$(grep " ce" $arq| grep " pa-"|wc -l )
PC=$(grep " ce" $arq| grep " pc-"|wc -l ) 
PD=$(grep " ce" $arq| grep " pd-"|wc -l )
PE=$(grep " ce" $arq| grep " pe-"|wc -l )
PF=$(grep " ce" $arq| grep " pf-"|wc -l )
PG=$(grep " ce" $arq| grep " pg-"|wc -l )
PH=$(grep " ce" $arq| grep " ph-"|wc -l ) 
PK=$(grep " ce" $arq| grep " pk-"|wc -l )
PL=$(grep " ce" $arq| grep " pl-"|wc -l )
PM=$(grep " ce" $arq| grep " pm-"|wc -l )
PQ=$(grep " ce" $arq| grep " pq-"|wc -l )
PR=$(grep " ce" $arq| grep " pr-"|wc -l )
T=$(grep " ce" $arq| grep " t-"|wc -l )
bio=$(grep " ce" $arq| grep " bio" | wc -l)
E=$(grep " ce" $arq| grep "### "| wc -l)
echo -n "Estatistica: Total -> $TOTAL  | PA(centro) -> $PA "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  "";
#####################################################
##	Expresão Grafica		########################
TOTAL=$(grep " cd" $arq | wc -l )
CT=$(grep " cd" $arq| grep " ct-"|wc -l )
EQ=$(grep " cd" $arq| grep " eq-"|wc -l )
PA=$(grep " cd" $arq| grep " pa-"|wc -l )
PC=$(grep " cd" $arq| grep " pc-"|wc -l ) 
PD=$(grep " cd" $arq| grep " pd-"|wc -l )
PE=$(grep " cd" $arq| grep " pe-"|wc -l )
PF=$(grep " cd" $arq| grep " pf-"|wc -l )
PG=$(grep " cd" $arq| grep " pg-"|wc -l )
PH=$(grep " cd" $arq| grep " ph-"|wc -l ) 
PK=$(grep " cd" $arq| grep " pk-"|wc -l )
PL=$(grep " cd" $arq| grep " pl-"|wc -l )
PM=$(grep " cd" $arq| grep " pm-"|wc -l )
PQ=$(grep " cd" $arq| grep " pq-"|wc -l )
PR=$(grep " cd" $arq| grep " pr-"|wc -l )
T=$(grep " cd" $arq| grep " t-"|wc -l )
bio=$(grep " cd" $arq| grep " bio" | wc -l)
E=$(grep " cd" $arq| grep "### "| wc -l)
echo -n "Expressão Grafica: Total -> $TOTAL  | PC(centro) -> $PC "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Fisica	########################
TOTAL=$(grep " cf" $arq | wc -l )
CT=$(grep " cf" $arq| grep " ct-"|wc -l )
EQ=$(grep " cf" $arq| grep " eq-"|wc -l )
PA=$(grep " cf" $arq| grep " pa-"|wc -l )
PC=$(grep " cf" $arq| grep " pc-"|wc -l ) 
PD=$(grep " cf" $arq| grep " pd-"|wc -l )
PE=$(grep " cf" $arq| grep " pe-"|wc -l )
PF=$(grep " cf" $arq| grep " pf-"|wc -l )
PG=$(grep " cf" $arq| grep " pg-"|wc -l )
PH=$(grep " cf" $arq| grep " ph-"|wc -l ) 
PK=$(grep " cf" $arq| grep " pk-"|wc -l )
PL=$(grep " cf" $arq| grep " pl-"|wc -l )
PM=$(grep " cf" $arq| grep " pm-"|wc -l )
PQ=$(grep " cf" $arq| grep " pq-"|wc -l )
PR=$(grep " cf" $arq| grep " pr-"|wc -l )
T=$(grep " cf" $arq| grep " t-"|wc -l )
bio=$(grep " cf" $arq| grep " bio" | wc -l)
E=$(grep " cf" $arq| grep "### "| wc -l)
echo -n "Fisica: Total -> $TOTAL  | PE(centro) -> $PE "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Geografia		########################
TOTAL=$(grep " gb" $arq | wc -l )
CT=$(grep " gb" $arq| grep " ct-"|wc -l )
EQ=$(grep " gb" $arq| grep " eq-"|wc -l )
PA=$(grep " gb" $arq| grep " pa-"|wc -l )
PC=$(grep " gb" $arq| grep " pc-"|wc -l ) 
PD=$(grep " gb" $arq| grep " pd-"|wc -l )
PE=$(grep " gb" $arq| grep " pe-"|wc -l )
PF=$(grep " gb" $arq| grep " pf-"|wc -l )
PG=$(grep " gb" $arq| grep " pg-"|wc -l )
PH=$(grep " gb" $arq| grep " ph-"|wc -l ) 
PK=$(grep " gb" $arq| grep " pk-"|wc -l )
PL=$(grep " gb" $arq| grep " pl-"|wc -l )
PM=$(grep " gb" $arq| grep " pm-"|wc -l )
PQ=$(grep " gb" $arq| grep " pq-"|wc -l )
PR=$(grep " gb" $arq| grep " pr-"|wc -l )
T=$(grep " gb" $arq| grep " t-"|wc -l )
bio=$(grep " gb" $arq| grep " bio" | wc -l)
E=$(grep " gb" $arq| grep "### "| wc -l)
echo -n "Geografia: Total -> $TOTAL  | CT(centro) -> $CT "
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  "";
#####################################################
##	Geologia		########################
TOTAL=$(grep " gc" $arq | wc -l )
CT=$(grep " gc" $arq| grep " ct-"|wc -l )
EQ=$(grep " gc" $arq| grep " eq-"|wc -l )
PA=$(grep " gc" $arq| grep " pa-"|wc -l )
PC=$(grep " gc" $arq| grep " pc-"|wc -l ) 
PD=$(grep " gc" $arq| grep " pd-"|wc -l )
PE=$(grep " gc" $arq| grep " pe-"|wc -l )
PF=$(grep " gc" $arq| grep " pf-"|wc -l )
PG=$(grep " gc" $arq| grep " pg-"|wc -l )
PH=$(grep " gc" $arq| grep " ph-"|wc -l ) 
PK=$(grep " gc" $arq| grep " pk-"|wc -l )
PL=$(grep " gc" $arq| grep " pl-"|wc -l )
PM=$(grep " gc" $arq| grep " pm-"|wc -l )
PQ=$(grep " gc" $arq| grep " pq-"|wc -l )
PR=$(grep " gc" $arq| grep " pr-"|wc -l )
T=$(grep " gc" $arq| grep " t-"|wc -l )
E=$(grep " gc" $arq| grep "### "| wc -l)
bio=$(grep " gc" $arq| grep " bio" | wc -l)
echo -n "Geologia: Total -> $TOTAL  | PH(centro) -> $PH "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Geomatica		########################
TOTAL=$(grep " ga" $arq | wc -l )
CT=$(grep " ga" $arq| grep " ct-"|wc -l )
EQ=$(grep " ga" $arq| grep " eq-"|wc -l )
PA=$(grep " ga" $arq| grep " pa-"|wc -l )
PC=$(grep " ga" $arq| grep " pc-"|wc -l ) 
PD=$(grep " ga" $arq| grep " pd-"|wc -l )
PE=$(grep " ga" $arq| grep " pe-"|wc -l )
PF=$(grep " ga" $arq| grep " pf-"|wc -l )
PG=$(grep " ga" $arq| grep " pg-"|wc -l )
PH=$(grep " ga" $arq| grep " ph-"|wc -l ) 
PK=$(grep " ga" $arq| grep " pk-"|wc -l )
PL=$(grep " ga" $arq| grep " pl-"|wc -l )
PM=$(grep " ga" $arq| grep " pm-"|wc -l )
PQ=$(grep " ga" $arq| grep " pq-"|wc -l )
PR=$(grep " ga" $arq| grep " pr-"|wc -l )
T=$(grep " ga" $arq| grep " t-"|wc -l )
bio=$(grep " ga" $arq| grep " bio" | wc -l)
E=$(grep " ga" $arq| grep "### "| wc -l)
echo -n "Geomatica: Total -> $TOTAL  | CT(centro) -> $CT "
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Hidraulica e Saneamento		########################
TOTAL=$(grep " th" $arq | wc -l )
CT=$(grep " th" $arq| grep " ct-"|wc -l )
EQ=$(grep " th" $arq| grep " eq-"|wc -l )
PA=$(grep " th" $arq| grep " pa-"|wc -l )
PC=$(grep " th" $arq| grep " pc-"|wc -l ) 
PD=$(grep " th" $arq| grep " pd-"|wc -l )
PE=$(grep " th" $arq| grep " pe-"|wc -l )
PF=$(grep " th" $arq| grep " pf-"|wc -l )
PG=$(grep " th" $arq| grep " pg-"|wc -l )
PH=$(grep " th" $arq| grep " ph-"|wc -l ) 
PK=$(grep " th" $arq| grep " pk-"|wc -l )
PL=$(grep " th" $arq| grep " pl-"|wc -l )
PM=$(grep " th" $arq| grep " pm-"|wc -l )
PQ=$(grep " th" $arq| grep " pq-"|wc -l )
PR=$(grep " th" $arq| grep " pr-"|wc -l )
T=$(grep " th" $arq| grep " t-"|wc -l )
bio=$(grep " th" $arq| grep " bio" | wc -l)
E=$(grep " th" $arq| grep "### "| wc -l)
echo -n "Hidraulica e saneamento: Total -> $TOTAL  | PH(centro) -> $PH "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Informatica	########################
TOTAL=$(grep " ci" $arq | wc -l )
CT=$(grep " ci" $arq| grep " ct-"|wc -l )
EQ=$(grep " ci" $arq| grep " eq-"|wc -l )
PA=$(grep " ci" $arq| grep " pa-"|wc -l )
PC=$(grep " ci" $arq| grep " pc-"|wc -l ) 
PD=$(grep " ci" $arq| grep " pd-"|wc -l )
PE=$(grep " ci" $arq| grep " pe-"|wc -l )
PF=$(grep " ci" $arq| grep " pf-"|wc -l )
PG=$(grep " ci" $arq| grep " pg-"|wc -l )
PH=$(grep " ci" $arq| grep " ph-"|wc -l ) 
PK=$(grep " ci" $arq| grep " pk-"|wc -l )
PL=$(grep " ci" $arq| grep " pl-"|wc -l )
PM=$(grep " ci" $arq| grep " pm-"|wc -l )
PQ=$(grep " ci" $arq| grep " pq-"|wc -l )
PR=$(grep " ci" $arq| grep " pr-"|wc -l )
T=$(grep " ci" $arq| grep " t-"|wc -l )
bio=$(grep " ci" $arq| grep " bio" | wc -l)
E=$(grep " ci" $arq| grep "### "| wc -l)
echo -n "Informatica: Total -> $TOTAL  | PA(centro) -> $PA "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Matematica	########################
TOTAL=$(grep " cm" $arq | wc -l )
CT=$(grep " cm" $arq| grep " ct-"|wc -l )
EQ=$(grep " cm" $arq| grep " eq-"|wc -l )
PA=$(grep " cm" $arq| grep " pa-"|wc -l )
PC=$(grep " cm" $arq| grep " pc-"|wc -l ) 
PD=$(grep " cm" $arq| grep " pd-"|wc -l )
PE=$(grep " cm" $arq| grep " pe-"|wc -l )
PF=$(grep " cm" $arq| grep " pf-"|wc -l )
PG=$(grep " cm" $arq| grep " pg-"|wc -l )
PH=$(grep " cm" $arq| grep " ph-"|wc -l ) 
PK=$(grep " cm" $arq| grep " pk-"|wc -l )
PL=$(grep " cm" $arq| grep " pl-"|wc -l )
PM=$(grep " cm" $arq| grep " pm-"|wc -l )
PQ=$(grep " cm" $arq| grep " pq-"|wc -l )
PR=$(grep " cm" $arq| grep " pr-"|wc -l )
T=$(grep " cm" $arq| grep " t-"|wc -l )
bio=$(grep " cm" $arq| grep " bio" | wc -l)
E=$(grep " cm" $arq| grep "### "| wc -l)
echo -n "Matematica: Total -> $TOTAL  | PC(centro) -> $PC "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Quimica		########################
TOTAL=$(grep " cq" $arq | wc -l )
CT=$(grep " cq" $arq| grep " ct-"|wc -l )
EQ=$(grep " cq" $arq| grep " eq-"|wc -l )
PA=$(grep " cq" $arq| grep " pa-"|wc -l )
PC=$(grep " cq" $arq| grep " pc-"|wc -l ) 
PD=$(grep " cq" $arq| grep " pd-"|wc -l )
PE=$(grep " cq" $arq| grep " pe-"|wc -l )
PF=$(grep " cq" $arq| grep " pf-"|wc -l )
PG=$(grep " cq" $arq| grep " pg-"|wc -l )
PH=$(grep " cq" $arq| grep " ph-"|wc -l ) 
PK=$(grep " cq" $arq| grep " pk-"|wc -l )
PL=$(grep " cq" $arq| grep " pl-"|wc -l )
PM=$(grep " cq" $arq| grep " pm-"|wc -l )
PQ=$(grep " cq" $arq| grep " pq-"|wc -l )
PR=$(grep " cq" $arq| grep " pr-"|wc -l )
T=$(grep " cq" $arq| grep " t-"|wc -l )
bio=$(grep " cq" $arq| grep " bio" | wc -l)
E=$(grep " cq" $arq| grep "### "| wc -l)
echo -n "Quimica: Total -> $TOTAL  | PQ(centro) -> $PQ "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
##	Transporte		########################
TOTAL=$(grep " tt" $arq | wc -l )
CT=$(grep " tt" $arq| grep " ct-"|wc -l )
EQ=$(grep " tt" $arq| grep " eq-"|wc -l )
PA=$(grep " tt" $arq| grep " pa-"|wc -l )
PC=$(grep " tt" $arq| grep " pc-"|wc -l ) 
PD=$(grep " tt" $arq| grep " pd-"|wc -l )
PE=$(grep " tt" $arq| grep " pe-"|wc -l )
PF=$(grep " tt" $arq| grep " pf-"|wc -l )
PG=$(grep " tt" $arq| grep " pg-"|wc -l )
PH=$(grep " tt" $arq| grep " ph-"|wc -l ) 
PK=$(grep " tt" $arq| grep " pk-"|wc -l )
PL=$(grep " tt" $arq| grep " pl-"|wc -l )
PM=$(grep " tt" $arq| grep " pm"|wc -l )
PQ=$(grep " tt" $arq| grep " pq-"|wc -l )
PR=$(grep " tt" $arq| grep " pr-"|wc -l )
T=$(grep " tt" $arq| grep " t-"|wc -l )
bio=$(grep " tt" $arq| grep " bio" | wc -l)
E=$(grep " tt" $arq| grep "### "| wc -l)
echo -n "Transporte: Total -> $TOTAL  | PH(centro) -> $PH "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $bio > 0 )); then
	echo -n "| bio -> $bio "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
#####################################################
## Biologia, a se tornar mais especifico no futuro ##


TOTAL=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"|wc -l )
CT=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " ct-"|wc -l )
EQ=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " eq-"|wc -l )
PA=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pa-"|wc -l )
PC=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pc-"|wc -l ) 
PD=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pd-"|wc -l )
PE=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pe-"|wc -l )
PF=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pf-"|wc -l )
PG=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pg-"|wc -l )
PH=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " ph-"|wc -l ) 
PK=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pk-"|wc -l )
PL=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pl-"|wc -l )
PM=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pm"|wc -l )
PQ=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pq-"|wc -l )
PR=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " pr-"|wc -l )
T=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " t-"|wc -l )
bio=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep " bio" | wc -l)
E=$(grep -v " tt" $arq|grep -v " cq"|grep -v " cm"|grep -v " ci"|grep -v " th"|grep -v " ga"|grep -v " gc"|grep -v " gb"|grep -v " cf"|grep -v " cd"|grep -v " ce"|grep -v " tq"|grep -v " tm"|grep -v " te"|grep -v " tp"|grep -v " teb"|grep -v " tea"|grep -v " tc"|grep -v " ta"| grep "### "| wc -l)
echo -n "Biologicas: Total -> $TOTAL  | bio(centro) -> $bio "
if (( $CT > 0 )); then
	echo -n "| CT -> $CT "
fi
if (( $EQ > 0 )); then
	echo -n "| EQ -> $EQ "
fi
if (( $PA > 0 )); then
	echo -n "| PA -> $PA "
fi
if (( $PC > 0 )); then
	echo -n "| PC -> $PC "
fi
if (( $PD > 0 )); then
	echo -n "| PD -> $PD "
fi
if (( $PE > 0 )); then
	echo -n "| PE -> $PE "
fi
if (( $PF > 0 )); then
	echo -n "| PF -> $PF "
fi
if (( $PG > 0 )); then
	echo -n "| PG -> $PG "
fi
if (( $PH > 0 )); then
	echo -n "| PH -> $PH "
fi
if (( $PK > 0 )); then
	echo -n "| PK -> $PK "
fi
if (( $PL > 0 )); then
	echo -n "| PL -> $PL "
fi
if (( $PM > 0 )); then
	echo -n "| PM -> $PM "
fi
if (( $PQ > 0 )); then
	echo -n "| PQ -> $PQ "
fi
if (( $PR > 0 )); then
	echo -n "| PR -> $PR "
fi
if (( $T > 0 )); then
	echo -n "| T -> $T "
fi
if (( $E > 0 )); then
	echo -n "| Turmas nao ensaladas -> $E "
fi
echo  ""
