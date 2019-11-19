from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
import plotly.graph_objs as go
from plotly import tools

import numpy as np
import datetime

import yaml
import io
from collections import defaultdict

import sys

WEEK_DAYS = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
# WEEK_DAYS = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]

MIN_HOUR_DAY = 7
MAX_HOUR_DAY = 23

# Every room that has this strings in name will be disconsidered
BANNED_LIST_ROOMS = [
    "palotina",
    "dp2",
    "dp1",
]

# Every schedule that has this strings on blocks names will be disconsidered
BANNED_SCHEDULE_BLOCKS = [
    "palotina",
]


SECTORS = [
    "politecnico",
    "humanas",
    "biologicas",
    "palotina",
]

BLOCK_2_SECTOR = {
    'humanas-dp1-11': 'humanas',
    'humanas-dp1-09': 'humanas',
    'humanas-dp2-05': 'humanas',
    'humanas-dp1-12': 'humanas',
    'humanas-dp1-10': 'humanas',
    'humanas-dp1-01': 'humanas',
    'humanas-dp2-03': 'humanas',
    'humanas-dp2-04': 'humanas',
    'humanas-dp1-06': 'humanas',
    'humanas-dp2-06': 'humanas',
    'dp1': 'humanas',
    'dp2': 'humanas',

    'palotina-bl-5': 'palotina',
    'palotina-bl-1': 'palotina',
    'palotina-bl-3': 'palotina',
    'palotina-bl-4': 'palotina',
    'palotina-bl-2': 'palotina',
    
    'bl_anexo_i': 'biologicas',
    'bl': 'biologicas',
    
    'pf': 'politecnico',
    'pm': 'politecnico',
    'pd': 'politecnico',
    'pg': 'politecnico',
    'eq': 'politecnico',
    'pk': 'politecnico',
    'pa': 'politecnico',
    'ph': 'politecnico',
    'ct': 'politecnico',
    'pc': 'politecnico',
    'pl': 'politecnico',
    'pq': 'politecnico',
}


MARGIN_PLOTS = go.layout.Margin(
    l=50,
    r=50,
    b=200,
    t=150,
    pad=0
)

def pretty(d, indent=0):
   for key, value in d.items():
      print('\t' * indent + str(key))
      if isinstance(value, dict):
         pretty(value, indent+1)
      else:
         print('\t' * (indent+1) + str(value))

def plot_matrix_heatmap(x_axis_labels, y_axis_labels, z_axis_labels, title="", filename="ensalament-heatmap"):

    my_colorsc=[[0, 'rgb(255,255,255)'],#white
        # [0.08, 'rgb(255,255,255'], 
        [0.2, 'rgb(0,0,255)'],
        [0.6, 'rgb(255,165,0)'],#orange
        [0.8, 'rgb(255,165,0)'],
        # [0.4, 'rgb(255,0,0'], #red
        [1.0, 'rgb(255,0,0)']
        # [0.999, 'rgb(255,0,0)'],
        # [1.0, 'rgb(0,255,0)']
    ]
        # [0.8, 'rgb(0,0,255)'], #blue

    data = [
        go.Heatmap(
            z=z_axis_labels,
            x=x_axis_labels,
            y=y_axis_labels,
            # colorscale='Viridis',
            colorscale = my_colorsc,
            colorbar= {
                # "x": -2,
                "y": 1,
                "yanchor": "top",
                # "width": 30,
                "tickmode": "array",
                "lenmode": "pixels",
                "len": 500,
            }
        )
    ]

    layout = go.Layout(
        title=title,
        xaxis = dict(ticks='', nticks=24, side='top'),
        yaxis = dict(ticks='' ),
        autosize = True,
        height = len(y_axis_labels)*30,
        margin=MARGIN_PLOTS,
    )

    fig = go.Figure(data=data, layout=layout)
    plot(fig, filename=filename)



def daily_use(rooms_uses, blocks):

    for sector in SECTORS: 
        data_heat_map = []
        y_axis_labels = []
        x_axis_labels = WEEK_DAYS
        for room in rooms_uses:
            room_block = get_block_of_room(room, blocks)
            if(room_block != "" and BLOCK_2_SECTOR[room_block] != sector):
                continue
            y_axis_labels.append(room)
            heat_map_line = []
            
            for day in rooms_uses[room]:
                used_times_per_day = len( [ 1 for x in rooms_uses[room][day] if rooms_uses[room][day][x] != None] )
                heat_map_line.append(used_times_per_day)
            
            data_heat_map.append(heat_map_line)
        
        if(len(data_heat_map) == 0):
            continue
        
        plot_matrix_heatmap(
            x_axis_labels,
            y_axis_labels,
            data_heat_map,
            "Uso (horas) diário de cada sala não reestrita. <br>As cores próximas de azul representam baixos usos das salas e as próximas do vermelho um alto uso (cores brancas indicam o não uso da sala em um determinado dia da semana).",
            sector+"_heatmap"
        )


