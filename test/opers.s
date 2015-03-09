        .data
.tmp:   .fill   4                       # Temporary storage
        .text
        .globl  print                   
print:  enter   $0,$0                   # Start function print
        movl    8(%ebp),%eax            # -x
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    12(%ebp),%eax           # -op1
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
                                        # Start if statement
        movl    16(%ebp),%eax           # -op2
        pushl   %eax                    
        movl    $32,%eax                # 32
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setne   %al                     # Test !=
        cmpl    $0,%eax                 
        je      .L0001                  
        movl    16(%ebp),%eax           # -op2
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.L0001:                                 # End if statement
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    20(%ebp),%eax           # -y
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $61,%eax                # 61
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    24(%ebp),%eax           # -res
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
        movl    $10,%eax                # 10
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.exit$print:
        leave                           
        ret                             # End function print
        .globl  test                    
test:   enter   $0,$0                   # Start function test
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $43,%eax                # 43
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $45,%eax                # 45
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $42,%eax                # 42
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $47,%eax                # 47
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        sete    %al                     # Test ==
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $61,%eax                # 61
        pushl   %eax                    
        movl    $61,%eax                # 61
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setne   %al                     # Test !=
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $61,%eax                # 61
        pushl   %eax                    
        movl    $33,%eax                # 33
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $60,%eax                # 60
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $61,%eax                # 61
        pushl   %eax                    
        movl    $60,%eax                # 60
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setg    %al                     # Test >
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $62,%eax                # 62
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setge   %al                     # Test >=
        pushl   %eax                    
        movl    12(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $61,%eax                # 61
        pushl   %eax                    
        movl    $62,%eax                # 62
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        call    print                   # call print()
        addl    $20,%esp                # Remove parameters
.exit$test:
        leave                           
        ret                             # End function test
        .globl  main                    
main:   enter   $32,$0                  # Start function main
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $-3,%eax                # -3
        leal    -12(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # va[ ] = 
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    -12(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # va[ ] = 
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    $17,%eax                # 17
        leal    -12(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # va[ ] = 
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $-32,%eax               # -32
        leal    -24(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # vb[ ] = 
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $2,%eax                 # 2
        leal    -24(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # vb[ ] = 
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    $17,%eax                # 17
        leal    -24(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # vb[ ] = 
        movl    $0,%eax                 # 0
        movl    %eax,-28(%ebp)          # ia = 
.L0002:                                 # Start for statement
        movl    -28(%ebp),%eax          # -ia
        pushl   %eax                    
        movl    $3,%eax                 # 3
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0003                  
        movl    $0,%eax                 # 0
        movl    %eax,-32(%ebp)          # ib = 
.L0004:                                 # Start for statement
        movl    -32(%ebp),%eax          # -ib
        pushl   %eax                    
        movl    $3,%eax                 # 3
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0005                  
        movl    -32(%ebp),%eax          # -ib
        leal    -24(%ebp),%edx          # vb[ ]
        movl    (%edx,%eax,4),%eax      
        pushl   %eax                    
        movl    -28(%ebp),%eax          # -ia
        leal    -12(%ebp),%edx          # va[ ]
        movl    (%edx,%eax,4),%eax      
        pushl   %eax                    
        call    test                    # call test()
        addl    $8,%esp                 # Remove parameters
        movl    -32(%ebp),%eax          # -ib
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-32(%ebp)          # ib = 
        jmp     .L0004                  
.L0005:                                 # End for statement
        movl    -28(%ebp),%eax          # -ia
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-28(%ebp)          # ia = 
        jmp     .L0002                  
.L0003:                                 # End for statement
.exit$main:
        leave                           
        ret                             # End function main
