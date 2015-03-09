        .data
.tmp:   .fill   4                       # Temporary storage
        .globl  LF
LF:     .fill   4                       # int LF;
        .globl  TAB
TAB:    .fill   4                       # int TAB;
        .text
        .globl  print                   
print:  enter   $0,$0                   # Start function print
        fldl    8(%ebp)                 # x
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    putdouble               # Call putdouble
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    # Remove return value.
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    16(%ebp),%eax           # op1
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
                                        # Start if-statement
        movl    20(%ebp),%eax           # op2
        pushl   %eax                    
        movl    $32,%eax                # 32
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setne   %al                     # Test !=
        cmpl    $0,%eax                 
        je      .L0001                  
        movl    20(%ebp),%eax           # op2
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
.L0001:                                 # End if-statement
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        fldl    24(%ebp)                # y
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    putdouble               # Call putdouble
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    # Remove return value.
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        fldl    32(%ebp)                # res
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    putdouble               # Call putdouble
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    # Remove return value.
        movl    LF,%eax                 # LF
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
.exit$print:
        leave                           
        ret                             # End function print
        .globl  prini                   
prini:  enter   $0,$0                   # Start function prini
        fldl    8(%ebp)                 # x
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    putdouble               # Call putdouble
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    # Remove return value.
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    16(%ebp),%eax           # op1
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
                                        # Start if-statement
        movl    20(%ebp),%eax           # op2
        pushl   %eax                    
        movl    $32,%eax                # 32
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setne   %al                     # Test !=
        cmpl    $0,%eax                 
        je      .L0002                  
        movl    20(%ebp),%eax           # op2
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
.L0002:                                 # End if-statement
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        fldl    24(%ebp)                # y
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    putdouble               # Call putdouble
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    # Remove return value.
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    32(%ebp),%eax           # res
        pushl   %eax                    # Push parameter #1
        call    putint                  # Call putint
        addl    $4,%esp                 # Remove parameters
        movl    LF,%eax                 # LF
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
.exit$prini:
        leave                           
        ret                             # End function prini
        .globl  test                    
