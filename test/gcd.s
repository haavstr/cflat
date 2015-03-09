        .data
.tmp:   .fill   4                       # Temporary storage
        .globl  LF
LF:     .fill   4                       # int  LF;
        .text
        .globl  gcd                     
gcd:    enter   $0,$0                   # Start function gcd
.L0001:                                 # Start while-statement
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setne   %al                     # Test !=
        cmpl    $0,%eax                 
        je      .L0002                  
                                        # Start if statement
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0004                  
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        movl    %eax,12(%ebp)           # b = 
        jmp     .L0003                  
.L0004:                                 #  else
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        movl    %eax,8(%ebp)            # a = 
.L0003:                                 # End if statement
        jmp     .L0001                  
.L0002:                                 # End while-statement
        movl    8(%ebp),%eax            # -a
        jmp     .exit$gcd               # Return
.exit$gcd:
        leave                           
        ret                             # End function gcd
        .globl  main                    
main:   enter   $8,$0                   # Start function main
        movl    $10,%eax                # 10
        movl    %eax,LF                 # LF = 
        movl    $63,%eax                # 63
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        call    getint                  # call getint()
        movl    %eax,-4(%ebp)           # v1 = 
        call    getint                  # call getint()
        movl    %eax,-8(%ebp)           # v2 = 
        movl    -8(%ebp),%eax           # -v2
        pushl   %eax                    
        movl    -4(%ebp),%eax           # -v1
        pushl   %eax                    
        call    gcd                     # call gcd()
        addl    $8,%esp                 # Remove parameters
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
        movl    LF,%eax                 # -LF
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $0,%eax                 # 0
        pushl   %eax                    
        call    exit                    # call exit()
        addl    $4,%esp                 # Remove parameters
.exit$main:
        leave                           
        ret                             # End function main
