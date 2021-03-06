package no.uio.ifi.cflat.syntax;

/*
 * module Syntax
 */

import no.uio.ifi.cflat.cflat.Cflat;
import no.uio.ifi.cflat.code.Code;
import no.uio.ifi.cflat.error.Error;
import no.uio.ifi.cflat.log.Log;
import no.uio.ifi.cflat.scanner.Scanner;
import no.uio.ifi.cflat.scanner.Token;
import static no.uio.ifi.cflat.scanner.Token.*;
import no.uio.ifi.cflat.types.*;

/*
 * Creates a syntax tree by parsing; 
 * prints the parse tree (if requested);
 * checks it;
 * generates executable code. 
 */
public class Syntax {
    static DeclList library;
    static Program program;

    public static void init() {
	while(Scanner.curToken == null) {
            Scanner.readNext();
        }
    }

    public static void finish() {
	//-- Must be changed in part 1:
    }

    public static void checkProgram() {
		program.check(library);
    }

    public static void genCode() {
	program.genCode(null);
    }

    public static void parseProgram() {
		//Lager et bibliotek
		createLibrary();

		program = new Program();
		program.parse();
	}

    public static void printProgram() {
	program.printTree();
    }

    static void error(SyntaxUnit use, String message) {
	Error.error(use.lineNum, message);
    }

	static void createLibrary(){
		library = new GlobalDeclList();	
			
		library.addDecl(new FuncDecl("exit", Types.intType, Types.intType));
		library.addDecl(new FuncDecl("getchar", null, Types.intType));
		library.addDecl(new FuncDecl("getdouble", null, Types.doubleType));	
		library.addDecl(new FuncDecl("getint", null, Types.intType));
		library.addDecl(new FuncDecl("putchar", Types.intType, Types.intType));
		library.addDecl(new FuncDecl("putdouble", Types.doubleType, Types.doubleType));
		library.addDecl(new FuncDecl("putint", Types.intType, Types.intType));
	}
}


/*
 * Master class for all syntactic units.
 * (This class is not mentioned in the syntax diagrams.)
 */
abstract class SyntaxUnit {
    int lineNum;
    SyntaxUnit next;

    SyntaxUnit() {
		lineNum = Scanner.curLine;
    }

    abstract void check(DeclList curDecls);
    abstract void genCode(FuncDecl curFunc);
    abstract void parse();
    abstract void printTree();
}


/*
 * A <program>
 */
class Program extends SyntaxUnit {
    DeclList progDecls = new GlobalDeclList();
	
    @Override void check(DeclList curDecls) {		
		progDecls.check(curDecls);
    	// Check that 'main' has been declared properly, how?
		Declaration main = progDecls.findDecl("main", Syntax.library);
		if(main == null){
			Syntax.error(this, " is not decleared");
		}
		if(main.type != Types.intType){
			Syntax.error(this, " main must have a int return-type");
		}
		FuncDecl funcMain = (FuncDecl)main;
		if(funcMain.params.firstDecl != null) {
			Syntax.error(this, "main should not have any parameters");
		}
    	//-- Must be changed in part 2:
		
    }
		
    @Override void genCode(FuncDecl curFunc) {
		progDecls.genCode(null);
    }

    @Override void parse() {
		Log.enterParser("<program>");

		progDecls.parse();
        
		if (Scanner.curToken != eofToken) Error.expected("A declaration");

		Log.leaveParser("</program>");
    }

    @Override void printTree() {			
		progDecls.printTree();
    }
}


/*
 * A declaration list.
 * (This class is not mentioned in the syntax diagrams.)
 */

abstract class DeclList extends SyntaxUnit {
    Declaration firstDecl = null;
    DeclList outerScope;

    DeclList () {
        //outerScope = Syntax.program.progDecls; // Maybe? Check for confirmation. No?

	//-- Must be changed in part 1:
    }

    @Override void check(DeclList curDecls) {	
		outerScope = curDecls;

		Declaration dx = firstDecl;
		while (dx != null) {
	    	dx.check(this);  
			if(dx.type == null) System.err.println("\nDECLARATION: " + dx.name + " does not have type!");
			dx = dx.nextDecl;
		}
    }

    @Override void printTree() {        
		Declaration d = firstDecl;
        while(d != null){
            d.printTree();
            d = d.nextDecl;        
	}
	//-- Must be changed in part 1:
    }

    void addDecl(Declaration d) {
        if(firstDecl == null){
            firstDecl = d;
        } else if(firstDecl.nextDecl == null) {
            firstDecl.nextDecl = d;
        } else {
            Declaration temp = firstDecl;
        
            while(temp.nextDecl != null){
                temp = temp.nextDecl;
            }
        	temp.nextDecl = d;
            
		//-- Must be changed in part 1:
        }
    }

    int dataSize() {
	Declaration dx = firstDecl;
	int res = 0;

	while (dx != null) {
	    res += dx.declSize();  dx = dx.nextDecl;
	}
	return res;
    }

    Declaration findDecl(String name, SyntaxUnit usedIn) {		
		if(firstDecl == null && outerScope != null){
			return outerScope.findDecl(name, usedIn);
		} 

		Declaration temp = firstDecl;
		while (temp != null){		
			if(name.equals(temp.name) && temp.visible){
				Log.noteBinding(temp.name, temp.lineNum, usedIn.lineNum);
				return temp;
			}

			temp = temp.nextDecl;
		}
		if (outerScope == null){
			Syntax.error(usedIn, name + " Is not decleared before.");
		}

		//Fant ikke i denne decl-list, sjekker da outerscope
		return outerScope.findDecl(name, usedIn);
			
		//-- Must be changed in part 2:
    }
}


/*
 * A list of global declarations. 
 * (This class is not mentioned in the syntax diagrams.)
 */
class GlobalDeclList extends DeclList {
    @Override void genCode(FuncDecl curFunc) {
		Declaration d = firstDecl;
		while (d != null){
			d.genCode(null);
			d = d.nextDecl;
		}
	//-- Must be changed in part 2:
    }

    @Override void parse() {
	   while (Token.isTypeName(Scanner.curToken)) {
	       if (Scanner.nextToken == nameToken) {
	           if (Scanner.nextNextToken == leftParToken) {
                  FuncDecl fd = new FuncDecl(Scanner.nextName);
    		      fd.parse();
		          addDecl(fd);
		      } else if (Scanner.nextNextToken == leftBracketToken) {
		          GlobalArrayDecl gad = new GlobalArrayDecl(Scanner.nextName);
		          gad.parse();
		          addDecl(gad);
		      } else {
                  GlobalSimpleVarDecl gsvd = new GlobalSimpleVarDecl(Scanner.nextName);
                  gsvd.parse();
                  addDecl(gsvd);
                 
                   //-- Must be changed in part 1:
		      }
            } else {
		      Error.expected("A declaration");
	       }
	   }
    }
}


/*
 * A list of local declarations. 
 * (This class is not mentioned in the syntax diagrams.)
 */
class LocalDeclList extends DeclList {