test:   enter   $0,$0                   # Start function test
        movl    LF,%eax                 # LF
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        faddp                           # Compute +
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #3
        movl    $43,%eax                # 43
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    print                   # Call print
        addl    $32,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           # Compute -
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #3
        movl    $45,%eax                # 45
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    print                   # Call print
        addl    $32,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fmulp                           # Compute *
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #3
        movl    $42,%eax                # 42
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    print                   # Call print
        addl    $32,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #3
        movl    $47,%eax                # 47
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    print                   # Call print
        addl    $32,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        sete    %al                     # Test ==
        pushl   %eax                    # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #3
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    prini                   # Call prini
        addl    $28,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        setne   %al                     # Test !=
        pushl   %eax                    # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #3
        movl    $33,%eax                # 33
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    prini                   # Call prini
        addl    $28,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        setl    %al                     # Test <
        pushl   %eax                    # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #3
        movl    $60,%eax                # 60
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    prini                   # Call prini
        addl    $28,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        setle   %al                     # Test <=
        pushl   %eax                    # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #3
        movl    $60,%eax                # 60
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    prini                   # Call prini
        addl    $28,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        setg    %al                     # Test >
        pushl   %eax                    # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #3
        movl    $62,%eax                # 62
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    prini                   # Call prini
        addl    $28,%esp                # Remove parameters
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    16(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        setge   %al                     # Test >=
        pushl   %eax                    # Push parameter #5
        fldl    16(%ebp)                # b
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #4
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #3
        movl    $62,%eax                # 62
        pushl   %eax                    # Push parameter #2
        fldl    8(%ebp)                 # a
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    prini                   # Call prini
        addl    $28,%esp                # Remove parameters
.exit$test:
        leave                           
        ret                             # End function test
        .globl  main                    
main:   enter   $64,$0                  # Start function main
        movl    $100,%eax               # 100
        movl    %eax,.tmp               
        fildl   .tmp                    #   (double)
        fstpl   -56(%ebp)               # c =
        movl    $9,%eax                 # 9
        movl    %eax,TAB                # TAB =
        movl    $10,%eax                # 10
        movl    %eax,LF                 # LF =
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $-314,%eax              # -314
        leal    -24(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    #   (double)
        fstpl   (%edx,%ecx,8)           # va[...] =
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    -24(%ebp),%edx          # va[...]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    -56(%ebp)               # c
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        leal    -24(%ebp),%edx          
        popl    %ecx                    
        fstpl   (%edx,%ecx,8)           # va[...] =
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    -24(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    #   (double)
        fstpl   (%edx,%ecx,8)           # va[...] =
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    $17,%eax                # 17
        leal    -24(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    #   (double)
        fstpl   (%edx,%ecx,8)           # va[...] =
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $-5,%eax                # -5
        leal    -48(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    #   (double)
        fstpl   (%edx,%ecx,8)           # vb[...] =
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    -48(%ebp),%edx          # vb[...]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  
        fldl    -56(%ebp)               # c
        fldl    (%esp)                  
        addl    $8,%esp                 
        fdivp                           # Compute /
        leal    -48(%ebp),%edx          
        popl    %ecx                    
        fstpl   (%edx,%ecx,8)           # vb[...] =
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $2,%eax                 # 2
        leal    -48(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    #   (double)
        fstpl   (%edx,%ecx,8)           # vb[...] =
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    $17,%eax                # 17
        leal    -48(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,.tmp               
        fildl   .tmp                    #   (double)
        fstpl   (%edx,%ecx,8)           # vb[...] =
        movl    $0,%eax                 # 0
        movl    %eax,-60(%ebp)          # ia =
.L0003:                                 # Start for-statement
        movl    -60(%ebp),%eax          # ia
        pushl   %eax                    
        movl    $3,%eax                 # 3
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0004                  
        movl    $118,%eax               # 118
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $97,%eax                # 97
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $91,%eax                # 91
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    -60(%ebp),%eax          # ia
        pushl   %eax                    # Push parameter #1
        call    putint                  # Call putint
        addl    $4,%esp                 # Remove parameters
        movl    $93,%eax                # 93
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    -60(%ebp),%eax          # ia
        leal    -24(%ebp),%edx          # va[...]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    putdouble               # Call putdouble
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    # Remove return value.
        movl    TAB,%eax                # TAB
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $118,%eax               # 118
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $98,%eax                # 98
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $91,%eax                # 91
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    -60(%ebp),%eax          # ia
        pushl   %eax                    # Push parameter #1
        call    putint                  # Call putint
        addl    $4,%esp                 # Remove parameters
        movl    $93,%eax                # 93
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $61,%eax                # 61
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    -60(%ebp),%eax          # ia
        leal    -48(%ebp),%edx          # vb[...]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    putdouble               # Call putdouble
        addl    $8,%esp                 # Remove parameters
        fstps   .tmp                    # Remove return value.
        movl    LF,%eax                 # LF
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    -60(%ebp),%eax          # ia
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-60(%ebp)          # ia =
        jmp     .L0003                  
.L0004:                                 # End for-statement
        movl    LF,%eax                 # LF
        pushl   %eax                    # Push parameter #1
        call    putchar                 # Call putchar
        addl    $4,%esp                 # Remove parameters
        movl    $0,%eax                 # 0
        movl    %eax,-60(%ebp)          # ia =
.L0005:                                 # Start for-statement
        movl    -60(%ebp),%eax          # ia
        pushl   %eax                    
        movl    $3,%eax                 # 3
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0006                  
        movl    $0,%eax                 # 0
        movl    %eax,-64(%ebp)          # ib =
.L0007:                                 # Start for-statement
        movl    -64(%ebp),%eax          # ib
        pushl   %eax                    
        movl    $3,%eax                 # 3
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0008                  
        movl    -64(%ebp),%eax          # ib
        leal    -48(%ebp),%edx          # vb[...]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #2
        movl    -60(%ebp),%eax          # ia
        leal    -24(%ebp),%edx          # va[...]
        fldl    (%edx,%eax,8)           
        subl    $8,%esp                 
        fstpl   (%esp)                  # Push parameter #1
        call    test                    # Call test
        addl    $16,%esp                # Remove parameters
        movl    -64(%ebp),%eax          # ib
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-64(%ebp)          # ib =
        jmp     .L0007                  
.L0008:                                 # End for-statement
        movl    -60(%ebp),%eax          # ia
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-60(%ebp)          # ia =
        jmp     .L0005                  
.L0006:                                 # End for-statement
.exit$main:
        leave                           
        ret                             # End function main
