!                          1 REM KEY OFF:CLS:INPUT "ENTER RUN NUMBER (Ex: R1 ) ";RNN$
!  + common3               2 DIM NTS(10),TSMULT(10),PERLEN(10)
!  + aug4                  3 READ RNN$
!  + aug4                  4 DATA "R1"
!                          10 REM ************************** AUG2 *******************************************
!                          15 CLS
!                          20 ON ERROR GOTO 4000
!  + tape74setup           25 OPEN "I",#1,"TAPE74.DAT"
!  + tape74setup           26 CLOSE#1:
!  + tape74setup           27 PRINT "MODEL OUTPUT (TAPE74.DAT) HAS NOT BEEN RENAMED WITH RUN NUMBER"
!  + tape74setup           28 INPUT "ENTER RUN NUMBER TO BE USED TO RENAME TAPE74.DAT  ";RNRN$
!  + tape74setup           29 NAME "TAPE74.DAT" AS "TAPE74."+RNRN$
!  + common3               40 COMMON NTS(), TSMULT(), PERLEN(),NSP,SHORT$,DD1$,AQNAM$,RN$,OSELECT,RNN$
!  + readjunkfile          50 OPEN "I",#1,"C:\AUG3\JUNK."+RNN$
!  + readjunkfile          60 INPUT#1,NSP
!  + readjunkfile          70 LINE INPUT#1,SHORT$
!  + readjunkfile          80 LINE INPUT#1,DD1$
!  + readjunkfile          85 LINE INPUT#1,RN$
!  + readjunkfile          90 FOR X=1 TO NSP
!  + readjunkfile          100 INPUT#1,NTS(X),TSMULT(X),PERLEN(X)
!  + readjunkfile          110 NEXT X
!  + readjunkfile          120 CLOSE#1
!  + readjunkfile          121 IF RN$<>RNN$ THEN GOSUB 5000:GOTO 50
!  + readjunkfile          130 RESTORE 1100
!  + readjunkfile          140 READ AQNAM$,TEST$
!  + readjunkfile          150 IF TEST$<>MID$(SHORT$,1,2) THEN GOTO 140
!  + aug4                  230 CLS
!  + aug4                  240 REM PRINT "SELECT OPTION:";TAB(2);"1) CODE TAPE9.DAT (WELL LIST)";TAB(2);"2) PRINT REPORT";TAB(2);"3) PLOT GRID MAP";TAB(2);"4) PLOT GRID MAP WITH WELL LOCATION(S)";TAB(2);"5) PLOT STREAM DEPLETIONS";TAB(2);"6) STOP"
!  + aug4                  241 PRINT "SELECT OPTION:";TAB(2);"1) CODE TAPE9.DAT (WELL LIST)";TAB(2);"6) STOP"
!  + aug4                  250 INPUT "       enter appropriate line number  ";OSELECT
!  + aug4                  260 IF OSELECT=6 THEN SYSTEM
!  + aug4                  261 IF OSELECT=1 THEN GOTO 280
!  + aug4                  262 IF OSELECT=2 THEN GOTO 800
!  + aug4                  263 IF OSELECT=3 OR OSELECT=4 THEN CHAIN "C:AUG3MOD1.BAS"
!  + aug4                  264 IF OSELECT=5 THEN CHAIN "C:AUG3MOD2.BAS"
!  + aug4                  270 GOTO 50