    @Override void genCode(FuncDecl curFunc) {
		int offset = 0;

		Declaration temp = firstDecl;
		while(temp != null){
			
			offset = offset - temp.declSize(); //minus?
			temp.assemblerName = offset + "(%ebp)";
			temp.genCode(curFunc);

			temp = temp.nextDecl;
		}

	//-- Must be changed in part 2:
    }

    @Override void parse() {
	while(Token.isTypeName(Scanner.curToken)) {
            if(Scanner.nextToken == nameToken){
                if(Scanner.nextNextToken == leftParToken) {
                    Error.expected("A variable not a function decleration.");
                } else if(Scanner.nextNextToken == leftBracketToken) {
                    LocalArrayDecl lad = new LocalArrayDecl(Scanner.nextName);
                    lad.parse();
                    this.addDecl(lad);
                } else {
                    LocalSimpleVarDecl lsvd = new LocalSimpleVarDecl(Scanner.nextName);
                    lsvd.parse();
                    this.addDecl(lsvd);
                }
                      


            } else {
                Error.expected("A decleration");
            }        
        }
        //-- Must be changed in part 1:
    }
}


/*
 * A list of parameter declarations. 
 * (This class is not mentioned in the syntax diagrams.)
 */
class ParamDeclList extends DeclList {
   	int num = 0;

    @Override void genCode(FuncDecl curFunc) {
		int size = 8;

		Declaration temp = firstDecl;
		while(temp != null){
			temp.assemblerName = size + "(%ebp)";
			size = size + temp.declSize();

			temp = temp.nextDecl;
		}

	//-- Must be changed in part 2:
    }

    @Override void parse() {
		
		//-- Must be changed in part 1:
    }

    @Override void printTree() {
       
        Declaration d = firstDecl;
        while(d != null){
            d.printTree();
            d = d.nextDecl;
            if(d != null){
                Log.wTree(", ");
            }
        }
	//-- Must be changed in part 1:
    }

}


/*
 * Any kind of declaration.
 * (This class is not mentioned in the syntax diagrams.)
 */
abstract class Declaration extends SyntaxUnit {
    String name, assemblerName;
    Type type;
    boolean visible = false;
    Declaration nextDecl = null;

    Declaration(String n) {
	name = n;
    }

    abstract int declSize();

    /**
     * checkWhetherArray: Utility method to check whether this Declaration is
     * really an array. The compiler must check that a name is used properly;
     * for instance, using an array name a in "a()" or in "x=a;" is illegal.
     * This is handled in the following way:
     * <ul>
     * <li> When a name a is found in a setting which implies that should be an
     *      array (i.e., in a construct like "a["), the parser will first 
     *      search for a's declaration d.
     * <li> The parser will call d.checkWhetherArray(this).
     * <li> Every sub-class of Declaration will implement a checkWhetherArray.
     *      If the declaration is indeed an array, checkWhetherArray will do
     *      nothing, but if it is not, the method will give an error message.
     * </ul>
     * Examples
     * <dl>
     *  <dt>GlobalArrayDecl.checkWhetherArray(...)</dt>
     *  <dd>will do nothing, as everything is all right.</dd>
     *  <dt>FuncDecl.checkWhetherArray(...)</dt>
     *  <dd>will give an error message.</dd>
     * </dl>
     */
    abstract void checkWhetherArray(SyntaxUnit use);

    /**
     * checkWhetherFunction: Utility method to check whether this Declaration
     * is really a function.
     * 
     * @param nParamsUsed Number of parameters used in the actual call.
     *                    (The method will give an error message if the
     *                    function was used with too many or too few parameters.)
     * @param use From where is the check performed?
     * @see   checkWhetherArray
     */
    abstract void checkWhetherFunction(int nParamsUsed, SyntaxUnit use);

    /**
     * checkWhetherSimpleVar: Utility method to check whether this
     * Declaration is really a simple variable.
     *
     * @see   checkWhetherArray
     */
    abstract void checkWhetherSimpleVar(SyntaxUnit use);
	
	}


/*
 * A <var decl>
 */
abstract class VarDecl extends Declaration {
    VarDecl(String n) {
		super(n);
    }

    @Override int declSize() {
	return type.size();
    }

    @Override void checkWhetherFunction(int nParamsUsed, SyntaxUnit use) {
		Syntax.error(use, name + " is a variable and no function!");
    }
	
    @Override void printTree() {
		Log.wTree(type.typeName() + " " + name);
		Log.wTreeLn(";");
   
    }

    //-- Must be changed in part 1+2:
}


/*
 * A global array declaration
 */
class GlobalArrayDecl extends VarDecl {
    GlobalArrayDecl(String n) {
	super(n);
	assemblerName = (Cflat.underscoredGlobals() ? "_" : "") + n;
    }

    @Override void check(DeclList curDecls) {
		visible = true;
		if (((ArrayType)type).nElems < 0){
		    Syntax.error(this, "Arrays cannot have negative size!");
	    }
	}

	@Override void checkWhetherArray(SyntaxUnit use) {
		/* OK */
    }

    @Override void checkWhetherSimpleVar(SyntaxUnit use) {
		Syntax.error(use, name + " is an array and no simple variable!");
    }

    @Override void genCode(FuncDecl curFunc) {
		ArrayType a = (ArrayType)type;		
		int elems = a.nElems;

		Code.genVar(assemblerName, true, declSize(), "" + type.typeName() + "  " + name + " [ " + elems + "] ;");	
		//-- Must be changed in part 2:
    }

    @Override void parse() {

		Log.enterParser("<var decl>");

        type = Types.getType(Scanner.curToken);
        
        Scanner.readNext();
        Scanner.skip(nameToken);
        Scanner.skip(leftBracketToken);
        type = new ArrayType(Scanner.curNum, type);
		Scanner.skip(numberToken);
        Scanner.skip(rightBracketToken);
        Scanner.skip(semicolonToken);
        
	//-- Must be changed in part 1:

	Log.leaveParser("</var decl>");
    }

    @Override void printTree() {
		ArrayType a = (ArrayType)type;
        Log.wTree(type.typeName() + " " + name + "[" + a.nElems + "]");
        
        
        
     



	//-- Must be changed in part 1:
    }
}


/*
 * A global simple variable declaration
 */
class GlobalSimpleVarDecl extends VarDecl {
    GlobalSimpleVarDecl(String n) {
	super(n);
	assemblerName = (Cflat.underscoredGlobals() ? "_" : "") + n;
    }

    @Override void check(DeclList curDecls) {
		visible = true;	
	
	//-- Must be changed in part 2:
    }

    @Override void checkWhetherArray(SyntaxUnit use) {
		Syntax.error(use, name + "is a simple variable and not an array.");		
	//-- Must be changed in part 2:
    }

    @Override void checkWhetherSimpleVar(SyntaxUnit use) {
	/* OK */
    }

    @Override void genCode(FuncDecl curFunc) {
		Code.genVar(assemblerName, true, declSize(), "" + type.typeName() + "  " + name + ";");	
	//-- Must be changed in part 2:
    }

