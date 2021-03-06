package no.uio.ifi.cflat.scanner;

/*
 * module Scanner
 */

import no.uio.ifi.cflat.chargenerator.CharGenerator;
import no.uio.ifi.cflat.error.Error;
import no.uio.ifi.cflat.log.Log;
import static no.uio.ifi.cflat.scanner.Token.*;

/*
 * Module for forming characters into tokens.
 */
public class Scanner {
    public static Token curToken, nextToken, nextNextToken;
    public static String curName, nextName, nextNextName;
    public static int curNum, nextNum, nextNextNum;
    public static int curLine, nextLine, nextNextLine;
	
    //Indikerer at scanneren er på siste lesing etter funn av EOF tegn. 
    public static boolean lastPass = false;
    
    public static void init() {
	//-- Must be changed in part 0:
    }
	
    public static void finish() {
	//-- Must be changed in part 0:
    }
	
    public static void readNext() {
  	curToken = nextToken;  nextToken = nextNextToken;
	curName = nextName;  nextName = nextNextName;
	curNum = nextNum;  nextNum = nextNextNum;
	curLine = nextLine;  nextLine = nextNextLine;  
        
	nextNextToken = null;
	while (nextNextToken == null) {
            while(Character.isWhitespace(CharGenerator.curC)){
                CharGenerator.readNext();
            }
	    nextNextLine = CharGenerator.curLineNum();
            
            if(lastPass){
                nextNextToken = eofToken;
                Log.noteToken();
                return;
            }
	    if (!CharGenerator.isMoreToRead()) {
                lastPass = true;
            }
            
            while(Character.isWhitespace(CharGenerator.curC)){
                CharGenerator.readNext();
            }
            String token = "";
            //Går gjennom alle tegn som ikke er bokstaver først. 
            if(!isLetterAZ(CharGenerator.curC)){
                
                char c = CharGenerator.curC;
                if(c == '+'){
                    nextNextToken = addToken;
                } else if (c == '-') {
                    nextNextToken = subtractToken;
                } else if (c == '*') {
                    nextNextToken = multiplyToken;                                     
                } else if (c == '/' && CharGenerator.nextC == '*') {
                    while((!((CharGenerator.curC == '*') && (CharGenerator.nextC == '/'))) && CharGenerator.isMoreToRead()){
						CharGenerator.readNext();
                    }
                    CharGenerator.readNext();
                } else if (c == '/') { // Kan være divide eller kommentar, sjekker for etterfølgende * og vil så hoppe over alt til den finner close-symbol.
                    nextNextToken = divideToken;
                } else if (c == ',') {
                    nextNextToken = commaToken;
                } else if (c == ';') {
                    nextNextToken = semicolonToken;
                } else if (c == '=') {
                    if(CharGenerator.nextC == '='){
                        nextNextToken = equalToken;
                        CharGenerator.readNext();
                    } else {
                        nextNextToken = assignToken;
                    }
                } else if (c == '!' ) {
                    if(CharGenerator.nextC == '='){
                        nextNextToken = notEqualToken;
                        CharGenerator.readNext();
                    } else {
                        Error.error("Illegal symbol, ! , there is no \"not\" in cflat. ! is only used in !=");
                    }
                } else if (c == '>') {
                    if(CharGenerator.nextC == '='){
                        nextNextToken = greaterEqualToken;
                        CharGenerator.readNext();
                    } else {
                        nextNextToken = greaterToken;
                    }
                } else if (c == '<') {
                    if(CharGenerator.nextC == '='){
                        nextNextToken = lessEqualToken;
                        CharGenerator.readNext();
                    } else {
                        nextNextToken = lessToken;
                    } 
                } else if (c == '(') {
                    nextNextToken = leftParToken;
                } else if (c == ')') {
                    nextNextToken = rightParToken;
                } else if (c == '{') {
                    nextNextToken = leftCurlToken;
                } else if (c == '}') {
                    nextNextToken = rightCurlToken;
                } else if (c == '[') {
                    nextNextToken = leftBracketToken;
                } else if (c == ']') {
                    nextNextToken = rightBracketToken;
                } else if(c == 39) {//Hvis tegnet er et ' så lagre neste tegn som et tall, hvis det igjen følles av nytt '.
                    CharGenerator.readNext();
                    if(CharGenerator.nextC != 39){
                        Error.error(nextNextLine, "Missing another ', found: " + CharGenerator.nextC + " instead!");
                    }
                    nextNextToken = numberToken;
                    nextNextNum = CharGenerator.curC;
                    CharGenerator.readNext();
                } else if(c <= '9' && c >= '0') {// If its a number, check how large it is.
                    String number = "";
                    number = number + CharGenerator.curC;
                    while(CharGenerator.nextC <= '9' && CharGenerator.nextC >= '0'){
                        number = number + CharGenerator.nextC;
                        CharGenerator.readNext();
                    }
                    nextNextToken = numberToken;
                    nextNextNum = Integer.parseInt(number);
                } else {
                    Error.error("Illegal symbol: '" + c + ".");//Hvis den ikke matcher noen av symbolene er det ikke definert for Cflat
                }
                //Gjør klart neste symbol. 
                CharGenerator.readNext();
            } else {                
                //Hvis den starter med en bokstav leser den inn ordet.
                while(CharGenerator.isMoreToRead() && (isLetterAZ(CharGenerator.curC) || (CharGenerator.curC == '_') || (CharGenerator.curC <= '9' && CharGenerator.curC >= '0'))){
                    if(CharGenerator.curC == '/' && (CharGenerator.nextC == '*')){
                        while(CharGenerator.curC != '*' && (CharGenerator.nextC != '/')){//Sjekker for kommentarer.
                            CharGenerator.readNext();
                        }
                    }
                    //Legger til hver bokstav til allerede leste bokstaver.
                    token = token + CharGenerator.curC;
                    CharGenerator.readNext();                    
                }
                //Matcher ordet lest inn til en token, eventuelt en nameToken hvis den ikke merker en innebygget funksjon.
                if(token.equals("int")){
                    nextNextToken = intToken;
                } else if(token.equals("double")){
                    nextNextToken = doubleToken;
                } else if(token.equals("return")){
                    nextNextToken = returnToken;
                } else if(token.equals("else")){
                    nextNextToken = elseToken;
                } else if(token.equals("for")){
                    nextNextToken = forToken;
                } else if(token.equals("if")){
                    nextNextToken = ifToken;
                } else if(token.equals("while")){
                    nextNextToken = whileToken;
                } else { 
                    nextNextToken = nameToken;
                    nextNextName = token;
                }
            }
            /*Error.error(nextNextLine,
              "Illegal symbol: '" + CharGenerator.curC + "'!");*/
        }
 
    //Logger token.
    Log.noteToken();
    }

    private static boolean isLetterAZ(char c) {
	if((c >= 'a' && c <= 'z')||(c >= 'A' && c <= 'Z')){
            return true;
        } else {       
        	return false;
        } 
    }
    
	
    public static void check(Token t) {
	if (curToken != t)
	    Error.expected("A " + t);
    }
	
    public static void check(Token t1, Token t2) {
	if (curToken != t1 && curToken != t2)
	    Error.expected("A " + t1 + " or a " + t2);
    }
	
    public static void skip(Token t) {
	check(t);  readNext();
    }
	
    public static void skip(Token t1, Token t2) {
	check(t1,t2);  readNext();
    }
}
