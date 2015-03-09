        .data
.tmp:   .fill   4                       # Temporary storage
        .globl  ten
ten:    .fill   8                       # double  ten;
        .globl  two
two:    .fill   8                       # double  two;
        .globl  one
one:    .fill   8                       # double  one;
        .globl  tenth
tenth:  .fill   8                       # double  tenth;
        .text
        .globl  mod                     
mod:    enter   $0,$0                   # Start function mod
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        jmp     .exit$mod               # Return
.exit$mod:
        leave                           
        ret                             # End function mod
        .globl  rough_log               
rough_log:
        enter   $0,$0                   # Start function rough_log
                                        # Start if statement
        fldl    8(%ebp)                 # x
        subl    $8, %esp                
        fstpl   (%esp)                  
        fldl    ten                     # ten
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        setg    %al                     # Test >
        cmpl    $0,%eax                 
        je      .L0001                  
        fldl    8(%ebp)                 # x
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    ten                     # ten
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        subl    $8,%esp                 
        fstpl   (%esp)                  
        call    rough_log               # call rough_log()
        addl    $8,%esp                 # Remove parameters
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        jmp     .exit$rough_log         # Return
.L0001:                                 # End if statement
                                        # Start if statement
        fldl    8(%ebp)                 # x
        subl    $8, %esp                
        fstpl   (%esp)                  
        fldl    tenth                   # tenth
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0002                  
        fldl    8(%ebp)                 # x
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    ten                     # ten
        fldl    (%esp)                  
        addl    $8,%esp                 
        fmulp                           # Compute *
        subl    $8,%esp                 
        fstpl   (%esp)                  
        call    rough_log               # call rough_log()
        addl    $8,%esp                 # Remove parameters
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        jmp     .exit$rough_log         # Return
.L0002:                                 # End if statement
        movl    $1,%eax                 # 1
        jmp     .exit$rough_log         # Return
.exit$rough_log:
        leave                           
        ret                             # End function rough_log
        .globl  power                   
power:  enter   $8,$0                   # Start function power
        movl    $1,%eax                 # 1
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   -8(%ebp)                # p = (double)
.L0003:                                 # Start while-statement
        movl    16(%ebp),%eax           # -n
        pushl   %eax                    
        movl    $0,%eax                 # 0
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setg    %al                     # Test >
        cmpl    $0,%eax                 
        je      .L0004                  
        fldl    -8(%ebp)                # p
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    8(%ebp)                 # x
        fldl    (%esp)                  
        addl    $8,%esp                 
        fmulp                           # Compute *
        fstpl   -8(%ebp)                # p = 
        movl    16(%ebp),%eax           # -n
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        movl    %eax,16(%ebp)           # n = 
        jmp     .L0003                  
.L0004:                                 # End while-statement
.L0005:                                 # Start while-statement
        movl    16(%ebp),%eax           # -n
        pushl   %eax                    
        movl    $0,%eax                 # 0
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0006                  
        fldl    -8(%ebp)                # p
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    8(%ebp)                 # x
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        fstpl   -8(%ebp)                # p = 
        movl    16(%ebp),%eax           # -n
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,16(%ebp)           # n = 
        jmp     .L0005                  
.L0006:                                 # End while-statement
        fldl    -8(%ebp)                # p
        jmp     .exit$power             # Return
        fldz                            
.exit$power:
        leave                           
        ret                             # End function power
        .globl  sqrt                    