!  + createtape9           280 REM        ASSEMBLE WELL PKG. ON TAPE9.DAT
!  + createtape9           290 REM ***********************************************************************
!  + createtape9           300 CLS
!  + createtape9           310 RESTORE 330
!  + createtape9           320 READ TN$,NA$,A1$,A2$
!  + createtape9           330 DATA "9","WELL","  YIELD (gpm)"," + for pumping     WELL LOCATION"
!  + createtape9           340 REM PRINT "SELECT UNITS FOR WELL YIELD:";TAB(2);"1) gpm";TAB(2);"2) cfs";TAB(2);"3) acre-feet/year"
!  + createtape9           350 REM INPUT "         enter appropriate line number    ";QSELECT
!  + createtape9           351 QSELECT=3
!  + createtape9           360 IF QSELECT=1 THEN FAC=-1/448
!  + createtape9           370 IF QSELECT=2 THEN FAC=-1:A1$="  YIELD (cfs)"
!  + createtape9           380 IF QSELECT=3 THEN FAC=-(5280^2)/(640*1440*60*365.25):A1$="YIELD (af/yr)"
!  + createtape9           400 RESTORE 2480
!  + createtape9           410 READ A$,TNR
!  + createtape9           420 FOR X=1 TO TNR
!  + createtape9           430 READ B$
!  + createtape9           440 NEXT X
!  + createtape9           450 READ IMIN,JMIN,NROW,NCOL
!  + createtape9           460 IF A$<>SHORT$ GOTO 410
!  + createtape9           470 A2$="  #   LAY     ROW       COL   "+A2$
!  + createtape9           480 NAM$="TAPE"+TN$+".DAT"
!  + createtape9           510 NAM$=DD1$+NAM$
!  + createtape9           520 OPEN "O",#1,NAM$
!  + createtape9           540 NUT$="N"
!  + createtape9           550 ICB=0
!  + createtape9           560 IF NUT$="Y" THEN ICB=-1
!  + createtape9           570 PRINT "ENTER MAX. NUMBER OF ";NA$;"'S   ";
!  + createtape9           580 INPUT "",MX
!  + createtape9           590 PRINT#1,USING"##########";MX;ICB
!  + createtape9           610 FOR XY=1 TO NSP
!  + createtape9           620 PRINT "ENTER NUMBER OF ";NA$;"'S FOR STRESS PERIOD #";XY:PRINT
!  + createtape9           630 INPUT "",ITMP
!  + createtape9           640 PRINT#1,USING"##########";ITMP
!  + createtape9           650 CLS
!  + createtape9           660 PRINT "WELL  ";A1$;"     LOCATION (Ex:  5,3N,64)"
!  + createtape9           670 FOR K=1 TO ITMP
!  + createtape9           680 PRINT K;TAB(10);
!  + createtape9           690 INPUT ;"",Q
!  + createtape9           700 PRINT TAB(25);
!  + createtape9           710 INPUT "";SCTN,TWP$,RNG
!  + createtape9           720 GOSUB 3270
!  + createtape9           730 I=I-IMIN+1
!  + createtape9           740 J=J-JMIN+1
!  + createtape9           741 PRINT I;" and"J;" has been selected for Row Number and Column Number"
!  + createtape9           742 PRINT 
!  + createtape9           750 PRINT#1,USING"##########";1;I;J;:PRINT#1,USING"###.######";Q*FAC;:PRINT#1,TAB(51);"SEC";SCTN;"T";TWP$;" R";MID$(STR$(RNG),2);"W"
!  + createtape9           760 NEXT K
!  + createtape9           770 NEXT XY
!  + createtape9           780 CLOSE#1
!  + createtape9           781 OPEN "I",#1,"TAPE9.DAT":OPEN "O",#2,"TAPE9."+RN$
!  + createtape9           782 LINE INPUT#1,A$
!  + createtape9           783 PRINT#2,A$
!  + createtape9           784 GOTO 782
!  + createtape9           790 GOTO 230