def create_axis_schedules():
    x_axis_labels = []
    
    for i in range(7):
        for j in range(1,25):
            init_hour_str = str(j%24)+":30"
            end_hour_str = str((j+1)%24)+":30"
            
            time_str = init_hour_str+" - "+end_hour_str

            x_axis_labels.append(WEEK_DAYS[i]+" "+time_str)
    return x_axis_labels

def rooms_uses_by_time(rooms_uses):

    total_rooms = len(rooms_uses)

    x_axis_labels = create_axis_schedules()
    
    y_data = [0 for i in range(24*7)]
    for room in rooms_uses:
        for day in rooms_uses[room]:
            for use_room_time in rooms_uses[room][day]:
                course_code = rooms_uses[room][day][use_room_time]
                if course_code:
                    y_data[(day-1)*24 + (use_room_time-1)] += 1
        

    # print(y_data)
    data = [
        go.Bar(
            x=x_axis_labels,
            y=y_data,
            name='Salas usadas neste horário',
        ),
        # go.Bar(
        #     x=x_axis_labels,
        #     y=[total_rooms-x for x in y_data],
        #     name='Salas não usadas neste horário',
        # ),
        go.Scatter(
            x=x_axis_labels,
            y=[str(total_rooms) for x in range(len(x_axis_labels))],
            name="Capacidade",
        )

    ]

    layout = go.Layout(
        title="Quantidade de salas não restritas usadas por horários <br>Total de salas não restritas: "+str(total_rooms),
        autosize = True,
        barmode='stack',
        margin=MARGIN_PLOTS,
        xaxis={
            "title": "Horários",
        },
        yaxis={
            "title": "Quantidade de salas utilizadas",
        },
    )

    fig = go.Figure(data=data, layout=layout)
    plot(fig, filename='ensalamento_graph_bar')


def get_block_of_room(room, blocks):
    for block in blocks:
        rooms = blocks[block]
        if(room in rooms):
            return block
    return None

def get_block_of_schedule(schedule_code, to_schedule):
    for ts in to_schedule:
        if(ts["code"] == schedule_code):
            return ts["block"]
    return None

def merge_room_uses(rooms):
    block_use = {}
    for i in range(1,8):
        block_use[i] = {}
        for j in range(1,25):
            block_use[i][j] = 0
    
    for room in rooms:
        for i in range(1,8):
            for j in range(1,25):
                if(room[i][j] != None):
                    block_use[i][j] += 1
    return block_use

def dict_uses_in_week_to_array(dic):
    array = np.zeros(7*24)
    for i in range(1,8):
        for j in range(1,25):
            array[i*7 + j] = dic[i][j]
    
    return array


def overflow_block_capacity(rooms_uses, blocks_capacities, blocks_not_restricts):
    

    blocks_uses = {}
    
    for block_name in blocks_capacities:
        blocks_uses[block_name] = merge_room_uses(
            [rooms_uses[x] for x in rooms_uses if get_block_of_room(x, blocks_not_restricts) == block_name ]
        )

    x_data = create_axis_schedules()

    plot_titles = ["Uso do bloco "+x for x in blocks_uses]
    fig = tools.make_subplots(rows=len(blocks_uses), cols=1, subplot_titles=plot_titles)

    for i,block_name in enumerate(blocks_uses):
        y_data = [0 for i in range(24*7)]
        for day in blocks_uses[block_name]:
            for use_room_time in blocks_uses[block_name][day]:
                block_use = blocks_uses[block_name][day][use_room_time]
                y_data[(day-1)*24 + (use_room_time-1)] += block_use

        trace_data = go.Bar(
            x=x_data,
            y=y_data,
            name="Salas usadas",
        )
        
        trace_limiar = go.Scatter(
            x=x_data,
            y=[blocks_capacities[block_name] for x in range(len(x_data))],
            name="Capacidade",
        )

        
        fig.append_trace(trace_data, i+1, 1)
        fig.append_trace(trace_limiar, i+1, 1)

        fig['layout']['xaxis'+str(i+1)].update(title='Horários')

        fig['layout']['yaxis'+str(i+1)].update(title='Quantidade de salas utilizadas')

    fig['layout'].update(title='Uso dos blocos por horários. As retas indicam a capacidade máxima de cada bloco.')
    fig['layout'].update(autosize = True)
    fig['layout'].update(height=len(blocks_uses)*400)
    fig['layout'].update(margin=MARGIN_PLOTS)

    plot(fig, filename='capacity_use')

