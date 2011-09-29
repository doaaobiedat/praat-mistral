##########
# Demo for LiaSpk Mistral
# Jonas Lindh 2009
# http://www.ling.gu.se/~jonas
###########
stopwatch
clearinfo
world_file$ = "./lst/world_demolist.lst"

Read Strings from raw text file... 'world_file$'
nrOfStrings = Get number of strings
if nrOfStrings < 2
  exit Less than 2 speakers to build world model
else
printline Training demo world... with 'nrOfStrings' speakers:

for nr to nrOfStrings
	result$ = Get string... nr
	printline 'result$'
endfor
Remove

system ./bin/TrainWorld.exe --config ./cfg/TrainWorldInit.cfg --inputStreamList ./lst/world_demo.lst --weightStreamList ./lst/world.weight --outputWorldFilename world_init_demo >> log/world_init_demo.log
printline .......................................................
time = stopwatch

printline Initial world model is trained... that took 'time:3' secs

system ./bin/TrainWorld.exe --config ./cfg/TrainWorldFinal.cfg --inputStreamList ./lst/world_demo.lst --weightStreamList ./lst/world.weight  --outputWorldFilename world_demo --inputWorldFilename world_init_demo >> log/world_demo_final.log
printline .......................................................
time2 = stopwatch
time3 = time + time2
mins = time3/60
hours = mins/60
printline World model is trained and ready to be used...that took 'time2:3' sec
printline .....................................
printline ...all together training took 'time3:3' sec and 'mins' min, 'hours' ours
endif