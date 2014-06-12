DECLARE FUNCTION dec2bas$ (denval$, dbas!)
DECLARE FUNCTION bas2denV2$ (basval$, sbas!)
DECLARE FUNCTION bas2den$ (basval$, sbas!)
DECLARE FUNCTION revString$ (strIn$)

CLS
GOSUB splash
GOSUB getParams

IF intsrcbase = 10 THEN
'check for need to convert to base 10.
  strDenVal$ = UCASE$(strBasVal$)
ELSE
  strDenVal$ = bas2denV2$(UCASE$(strBasVal$), intsrcbase)
END IF

IF intdstbase = 10 THEN
'check for need to convert from base 10.
  strResVal$ = UCASE$(strDenVal$)
ELSE
  strResVal$ = dec2bas$(strDenVal$, intdstbase)
END IF

PRINT "The value "; strBasVal$; " base"; intsrcbase;
PRINT "in base"; intdstbase; "is "; strResVal$
END

splash:
PRINT "The Base Converter v~3.1"
PRINT "created by Skele Drew"
PRINT "copyright (c) Skeleville Software 2006 - 2007"
PRINT "written on 11/2/06"
PRINT
RETURN

getParams:
PRINT "Enter the value to convert: "; : INPUT strBasVal$
PRINT "Enter the base of the value given: "; : INPUT intsrcbase
PRINT "Enter the base to convert the value to: "; : INPUT intdstbase
PRINT
RETURN

FUNCTION bas2den$ (basval$, sbas!)
  'converts the given value to base 10.
  strList$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  basval$ = revString(basval$)
  totval = 0
 
  'counts from the end of the string to the start.
  FOR inc = LEN(basval$) TO 1 STEP -1
    strPos$ = MID$(basval$, inc, 1)
   
    'counts to the base given to isolate only relevant characters.
    FOR inc2 = 1 TO sbas
     
      'compares a value symbol to the set of isolated symbols.
      IF strPos$ = MID$(strList$, inc2, 1) THEN
        intpos = inc2 - 1
        EXIT FOR
      END IF
    NEXT
    curVal = intpos * sbas ^ (inc - 1): PRINT "curval:"; curVal
    totval = totval + curVal 'total value calculated.
  NEXT
  bas2den$ = LTRIM$(STR$(totval))
END FUNCTION

FUNCTION bas2denV2$ (basval$, sbas!)
  'second version of conversion to denary. ok.
  strList$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  totval = 0

  'gets the correct character without string reversal.
  dec = LEN(basval$)
  WHILE dec > 0
    dec = dec - 1
    strPos$ = MID$(basval$, (LEN(basval$)) - dec, 1)

    'counts to the base given to isolate only relevant characters from string.
    FOR inc = 1 TO sbas
     
      'compares a value symbol to the set of isolated symbols.
      IF strPos$ = MID$(strList$, inc, 1) THEN
        intpos = inc - 1
        EXIT FOR
      END IF
    NEXT
    curVal = intpos * sbas ^ dec
    totval = totval + curVal
  WEND
  bas2denV2$ = LTRIM$(STR$(totval))
END FUNCTION

FUNCTION dec2bas$ (denval$, dbas)
  'converts denary to final base.
  denNum = VAL(denval$)
  power = 1
  strList$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  strBas$ = "": PRINT "debug0:"; dbas

  WHILE power < denNum
    power = power * dbas
  WEND
 
  WHILE denNum > 0
    power = power / dbas: PRINT "debug1:"; power
    basNum = dbas
 
    DO
      basNum = basNum - 1
      subVal = basNum * power
    LOOP WHILE subVal > denNum
    denNum = denNum - subVal
    posChar$ = MID$(strList$, basNum + 1, 1)
    strBas$ = strBas$ + posChar$
  WEND
  dec2bas$ = strBas$
END FUNCTION

FUNCTION revString$ (strIn$)
  'reverses the entered string.
  strIn2$ = ""
 
  FOR i = 1 TO LEN(strIn$)
    strIn2$ = MID$(strIn$, i, 1) + strIn2$
  NEXT
 
  revString$ = strIn2$
END FUNCTION