def plot_schedules_by_day(schedules):
    MIN_TIME = 5
    days = [["" for x in range(MIN_TIME,24)] for i in WEEK_DAYS]
    days = [[str(x)+":30" for x in range(MIN_TIME,24)]] + days

    for schedule in schedules:
        day = schedule["day"]
        ini = (schedule["ini"] - MIN_TIME) % 24
        end = (schedule["end"] - MIN_TIME) % 24
        code= schedule["code"]

        text = code
        if("suggested" in schedule):
            text+="<br>Sala sugerida: <b>"+schedule["suggested"]+"</b>"

        for i in range(ini,end):
            days[day][i]+="<br> <b>"+text+"</b><br>" 
    
    trace = go.Table(
        header=dict(values=["Horários"]+WEEK_DAYS,
                    fill = dict(color='#C2D4FF'),
                    align = ['left'] * 5),
        cells=dict(values=days,
                fill = dict(color='#F5F8FF'),
                align = ['left'] * 5),
                columnwidthsrc = "-PB - Sala sugerida: pm-4 &nbsp-PB - Sala sugerida: pm-4 &nbsp"
                )
                

    data = [trace] 

    layout = go.Layout(
        title="Turmas que não receberam salas. As turmas que possuem ; representam diferentes turmas que foram consideradas aptas a serem juntadas",
        autosize = True,
        margin=MARGIN_PLOTS,
    )
    fig = go.Figure(data=data, layout=layout)
    plot(fig, filename = 'not_scheduled')



def get_rooms_uses(rooms, schedules):
    rooms_uses = {}

    for room in rooms:
        room_use = {}
        for i in range(1,8):
            room_use[i] = {}
            for j in range(1,25):
                room_use[i][j] = None
        rooms_uses[room["code"]] = room_use

    for schedule in schedules:
        ini = schedule["ini"]
        end = schedule["end"]
        day = schedule["day"]
        course_code = schedule["code"]
        assigned = schedule["assigned"]

        for i in range(ini,end):
            if(assigned in rooms_uses.keys()):
                rooms_uses[assigned][day][i] = course_code

    return rooms_uses

if __name__ == "__main__":
    if(len(sys.argv) < 4):
        print("Fail. Use: \"python3 ensalador_plots.py rooms.yaml schedules.yaml current.yaml")
        exit()
    with open(sys.argv[1], 'r') as stream:
        rooms = yaml.load(stream)["rooms"]
    with open(sys.argv[2], 'r') as stream:
        to_schedule = yaml.load(stream)["schedules"]
    with open(sys.argv[3], 'r') as stream:
        schedules = yaml.load(stream)["schedules"]

    # Some schedules, like CELIN and Idioma sem fronteiras has no blocks
    # Then, add empty strings to its objects
    for x in to_schedule:
        if(not "block" in x):
            x["block"] = ""
    for x in schedules:
        if(not "block" in x):
            x["block"] = ""
    
    # Filter schedules by banned blocks
    schedules = [x for x in schedules if len([True for y in BANNED_SCHEDULE_BLOCKS if y in x["block"] ]) == 0 ]
    to_schedule = [x for x in to_schedule if len([True for y in BANNED_SCHEDULE_BLOCKS if y in x["block"] ]) == 0 ]

    filtered_rooms = [x for x in rooms if len([True for y in BANNED_LIST_ROOMS if y in x["code"] ]) == 0 ]
    rooms = filtered_rooms

    restrict_rooms = [r for r in rooms if "restrict" in r]
    not_restrict_rooms = [r for r in rooms if not ("restrict" in r)]

    not_schedules = [x for x in schedules if not "assigned" in x]
    schedules = [x for x in schedules if "assigned" in x]

    

    blocks_not_restricts = defaultdict(list)
    blocks = defaultdict(list)

    # Define if is filtered or any rooms
    for room in rooms:
        blocks[room["block"]].append(room["code"])
    for room in not_restrict_rooms:
        blocks_not_restricts[room["block"]].append(room["code"])

    blocks_capacities = defaultdict(lambda: 0)

    for block in blocks_not_restricts:
        blocks_capacities[block] = len(blocks_not_restricts[block])

    rooms_uses = get_rooms_uses(not_restrict_rooms,schedules)

    rooms_uses_by_time( rooms_uses )
    daily_use( rooms_uses, blocks )
    overflow_block_capacity(rooms_uses, blocks_capacities, blocks)


    plot_schedules_by_day(not_schedules)
