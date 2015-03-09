        .data
.tmp:   .fill   4                       # Temporary storage
        .globl  s
s:      .fill   804                     # int array  s [ 201] ;
        .globl  true
true:   .fill   4                       # int  true;
        .globl  false
false:  .fill   4                       # int  false;
        .globl  LF
LF:     .fill   4                       # int  LF;
        .text
        .globl  getstring               
getstring:
        enter   $8,$0                   # Start function getstring
        movl    $0,%eax                 # 0
        movl    %eax,-4(%ebp)           # i = 
.L0001:                                 # Start while-statement
        movl    true,%eax               # -true
        cmpl    $0,%eax                 
        je      .L0002                  
        call    getchar                 # call getchar()
        movl    %eax,-8(%ebp)           # c = 
                                        # Start if statement
        movl    -8(%ebp),%eax           # -c
        pushl   %eax                    
        movl    LF,%eax                 # -LF
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        sete    %al                     # Test ==
        cmpl    $0,%eax                 
        je      .L0003                  
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    s,%edx                  
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # s[ ] = 
        movl    $0,%eax                 # 0
        jmp     .exit$getstring         # Return
.L0003:                                 # End if statement
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    -8(%ebp),%eax           # -c
        leal    s,%edx                  
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # s[ ] = 
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i = 
        jmp     .L0001                  
.L0002:                                 # End while-statement
.exit$getstring:
        leave                           
        ret                             # End function getstring
        .globl  p1                      
p1:     enter   $0,$0                   # Start function p1
        movl    8(%ebp),%eax            # -c1
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.exit$p1:
        leave                           
        ret                             # End function p1
        .globl  p2                      
p2:     enter   $0,$0                   # Start function p2
        movl    8(%ebp),%eax            # -c1
        pushl   %eax                    
        call    p1                      # call p1()
        addl    $4,%esp                 # Remove parameters
        movl    12(%ebp),%eax           # -c2
        pushl   %eax                    
        call    p1                      # call p1()
        addl    $4,%esp                 # Remove parameters
.exit$p2:
        leave                           
        ret                             # End function p2
        .globl  p3                      
p3:     enter   $0,$0                   # Start function p3
        movl    12(%ebp),%eax           # -c2
        pushl   %eax                    
        movl    8(%ebp),%eax            # -c1
        pushl   %eax                    
        call    p2                      # call p2()
        addl    $8,%esp                 # Remove parameters
        movl    16(%ebp),%eax           # -c3
        pushl   %eax                    
        call    p1                      # call p1()
        addl    $4,%esp                 # Remove parameters
.exit$p3:
        leave                           
        ret                             # End function p3
        .globl  p4                      
p4:     enter   $0,$0                   # Start function p4
        movl    16(%ebp),%eax           # -c3
        pushl   %eax                    
        movl    12(%ebp),%eax           # -c2
        pushl   %eax                    
        movl    8(%ebp),%eax            # -c1
        pushl   %eax                    
        call    p3                      # call p3()
        addl    $12,%esp                # Remove parameters
        movl    20(%ebp),%eax           # -c4
        pushl   %eax                    
        call    p1                      # call p1()
        addl    $4,%esp                 # Remove parameters
.exit$p4:
        leave                           
        ret                             # End function p4
        .globl  p12                     
p12:    enter   $0,$0                   # Start function p12
        movl    20(%ebp),%eax           # -c4
        pushl   %eax                    
        movl    16(%ebp),%eax           # -c3
        pushl   %eax                    
        movl    12(%ebp),%eax           # -c2
        pushl   %eax                    
        movl    8(%ebp),%eax            # -c1
        pushl   %eax                    
        call    p4                      # call p4()
        addl    $16,%esp                # Remove parameters
        movl    36(%ebp),%eax           # -c8
        pushl   %eax                    
        movl    32(%ebp),%eax           # -c7
        pushl   %eax                    
        movl    28(%ebp),%eax           # -c6
        pushl   %eax                    
        movl    24(%ebp),%eax           # -c5
        pushl   %eax                    
        call    p4                      # call p4()
        addl    $16,%esp                # Remove parameters
        movl    52(%ebp),%eax           # -c12
        pushl   %eax                    
        movl    48(%ebp),%eax           # -c11
        pushl   %eax                    
        movl    44(%ebp),%eax           # -c10
        pushl   %eax                    
        movl    40(%ebp),%eax           # -c9
        pushl   %eax                    
        call    p4                      # call p4()
        addl    $16,%esp                # Remove parameters
.exit$p12:
        leave                           
        ret                             # End function p12
        .globl  putstring               
putstring:
        enter   $8,$0                   # Start function putstring
        movl    $0,%eax                 # 0
        movl    %eax,-4(%ebp)           # i = 
.L0004:                                 # Start while-statement
        movl    -4(%ebp),%eax           # -i
        leal    s,%edx                  # s[ ]
        movl    (%edx,%eax,4),%eax      
        cmpl    $0,%eax                 
        je      .L0005                  
        movl    -4(%ebp),%eax           # -i
        leal    s,%edx                  # s[ ]
        movl    (%edx,%eax,4),%eax      
        movl    %eax,-8(%ebp)           # c = 
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i = 
        movl    -8(%ebp),%eax           # -c
        pushl   %eax                    
        call    p1                      # call p1()
        addl    $4,%esp                 # Remove parameters
        jmp     .L0004                  
