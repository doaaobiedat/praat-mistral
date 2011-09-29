# LiaSpkDet Demo for Praat
# Copyright @2008 Jonas Lindh, University of Gothenburg, Sweden
#
# http://www.ling.gu.se/~jonas
# jonas@ling.gu.se
#

Add menu command... "Objects" "Praat" "LiaSpkDet_Demo" "" 0 
Add menu command... "Objects" "Praat" "LiaSpkDet_Feature_extraction" "LiaSpkDet_Demo" 1 feature_extraction.praat
Add menu command... "Objects" "Praat" "Train World" "Train World Model" 1 train_world.praat
Add menu command... "Objects" "Praat" "Train Users" "Train Users" 1 train_users.praat


Add action command... Sound 0 "" 0 "" 0 "SpeakerIDemo -" "Analyse" 0
Add action command... Sound 1 "" 0 "" 0 "Recognize User" "SpeakerIDemo -" 1 reco_user.praat
Add action command... Sound 1 "" 0 "" 0 "Train Users" "SpeakerIDemo -" 1 train_world.praat
Add action command... Sound 1 "" 0 "" 0 "Train Users" "SpeakerIDemo -" 1 train_users.praat
Add action command... Sound 1 "" 0 "" 0 "New User" "SpeakerIDemo -" 1 feature_extraction_single.praat


