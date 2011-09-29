##############################
#
# Extract sounding parts from bunch of audio files
# jonas.lindh@ling.gu.se  http://www.ling.gu.se/~jonas
#
#######################################
form Looping extract_sounding
#	comment Directory of Sound Files
#	text sound_directory /mnt/win_c/alize_test/MISTRAL_formation_nic/data/sph/
#	text out_directory /mnt/win_c/alize_test/MISTRAL_formation_nic/data/sph/desilenced/
	sentence Sound_file_extension .wav
	comment Minimum dB-threshold for sounding
	real dB_value -25
	comment Min silent and sounding durations in seconds
	positive sil_min 0.1
	positive sound_dur 0.1
endform
########################
#Create Strings as file list... list 'sound_directory$'*'sound_file_extension$'
#numberOfFiles = Get number of strings
clearinfo

sampl_fr = Get sampling frequency
if sampl_fr = 16000

#for ifile to numberOfFiles
#	select Strings list
#	filename$ = Get string... ifile
#	Read from file... 'sound_directory$''filename$'
#	printline extracting sounding parts from 'filename$'
	name$ = selected$("Sound")

########################################
To TextGrid (silences)...  100 0  'dB_value' sil_min sound_dur silent sounding
plus Sound 'name$'
Extract intervals where... 1 no "is equal to" sounding
Concatenate

#######################################
select TextGrid 'name$'
Remove

select Sound chain
Rename... 'name$'_sounding
Write to WAV file... ./data/sph/'name$'.wav
select all
minus Sound 'name$'
minus Sound 'name$'_sounding
Remove
#endfor
###############
printline done... saved to ./data/sph/'name$'.wav
else
echo Sampling frequency is 'sampl_fr' Hz - needs to be 16000Hz please resample
endif