    @Override void parse() {
	Log.enterParser("<var decl>");
        
        type = Types.getType(Scanner.curToken);
        Scanner.readNext();
        Scanner.skip(nameToken);
        Scanner.skip(semicolonToken);
        
        
	//-- Must be changed in part 1:
        
	Log.leaveParser("</var decl>");
    }
}


/*
 * A local array declaration
 */
class LocalArrayDecl extends VarDecl {
    LocalArrayDecl(String n) {
	   super(n); 
    }

    @Override void check(DeclList curDecls) {
		visible = true;
		if (((ArrayType)type).nElems < 0){
		    Syntax.error(this, "Arrays cannot have negative size!");
	    }	

	//-- Must be changed in part 2:
    }

    @Override void checkWhetherArray(SyntaxUnit use) {
	// OK	
	//-- Must be changed in part 2:
    }

    @Override void checkWhetherSimpleVar(SyntaxUnit use) {
			Syntax.error(use, name + " is an array and no simple variable!");	

	//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
	//-- Must be changed in part 2:
    }

    @Override void parse() {
	Log.enterParser("<var decl>");

        type = Types.getType(Scanner.curToken);
        
        Scanner.readNext();
        Scanner.skip(nameToken);
        Scanner.skip(leftBracketToken);
        
        
        type = new ArrayType(Scanner.curNum, type);
		Scanner.skip(numberToken);
        Scanner.skip(rightBracketToken);
        Scanner.skip(semicolonToken);

	//-- Must be changed in part 1:

	Log.leaveParser("</var decl>");
    }

    @Override void printTree() {
       
		ArrayType a = (ArrayType)type;
		Log.wTree(a.elemType.typeName() + " " + name + "[" + a.nElems + "]");
        
      
        
            
        //-- Must be changed in part 1:
    }

}


/*
 * A local simple variable declaration
 */
class LocalSimpleVarDecl extends VarDecl {
    LocalSimpleVarDecl(String n) {
	super(n); 
    }

    @Override void check(DeclList curDecls) {
		visible = true;	
		//-- Must be changed in part 2:
    }

    @Override void checkWhetherArray(SyntaxUnit use) {
		Syntax.error(use, name + "Is a simple variable and not an array.");	

	//-- Must be changed in part 2:
    }

    @Override void checkWhetherSimpleVar(SyntaxUnit use) {
	// OK	

	//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
		//Code.genVar(assemblerName, false, declSize(), "" + type.typeName() + "  " + name + ";");	
	//-- Must be changed in part 2:
    }

    @Override void parse() {
	Log.enterParser("<var decl>");

        type = Types.getType(Scanner.curToken);
        Scanner.readNext();
        Scanner.skip(nameToken);
        Scanner.skip(semicolonToken);
	//-- Must be changed in part 1:

	Log.leaveParser("</var decl>");
    }
}


/*
 * A <param decl>
 */
class ParamDecl extends VarDecl {
    int paramNum = 0;

    ParamDecl(String n) {
		super(n);
    }

    @Override void check(DeclList curDecls) {
		visible = true;		
		//-- Must be changed in part 2:
    }

    @Override void checkWhetherArray(SyntaxUnit use) {
		Syntax.error(use, name + "Is a paramater and not an array.");
	//-- Must be changed in part 2:
    }

    @Override void checkWhetherSimpleVar(SyntaxUnit use) {
	//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
		

	//-- Must be changed in part 2:
    }

    @Override void parse() {
	Log.enterParser("<param decl>");
        
        type = Types.getType(Scanner.curToken);

        Scanner.readNext();
        Scanner.skip(nameToken);
        
        //-- Must be changed in part 1:

	Log.leaveParser("</param decl>");
    }

    @Override void printTree() {
        Log.wTree(type.typeName() + " " + name);
    }

}


/*
 * A <func decl>
 */
class FuncDecl extends Declaration {
    ParamDeclList params = new ParamDeclList(); 
    StatmList statmList = new StatmList();
    LocalDeclList localDecls = new LocalDeclList();
	String exit;    
	//-- Must be changed in part 1+2:
	
	//Library functions
	FuncDecl(String n, Type parameterType, Type returnType) {
		super(n);
		assemblerName = (Cflat.underscoredGlobals() ? "_" : "") + n;		
		visible = true;
		lineNum = 0;
		if(parameterType != null){
			params.addDecl(new ParamDecl("libraryparam"));
			params.firstDecl.type = parameterType;
		}
		type = returnType;
		exit = ".exit$" + n;
		//add parametertypes	
	}

    FuncDecl(String n) {
	// Used for user functions:

		super(n);
		assemblerName = (Cflat.underscoredGlobals() ? "_" : "") + n;
		exit = ".exit$" + n;	
		//-- Must be changed in part 1:
    }

    @Override int declSize() {
		return 0;
    }

    @Override void check(DeclList curDecls) {			
		params.check(curDecls);
		visible = true;	//Gjøres synlig her for å ikke la parameterne sjekke sin egen funksjon.	

		localDecls.check(params);
		statmList.check(localDecls);
			

		
	//-- Must be changed in part 2:
    }

    @Override void checkWhetherArray(SyntaxUnit use) {
		Syntax.error(use, name + "Is a function, not an array.");	
		//-- Must be changed in part 2:
    }

    @Override void checkWhetherFunction(int nParamsUsed, SyntaxUnit use) {
		int number = 0;
				
	
		if(nParamsUsed != params.num){	
			Syntax.error(use, "This function " + name + " have " + params.num + " params, you have provided " + nParamsUsed);
		}	
//-- Must be changed in part 2:
    }
	
    @Override void checkWhetherSimpleVar(SyntaxUnit use) {
		Syntax.error(use, name + "Is a function, not a variable.");	
	//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
		int antallByte = localDecls.dataSize();		
		Code.genInstr("", ".globl", assemblerName, "");
		Code.genInstr(assemblerName, "enter", "$" + antallByte + ",$0", "Start function "+name);
		
		
		params.genCode(this);
		localDecls.genCode(this);
		statmList.genCode(this);

		if(type == Types.doubleType) {
			Code.genInstr("", "fldz", "", "");
		}
			
		Code.genInstr(exit, "leave", "", "");
		Code.genInstr("", "ret", "", "End function "+name);
		
	//-- Must be changed in part 2:
    }