sqrt:   enter   $104,$0                 # Start function sqrt
        fldl    8(%ebp)                 # v
        subl    $8,%esp                 
        fstpl   (%esp)                  
        call    rough_log               # call rough_log()
        addl    $8,%esp                 # Remove parameters
        movl    %eax,-4(%ebp)           # d = 
                                        # Start if statement
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    -4(%ebp),%eax           # -d
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        pushl   %eax                    
        movl    $1,%eax                 # 1
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        sete    %al                     # Test ==
        cmpl    $0,%eax                 
        je      .L0008                  
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $2,%eax                 # 2
        leal    -104(%ebp),%edx         
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   (%edx,%ecx,8)           # x[ ] = (double)
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    -104(%ebp),%edx         # x[ ]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  
        movl    -4(%ebp),%eax           # -d
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    $2,%eax                 # 2
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        pushl   %eax                    
        fldl    ten                     # ten
        subl    $8,%esp                 
        fstpl   (%esp)                  
        call    power                   # call power()
        addl    $12,%esp                # Remove parameters
        fldl    (%esp)                  
        addl    $8,%esp                 
        fmulp                           # Compute *
        leal    -104(%ebp),%edx         
        popl    %ecx                    
        fstpl   (%edx,%ecx,8)           # x[ ] = 
        jmp     .L0007                  
.L0008:                                 #  else
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $6,%eax                 # 6
        leal    -104(%ebp),%edx         
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   (%edx,%ecx,8)           # x[ ] = (double)
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    -104(%ebp),%edx         # x[ ]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  
        movl    -4(%ebp),%eax           # -d
        pushl   %eax                    
        movl    $2,%eax                 # 2
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    $2,%eax                 # 2
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        pushl   %eax                    
        fldl    ten                     # ten
        subl    $8,%esp                 
        fstpl   (%esp)                  
        call    power                   # call power()
        addl    $12,%esp                # Remove parameters
        fldl    (%esp)                  
        addl    $8,%esp                 
        fmulp                           # Compute *
        leal    -104(%ebp),%edx         
        popl    %ecx                    
        fstpl   (%edx,%ecx,8)           # x[ ] = 
.L0007:                                 # End if statement
        movl    $1,%eax                 # 1
        movl    %eax,-8(%ebp)           # ix = 
.L0009:                                 # Start for statement
        movl    -8(%ebp),%eax           # -ix
        pushl   %eax                    
        movl    $12,%eax                # 12
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0010                  
        movl    -8(%ebp),%eax           # -ix
        pushl   %eax                    
        movl    -8(%ebp),%eax           # -ix
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        leal    -104(%ebp),%edx         # x[ ]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    8(%ebp)                 # v
        subl    $8,%esp                 
        fstpl   (%esp)                  
        movl    -8(%ebp),%eax           # -ix
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        leal    -104(%ebp),%edx         # x[ ]
        fldl    (%edx,%eax,8)           
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        fldl    (%esp)                  
        addl    $8,%esp                 
        faddp                           # Compute +
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    two                     # two
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        leal    -104(%ebp),%edx         
        popl    %ecx                    
        fstpl   (%edx,%ecx,8)           # x[ ] = 
        movl    -8(%ebp),%eax           # -ix
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-8(%ebp)           # ix = 
        jmp     .L0009                  
.L0010:                                 # End for statement
        movl    $11,%eax                # 11
        leal    -104(%ebp),%edx         # x[ ]
        fldl    (%edx,%eax,8)           
        jmp     .exit$sqrt              # Return
        fldz                            
.exit$sqrt:
        leave                           
        ret                             # End function sqrt
        .globl  main                    
main:   enter   $0,$0                   # Start function main
        movl    $10,%eax                # 10
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   ten                     # ten = (double)
        movl    $2,%eax                 # 2
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   two                     # two = (double)
        movl    $1,%eax                 # 1
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   one                     # one = (double)
        fldl    one                     # one
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    ten                     # ten
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        fstpl   tenth                   # tenth = 
        movl    $63,%eax                # 63
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        call    getdouble               # call getdouble()
        subl    $8,%esp                 
        fstpl   (%esp)                  
        call    sqrt                    # call sqrt()
        addl    $8,%esp                 # Remove parameters
        subl    $8,%esp                 
        fstpl   (%esp)                  
        call    putdouble               # call putdouble()
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    
        movl    $10,%eax                # 10
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
