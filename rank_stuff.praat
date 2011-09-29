
name$ = "joel_test_1"
clearinfo
nrOfStrings = Get number of strings
for nr to nrOfStrings
xx=nr-1
	result$ = Get string... nr
	rank_'nr' = extractNumber (result$, name$)
if rank_'nr' > 0
	score = rank_'nr'
		target$ = extractWord$ (result$, "M")
	printline ..................SCORE FOR USER........................
	printline 'score' is the highest score for 'target$'
	printline .....................................................................
endif
	printline 'result$'
endfor

	