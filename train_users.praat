##########
# Demo for LiaSpk Mistral
# Jonas Lindh 2009
# http://www.ling.gu.se/~jonas
###########
clearinfo
Read Strings from raw text file... ./ndx/new_users.ndx
stopwatch
nrOfStrings = Get number of strings
if nrOfStrings < 1
echo No new users to train...
else
for i to nrOfStrings
	string$ = Get string... i
		word$ = extractWord$ (string$, "")
if word$ = ""
else
			printline Training user 'word$'
endif
endfor
Remove

system ./bin/TrainTarget.exe --config ./cfg/target_male_demo.cfg --targetIdList ./ndx/new_users.ndx --inputWorldFilename world_demo >> log/demo_training.log
time = stopwatch
system rm ./ndx/new_users.ndx
printline Training for users above is done... it took 'time' secs to train
endif