    @Override void parse() {
      
        Log.enterParser("<func-decl>");
        //-- Must be changed in part 1:        
		type = Types.getType(Scanner.curToken);
        if(type == null) System.err.println("Attempted to set type in FuncDecl - " + this.name + " -, but type is still null!");
        Scanner.readNext();
        Scanner.skip(nameToken);
        Scanner.skip(leftParToken);
        if(Scanner.curToken == rightParToken) {
            Scanner.skip(rightParToken);
            //No params
        } else {//Populating param list
            int parNum = 0;
            params = new ParamDeclList();
            while(Token.isTypeName(Scanner.curToken)){
                ParamDecl param = new ParamDecl(Scanner.nextName);
                param.parse();
                params.addDecl(param);
                param.paramNum = parNum;
                parNum++;

                if(Scanner.curToken == rightParToken) { // No more params to read
                    Scanner.readNext();
                    
                } else if(Scanner.curToken == commaToken) {
                    Scanner.skip(commaToken);
                    
                } else {
                    Error.expected(", or )");
                }
            params.num = parNum;   
            }
            
           
            
        }
        Scanner.skip(leftCurlToken);
        Log.enterParser("<func-body>");
        // if there are decls 

        while(Token.isTypeName(Scanner.curToken)){
           
            localDecls.parse();
            
        }
        

        statmList = new StatmList();

        statmList.parse();

        //Scanner.skip(rightCurlToken);
        


        // if there are statements

        Log.leaveParser("/<func-body>");
        
        Log.leaveParser("</func-decl>");
    }

    @Override void printTree() {
	//Write type and name of function
		        
		Log.wTree(type.typeName() + " " + name + "(");
        //Write parameters
        if(params != null){
            params.printTree();
        }
        Log.wTreeLn(") {");
        
        Log.indentTree();
        //Write local declerations
        if(localDecls != null){
            localDecls.printTree();
            Log.wTreeLn();
        }

        //Write Statementlist

        statmList.printTree();
        
        Log.wTreeLn("");
        Log.outdentTree();
        
        Log.wTreeLn("}");
        
        //-- Must be changed in part 1:
    }
}


/*
 * A <statm list>.
 */
class StatmList extends SyntaxUnit {
    //-- Must be changed in part 1:
    Statement first = null;
    
    @Override void check(DeclList curDecls) {				
		Statement temp = first;
		while(temp != null){
			temp.check(curDecls);
			temp = temp.nextStatm;
		}	

		//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
		Statement temp = first;
		while(temp != null){
			temp.genCode(curFunc);

			temp = temp.nextStatm;
		}

	//-- Must be changed in part 2:
    }

    @Override void parse() {
	Log.enterParser("<statm list>");

	Statement lastStatm = null;
	while (Scanner.curToken != rightCurlToken) {
	    Log.enterParser("<statement>");

	    Statement s = Statement.makeNewStatement();
            s.parse();
            
            if(first == null){
                first = s;
                lastStatm = s;
            } else {
                lastStatm.nextStatm = s;
                lastStatm = s;
            }
	    Log.leaveParser("</statement>");
            
	}
        Log.leaveParser("</statm list>");
        Scanner.skip(rightCurlToken);
    }

    @Override void printTree() {
		Statement s = first;
        
        while(s != null){
            s.printTree();
            s = s.nextStatm;
        }
	//-- Must be changed in part 1:
    }
}

/*
 * A <statement>.
 */
abstract class Statement extends SyntaxUnit {
    Statement nextStatm = null;

    static Statement makeNewStatement() {
	if (Scanner.curToken==nameToken && 
	    Scanner.nextToken==leftParToken) {
	    return new CallStatm();//-- Must be changed in part 1: //call
	} else if (Scanner.curToken == nameToken) {
	    return new AssignStatm(); //-- Must be changed in part 1: //assign
	} else if (Scanner.curToken == forToken) {
	    return new ForStatm();
	} else if (Scanner.curToken == ifToken) {
	    return new IfStatm();
	} else if (Scanner.curToken == returnToken) {
	    return new ReturnStatm();
	} else if (Scanner.curToken == whileToken) {
	    return new WhileStatm();
	} else if (Scanner.curToken == semicolonToken) {
	    return new EmptyStatm();
	} else {
	    Error.expected("A statement");
	}
	return null;  // Just to keep the Java compiler happy. :-)
    }
} 


/*
 * An <empty statm>.
 */
class EmptyStatm extends Statement {
    //-- Must be changed in part 1+2:

    @Override void check(DeclList curDecls) {
	//Nothing to check
	//Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
	// No code for an empty statement	
	//-- Must be changed in part 2:
    }

    @Override void parse() {
		Log.enterParser("<empty statm>");

        Scanner.skip(semicolonToken);

        Log.leaveParser("</empty statem>");
    }

    @Override void printTree() {
        Log.wTreeLn(";");
        

	//-- Must be changed in part 1:
    }
}
	

/*
 * A <for-statm>.
 */
class ForStatm extends Statement {
    Assignment initial = new Assignment();
    Expression until = new Expression();
    Assignment count = new Assignment();
    StatmList statmList = new StatmList();

    @Override void check(DeclList curDecls) {
		initial.check(curDecls);
		until.check(curDecls);
		count.check(curDecls);
		statmList.check(curDecls);        
		//Must be changed in part two.
    }
    
    @Override void genCode(FuncDecl curFunc) {
		initial.genCode(curFunc);
		String start = Code.getLocalLabel();
		Code.genInstr(start, "", "", "Start for statement");
		
		String end = Code.getLocalLabel();
	
		until.genCode(curFunc);
		until.valType.genJumpIfZero(end);
		
		statmList.genCode(curFunc);
		     
		count.genCode(curFunc);
		
		Code.genInstr("", "jmp", start, "");
		Code.genInstr(end, "", "", "End for statement");
	   //Must be changed in part two.
    }
    
    @Override void parse() {
        Log.enterParser("<for-statm>");

        Scanner.skip(forToken);
        Scanner.skip(leftParToken);
        initial.parse();
        Scanner.skip(semicolonToken);
        until.parse();
        Scanner.skip(semicolonToken);
        count.parse();
        Scanner.skip(rightParToken);
        Scanner.skip(leftCurlToken);
        statmList.parse();

        //        Scanner.skip(rightCurlToken);

        Log.leaveParser("</for-statm>");


        //Must be changed in part one.
    }

    @Override void printTree() {
        Log.wTree("for (");

        initial.printTree();
        Log.wTree("; ");
        until.printTree();
        Log.wTree("; ");
        count.printTree();
        Log.wTreeLn(") {");
  
        Log.indentTree();
        //Print statementlist
        statmList.printTree();
        Log.outdentTree();

        Log.wTreeLn("}");

        
        //Must be changed in part one.
    }
}

//-- Must be changed in part 1+2:

/*
 * An <if-statm>.
 */
class IfStatm extends Statement {
    Expression test = new Expression();
    StatmList body = new StatmList();
    StatmList elsePart = null;
    //-- Must be changed in part 1+2:

    @Override void check(DeclList curDecls) {
		test.check(curDecls);
		body.check(curDecls);
		if(elsePart != null){
			elsePart.check(curDecls);
		}
		//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
		Code.genInstr("", "", "", "Start if statement");	
		String localLabelIf	= Code.getLocalLabel();	

		test.genCode(curFunc);
		if(elsePart != null){
			String localLabelElse = Code.getLocalLabel();
			test.valType.genJumpIfZero(localLabelElse);
			body.genCode(curFunc);
			
			Code.genInstr("", "jmp", localLabelIf, "");
			Code.genInstr(localLabelElse, "", "", " else");
			elsePart.genCode(curFunc);
		} else {
			test.valType.genJumpIfZero(localLabelIf);
			body.genCode(curFunc);			

		}
		Code.genInstr(localLabelIf, "", "", "End if statement");

		//-- Must be changed in part 2:
    }

