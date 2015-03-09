package no.uio.ifi.cflat.log;

/*
 * module Log
 */

import java.io.*;
import no.uio.ifi.cflat.cflat.Cflat;
import no.uio.ifi.cflat.error.Error;
import no.uio.ifi.cflat.scanner.Scanner;
import static no.uio.ifi.cflat.scanner.Token.*;

/*
 * Produce logging information.
 */
public class Log {
    public static boolean doLogBinding = false, doLogParser = false, 
	doLogScanner = false, doLogTree = false;
	
    private static String logName, curTreeLine = "";
    private static int nLogLines = 0, parseLevel = 0, treeLevel = 0;
	
    private static int indentation;

    public static void init() {
		logName = Cflat.sourceBaseName + ".log";
    }
	
    public static void finish() {
		if(curTreeLine.length() != 0){
			wTreeLn();
		}


    }

    private static void writeLogLine(String data) {
	try {
	    PrintWriter log = (nLogLines==0 ? new PrintWriter(logName) :
		new PrintWriter(new FileOutputStream(logName,true)));
	    log.println(data);  ++nLogLines;
	    log.close();
	} catch (FileNotFoundException e) {
	    Error.error("Cannot open log file " + logName + "!");
	}
    }

    /*
     * Make a note in the log file that an error has occured.
     *
     * @param message  The error message
     */
    public static void noteError(String message) {
		if (nLogLines > 0) { 
	    	writeLogLine(message);
		}
    }


    public static void enterParser(String symbol) {
		if (! doLogParser) return;
    	indentation++;
        
    	String line = "Parser:\t";
    	for(int i = 0; i < indentation; i++){
            line = line + "    ";
        }
	        line = line + symbol;
        writeLogLine(line);

	//-- Must be changed in part 1:
    }

    public static void leaveParser(String symbol) {
		if (! doLogParser) return;
		String line = "Parser:\t";
        for(int i = 0; i < indentation; i++){
            line = line + "    ";
        }
        line = line + symbol;
        writeLogLine(line);

        indentation--;
	//-- Must be changed in part 1:
    }

    /**
     * Make a note in the log file that another source line has been read.
     * This note is only made if the user has requested it.
     *
     * @param lineNum  The line number
     * @param line     The actual line
     */
    public static void noteSourceLine(int lineNum, String line) {
	if (! doLogParser && ! doLogScanner) return;
    
    	writeLogLine("\t" + lineNum + ": " + line);
	//-- Must be changed in part 0:
    }
	
    /**
     * Make a note in the log file that another token has been read 
     * by the Scanner module into Scanner.nextNextToken.
     * This note will only be made if the user has requested it.
     */
    public static void noteToken() {
		if (! doLogScanner) return;


    	String line = Scanner.nextNextToken.toString();
        
    	if(Scanner.nextNextToken.equals(nameToken)){
        	line = line + " " + Scanner.nextNextName;
    	} else if(Scanner.nextNextToken.equals(numberToken)){
        	line = line + " " + Scanner.nextNextNum;
    	}
    	writeLogLine("Scanner: " + line);

	//-- Must be changed in part 0:
    }

    public static void noteBinding(String name, int lineNum, int useLineNum) {
		if (! doLogBinding) return;
			if(lineNum == 0) {
				writeLogLine("Binding: Line " + useLineNum + ": " + name + " refers to declaration in library");
			} else {
				writeLogLine("Binding: Line " + useLineNum + ": " + name + " refers to declaration in line " + lineNum);
			}
    }


    public static void wTree(String s) {
	if (curTreeLine.length() == 0) {
	    for (int i = 1;  i <= treeLevel;  ++i) curTreeLine += "  ";
	}
		curTreeLine += s;
    }

    public static void wTreeLn() {
		writeLogLine("Tree:     " + curTreeLine);
		curTreeLine = "";
    }

    public static void wTreeLn(String s) {
		wTree(s);  wTreeLn();
    }

    public static void indentTree() {
		treeLevel++; 
	//-- Must be changed in part 1:
    }

    public static void outdentTree() {
		treeLevel--; 
	//-- Must be changed in part 1:
    }
}
