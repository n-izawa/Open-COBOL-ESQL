
       IDENTIFICATION              DIVISION.
      ******************************************************************
       PROGRAM-ID.                 prog.
      ******************************************************************
       DATA                        DIVISION.
      ******************************************************************
       WORKING-STORAGE             SECTION.
       01 READ-DATA.
         03  READ-TBL    OCCURS  1.
           05  READ-V PIC X(5).

OCESQL*EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 DATA-ID PIC 9(4).
       01 DATA-V PIC X(5).
       01  DBNAME                  PIC  X(30) VALUE SPACE.
       01  USERNAME                PIC  X(30) VALUE SPACE.
       01  PASSWD                  PIC  X(10) VALUE SPACE.
OCESQL*EXEC SQL END DECLARE SECTION END-EXEC.

OCESQL*EXEC SQL INCLUDE SQLCA END-EXEC.
OCESQL     copy "sqlca.cbl".

      ******************************************************************
OCESQL*
OCESQL 01  SQ0001.
OCESQL     02  FILLER PIC X(041) VALUE "INSERT INTO TESTTABLE VALUES ("
OCESQL  &  "1, 'hello')".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0002.
OCESQL     02  FILLER PIC X(051) VALUE "INSERT INTO TESTTABLE VALUES ("
OCESQL  &  "'invalid', 'invalid')".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0003.
OCESQL     02  FILLER PIC X(023) VALUE "SELECT V FROM TESTTABLE".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0004.
OCESQL     02  FILLER PIC X(028) VALUE "SELECT V FROM TESTTABLEERROR".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0005.
OCESQL     02  FILLER PIC X(045) VALUE "UPDATE TESTTABLE SET V = 'worl"
OCESQL  &  "d' WHERE ID = 1".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0006.
OCESQL     02  FILLER PIC X(045) VALUE "UPDATE TESTTABLE SET V = 'worl"
OCESQL  &  "d' WHERE ID = 3".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0007.
OCESQL     02  FILLER PIC X(050) VALUE "UPDATE TESTTABLEERROR SET V = "
OCESQL  &  "'world' WHERE ID = 1".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0008.
OCESQL     02  FILLER PIC X(034) VALUE "DELETE FROM TESTTABLE WHERE ID"
OCESQL  &  " = 1".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0009.
OCESQL     02  FILLER PIC X(034) VALUE "DELETE FROM TESTTABLE WHERE ID"
OCESQL  &  " = 3".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0010.
OCESQL     02  FILLER PIC X(039) VALUE "DELETE FROM TESTTABLEERROR WHE"
OCESQL  &  "RE ID = 3".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0011.
OCESQL     02  FILLER PIC X(030) VALUE "DROP TABLE IF EXISTS TESTTABLE".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0012.
OCESQL     02  FILLER PIC X(048) VALUE "CREATE TABLE TESTTABLE ( ID in"
OCESQL  &  "teger, V char(5) )".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0013.
OCESQL     02  FILLER PIC X(014) VALUE "DISCONNECT ALL".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
       PROCEDURE                   DIVISION.
      ******************************************************************
       MAIN-RTN.

       PERFORM SETUP-DB.

OCESQL*EXEC SQL
OCESQL*  INSERT INTO TESTTABLE VALUES (1, 'hello')
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0001
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  INSERT INTO TESTTABLE VALUES ('invalid', 'invalid')
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0002
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  SELECT V INTO :READ-TBL FROM TESTTABLE
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetResultParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 5
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE READ-V(1)
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetHostTable" USING
OCESQL          BY VALUE 1
OCESQL          BY VALUE 5
OCESQL          BY VALUE 1
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecSelectIntoOccurs" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0003
OCESQL          BY VALUE 0
OCESQL          BY VALUE 1
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  SELECT V INTO :READ-TBL FROM TESTTABLEERROR
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetResultParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 5
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE READ-V(1)
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetHostTable" USING
OCESQL          BY VALUE 1
OCESQL          BY VALUE 5
OCESQL          BY VALUE 1
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecSelectIntoOccurs" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0004
OCESQL          BY VALUE 0
OCESQL          BY VALUE 1
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  UPDATE TESTTABLE SET V = 'world' WHERE ID = 1
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0005
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  UPDATE TESTTABLE SET V = 'world' WHERE ID = 3
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0006
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  UPDATE TESTTABLEERROR SET V = 'world' WHERE ID = 1
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0007
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  DELETE FROM TESTTABLE WHERE ID = 1
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0008
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  DELETE FROM TESTTABLE WHERE ID = 3
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0009
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

OCESQL*EXEC SQL
OCESQL*  DELETE FROM TESTTABLEERROR WHERE ID = 3
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0010
OCESQL     END-CALL.
       PERFORM SHOW-STATUS.

       PERFORM CLEANUP-DB.

           STOP RUN.

      ******************************************************************
       SETUP-DB.
      ******************************************************************

           MOVE  "testdb@db_postgres:5432"
             TO DBNAME.
           MOVE  "main_user"
             TO USERNAME.
           MOVE  "password"
             TO PASSWD.

OCESQL*    EXEC SQL
OCESQL*        CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME
OCESQL*    END-EXEC.
OCESQL     CALL "OCESQLConnect" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE USERNAME
OCESQL          BY VALUE 30
OCESQL          BY REFERENCE PASSWD
OCESQL          BY VALUE 10
OCESQL          BY REFERENCE DBNAME
OCESQL          BY VALUE 30
OCESQL     END-CALL.

OCESQL*    EXEC SQL
OCESQL*        DROP TABLE IF EXISTS TESTTABLE
OCESQL*    END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0011
OCESQL     END-CALL.

OCESQL*    EXEC SQL
OCESQL*        CREATE TABLE TESTTABLE
OCESQL*        (
OCESQL*          ID integer,
OCESQL*          V  char(5)
OCESQL*        )
OCESQL*    END-EXEC.
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0012
OCESQL     END-CALL.


      ******************************************************************
       CLEANUP-DB.
      ******************************************************************

OCESQL*    EXEC SQL
OCESQL*        DISCONNECT ALL
OCESQL*    END-EXEC.
OCESQL     CALL "OCESQLDisconnect" USING
OCESQL          BY REFERENCE SQLCA
OCESQL     END-CALL.

      ******************************************************************
       SHOW-STATUS.
      ******************************************************************
           DISPLAY SQLCODE.
           DISPLAY SQLSTATE.