    @Override void parse() {
        Log.enterParser("<if-statm>");
        
        Scanner.readNext();
        Scanner.skip(leftParToken);
        test.parse();
        Scanner.skip(rightParToken);
        Scanner.skip(leftCurlToken);
        body.parse();
        //Scanner.skip(rightCurlToken);

        /*
         *If there is an else part we need to make another statement list for that.
         */
        if(Scanner.curToken == elseToken){
            Log.enterParser("<else-part>");
            
            Scanner.skip(elseToken);
            Scanner.skip(leftCurlToken);
            
            elsePart = new StatmList();
            elsePart.parse();
            //Scanner.skip(rightCurlToken);
            Log.leaveParser("</else-part>");
        }

        Log.leaveParser("</if-statm>");

	//-- Must be changed in part 1:
    }

    @Override void printTree() {
        Log.wTree("if (");
        test.printTree();
        Log.wTreeLn(") {");
    
        Log.indentTree();
        body.printTree();
        Log.outdentTree();
        
        
        
        if(elsePart != null){
            Log.wTreeLn("} else {");
            
            Log.indentTree();
            elsePart.printTree();
            Log.outdentTree();
            
            Log.wTreeLn("} ");
        } else {
            Log.wTreeLn("}");
        }
        

	//-- Must be changed in part 1:
    }
}


/*
 * A <return-statm>.
 */
class ReturnStatm extends Statement {
    Expression toReturn = new Expression();
    
    @Override void check(DeclList curDecls) {
		toReturn.check(curDecls);
		
    }
    
    @Override void genCode(FuncDecl curFunc) {
		toReturn.valType.checkType(lineNum, curFunc.type, "Return value does not match the decleared value for the function, it is");
		toReturn.genCode(curFunc);
		Code.genInstr("", "jmp", curFunc.exit, "Return");
    }

    @Override void parse() {
        Log.enterParser("<return-statm>");

        Scanner.readNext();
        toReturn.parse();
        Scanner.skip(semicolonToken);

        Log.leaveParser("</return-statm>");
    }

    @Override void printTree() {
        Log.wTree("return ");

        toReturn.printTree();

        Log.wTreeLn(";");
    }

}

//-- Must be changed in part 1+2:


/*
 * A <while-statm>.
 */
class WhileStatm extends Statement {
    Expression test = new Expression();
    StatmList body = new StatmList();

    @Override void check(DeclList curDecls) {
		test.check(curDecls);
		body.check(curDecls);
    }

    @Override void genCode(FuncDecl curFunc) {
	String testLabel = Code.getLocalLabel(), 
	       endLabel  = Code.getLocalLabel();

	Code.genInstr(testLabel, "", "", "Start while-statement");
	test.genCode(curFunc);
	test.valType.genJumpIfZero(endLabel);
	body.genCode(curFunc);
	Code.genInstr("", "jmp", testLabel, "");
	Code.genInstr(endLabel, "", "", "End while-statement");
    }

    @Override void parse() {
	Log.enterParser("<while-statm>");

	Scanner.readNext();
	Scanner.skip(leftParToken);
	test.parse();
	Scanner.skip(rightParToken);
	Scanner.skip(leftCurlToken);
	body.parse();
	//Scanner.skip(rightCurlToken);

	Log.leaveParser("</while-statm>");
    }

    @Override void printTree() {
	Log.wTree("while (");  test.printTree();  Log.wTreeLn(") {");
	Log.indentTree();
	body.printTree();
	Log.outdentTree();
	Log.wTreeLn("}");
    }
}

/* 
 *Assign statement
 */

class AssignStatm extends Statement{
    Assignment assign = new Assignment();
    
    @Override void check(DeclList curDecls) {
		assign.check(curDecls);        
		//Must be changed in part two.
    }

    @Override void genCode(FuncDecl curFunc) {
		assign.genCode(curFunc);       
		 //Must be changed in part two.
    }

    @Override void parse() {
        Log.enterParser("<assign-statm>");

        assign.parse();
        Scanner.skip(semicolonToken);

        Log.leaveParser("</assign-statm>");
    }

    @Override void printTree() {
        assign.printTree();
        Log.wTreeLn(";");

        
        //Must be changed in part 1.
    }



}

class CallStatm extends Statement {
    FunctionCall call = new FunctionCall();

    
    @Override void check(DeclList curDecls) {
		call.check(curDecls);    
	    //Must be changed in part two.
    }

    @Override void genCode(FuncDecl curFunc) {
		call.genCode(curFunc);
		if(call.decl.type == Types.doubleType){
			Code.genInstr("", "fstps", ".tmp", "");
		}
        //Must be changed in part two.
    }

    @Override void parse() {
        Log.enterParser("<call-statm>");

        call.parse();
        
        Scanner.skip(semicolonToken);
     

        Log.leaveParser("</call-statm>");
    }

    @Override void printTree() {
        call.printTree();
			
        Log.wTreeLn(";");
        //Must be changed in part 1.
    }
}




//-- Must be changed in part 1+2:


/*
 * An <expression list>.
 */

class ExprList extends SyntaxUnit {
    Expression firstExpr = null;
    

    @Override void check(DeclList curDecls) {

		Expression temp = firstExpr;
		
		while(temp != null){
			temp.check(curDecls);
			temp = temp.nextExpr;

		}	

		//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
	//-- Must be changed in part 2:
    }

    @Override void parse() {
	Expression lastExpr = null;

	Log.enterParser("<expr list>");

        if(Scanner.curToken == rightParToken){
            //nothing to do, no expression, which is allowed.
        } else {
            Expression temp = new Expression();
            temp.parse();
            firstExpr = temp;
            lastExpr = temp;
            while(Scanner.curToken == commaToken){
                Scanner.skip(commaToken);
                temp = new Expression();
                temp.parse();
                if(firstExpr.nextExpr == null){
                    firstExpr.nextExpr = temp;
                    lastExpr = temp;
                } else {
                    lastExpr.nextExpr = temp;
                    lastExpr = temp;
                }
            }
        }
        

	//-- Must be changed in part 1:

	Log.leaveParser("</expr list>");
    }

    @Override void printTree() {
        Expression temp = firstExpr;
        while(temp != null){
            temp.printTree();
            temp = temp.nextExpr;
            if(temp != null){
                Log.wTree(", ");
            }
        }
        


	//-- Must be changed in part 1:
    }
    //-- Must be changed in part 1:
}


/*
 * An <expression>
 */
class Expression extends Operand {
    Expression nextExpr = null;
    Term firstTerm = new Term(), secondTerm = null;
    Operator relOp = null;
    boolean innerExpr = false;
	

    Expression(){
        //Do nothing
    }

    Expression(boolean inner){
        if(inner){
            innerExpr = true;
        }            
    }

