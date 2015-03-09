package no.uio.ifi.cflat.chargenerator;

/*
 * module CharGenerator
 */

import java.io.*;
import no.uio.ifi.cflat.cflat.Cflat;
import no.uio.ifi.cflat.error.Error;
import no.uio.ifi.cflat.log.Log;

/*
 * Module for reading single characters.
 */
public class CharGenerator {
    public static char curC, nextC;
	
    private static LineNumberReader sourceFile = null;
    private static String sourceLine;
    private static int sourcePos;
	private static boolean eofReached = false; // Flag for the end of the file

    public static void init() {
	try {
	    sourceFile = new LineNumberReader(new FileReader(Cflat.sourceName));
	} catch (FileNotFoundException e) {
	    Error.error("Cannot read " + Cflat.sourceName + "!");
	}
	sourceLine = "";  sourcePos = 0;  curC = nextC = ' ';
	readNext();  readNext();
    }
	
    public static void finish() {
	if (sourceFile != null) {
	    try {
		sourceFile.close();
	    } catch (IOException e) {}
	}
    }
	
    public static boolean isMoreToRead() {
	 	if(eofReached){
            return false;
        } else {
            return true; 
        }//-- Must be changed in part 0:
	
    }
	
    public static int curLineNum() {
	return (sourceFile == null ? 0 : sourceFile.getLineNumber());
    }
	
    public static void readNext() {
        curC = nextC;
	if (!isMoreToRead()){
            return;
        }
        if(!sourceLine.isEmpty()){
            nextC = sourceLine.charAt(0); //Take the first char of the inputline
            sourceLine = sourceLine.substring(1);
        } else {
            try {
                
                sourceLine = sourceFile.readLine();
                sourcePos = sourceFile.getLineNumber();
                
            } catch (IOException e) {
                Error.error("Error reading a new line from " + Cflat.sourceName + "!"); 
            }
            if(sourceLine == null) {
                eofReached = true;
            } else {
                Log.noteSourceLine(curLineNum(), sourceLine);
                if(sourceLine.length() != 0){
                    if(sourceLine.charAt(0) == '#'){
                        sourceLine = "";
                        readNext();
                    } else {
                        nextC = sourceLine.charAt(0);
                        sourceLine = sourceLine.substring(1);
                    }
                } else {
                    readNext();
                }

            }
            
        }
    }
}