!                          800 DIM DELT(201)
!                          810 WIDTH "LPT1:",230
!                          820 LPRINT CHR$(15);
!                          830 LINE INPUT "ENTER APPLICANTS NAME  ";APPLI$
!                          840 INPUT "DO YOU WANT TO PRINT TO WIDE(W) OR NARROW(N) PAPER (N or W)";NUT$
!                          850 IF NUT$="W" OR NUT$="w" THEN IWIDE=18:WIDTH "LPT1:",220 ELSE IWIDE=9:WIDTH "LPT1:",130
!                          860 DEFINT R
!                          870 LPRINT CHR$(27);"N";CHR$(6);
!                          890 FOR X=1 TO NSP
!                          900 CLS
!                          920 NTS=NTS(X)
!                          930 TMULT=TSMULT(X)
!                          940 PERLEN=PERLEN(X)
!                          950 DELT(TN+1)=PERLEN*(1-TMULT)/(1-TMULT^NTS)
!                          960 FOR J=2 TO NTS
!                          970 DELT(TN+J)=DELT(TN+J-1)*TMULT
!                          980 NEXT J
!                          990 TN=TN+NTS
!                          1000 NEXT X
!                          1010 NTS=TN
!                          REM                                           NUMBER OF TIME STEPS
!                          1100 DATA "LARAMIE-FOX HILLS","LF","LOWER ARAPAHOE","LA","UPPER ARAPAHOE","AR","DENVER","DE","LOWER DAWSON","LD","UPPER DAWSON","DA","UPPER DAWSON","CW"
!                          1230 RESTORE 2480
!                          1240 READ A$,TNR
!                          1250 IF A$<>SHORT$ THEN FOR X=1 TO TNR:READ A$:NEXT X:READ JUNK,JUNK,JUNK,JUNK:GOTO 1240
!                          1260 DIM T(NTS),QR(NTS),QS(NTS),QSS(NTS,TNR),SUMQSS(NTS,TNR),SUMQW(NTS),SUMQS(NTS),QW(NTS)
!                          1270 FOR X=1 TO NTS::SUM=SUM+DELT(X):T(X)=SUM:NEXT X
!                          1280 REM PRINT:FOR X=1 TO NTS:PRINT T(X);:NEXT X
!                          1290 CLS:PRINT "OUTPUT IS BEING WRITTEN TO A FILE NAMED ";RN$;".PRN":PRINT "PLEASE WAIT......"
!                          1300 NAM$=DD1$+"TAPE9."+RNN$
!                          1301 OUTNAM$=RN$+".PRN"
!                          1302 OPEN "O",#3,OUTNAM$
!                          1310 OPEN "I",#2,NAM$
!                          1320 LINE INPUT#2,A$
!                          1330 LINE INPUT#2,A$
!                          1340 NWEL=VAL(A$)
!                          1360 NAM$=DD1$+"TAPE74."+RN$
!                          1370 OPEN "I",#1,NAM$
!                          1380 FOR XX=1 TO NWEL
!                          1390 LINE INPUT#2,A$
!                          1394 IF XXFLAG=1 GOTO 1410
!                          1395 IF LEN(WL$)>230 THEN WL$=STR$(NWEL)+" WELLS":XXFLAG=1:GOTO 1410
!                          1400 IF XX=1 THEN WL$=MID$(A$,51) ELSE WL$=WL$+",  "+MID$(A$,51)
!                          1410 NEXT XX
!                          1420 CLOSE#2
!                          1430 NWEL=1
!                          1440 FOR XX=1 TO (NWEL+1)
!                          1450 IF NWEL=1 AND XX=2 THEN GOTO 2450
!                          1460 FOR X=1 TO NTS
!                          REM    ***********************  START LOOP FOR EACH TIME STEP
!                          1470 LINE INPUT#1,A$
!                          1480 QW(X)=VAL(A$)
!                          1490 IF X=1 THEN QNOM=QW(X):QNOMT=QNOMT+QNOM
!                          1500 FOR K=1 TO TNR
!                          1510 INPUT#1,QSS(X,K)
!                          1520 NEXT K
!                          1530 LINE INPUT#1,A$
!                          1540 QS(X)=VAL(A$)
!                          1550 NEXT X
!                          1560 IF XX=(NWEL+1) THEN PRINT#3, "   ALL WELLS PUMPED SIMULTANEOUSLY"
!                          1570 IF FLG3=1 THEN PRINT#3, "  WELL LOCATION:   ";WL$
!                          1580 IF FLG3=1 AND XX=NWEL THEN PRINT#3,:PRINT#3,:PRINT#3,:PRINT#3,:
!                          1590 IF FLG3=1 GOTO 1640
!                          1600 PRINT#3, "     DISTRIBUTION OF REPLACEMENT WATER"
!                          1610 PRINT#3,
!                          1620 PRINT#3, "MODEL: ";AQNAM$;" WINDOW # ";MID$(SHORT$,3);"     RUN No.: ";RN$;"       DATE: ";DATE$
!                          1630 PRINT#3, "APPLICANT: ";APPLI$;"      WELL LOCATION(S): ";WL$
!                          1640 FACT=640*60*1440*365.25/(5280^2)
!                          1650 B$="    vol. this time step (af)":B=40:C=(220-B)/10
!                          1660 C$="    cumulative volume (af)"
!                          1670 CC$="                   q/Q (%)"
!                          1680 IF FLG3=1 GOTO 1820
!                          1690 PRINT#3,:PRINT#3, "TIME (years)";TAB(B);
!                          1700 FOR Y=1 TO NTS
!                          1710 PRINT#3, USING"########.#";T(Y);
!                          1720 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          1730 NEXT Y
!                          1740 PRINT#3, TAB(1);"TIME STEP LENGTH (years)";TAB(B);
!                          1750 FOR Y=1 TO NTS
!                          1760 PRINT#3, USING"########.#";DELT(Y);
!                          1770 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          1780 NEXT Y
!                          1790 D$="------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
!                          1800 PRINT#3, TAB(1);TAB(B);D$;
!                          1810 PRINT#3, TAB(1);"PUMPING (cfs)";TAB(B);
!                          1820 FOR Y=1 TO NTS
!                          1830 IF FLG3=1 GOTO 1850
!                          1840 PRINT#3, USING"######.###";QW(Y);
!                          1850 SUMQW(Y)=SUMQW(Y)+QW(Y)
!                          1860 IF FLG3=1 GOTO 1880
!                          1870 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          1880 NEXT Y
!                          1890 IF FLG3=1 GOTO 2030
!                          1900 SUM=0:PRINT#3, TAB(1);B$;TAB(B);
!                          1910 FOR Y=1 TO NTS
!                          1920 PRINT#3, USING "#######.##";QW(Y)*FACT*DELT(Y);
!                          1930 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          1940 NEXT Y
!                          1950 PRINT#3, TAB(1);C$;TAB(B);
!                          1960 FOR Y=1 TO NTS
!                          1970 SUM=SUM+FACT*QW(Y)*DELT(Y)
!                          1980 PRINT#3, USING"########.#";SUM;
!                          1990 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          2000 NEXT Y
!                          2010 PRINT#3, TAB(1);TAB(B);D$;
!                          2020 PRINT#3, TAB(1);"STREAM SEGMENT DEPLETION"
!                          2030 FOR Z=1 TO TNR
!                          2040 IF FLG3=1 GOTO 2060
!                          2050 READ A$:A$="  "+A$+" (cfs)"
!                          2060 GOSUB 3000
!                          2070 NEXT Z
!                          2080 IF FLG3=1 GOTO 2110
!                          2090 PRINT#3, TAB(1);TAB(B);D$;
!                          2100 PRINT#3, TAB(1);"TOTAL STREAM DEPLETION (cfs)";TAB(B);
!                          2110 FOR Y=1 TO NTS
!                          2120 IF FLG3=1 GOTO 2140
!                          2130 PRINT#3, USING"##.#######";QS(Y);
!                          2140 SUMQS(Y)=SUMQS(Y)+QS(Y)
!                          2150 IF FLG3=1 GOTO 2170
!                          2160 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          2170 NEXT Y
!                          2180 IF FLG3=1 GOTO 2360
!                          2190 PRINT#3, TAB(1);CC$;TAB(B);
!                          2200 FOR Y=1 TO NTS
!                          2210 PRINT#3, USING "######.###";QS(Y)*100/QNOM;
!                          2220 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          2230 NEXT Y
!                          2240 PRINT#3, TAB(1);B$;TAB(B);
!                          2250 FOR Y=1 TO NTS
!                          2260 PRINT#3, USING"#####.####";QS(Y)*DELT(Y)*FACT;
!                          2270 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          2280 NEXT Y
!                          2290 PRINT#3, TAB(1);C$;TAB(B);
!                          2300 SUM=0
!                          2310 FOR Y=1 TO NTS
!                          2320 SUM=SUM+QS(Y)*DELT(Y)*FACT
!                          2330 PRINT#3, USING"#####.####";SUM;
!                          2340 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          2350 NEXT Y
!                          2360 REM IF XX<>NWEL GOTO 2650
!                          2370 FLG=1:FLG3=0
!                          2380 FOR X=1 TO NTS
!                          2390 FOR Y=1 TO TNR
!                          2400 QSS(X,Y)=SUMQSS(X,Y)
!                          2410 NEXT Y
!                          2420 QW(X)=SUMQW(X)
!                          2430 QS(X)=SUMQS(X)
!                          2440 NEXT X
!                          2450 NEXT XX
!                          2460 CLOSE#1:CLOSE#2:CLOSE#3
!                          2461 CLS:PRINT OUTNAM$;" HAS BEEN WRITTEN TO THE C: DRIVE."
!                          2462 INPUT "DO YOU WANT TO PRINT IT NOW (Y/N) ";NUT$
!                          2463 IF NUT$="Y" OR NUT$="y" THEN OPEN "I",#3,OUTNAM$ ELSE GOTO 230
!                          2464 LINE INPUT#3,A$
!                          2465 LPRINT A$
!                          2466 GOTO 2464
!                          2470 GOTO 230