    @Override void check(DeclList curDecls) {
				
		firstTerm.check(curDecls);	
		valType = firstTerm.valType;
		
		if(relOp != null) {
			relOp.check(curDecls);

			secondTerm.check(curDecls);

			//på vei opp
			firstTerm.valType.checkSameType(lineNum, secondTerm.valType, "Different types first and and second term in an expression");
			relOp.opType = firstTerm.valType;			
			valType = Types.intType; // Int ifølge foiler for sjekking.		
		}	

	
	

	//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
		firstTerm.genCode(curFunc);
		if(relOp != null) {
			if(firstTerm.valType == Types.intType){
				Code.genInstr("", "pushl", "%eax", "");
			} else {
				Code.genInstr("", "subl", "$8, %esp", "");
				Code.genInstr("", "fstpl", "(%esp)", "");
			}
			secondTerm.genCode(curFunc);
			relOp.genCode(curFunc);
		}

	//-- Must be changed in part 2:
    }

    @Override void parse() {
	Log.enterParser("<expression>");
    
        if(innerExpr){
            Scanner.skip(leftParToken);
          
        }
        
	firstTerm.parse();
        
	if (Token.isRelOperator(Scanner.curToken)) {
	    relOp = new RelOperator(); 
	    relOp.parse();
	    secondTerm = new Term();
	    secondTerm.parse();
	}
        
        if(innerExpr){
            Scanner.skip(rightParToken);
        }
        
	Log.leaveParser("</expression>");
    }

    @Override void printTree() {
        if(innerExpr){
            Log.wTree("(");
        }
        firstTerm.printTree();
        if(relOp != null){
            relOp.printTree();
        }
        if(secondTerm != null){
            secondTerm.printTree();
        }
        if(innerExpr){
            Log.wTree(")");
        }
	//-- Must be changed in part 1:
    }
}


/*
 * A <term>
 */
class Term extends SyntaxUnit {
    Factor first = null;
	Operator firstOperator = null;    
    Type valType = null;
	
	//-- Must be changed in part 1+2:

    @Override void check(DeclList curDecls) {
		Factor temp = first;
		while(temp != null){
			temp.check(curDecls);
			if(valType == null){			
				valType = temp.valType; //Terms type blir satt av faktorens type
			} else {
				valType.checkSameType(lineNum, temp.valType, "i Term");
			}	
			temp = temp.next;
		}
				
		Operator tempOp = firstOperator;

		while(tempOp != null){
			tempOp.check(curDecls);			
			tempOp.opType = valType;
			tempOp = tempOp.nextOp;
	
		}			
		//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {
		Factor temp = first;
		first.genCode(curFunc);
			
		if(firstOperator != null){
			Operator tempOp = firstOperator;
			temp = temp.next;		
			while(temp != null){
				if(valType == Types.intType){
					Code.genInstr("", "pushl", "%eax", "");
				} else if (valType == Types.doubleType) {
					Code.genInstr("", "subl", "$8,%esp", "");
					Code.genInstr("", "fstpl", "(%esp)", "");
				}
				temp.genCode(curFunc);
				tempOp.genCode(curFunc);
				temp = temp.next;
				tempOp = tempOp.nextOp;
			}
		}		
	//-- Must be changed in part 2:
    }
    
    @Override void parse() {
        Log.enterParser("<term>");
        
        boolean moreFactors = true;
        Factor last = first;
        
        while(moreFactors){
            
            if(first == null){
                first = new Factor();
                last = first;
            } else if(first.next == null) {
                first.next = new Factor();
                last = first.next;
            } else {
                last.next = new Factor();
                last = last.next;
            }          
            last.parse();
                         
            if((Scanner.curToken == addToken) || (Scanner.curToken == subtractToken)){   
                Operator temp = new TermOperator();
                temp.parse();
	
                if(firstOperator == null){
                    firstOperator = temp;
                } else if (firstOperator.nextOp == null) {
                    firstOperator.nextOp = temp;
                } else {
                    Operator to = firstOperator.nextOp;
                    while(to.nextOp != null){
                        to = to.nextOp;
                    }
                    to.nextOp = temp;
                }
            } else {
                moreFactors = false;
            }
            

        }
        Log.leaveParser("</term>");
        //-- Must be changed in part 1:
    }

    @Override void printTree() {
		Factor temp = first;
        Operator tempOperator = firstOperator;
 
        temp.printTree();

		temp = temp.next;
        while(temp != null){
			tempOperator.printTree();
			temp.printTree();

			tempOperator = tempOperator.nextOp;
			temp = temp.next;
		}        
	//-- Must be changed in part 1+2:
    }

}

class TermOperator extends Operator {
	@Override void genCode(FuncDecl curFunc){
		if(opType == Types.intType) {//ints
			Code.genInstr("", "movl", "%eax,%ecx", "");
			Code.genInstr("", "popl", "%eax", "");
			if(opToken == addToken){
				Code.genInstr("", "addl", "%ecx,%eax", "Compute +");
			} else {
				Code.genInstr("", "subl", "%ecx,%eax", "Compute -");
			}
		} else {//doubles
			Code.genInstr("", "fldl", "(%esp)", "");
			Code.genInstr("", "addl", "$8,%esp", "");
			if(opToken == addToken){
				Code.genInstr("", "faddp", "", "Compute +");
			} else {
				Code.genInstr("", "fsubp", "", "Compute -");
			}	
		}	
	}

	@Override void parse () {
		Log.enterParser("<term operator>");
			opToken = Scanner.curToken;
			Scanner.readNext();
		Log.leaveParser("</term operator>");
	}

	@Override void printTree() {
		if(opToken == addToken){
			Log.wTree("+");
		} else if (opToken == subtractToken) {
			Log.wTree("-");
		}
	}
}


class Factor extends SyntaxUnit {
    Factor next = null;
    Operand first = null;
	Operator firstOperator = null;
	Type valType = null;    

    @Override void check(DeclList curDecls) {
		
		Operand temp = first;
		while(temp != null){
			temp.check(curDecls);
			
			if(valType == null){			
				valType = temp.valType;
			} else {
				valType.checkSameType(lineNum, temp.valType, "i Factor");
			}
			temp = temp.nextOperand;
		}

		Operator tempOp = firstOperator;

		while(tempOp != null){
			tempOp.check(curDecls);			
			tempOp.opType = valType;
			tempOp = tempOp.nextOp;
		}
    }

    @Override void genCode(FuncDecl curFunc) {
        Operand temp = first;
		first.genCode(curFunc);
			
		if(firstOperator != null){
			Operator tempOp = firstOperator;
			temp = temp.nextOperand;		
			while(temp != null){
				if(valType == Types.intType){
					Code.genInstr("", "pushl", "%eax", "");
				} else if (valType == Types.doubleType) {
					Code.genInstr("", "subl", "$8,%esp", "");
					Code.genInstr("", "fstpl", "(%esp)", "");
				}
				temp.genCode(curFunc);
				tempOp.genCode(curFunc);
				temp = temp.nextOperand;
				tempOp = tempOp.nextOp;
			}

		}		
    }

