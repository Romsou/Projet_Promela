# maxx 1
# maxx 2
# maxx 3
# maxx 4
# maxx 5
# Scaler 0.562500, MH 1066
wm title . "scenario"
wm geometry . 1120x600+650+100
canvas .c -width 800 -height 800 \
	-scrollregion {0c -1c 30c 100c} \
	-xscrollcommand ".hscroll set" \
	-yscrollcommand ".vscroll set" \
	-bg white -relief raised -bd 2
scrollbar .vscroll -relief sunken  -command ".c yview"
scrollbar .hscroll -relief sunken -orient horiz  -command ".c xview"
pack append . \
	.vscroll {right filly} \
	.hscroll {bottom fillx} \
	.c {top expand fill}
.c yview moveto 0
# ProcLine[2] stays at 0 (Used 0 nobox 0)
.c create rectangle 264 0 340 20 -fill black
# ProcLine[2] stays at 0 (Used 0 nobox 0)
.c create rectangle 263 -2 337 18 -fill ivory
.c create text 300 8 -text "1::init:"
# ProcLine[1] stays at 0 (Used 0 nobox 0)
.c create rectangle 99 0 185 20 -fill black
# ProcLine[1] stays at 0 (Used 0 nobox 0)
.c create rectangle 98 -2 182 18 -fill ivory
.c create text 140 8 -text "0:never_0"
.c create text 70 32 -fill #eef -text "1"
.c create line 140 32 940 32 -fill #eef -dash {6 4}
.c create line 140 36 140 20 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[1] from 0 to 1 (Used 1 nobox 0)
# ProcLine[1] stays at 1 (Used 1 nobox 1)
.c create rectangle 127 22 153 42 -fill white -width 0
.c create text 140 32 -text "#36"
.c create text 70 56 -fill #eef -text "3"
.c create line 140 56 940 56 -fill #eef -dash {6 4}
.c create line 300 36 300 44 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[2] from 0 to 3 (Used 1 nobox 1)
# ProcLine[2] stays at 3 (Used 1 nobox 1)
.c create rectangle 287 46 313 66 -fill white -width 0
.c create text 300 56 -text "1:M"
.c create text 70 80 -fill #eef -text "5"
.c create line 140 80 940 80 -fill #eef -dash {6 4}
.c create line 460 36 460 68 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[3] from 0 to 5 (Used 0 nobox 1)
# ProcLine[3] stays at 5 (Used 0 nobox 0)
.c create rectangle 447 70 473 90 -fill ivory
.c create text 460 80 -text "2:C"
.c create text 70 104 -fill #eef -text "7"
.c create line 140 104 940 104 -fill #eef -dash {6 4}
.c create line 620 36 620 92 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[4] from 0 to 7 (Used 0 nobox 0)
.c create rectangle 608 96 636 116 -fill black
# ProcLine[4] stays at 7 (Used 0 nobox 0)
.c create rectangle 607 94 633 114 -fill ivory
.c create text 620 104 -text "3:L"
.c create text 70 128 -fill #eef -text "9"
.c create line 140 128 940 128 -fill #eef -dash {6 4}
.c create line 780 36 780 116 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[5] from 0 to 9 (Used 0 nobox 0)
.c create rectangle 768 120 796 140 -fill black
# ProcLine[5] stays at 9 (Used 0 nobox 0)
.c create rectangle 767 118 793 138 -fill ivory
.c create text 780 128 -text "4:B"
.c create line 940 162 860 162 -fill darkblue -tags mesg -width 2
.c create line 860 162 780 162 -fill darkblue -width 2 -arrow last -arrowshape {5 5 5} -tags mesg
.c raise mesg
.c create text 70 152 -fill #eef -text "11"
.c create line 140 152 940 152 -fill #eef -dash {6 4}
.c create line 940 36 940 140 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[6] from 0 to 11 (Used 0 nobox 0)
.c create rectangle 891 144 993 164 -fill black
# ProcLine[6] stays at 11 (Used 0 nobox 0)
.c create rectangle 890 142 990 162 -fill ivory
.c create text 940 152 -text "canal!aller"
.c create text 70 176 -fill #eef -text "13"
.c create line 140 176 940 176 -fill #eef -dash {6 4}
.c create line 780 144 780 164 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[5] from 9 to 13 (Used 1 nobox 0)
# ProcLine[5] stays at 13 (Used 1 nobox 1)
.c create rectangle 730 166 830 186 -fill white -width 0
.c create text 780 176 -text "canal?aller"
.c create line 940 210 780 210 -fill darkblue -tags mesg -width 2
.c create line 780 210 620 210 -fill darkblue -width 2 -arrow last -arrowshape {5 5 5} -tags mesg
.c raise mesg
.c create text 70 200 -fill #eef -text "15"
.c create line 140 200 940 200 -fill #eef -dash {6 4}
.c create line 940 168 940 188 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[6] from 11 to 15 (Used 1 nobox 1)
# ProcLine[6] stays at 15 (Used 1 nobox 1)
.c create rectangle 890 190 990 210 -fill white -width 0
.c create text 940 200 -text "canal!aller"
.c create text 70 224 -fill #eef -text "17"
.c create line 140 224 940 224 -fill #eef -dash {6 4}
.c create line 620 120 620 212 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[4] from 7 to 17 (Used 1 nobox 1)
# ProcLine[4] stays at 17 (Used 1 nobox 1)
.c create rectangle 570 214 670 234 -fill white -width 0
.c create text 620 224 -text "canal?aller"
.c create line 940 258 860 258 -fill darkblue -tags mesg -width 2
.c create line 860 258 780 258 -fill darkblue -width 2 -arrow last -arrowshape {5 5 5} -tags mesg
.c raise mesg
.c create text 70 248 -fill #eef -text "19"
.c create line 140 248 940 248 -fill #eef -dash {6 4}
.c create line 940 216 940 236 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[6] from 15 to 19 (Used 1 nobox 1)
# ProcLine[6] stays at 19 (Used 1 nobox 1)
.c create rectangle 884 238 996 258 -fill white -width 0
.c create text 940 248 -text "canal!retour"
.c create text 70 272 -fill #eef -text "21"
.c create line 140 272 940 272 -fill #eef -dash {6 4}
.c create line 780 192 780 260 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[5] from 13 to 21 (Used 1 nobox 1)
# ProcLine[5] stays at 21 (Used 1 nobox 1)
.c create rectangle 724 262 836 282 -fill white -width 0
.c create text 780 272 -text "canal?retour"
.c create line 940 306 700 306 -fill darkblue -tags mesg -width 2
.c create line 700 306 460 306 -fill darkblue -width 2 -arrow last -arrowshape {5 5 5} -tags mesg
.c raise mesg
.c create text 70 296 -fill #eef -text "23"
.c create line 140 296 940 296 -fill #eef -dash {6 4}
.c create line 940 264 940 284 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[6] from 19 to 23 (Used 1 nobox 1)
# ProcLine[6] stays at 23 (Used 1 nobox 1)
.c create rectangle 890 286 990 306 -fill white -width 0
.c create text 940 296 -text "canal!aller"
.c create text 70 320 -fill #eef -text "25"
.c create line 140 320 940 320 -fill #eef -dash {6 4}
.c create line 460 96 460 308 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[3] from 5 to 25 (Used 1 nobox 1)
# ProcLine[3] stays at 25 (Used 1 nobox 1)
.c create rectangle 410 310 510 330 -fill white -width 0
.c create text 460 320 -text "canal?aller"
.c create line 940 354 780 354 -fill darkblue -tags mesg -width 2
.c create line 780 354 620 354 -fill darkblue -width 2 -arrow last -arrowshape {5 5 5} -tags mesg
.c raise mesg
.c create text 70 344 -fill #eef -text "27"
.c create line 140 344 940 344 -fill #eef -dash {6 4}
.c create line 940 312 940 332 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[6] from 23 to 27 (Used 1 nobox 1)
# ProcLine[6] stays at 27 (Used 1 nobox 1)
.c create rectangle 884 334 996 354 -fill white -width 0
.c create text 940 344 -text "canal!retour"
.c create text 70 368 -fill #eef -text "29"
.c create line 140 368 940 368 -fill #eef -dash {6 4}
.c create line 620 240 620 356 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[4] from 17 to 29 (Used 1 nobox 1)
# ProcLine[4] stays at 29 (Used 1 nobox 1)
.c create rectangle 564 358 676 378 -fill white -width 0
.c create text 620 368 -text "canal?retour"
.c create line 940 402 860 402 -fill darkblue -tags mesg -width 2
.c create line 860 402 780 402 -fill darkblue -width 2 -arrow last -arrowshape {5 5 5} -tags mesg
.c raise mesg
.c create text 70 392 -fill #eef -text "31"
.c create line 140 392 940 392 -fill #eef -dash {6 4}
.c create line 940 360 940 380 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[6] from 27 to 31 (Used 1 nobox 1)
# ProcLine[6] stays at 31 (Used 1 nobox 1)
.c create rectangle 890 382 990 402 -fill white -width 0
.c create text 940 392 -text "canal!aller"
.c create text 70 416 -fill #eef -text "33"
.c create line 140 416 940 416 -fill #eef -dash {6 4}
.c create line 780 288 780 404 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[5] from 21 to 33 (Used 1 nobox 1)
# ProcLine[5] stays at 33 (Used 1 nobox 1)
.c create rectangle 730 406 830 426 -fill white -width 0
.c create text 780 416 -text "canal?aller"
.c create line 940 450 780 450 -fill darkblue -tags mesg -width 2
.c create line 780 450 620 450 -fill darkblue -width 2 -arrow last -arrowshape {5 5 5} -tags mesg
.c raise mesg
.c create text 70 440 -fill #eef -text "35"
.c create line 140 440 940 440 -fill #eef -dash {6 4}
.c create line 940 408 940 428 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[6] from 31 to 35 (Used 1 nobox 1)
# ProcLine[6] stays at 35 (Used 1 nobox 1)
.c create rectangle 890 430 990 450 -fill white -width 0
.c create text 940 440 -text "canal!aller"
.c create text 70 464 -fill #eef -text "37"
.c create line 140 464 940 464 -fill #eef -dash {6 4}
.c create line 620 384 620 452 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[4] from 29 to 37 (Used 1 nobox 1)
# ProcLine[4] stays at 37 (Used 1 nobox 1)
.c create rectangle 570 454 670 474 -fill white -width 0
.c create text 620 464 -text "canal?aller"
.c create text 70 488 -fill #eef -text "39"
.c create line 140 488 940 488 -fill #eef -dash {6 4}
.c create line 140 48 140 476 -fill lightgrey -tags grid -width 1 
.c lower grid
# ProcLine[1] from 1 to 39 (Used 1 nobox 1)
# ProcLine[1] stays at 39 (Used 1 nobox 1)
.c create rectangle 127 478 153 498 -fill white -width 0
.c create text 140 488 -text "#35"
.c lower grid
.c raise mesg
