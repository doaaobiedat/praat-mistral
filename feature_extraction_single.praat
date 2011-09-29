##########
# Demo for LiaSpk Mistral
# Jonas Lindh 2009
# http://www.ling.gu.se/~jonas
###########

form New User Demo
comment New UserName
text new_user UserName
comment Audio directory
text sph_dir ./data/sph/
comment Parameter out directory
text prm_dir ./data/prm/
sentence Sound_file_extension .wav
sentence File_type pcm16
sentence SPRO_options -m -e -D -A -k 0
positive Sampling_frequency 16000
positive Nr_mfccs 19
comment Minimum dB-threshold for sounding
real dB_value -25
comment Min silent and sounding durations in seconds
positive sil_min 0.1
positive sound_dur 0.1
endform

clearinfo

sampl_fr = Get sampling frequency
if sampl_fr > 16000
printline Sampling Frequency is not 16000Hz it is 'sampl_fr' Hz, resampling audio...
Resample... 16000 50
else
printline Sampling Frequency is presumably 16000Hz it is 'sampl_fr' Hz
endif
Rename...  'new_user$'

name$ = selected$("Sound")
filename$ = name$ + ".wav"

########################################
To TextGrid (silences)...  100 0  'dB_value' sil_min sound_dur silent sounding
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
###############
ndx_file$ = "./ndx/demo.ndx"
ndx_new_users$ = "./ndx/new_users.ndx"
if fileReadable (ndx_file$)
	addname$ = newline$ + name$ + tab$ + name$
	addname$ >> 'ndx_file$'
else
	addname$ = name$ + tab$ + name$
	addname$ > 'ndx_file$'
endif
if fileReadable (ndx_new_users$)
	addname$ = newline$ + name$ + tab$ + name$
	addname$ >> 'ndx_new_users$'
else
	addname$ = name$ + tab$ + name$
	addname$ > 'ndx_new_users$'
endif

world_file$ = "./lst/world_demolist.lst"
	addworldname$ = newline$ + name$
	addworldname$ >> 'world_file$'

printline done... saved to ./data/sph/'name$'.wav
printline extracting and normalising parameters from 'filename$'

system ./bin/sfbcep -F 'file_type$' -f 'sampling_frequency' -p 'nr_mfccs' 'SPRO_options$' 'sph_dir$''filename$' 'prm_dir$''name$'.prm
system ./bin/NormFeat.exe --config ./cfg/NormFeat_energy.cfg --inputFeatureFilename 'name$' --debug false --verbose true >> log/'name$'_enr_norm.log
system ./bin/NormFeat.exe --config ./cfg/NormFeat.cfg --inputFeatureFilename 'name$' >> log/'name$'_norm.log

printline done check prm in 'sph_dir$'
printline 'nr_mfccs' mfccs were extracted and normalised for 'name$'