    @Override void parse() {
        Log.enterParser("<factor>");
        
        boolean moreOperands = true;
        Operand last = null;
       
        while(moreOperands){            
            Log.enterParser("<operand>");
            if(first == null){
                first = whatOper();
                last = first;
            } else if (first.nextOperand == null){
                first.nextOperand = whatOper();
                last = first.nextOperand;
            } else {
                last.nextOperand = whatOper();
                last = last.nextOperand;
            }                      
            last.parse();
            Log.leaveParser("</operand>");
            
            if(Scanner.curToken == multiplyToken || Scanner.curToken == divideToken){        
                Operator temp = new FactorOperator();
      			temp.parse();
                if(firstOperator == null){
                    firstOperator = temp;
                } else if (firstOperator.nextOp == null) {
                    firstOperator.nextOp = temp;
                } else {
                    Operator to = firstOperator.nextOp;
                    while(to.nextOp != null){
                        to = to.nextOp;
                    }
                    to.nextOp = temp;
                }
            } else {                             
                moreOperands = false;            
            }            
        }        
        Log.leaveParser("</factor>");
    }

    @Override void printTree() {
        Operand temp = first;
        Operator tempOperator = firstOperator;
 
        temp.printTree();

		temp = temp.nextOperand;
        while(temp != null){
			tempOperator.printTree();
			temp.printTree();

			tempOperator = tempOperator.nextOp;
			temp = temp.nextOperand;
		}
        //Must be changed in part one.
    }

    Operand whatOper() {
        if(Scanner.curToken == numberToken){
			return new Number();
		} else if(Scanner.curToken == subtractToken && Scanner.nextToken == numberToken) {
			return new Number();
        } else if(Scanner.curToken == nameToken && Scanner.nextToken == leftParToken) {
            return new FunctionCall();
        } else if(Scanner.curToken == nameToken) {
            return new Variable();
        } else if(Scanner.curToken == leftParToken) {
            return new Expression(true);
            
        } else {
            Error.expected("An operand");
        }
        return null; //Compiler is happy :D
    }
    
 

}

//-- Must be changed in part 1+2:

/*
 * An <operator>
 */
abstract class Operator extends SyntaxUnit {
    Operator nextOp = null;
    Type opType;
    Token opToken;

    @Override void check(DeclList curDecls) {
	}

}


//-- Must be changed in part 1+2:


/*
 * A relational operator (==, !=, <, <=, > or >=).
 */

class RelOperator extends Operator {
    @Override void genCode(FuncDecl curFunc) {
	if (opType == Types.doubleType) {
	    Code.genInstr("", "fldl", "(%esp)", "");
	    Code.genInstr("", "addl", "$8,%esp", "");
	    Code.genInstr("", "fsubp", "", "");
	    Code.genInstr("", "fstps", Code.tmpLabel, "");
	    Code.genInstr("", "cmpl", "$0,"+Code.tmpLabel, "");
	} else {
	    Code.genInstr("", "popl", "%ecx", "");
	    Code.genInstr("", "cmpl", "%eax,%ecx", "");
	}
	Code.genInstr("", "movl", "$0,%eax", "");
	switch (opToken) {
	case equalToken:        
	    Code.genInstr("", "sete", "%al", "Test ==");  break;
	case notEqualToken:
	    Code.genInstr("", "setne", "%al", "Test !=");  break;
	case lessToken:
	    Code.genInstr("", "setl", "%al", "Test <");  break;
	case lessEqualToken:
	    Code.genInstr("", "setle", "%al", "Test <=");  break;
	case greaterToken:
	    Code.genInstr("", "setg", "%al", "Test >");  break;
	case greaterEqualToken:
	    Code.genInstr("", "setge", "%al", "Test >=");  break;
	}
    }

    @Override void parse() {
	Log.enterParser("<rel operator>");

	opToken = Scanner.curToken;
	Scanner.readNext();

	Log.leaveParser("</rel operator>");
    }

    @Override void printTree() {
	String op = "?";
	switch (opToken) {
	case equalToken:        op = "==";  break;
	case notEqualToken:     op = "!=";  break;
	case lessToken:         op = "<";   break;
	case lessEqualToken:    op = "<=";  break;
	case greaterToken:      op = ">";   break;
	case greaterEqualToken: op = ">=";  break;
	}
	Log.wTree(" " + op + " ");
    }
}

class FactorOperator extends Operator {

	@Override void genCode(FuncDecl curFunc) {
		if(opType == Types.intType) {//ints
			Code.genInstr("", "movl", "%eax,%ecx", "");
			Code.genInstr("", "popl", "%eax", "");
			if(opToken == multiplyToken){
				Code.genInstr("", "imull", "%ecx,%eax", "Compute *");
			} else {
				Code.genInstr("", "cdq", "", "");
				Code.genInstr("", "idivl", "%ecx", "Compute /");
			}
		} else {//doubles
			Code.genInstr("", "fldl", "(%esp)", "");
			Code.genInstr("", "addl", "$8,%esp", "");
			if(opToken == multiplyToken){
				Code.genInstr("", "fmulp", "", "Compute *");
			} else {
				Code.genInstr("", "fdivp", "", "Compute /");
			}		

		}
	}

	@Override void parse() {
		Log.enterParser("<factor operator>");

		opToken = Scanner.curToken;
		Scanner.readNext();

		Log.leaveParser("</factor operator>");
	}

	@Override void printTree() {
		if(opToken == multiplyToken) {
			Log.wTree("*");
		} else if (opToken == divideToken) {
			Log.wTree("/");
		}
	}	
}


/*
 * An <operand>
 */
abstract class Operand extends SyntaxUnit {
    Operand nextOperand = null;
    Type valType;
}

/*
 * A <function call>.
 */
class FunctionCall extends Operand {
    String name;
    ExprList expr = new ExprList();
	FuncDecl decl = null;
	int numParams = 0;
	int exprSize = 0;

    @Override void check(DeclList curDecls) {
		decl = (FuncDecl)curDecls.findDecl(name, this);			
		valType = decl.type;
		expr.check(curDecls);
		
		int num = 1;
		Expression callParam = expr.firstExpr;
		Declaration functionParam = decl.params.firstDecl;
		while (callParam != null){
			if(functionParam == null) {
				Syntax.error(this, "Number of parameters in the function does not match the number in the function declaration.");
			}
			callParam.valType.checkType(lineNum, functionParam.type, "param number: " + num);	
			num++;
			functionParam = functionParam.nextDecl;
			callParam = callParam.nextExpr;
		}
	//-- Must be changed in part 2:
    }

    @Override void genCode(FuncDecl curFunc) {		
		if(expr.firstExpr != null){
			addParamsToStack(expr.firstExpr, curFunc);
		}
		Code.genInstr("", "call", decl.assemblerName, "call " + decl.name + "()");
		if(expr.firstExpr != null){
			Code.genInstr("", "addl", "$" + exprSize + ",%esp", "Remove parameters");
		}
		
	//-- Must be changed in part 2:
    }


