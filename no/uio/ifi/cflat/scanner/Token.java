package no.uio.ifi.cflat.scanner;

/*
 * class Token
 */

/*
 * The different kinds of tokens read by Scanner.
 */
public enum Token { 
    addToken, assignToken, 
    commaToken, 
    divideToken, doubleToken,
    elseToken, eofToken, equalToken, 
    forToken, 
    greaterEqualToken, greaterToken, 
    ifToken, intToken, 
    leftBracketToken, leftCurlToken, leftParToken, lessEqualToken, lessToken, 
    multiplyToken, 
    nameToken, notEqualToken, numberToken, 
    rightBracketToken, rightCurlToken, rightParToken, returnToken, 
    semicolonToken, subtractToken, 
    whileToken;

    public static boolean isFactorOperator(Token t) {   
    if(t.equals(multiplyToken) || t.equals(divideToken)){
            return true;
    }
    return false;
    }

    public static boolean isTermOperator(Token t) {
        if(t.equals(subtractToken) ||t.equals(addToken)){
            return true;
        }
       return false;
    }

    public static boolean isRelOperator(Token t) {
    if(t.equals(equalToken) || t.equals(notEqualToken) ||t.equals(lessToken) ||t.equals(lessEqualToken) || t.equals(greaterEqualToken) || t.equals(greaterToken)||t.equals(equalToken)){
            return true;
        }
    return false;
    }

    public static boolean isOperand(Token t) {
    if(t.equals(numberToken) || t.equals(nameToken)){
            return true;
        }
    return false;
    }

    public static boolean isTypeName(Token t) {
    if(t.equals(intToken) || t.equals(doubleToken)){
            return true;
        }
    return false;
    }
}
