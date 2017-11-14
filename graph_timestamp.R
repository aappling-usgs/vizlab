graph <- "
digraph G {

graph [layout = dot,
       rankdir = TB]

node [shape = box,
      style = filled,
      color = grey]

node [fillcolor = dodgerblue]
'Does file exist?'

node [fillcolor = deepskyblue]
'Have viz.yaml args changed?'

node [fillcolor = azure]
'Have `depends` changed?'

node [fillcolor = goldenrod]
'What fetchTimestamp method applies?'

node [fillcolor = gold]
'Has timetolive elapsed\nsince last timestamp check?'

node [fillcolor = yellow]
'Has source timestamp changed?'

node [shape = hexagon,
      fillcolor = limegreen]
'Fetch timestamp'

node [shape = hexagon,
      fillcolor = tomato]
'Do not fetch timestamp'

node [shape = hexagon,
      fillcolor = limegreen]
'Fetch data'

node [shape = hexagon,
      fillcolor = tomato]
'Do not fetch data'

node [shape = oval,
      fillcolor = lightgrey,
      color = grey]

edge [color = grey]

'Does file exist?' -> 'No, missing' -> 'Fetch data'
'Does file exist?' -> 'Yes, present' -> 'Have viz.yaml args changed?'
'Have viz.yaml args changed?' -> 'Yes, args changed' -> 'Fetch data'
'Have viz.yaml args changed?' -> 'No, args unchanged' -> 'Have `depends` changed?'
'Have `depends` changed?' -> 'Yes, deps changed' -> 'Fetch data'
'Have `depends` changed?' -> 'No, deps unchanged' -> 'What fetchTimestamp method applies?'
'What fetchTimestamp method applies?' -> 'alwaysCurrent (exactly)' -> 'Do not fetch timestamp'
'What fetchTimestamp method applies?' -> 'Any other method' -> 'Has timetolive elapsed\nsince last timestamp check?'
'Has timetolive elapsed\nsince last timestamp check?' -> 'No, still waiting' -> 'Do not fetch timestamp'
'Has timetolive elapsed\nsince last timestamp check?' -> 'Yes, wait is over' -> 'Fetch timestamp' -> 'Has source timestamp changed?'
'Has source timestamp changed?' -> 'Yes, timestamp has changed\n(neverCurrent or source was updated)' -> 'Fetch data'
'Has source timestamp changed?' -> 'No, timestamp is unchanged' -> 'Do not fetch data'
'Do not fetch timestamp' -> 'Do not fetch data'

{rank = same; 'No, missing'; 'Yes, present';}
{rank = same; 'Yes, args changed'; 'No, args unchanged';}
{rank = same; 'Yes, deps changed'; 'No, deps unchanged';}
{rank = same; 'Any other method'; 'alwaysCurrent (exactly)';}
{rank = same; 'Yes, wait is over'; 'No, still waiting';}
{rank = same; 'Fetch timestamp'; 'Do not fetch timestamp';}
{rank = same; 'Yes, timestamp has changed\n(neverCurrent or source was updated)'; 'No, timestamp is unchanged';}
{rank = same; 'Fetch data'; 'Do not fetch data';}

}
"
DiagrammeR::grViz(graph, width=600, height=700)

# If you want to...then...

# 