.L0005:                                 # End while-statement
.exit$putstring:
        leave                           
        ret                             # End function putstring
        .globl  strlen                  
strlen: enter   $4,$0                   # Start function strlen
        movl    $0,%eax                 # 0
        movl    %eax,-4(%ebp)           # i = 
.L0006:                                 # Start while-statement
        movl    -4(%ebp),%eax           # -i
        leal    s,%edx                  # s[ ]
        movl    (%edx,%eax,4),%eax      
        cmpl    $0,%eax                 
        je      .L0007                  
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i = 
        jmp     .L0006                  
.L0007:                                 # End while-statement
        movl    -4(%ebp),%eax           # -i
        jmp     .exit$strlen            # Return
.exit$strlen:
        leave                           
        ret                             # End function strlen
        .globl  is_palindrome           
is_palindrome:
        enter   $8,$0                   # Start function is_palindrome
        movl    $0,%eax                 # 0
        movl    %eax,-4(%ebp)           # i1 = 
        call    strlen                  # call strlen()
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        movl    %eax,-8(%ebp)           # i2 = 
.L0008:                                 # Start while-statement
        movl    -4(%ebp),%eax           # -i1
        pushl   %eax                    
        movl    -8(%ebp),%eax           # -i2
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0009                  
                                        # Start if statement
        movl    -4(%ebp),%eax           # -i1
        leal    s,%edx                  # s[ ]
        movl    (%edx,%eax,4),%eax      
        pushl   %eax                    
        movl    -8(%ebp),%eax           # -i2
        leal    s,%edx                  # s[ ]
        movl    (%edx,%eax,4),%eax      
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setne   %al                     # Test !=
        cmpl    $0,%eax                 
        je      .L0010                  
        movl    false,%eax              # -false
        jmp     .exit$is_palindrome     # Return
.L0010:                                 # End if statement
        movl    -4(%ebp),%eax           # -i1
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i1 = 
        movl    -8(%ebp),%eax           # -i2
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        movl    %eax,-8(%ebp)           # i2 = 
        jmp     .L0008                  
.L0009:                                 # End while-statement
        movl    true,%eax               # -true
        jmp     .exit$is_palindrome     # Return
.exit$is_palindrome:
        leave                           
        ret                             # End function is_palindrome
        .globl  main                    
main:   enter   $4,$0                   # Start function main
        movl    $0,%eax                 # 0
        movl    %eax,false              # false = 
        movl    $1,%eax                 # 1
        movl    %eax,true               # true = 
        movl    $10,%eax                # 10
        movl    %eax,LF                 # LF = 
.L0011:                                 # Start while-statement
        movl    true,%eax               # -true
        cmpl    $0,%eax                 
        je      .L0012                  
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $63,%eax                # 63
        pushl   %eax                    
        call    p2                      # call p2()
        addl    $8,%esp                 # Remove parameters
        call    getstring               # call getstring()
                                        # Start if statement
        call    strlen                  # call strlen()
        pushl   %eax                    
        movl    $0,%eax                 # 0
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        sete    %al                     # Test ==
        cmpl    $0,%eax                 
        je      .L0013                  
        movl    $0,%eax                 # 0
        pushl   %eax                    
        call    exit                    # call exit()
        addl    $4,%esp                 # Remove parameters
.L0013:                                 # End if statement
        movl    $34,%eax                # 34
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        call    putstring               # call putstring()
        movl    $34,%eax                # 34
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $115,%eax               # 115
        pushl   %eax                    
        movl    $105,%eax               # 105
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    p4                      # call p4()
        addl    $16,%esp                # Remove parameters
        call    is_palindrome           # call is_palindrome()
        pushl   %eax                    
        movl    $0,%eax                 # 0
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        sete    %al                     # Test ==
        movl    %eax,-4(%ebp)           # no_p = 
                                        # Start if statement
        movl    -4(%ebp),%eax           # -no_p
        cmpl    $0,%eax                 
        je      .L0014                  
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $111,%eax               # 111
        pushl   %eax                    
        movl    $110,%eax               # 110
        pushl   %eax                    
        call    p3                      # call p3()
        addl    $12,%esp                # Remove parameters
.L0014:                                 # End if statement
        movl    LF,%eax                 # -LF
        pushl   %eax                    
        movl    $46,%eax                # 46
        pushl   %eax                    
        movl    $101,%eax               # 101
        pushl   %eax                    
        movl    $109,%eax               # 109
        pushl   %eax                    
        movl    $111,%eax               # 111
        pushl   %eax                    
        movl    $114,%eax               # 114
        pushl   %eax                    
        movl    $100,%eax               # 100
        pushl   %eax                    
        movl    $110,%eax               # 110
        pushl   %eax                    
        movl    $105,%eax               # 105
        pushl   %eax                    
        movl    $108,%eax               # 108
        pushl   %eax                    
        movl    $97,%eax                # 97
        pushl   %eax                    
        movl    $112,%eax               # 112
        pushl   %eax                    
        call    p12                     # call p12()
        addl    $48,%esp                # Remove parameters
        jmp     .L0011                  
.L0012:                                 # End while-statement
.exit$main:
        leave                           
        ret                             # End function main