	void addParamsToStack(Expression temp, FuncDecl curFunc){
		numParams ++;
		
		if(temp.nextExpr != null) {
			addParamsToStack(temp.nextExpr, curFunc);
		}
		temp.genCode(curFunc);
		
		if(temp.valType == Types.intType){
			exprSize += 4;
			Code.genInstr("", "pushl", "%eax", "");
		} else {
			exprSize += 8;
			Code.genInstr("", "subl", "$8,%esp", "");
			Code.genInstr("", "fstpl", "(%esp)", "");
		}	
		
			
		
	}

    @Override void parse() {
	Log.enterParser("<func-call>");
        
        if(Scanner.curToken == nameToken){
            name = Scanner.curName;
        }
        Scanner.skip(nameToken);
        Scanner.skip(leftParToken);
        expr.parse();
        Scanner.skip(rightParToken);
        
        Log.leaveParser("</func-call>");
    }

    @Override void printTree() {
        Log.wTree(name + "(");
        expr.printTree();
        Log.wTree(")");
	//-- Must be changed in part 1:
    }
    //-- Must be changed in part 1+2:
}


/*
 * A <number>.
 */
class Number extends Operand {
    int numVal;
	
   @Override void check(DeclList curDecls) {		
		valType = Types.intType;    
  	//-- Must be changed in part 2:
    }
	
    @Override void genCode(FuncDecl curFunc) {
		Code.genInstr("", "movl", "$" + numVal + ",%eax", "" + numVal); 
    }

    @Override void parse() {
	Log.enterParser("<number>");

        if(Scanner.curToken == numberToken){
            numVal = Scanner.curNum;
            Scanner.readNext();
		} else if (Scanner.curToken == subtractToken && Scanner.nextToken == numberToken ){
			Scanner.readNext();
			numVal = 0 - Scanner.curNum;       
			Scanner.readNext();
		} else {
            Error.expected("A number");
        }

        Log.leaveParser("</number>");
        //-- Must be changed in part 1:
    }

     @Override void printTree() {
	Log.wTree("" + numVal);
    }
}


/*
 * A <variable>.
 */

class Variable extends Operand {
    String varName;
    VarDecl declRef = null;
    Expression index = null;

    @Override void check(DeclList curDecls) {
		Declaration d = curDecls.findDecl(varName,this);
		if (index == null) {
		    d.checkWhetherSimpleVar(this);
		    valType = d.type;
		} else {
		    d.checkWhetherArray(this);
			index.check(curDecls);
			if(index.valType == null) System.err.println("Index valtype is null!");
		    index.valType.checkType(lineNum, Types.intType, "Array index");
		    valType = ((ArrayType)d.type).elemType;
		}
		declRef = (VarDecl)d;
	}

    @Override void genCode(FuncDecl curFunc) {
		if(index == null) {
			if(valType == Types.intType) {
				Code.genInstr("", "movl", declRef.assemblerName + ",%eax", "-" + varName);
			} else {
				Code.genInstr("", "fldl", declRef.assemblerName, varName);
			}
		} else { // For Array
			index.genCode(curFunc);
			Code.genInstr("", "leal", declRef.assemblerName + ",%edx", varName + "[ ]");
			if(valType == Types.intType) {
				Code.genInstr("", "movl", "(%edx,%eax,4),%eax", "");
			} else {
				Code.genInstr("", "fldl", "(%edx,%eax,8)", "");
			}


		}

	//-- Must be changed in part 2: 
    }

    @Override void parse() {
	Log.enterParser("<variable>");
        if(Scanner.curToken == nameToken){
            varName = Scanner.curName;
            Scanner.skip(nameToken);
            if(Scanner.curToken == leftBracketToken){
                Scanner.skip(leftBracketToken);
                index = new Expression();
                index.parse();
                Scanner.skip(rightBracketToken);
            }
        } else {
            Error.expected("A name");
        }
        
        Log.leaveParser("</variable>");

        //-- Must be changed in part 1:
    }

    @Override void printTree() {
        Log.wTree(varName);
		if(index != null){
			Log.wTree("[");
			index.printTree();
			Log.wTree("]");
		}
	//-- Must be changed in part 1:
    }
}
        
class Assignment extends SyntaxUnit{
    Expression expr = new Expression();
    Variable var = new Variable();

    @Override void check(DeclList curDecls) {

		var.check(curDecls);       

		expr.check(curDecls); 

		//Must be changed in part two.
    }

    @Override void genCode(FuncDecl curFunc) {       
		if(var.index != null){ //array
			var.index.genCode(curFunc);
			Code.genInstr("", "pushl", "%eax", "");
			
			expr.genCode(curFunc);
		
			VarDecl decl = var.declRef;
			ArrayType arrayType = (ArrayType)decl.type;
		

			Code.genInstr("", "leal", decl.assemblerName + ",%edx", "");
			Code.genInstr("", "popl", "%ecx", "");
			if(arrayType.elemType == Types.intType && expr.valType == Types.intType){
				Code.genInstr("", "movl", "%eax,(%edx,%ecx,4)", decl.name + "[ ] = ");
			} else if(arrayType.elemType == Types.intType && expr.valType == Types.doubleType) {
				Code.genInstr("", "fistpl", "(%edx,%ecx,4)", decl.name + "[ ] = (int)");
			} else if(arrayType.elemType == Types.doubleType && expr.valType == Types.doubleType) {
				Code.genInstr("", "fstpl", "(%edx,%ecx,8)", decl.name + "[ ] = ");
			} else if(arrayType.elemType == Types.doubleType && expr.valType == Types.intType) {
				Code.genInstr("", "movl", "%eax,.tmp", "");
				Code.genInstr("", "fildl", ".tmp", "");
				Code.genInstr("", "fstpl", "(%edx,%ecx,8)", decl.name + "[ ] = (double)");
			}
			// code-gen for array	
		} else {//not array
			expr.genCode(curFunc);
		
			VarDecl decl = var.declRef;
		
			if(decl.type == Types.intType && expr.valType == Types.intType){
				Code.genInstr("", "movl", "%eax," + decl.assemblerName, decl.name + " = ");
			} else if(decl.type == Types.intType && expr.valType == Types.doubleType) {
				Code.genInstr("", "fistpl", decl.assemblerName, decl.name + " = (int)");
			} else if(decl.type == Types.doubleType && expr.valType == Types.doubleType) {
				Code.genInstr("", "fstpl", decl.assemblerName, decl.name + " = ");
			} else if(decl.type == Types.doubleType && expr.valType == Types.intType) {
				Code.genInstr("", "movl", "%eax,.tmp", "");
				Code.genInstr("", "fildl", ".tmp", "");
				Code.genInstr("", "fstpl", decl.assemblerName, decl.name + " = (double)");
			}
		} 
		//Must be changed in part two.
    }

    @Override void parse() {
        Log.enterParser("<assignment>");

        var.parse();
        Scanner.skip(assignToken);
        expr.parse();
        

        Log.leaveParser("</assignment>");

    }

    @Override void printTree() {
        var.printTree();

        Log.wTree(" = ");

        expr.printTree();

        
        //Must be changed in part 1.
    }
 }