!  + aug4                  2480 DATA "AR9",7,MONUMENT,KETTLE,COTTONWOOD,SHOOKS RUN,SAND,JIMMY CAMP,BLACK SQUIRREL,78,17,37,36
!  + aug4                  2490 DATA DE8,14,WEST PLUM,PLUM,LITTLE DRY,PLATTE,BEAR,CLEAR CREEK,CHERRY CREEK,SAND CREEK,1st CREEK,2nd CREEK,3rd CREEK,BEEBE SEEP,BOX ELDER,KIOWA,29,2,60,40
!  + aug4                  2495 DATA DE11,14,WEST PLUM,PLUM,LITTLE DRY,PLATTE,BEAR,CLEAR CREEK,CHERRY CREEK,SAND CREEK,1st CREEK,2nd CREEK,3rd CREEK,BEEBE SEEP,BOX ELDER,KIOWA,29,2,60,40
!  + aug4                  2500 DATA LD2,8,PLUM,LITTLE DRY,CHERRY CREEK,COAL CREEK,RUNNING CREEK,KIOWA,WOLF,COMANCHE,54,13,49,36
!  + aug4                  2510 DATA DE9,7,SAND CREEK,1st CREEK,3rd CREEK,BOX ELDER,LOST CREEK,KIOWA COMANCHE & WOLF,BIJOU,30,30,59,31
!  + aug4                  2520 DATA DE10,9,BIJOU,BIG SANDY,MONUMENT,COTTONWOOD,SHOOKS RUN,SAND CREEK,BLACK SQUIRREL,STEELS FORK,HORSE CREEK,77,15,33,48
!  + aug4                  2530 DATA CW1,10,MONUMENT,EAST PLUM - w,EAST PLUM - e,WEST CHERRY,EAST CHERRY,CHERRY,KIOWA,KETTLE,SAND,BIG SANDY,51,16,49,36
!  + aug4                  2540 DATA LA1,4,BIG DRY,S. PLATTE,BEEBE & BOX ELDER,LOST CREEK,19,2,25,47
!  + aug4                  2550 DATA LD3,8,PLUM,LITTLE DRY,CHERRY CREEK,COAL CREEK,RUNNING CREEK,KIOWA,WOLF,COMANCHE,54,13,49,36
!  + aug4                  2560 DATA AR1,7,JARRE,PLUM,BEAR,S. PLATTE,BEEBE,BOX ELDER,LOST CREEK,20,2,55,45
!  + aug4                  2570 DATA LF8,10,W. MONUMENT,DOUGLAS,MONUMENT,SHOOKS RUN,SAND,JIMMY CAMP,WILLIAMS,CHICO,BLACK SQUIRREL,POND,90,18,30,41
!  + aug4                  2580 DATA DA1,5,EAST PLUM,COAL CREEK,KIOWA CREEK,CHERRY CREEK,RUNNING CREEK,58,16,30,29
!  + aug4                  2590 DATA DA2,11,MONUMENT,EAST PLUM - w,EAST PLUM - e,WEST CHERRY,EAST CHERRY,CHERRY,KIOWA,KETTLE,SAND,BIG SANDY,BLACK SQUIRREL,78,17,25,30
!  + aug4                  2591 DATA "LF4",3,"BEAR","PLATTE","WEST PLUM",54,6,40,40
!  + aug4                  2592 DATA "LF6",4,"PLATTE","BOULDER CREEK","CLEAR CREEK","BEAR CREEK",1,1,57,28
!  + aug4                  2593 DATA "LF1",4,"PLATTE","BOULDER CREEK","BOX ELDER","KIOWA-BIJOU",1,11,60,40
!  + aug4                  2594 DATA "AR3",8,"MONUMENT","KETTLE","COTTONWOOD","SHOOKS RUN","SAND","JIMMY CAMP","BLACK SQUIRREL","WEST PLUM",60,9,55,38
!  + aug4                  2595 DATA "AR4",8,"SAND","JIMMY CAMP","BLACK SQUIRREL","POND","STEELS FORK","HORSE CREEK","RUSH CREEK","BIG SANDY",72,29,43,45
!  + aug4                  2596 DATA "AR2",5,"BEEBE","BOX ELDER","LOST CREEK","KIOWA COMANCHE WOLF","BIJOU",20,29,58,41
!  + aug4                  2600 DATA "LF2",2,"KIOWA-BIJOU","SAN ARROYO",18,47,34,34
!  + aug4                  2610 DATA "LF3",8,"POND","STEELS FORK","HORSE","RUSH","BIG SANDY","LITTLE HORSE","ADOBE","MUSTANG",60,50,60,35
!  + aug4                  2611 DATA "AR10",8,"MONUMENT","KETTLE","COTTONWOOD","SHOOKS RUN","SAND","JIMMY CAMP","BLACK SQUIRREL","WEST PLUM",60,9,55,38
!  + aug4                  2620 'DATA
!  + aug4                  2630 'DATA
!  + aug4                  2640 'DATA
!  + aug4                  2650 DATA END
!
!                          3000 ' ********* SUB TO PRINT STREAM SEG. DEPLETION ****************
!                          3010 IF FLG3=1 GOTO 3030
!                          3020 PRINT#3, TAB(1);A$;TAB(B);
!                          3030 FOR Y=1 TO NTS
!                          3040 IF FLG3=1 GOTO 3070
!                          3050 PRINT#3, USING"##.#######";QSS(Y,Z);
!                          3060 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          3070 SUMQSS(Y,Z)=SUMQSS(Y,Z)+QSS(Y,Z)
!                          3080 NEXT Y
!                          3090 IF FLG3=1 THEN RETURN
!                          3100 PRINT#3, TAB(1);CC$;TAB(B);
!                          3110 FOR Y=1 TO NTS
!                          3120 PRINT#3, USING"######.###";QSS(Y,Z)*100/QNOM;
!                          3130 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          3140 NEXT Y
!                          3150 PRINT#3, TAB(1);B$;TAB(B);
!                          3160 FOR Y=1 TO NTS
!                          3170 PRINT#3, USING"#####.####";QSS(Y,Z)*DELT(Y)*FACT;
!                          3180 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          3190 NEXT Y
!                          3200 PRINT#3, TAB(1);C$;TAB(B);:SUM=0
!                          3210 FOR Y=1 TO NTS
!                          3220 SUM=SUM+QSS(Y,Z)*DELT(Y)*FACT
!                          3230 PRINT#3, USING"#####.####";SUM;
!                          3240 IF (Y MOD IWIDE)=0 THEN PRINT#3, TAB(B);
!                          3250 NEXT Y
!                          3260 RETURN
!
!  + checkwelllocation     3270 REM   SUB TO GET LF COORDINATES FROM SEC.,T, and R (RETURNS I,J FROM SCTN,TWP$,RNG) (OTHER VARIABLES USED=AJ,NSI$,L,X)
!  + checkwelllocation     3280 J=(70-RNG)*6-2
!  + checkwelllocation     3290 RESTORE 3340
!  + checkwelllocation     3300 FOR X=1 TO SCTN
!  + checkwelllocation     3310 READ AJ
!  + checkwelllocation     3320 NEXT X
!  + checkwelllocation     3330 J=J+AJ
!  + checkwelllocation     3340 DATA 6,5,4,3,2,1,1,2,3,4,5,6,6,5,4,3,2,1,1,2,3,4,5,6,6,5,4,3,2,1,1,2,3,4,5,6
!  + checkwelllocation     3350 L=LEN(TWP$)
!  + checkwelllocation     3360 NSI$=MID$(TWP$,L)
!  + checkwelllocation     3370 I=VAL(MID$(TWP$,1,(L-1)))
!  + checkwelllocation     3380 IF NSI$="N" GOTO 3450
!  + checkwelllocation     3390 IF NSI$="n" GOTO 3450
!  + checkwelllocation     3400 IF NSI$="S" GOTO 3430
!  + checkwelllocation     3410 IF NSI$="s" GOTO 3430
!  + checkwelllocation     3420 GOTO 3530
!  + checkwelllocation     3430 I=I*6+24+INT(SCTN/6-.05)
!  + checkwelllocation     3440 GOTO 3460
!  + checkwelllocation     3450 I=(5-I)*6+INT(SCTN/6-.05)
!  + checkwelllocation     3460 IF I<1 GOTO 3520
!  + checkwelllocation     3470 IF I>120 GOTO 3520
!  + checkwelllocation     3480 IF J<1 GOTO 3520
!  + checkwelllocation     3490 IF J>84 GOTO 3520
!  + checkwelllocation     3500 CODE%=(I-1)*84+J
!  + checkwelllocation     3510 RETURN
!  + checkwelllocation     3520 CLS
!  + checkwelllocation     3530 PRINT "YOU HAVE SELECTED A LOCATION (";SCTN;TWP$;RNG;") OUTSIDE THE BASIN.  TRY AGAIN!!":END
!  + checkwelllocation     3540 INPUT "INPUT SECTION, TOWNSHIP, and RANGE                                              (example: Sec. 4, T.2N., R.63W. would be input as 4,2N,63 )     ";SCTN,TWP$,RNG
!  + checkwelllocation     3550 GOTO 3280
!  + checkwelllocation     3560 RETURN
!
!                          4000 REM **************** ERROR TRAP ***************
!                          4004 IF ERL=810 OR ERL=820 THEN RESUME 830
!  + tape74setup           4005 IF ERL=25 THEN RESUME 40
!                          4006 IF ERL=870 THEN RESUME 890
!  + readjunkfile          4010 IF ERL=50 THEN GOSUB 5000:RESUME 50
!                          4011 IF ERL=1370 THEN NAM2$=DD1$+"TAPE74.DAT":NAME NAM2$ AS NAM$:RESUME 1370
!                          4012 IF ERL=2464 THEN CLOSE#3:RESUME 2470
!  + createtape9           4013 IF ERL=782 THEN CLOSE#1:CLOSE#2:RESUME 790
!                          4020 CLS:BEEP:PRINT "ERROR OCCURED AT LINE";ERL;"IN AUG3.BAS":SYSTEM:END
!
!  + createjunkfile        5000 REM  *************** CREATE COMMON VARIABLES AND WRITE TO JUNK.DAT *******
!  + selectstressperiods   5001 CLS:PRINT "FILES RESIDENT ON THE APPOLO ARE CONFIGURED AS FOLLOWS WITH RESPECT TO TIME:"
!  + selectstressperiods   5002 PRINT
!  + selectstressperiods   5003 PRINT "STRESS PERIOD   No. OF TIME STEPS   TSMULT   LENGTH (years)"
!  + selectstressperiods   5004 PRINT "-------------   -----------------   ------   --------------"
!  + selectstressperiods   5005 PRINT "     1                 20            1.01         100"
!  + selectstressperiods   5006 PRINT "     2                 60            1.01         300"
!  + selectstressperiods   5007 PRINT
!  + selectstressperiods   5008 PRINT "If you wish to simulate 2 stress periods as described above, press RETURN only  otherwise enter the number of stress periods to be simulated  ";
!  + selectstressperiods   5009 INPUT "";NSP$
!                          5010 REM INPUT "ENTER MODEL NAME (Ex:  DE10) (enter S for program to suggest model) ";SHORT$
!                          5011 REM IF SHORT$="s" OR SHORT$="S" THEN GOSUB 6000
!  + selectaquifer         5012 GOSUB 6000
!  + createjunkfile        5020 DD1$="C:\AUG3\"
!  + createjunkfile        5021 IF NSP$="" THEN NSP=2 ELSE NSP=VAL(NSP$):GOTO 5040
!  + createjunkfile        5022 NTS(1)=20:NTS(2)=60
!  + createjunkfile        5023 TSMULT(1)=1.01:TSMULT(2)=1.01
!  + createjunkfile        5024 PERLEN(1)=100:PERLEN(2)=300
!  + createjunkfile        5025 GOTO 5110
!  + createjunkfile        5040 CLS:PRINT "REMEMBER FILES ON APOLLO ARE CONFIGURED FOR 2 STRESS PERIODS.  YOU WILL HAVE TO CHANGE TAPE1.DAT ON THE APOLLO.":PRINT
!  + createjunkfile        5041 FOR X=1 TO NSP 
!  + createjunkfile        5060 PRINT "FOR STRESS PERIOD #";X
!  + createjunkfile        5070 REM INPUT "ENTER NUMBER OF TIME STEPS";NTS(X)
!  + createjunkfile        5080 REM INPUT "ENTER TIME STEP MULTIPLIER";TSMULT(X)
!  + createjunkfile        5090 INPUT "ENTER LENGTH OF STRESS PERIOD (years) ";PERLEN(X) 
!  + createjunkfile        5092 NTS(X)=PERLEN(X)/5
!  + createjunkfile        5093 TSMULT(X)=1.0001
!  + createjunkfile        5095 IF PERLEN(X)>300 THEN BEEP:CLS:PRINT "LENGTH OF TIME STEP CANNOT EXCEED 300 YEARS.  (press RETURN to abort) ...";:INPUT "";N$:SYSTEM
!  + createjunkfile        5100 NEXT X
!  + createjunkfile        5110 OPEN "O",#1,"C:\AUG3\JUNK."+RNN$
!  + createjunkfile        5120 PRINT#1,NSP
!  + createjunkfile        5130 PRINT#1,SHORT$
!  + createjunkfile        5140 PRINT#1,DD1$
!  + createjunkfile        5145 PRINT#1,RNN$
!  + createjunkfile        5150 FOR X=1 TO NSP
!  + createjunkfile        5160 PRINT#1,NTS(X);TSMULT(X);PERLEN(X)
!  + createjunkfile        5165 NEXT X
!  + createjunkfile        5170 CLOSE#1
!                          5171 L=LEN(SHORT$)
!                          5172 IF L=3 THEN SDIR$=MID$(SHORT$,1,2)+"0"+MID$(SHORT$,3,1) ELSE SDIR$=SHORT$
!                          5173 OPEN "I",#1,"C:\AUG3\"+SDIR$+"\TAPE1.SAV"
!                          5174 OPEN "O",#2,"C:\AUG3\"+SDIR$+"\TAPE1.DAT"
!                          5175 FOR X=1 TO 2
!                          5176 LINE INPUT#1,A$
!                          5177 PRINT#2,A$
!                          5178 NEXT X
!                          5179 INPUT#1,K1,K2,K3,K4,K5
!                          5180 PRINT#2,USING"##########";K1;K2;K3;NSP;K5
!                          5181 LINE INPUT#1,A$
!                          5182 IF MID$(A$,1,10)<>"3155760000" THEN PRINT#2,A$:GOTO 5181
!                          5183 FOR X=1 TO NSP
!                          5184 PRINT#2,USING"##########";PERLEN(X)*1440*365.25*60;NTS(X);:PRINT#2,USING"#####.####";TSMULT(X)
!                          5185 NEXT X
!                          5186 CLOSE#1:CLOSE#2
!                          5187 RETURN
!
!  + selectaquifer         6000 REM ********* SUB TO SELECT MODEL **********************
!  + selectaquifer         6010 CLS
!  + selectaquifer         6020 RESTORE 1100
!  + selectaquifer         6030 PRINT "SELECT AQUIFER:"
!  + selectaquifer         6040 FOR X=1 TO 6
!  + selectaquifer         6050 READ AQNAM$,AQSHORT$
!  + selectaquifer         6060 PRINT STR$(X);")  ";AQNAM$
!  + selectaquifer         6070 NEXT X
!  + selectaquifer         6080 INPUT "       enter appropriate line number  ";OSEL
!  + selectaquifer         6090 RESTORE 1100
!  + selectaquifer         6100 FOR X=1 TO OSEL
!  + selectaquifer         6110 READ AQNAM$,AQSHORT$
!  + selectaquifer         6120 NEXT X
!  + selectaquifer         6130 CLS
!  + selectwelllocation    6140 INPUT "ENTER LOCATION (example:  3,5N,64)  ";SCTN,TWP$,RNG
!  + selectwelllocation    6150 GOSUB 3270
!  + assignmodel           6160 ON OSEL GOTO 6170,6250,6270,6330,6360,6370
!  + assignmodel           6170 IF I>95 AND J<53 THEN SHORT$="LF8"
!  + assignmodel           6180 IF I<57 AND J<21 THEN SHORT$="LF6":GOTO 6380
!  + assignmodel           6190 IF I<33 AND J<66 THEN SHORT$="LF1":GOTO 6380
!  + assignmodel           6200 IF I<24 THEN GOTO 6380
!  + assignmodel           6205 IF I<44 AND J>65 THEN SHORT$="LF2"
!  + assignmodel           6210 IF I<87 AND J<39 THEN SHORT$="LF4"
!  + assignmodel           6220 IF I>66 AND J>55 THEN SHORT$="LF3"
!  + assignmodel           6240 GOTO 6380
!  + assignmodel           6250 SHORT$="LA1"
!  + assignmodel           6260 GOTO 6380
!  + assignmodel           6270 IF I<66 AND J<38 THEN SHORT$="AR1":GOTO 6380
!  + assignmodel           6280 IF I<72 AND J>37 THEN SHORT$="AR2":GOTO 6380
!  + assignmodel           6290 IF I>83 AND J<47 THEN SHORT$="AR9":GOTO 6380
!  + assignmodel           6300 IF J<38 THEN SHORT$="AR3":GOTO 6380
!  + assignmodel           6310 IF I>77 THEN SHORT$="AR4"
!  + assignmodel           6320 GOTO 6380
!  + assignmodel           6330 IF I>82 THEN SHORT$="DE10":GOTO 6380
!  + assignmodel           6340 IF J>35 THEN SHORT$="DE9" ELSE SHORT$="DE8"
!  + assignmodel           6350 GOTO 6380
!  + assignmodel           6360 SHORT$="LD2":GOTO 6380
!  + assignmodel           6370 IF I<83 THEN SHORT$="DA1" ELSE SHORT$="DA2"
!  + assignmodel           6380 IF SHORT$="S" OR SHORT$="s" THEN PRINT "ADEQUATE MODEL NOT AVAILABLE (press RETURN to continue...";:INPUT "";NUT$:SYSTEM
!  + assignmodel           6390 PRINT SHORT$;" has been selected  (press RETURN to continue) ";:INPUT "";NUT$
!  + assignmodel           6400 RETURN!       

       