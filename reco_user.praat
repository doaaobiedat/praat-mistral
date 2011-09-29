##########
# Demo for LiaSpk Mistral
# Jonas Lindh 2009
# http://www.ling.gu.se/~jonas
###########
clearinfo

sampl_fr = Get sampling frequency
if sampl_fr = 16000
	printline Sampling frequency is ok and 'sampl_fr' Hz
else
	printline Sampling Frequency is not 16000Hz it is 'sampl_fr' Hz , resampling...
	name1$ = selected$("Sound")
	Resample... 16000 50
	select Sound 'name1$'
		Remove
	select Sound 'name1$'_16000
	Rename... 'name1$'
endif

name$ = selected$("Sound")
filename$ = name$ + ".wav"

########################################
To TextGrid (silences)...  100 0 -25 0.1 0.1 silent sounding
select TextGrid 'name$'
	sound_labs = Count labels... 1 sounding
	if sound_labs < 1
		printline sounding parts are less then 1
	Remove
	  select Sound 'name$'
else
plus Sound 'name$'
Extract intervals where... 1 no "is equal to" sounding
Concatenate

#######################################

select Sound chain
Rename... 'name$'_sounding
Write to WAV file... ./data/sph/'name$'.wav
select all
minus Sound 'name$'
minus Sound 'name$'_sounding
Remove
select Sound 'name$'_sounding
Remove
###############
system ./bin/sfbcep -F pcm16 -f 16000 -p 19 -m -e -D -A -k 0 ./data/sph/'filename$' ./data/prm/'name$'.prm
printline ............................
printline feature extraction was successful
printline .................................
system ./bin/NormFeat.exe --config ./cfg/NormFeat_energy.cfg --inputFeatureFilename 'name$' --debug false --verbose true >> ./log/'name$'_enr_norm.log
printline ............................
printline features were energynormalised, see log here ./log/'name$'_enr_norm.log
printline .................................
system ./bin/NormFeat.exe --config ./cfg/NormFeat.cfg --inputFeatureFilename 'name$' >> ./log/'name$'_norm.log
printline ............................
printline features were normalised, see log here ./log/'name$'_norm.log
printline .................................

ndx_file$ = "./ndx/demo_test_'name$'.ndx"

if fileReadable (ndx_file$)
	filedelete 'ndx_file$'
endif

Read Strings from raw text file... ./ndx/demo.ndx
nrOfStrings = Get number of strings
printline There are 'nrOfStrings' Users in the system
for i to nrOfStrings
	string$ = Get string... i
	user$ = extractWord$ (string$, "")
#printline string is 'string$' and user is 'user$'
#pause test1

if i = 1
#printline i is 'i'
	addname$ = name$ + tab$ + user$
#printline addname is 'addname$'
#pause test2
	addname$ > 'ndx_file$'

elsif i > 1
#printline now i is 'i'
	addname$ = tab$ + user$
#printline and addname is 'addname$'
#pause test3
	addname$ >> 'ndx_file$'
endif

endfor
Remove

system ./bin/ComputeTest.exe --config ./cfg/target_seg_male_demo.cfg  --ndxFilename ./ndx/demo_test_'name$'.ndx --inputWorldFilename world_demo --outputFilename ./results/demo_test_'name$'.res>> log/demo_test_'name$'.log

printline ....................................................
printline The Result is:
resultfile$ = "./results/demo_test_'name$'.res"
if fileReadable (resultfile$)
Read Strings from raw text file... ./results/demo_test_'name$'.res
nrOfStrings = Get number of strings
for nr to nrOfStrings
	result$ = Get string... nr
	rank_'nr' = extractNumber (result$, name$)
if rank_'nr' > 0
	score = rank_'nr'
		target$ = extractWord$ (result$, "M")
	printline ..................HIGH SCORE FOR USER........................
	printline 'score' is the highest score for 'target$'
	printline .....................................................................
else
printline 'result$'
endif
endfor

Remove
select Sound 'name$'
else
printline check the logs since there was no result file 'resultfile$'
printline the logs can be found here demo_test_'name$'.log
endif
