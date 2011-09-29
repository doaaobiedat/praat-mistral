##########
# Demo for LiaSpk Mistral
# Jonas Lindh 2009
# http://www.ling.gu.se/~jonas
###########
form Feature Extraction
comment Remove silence or make frame selection before you run this script
comment Audio directory
text sph_dir ./data/sph/
comment Parameter out directory
text prm_dir ./data/prm/
sentence Sound_file_extension .wav
sentence File_type pcm16
sentence SPRO_options -m -e -D -A -k 0
positive Sampling_frequency 16000
positive Nr_mfccs 19
endform


Create Strings as file list... list 'sph_dir$'*'sound_file_extension$'
numberOfFiles = Get number of strings
clearinfo
for ifile to numberOfFiles
	select Strings list
	filename$ = Get string... ifile
		file$ = filename$ - "'Sound_file_extension$'"
	printline extracting parameters from 'filename$'
system ./bin/sfbcep -F 'file_type$' -f 'sampling_frequency' -p 'nr_mfccs' 'SPRO_options$' 'sph_dir$''filename$' 'prm_dir$''file$'.prm
system ./bin/NormFeat.exe --config ./cfg/NormFeat_energy.cfg --inputFeatureFilename 'file$' --debug false --verbose true >> log/'file$'_enr_norm.log
system ./bin/NormFeat.exe --config ./cfg/NormFeat.cfg --inputFeatureFilename 'file$' >> log/'file$'_norm.log

endfor
done check prms in 'sph_dir$'
