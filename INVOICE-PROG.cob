       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.INVOICE-PROG.
      *================================================================*
      *    AUTHOR      : NATAN BOANAFINA.                              *
      *    ENTERPRISE  : NOT APPLICABLE                                *
      *    PROFESSOR   : IVAN PETRUCCI                                 *
      *    DATE        : 23/11/2022                                    *
      *                                                                *
      *----------------------------------------------------------------*
      *    PURPOSE     : SEARCH FOR CLIENTS VIA ID, SAVE THEIR GOODS   *
      *    BOUGHT INTO A NEW FILE AND SHOW IT UP.                      *
      *                                                                *
      *----------------------------------------------------------------*
      *    FILES       :                                               *
      *    DDNAME                 I/O                 COPY/BOOK        *
      *    CLIENTS                 I                      -            *
      *    SHOPPING                I                      -            *
      *    INVOICE                 O                      -            *
      *----------------------------------------------------------------*
      *================================================================*
       ENVIRONMENT                     DIVISION.
      *----------------------------------------------------------------*
       CONFIGURATION                   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

      *----------------------------------------------------------------*
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *=================================================================
      *                    SELECT CLIENTES.DAT
      *=================================================================
           SELECT CLIENTS ASSIGN TO "C:\Cobol\task3\data\CLIENTES.DAT"
                              FILE STATUS IS FS-CLIENTS-STATUS.

      *=================================================================
      *                    SELECT COMPRAS.DAT
      *=================================================================
           SELECT SHOPPING ASSIGN TO "C:\Cobol\task3\data\COMPRAS.DAT"
                               FILE STATUS IS FS-SHOPPING-STATUS.

      *=================================================================
      *                    SELECT NF.DAT
      *=================================================================
           SELECT INVOICE ASSIGN TO "C:\Cobol\task3\data\NF.DAT"
                              FILE STATUS IS FS-INVOICE-STATUS.

      *----------------------------------------------------------------*
      *================================================================*
      *----------------------------------------------------------------*
       DATA                            DIVISION.
       FILE                            SECTION.
      **================== FD CLIENTS BEGINNING =======================*
       FD  CLIENTS.
       01  RG-CLIENTS.
           05 RG-CLIENTS-ID        PIC 9(05).
           05 RG-CLIENTS-NAME      PIC X(20).

      **================= FD SHOPPING BEGINNING =======================*
       FD  SHOPPING.
       01  RG-SHOPPING.
           05 RG-SHOPPING-ID       PIC 9(05).
           05 RG-SHOPPING-ID-CLI   PIC 9(05).
           05 RG-SHOPPING-PROD     PIC X(15).
           05 RG-SHOPPING-PRICE    PIC 9(08)V99.

      **================== FD INVOICE BEGINNING =======================*
       FD  INVOICE.
       01  RG-INVOICE.
           05 RG-INVOICE-NAME      PIC X(20).
           05 RG-INVOICE-PROD      PIC X(15).

      *----------------------------------------------------------------*
       WORKING-STORAGE                 SECTION.
      *----------------------------------------------------------------*
       01  FILLER          PIC X(047) VALUE
           "========== WORKING-STORAGE BEGINNING ==========".

      *----------------------------------------------------------------*
       01  FILLER          PIC X(047) VALUE
           "============ FILE-STATUS BEGINNING ============".
      *----------------------------------------------------------------*
       77  FS-CLIENTS-STATUS       PIC 9(02) VALUE ZEROS.
       77  FS-SHOPPING-STATUS      PIC 9(02) VALUE ZEROS.
       77  FS-INVOICE-STATUS       PIC 9(02) VALUE ZEROS.
      *----------------------------------------------------------------*
       01  FILLER          PIC X(050) VALUE
           "============ ERROR MESSAGES BEGINNING ============".
      *----------------------------------------------------------------*
       77  WRK-OPEN-ERROR       PIC X(20) VALUE "FILE WAS NOT OPENED!".
      *================================================================*
      *----------------------------------------------------------------*
      *================================================================*
       PROCEDURE                       DIVISION.
      *----------------------------------------------------------------*
           PERFORM 0100-INIT.
      *     PERFORM 0110-ADD-DATA UNTIL CTRL-VAR NOT EQUAL "N".
           PERFORM 0200-PROCESS.
           PERFORM 0300-END.
      *----------------------------------------------------------------*
       0100-INIT                       SECTION.
           OPEN INPUT SHOPPING.
                IF FS-SHOPPING-STATUS NOT EQUAL 00
                   DISPLAY WRK-OPEN-ERROR
                   DISPLAY "STATUS: " FS-SHOPPING-STATUS
                  GOBACK
                END-IF.
      *----------------------------------------------------------------*
       0200-PROCESS                    SECTION.
           CONTINUE.
      *----------------------------------------------------------------*
       0300-END                        SECTION.
           CLOSE SHOPPING.

      *----------------------------------------------------------------*
      *================================================================*
