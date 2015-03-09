        .data
.tmp:   .fill   4                       # Temporary storage
        .text
        .globl  mod                     
mod:    enter   $0,$0                   # Start function mod
        movl    8(%ebp),%eax            # -x
        pushl   %eax                    
        movl    8(%ebp),%eax            # -x
        pushl   %eax                    
        movl    12(%ebp),%eax           # -y
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        pushl   %eax                    
        movl    12(%ebp),%eax           # -y
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
        .globl  easter                  
easter: enter   $80,$0                  # Start function easter
        movl    $19,%eax                # 19
        pushl   %eax                    
        movl    8(%ebp),%eax            # -y
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        movl    %eax,-4(%ebp)           # a = 
        movl    8(%ebp),%eax            # -y
        pushl   %eax                    
        movl    $100,%eax               # 100
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        movl    %eax,-8(%ebp)           # b = 
        movl    $100,%eax               # 100
        pushl   %eax                    
        movl    8(%ebp),%eax            # -y
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        movl    %eax,-12(%ebp)          # c = 
        movl    -8(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $4,%eax                 # 4
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        movl    %eax,-16(%ebp)          # d = 
        movl    $4,%eax                 # 4
        pushl   %eax                    
        movl    -8(%ebp),%eax           # -b
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        movl    %eax,-20(%ebp)          # e = 
        movl    -8(%ebp),%eax           # -b
        pushl   %eax                    
        movl    $8,%eax                 # 8
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $25,%eax                # 25
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        movl    %eax,-24(%ebp)          # f = 
        movl    -8(%ebp),%eax           # -b
        pushl   %eax                    
        movl    -24(%ebp),%eax          # -f
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $3,%eax                 # 3
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        movl    %eax,-28(%ebp)          # g = 
        movl    $30,%eax                # 30
        pushl   %eax                    
        movl    $19,%eax                # 19
        pushl   %eax                    
        movl    -4(%ebp),%eax           # -a
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        pushl   %eax                    
        movl    -8(%ebp),%eax           # -b
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    -16(%ebp),%eax          # -d
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    -28(%ebp),%eax          # -g
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    $15,%eax                # 15
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        movl    %eax,-32(%ebp)          # h = 
        movl    -12(%ebp),%eax          # -c
        pushl   %eax                    
        movl    $4,%eax                 # 4
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        movl    %eax,-36(%ebp)          # i = 
        movl    $4,%eax                 # 4
        pushl   %eax                    
        movl    -12(%ebp),%eax          # -c
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        movl    %eax,-40(%ebp)          # k = 
        movl    $7,%eax                 # 7
        pushl   %eax                    
        movl    $32,%eax                # 32
        pushl   %eax                    
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    -20(%ebp),%eax          # -e
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    -36(%ebp),%eax          # -i
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    -32(%ebp),%eax          # -h
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    -40(%ebp),%eax          # -k
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        movl    %eax,-44(%ebp)          # l = 
        movl    -4(%ebp),%eax           # -a
        pushl   %eax                    
        movl    $11,%eax                # 11
        pushl   %eax                    
        movl    -32(%ebp),%eax          # -h
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $22,%eax                # 22
        pushl   %eax                    
        movl    -44(%ebp),%eax          # -l
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $451,%eax               # 451
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        movl    %eax,-48(%ebp)          # m = 
        movl    -32(%ebp),%eax          # -h
        pushl   %eax                    
        movl    -44(%ebp),%eax          # -l
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $7,%eax                 # 7
        pushl   %eax                    
        movl    -48(%ebp),%eax          # -m
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    $114,%eax               # 114
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $31,%eax                # 31
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        movl    %eax,-52(%ebp)          # month = 
        movl    $31,%eax                # 31
        pushl   %eax                    
        movl    -32(%ebp),%eax          # -h
        pushl   %eax                    
        movl    -44(%ebp),%eax          # -l
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        movl    $7,%eax                 # 7
        pushl   %eax                    
        movl    -48(%ebp),%eax          # -m
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        movl    $114,%eax               # 114
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-76(%ebp)          # day = 
                                        # Start if statement
        movl    -52(%ebp),%eax          # -month
        pushl   %eax                    
        movl    $3,%eax                 # 3
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        sete    %al                     # Test ==
        cmpl    $0,%eax                 
        je      .L0002                  
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $77,%eax                # 77
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $97,%eax                # 97
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    $114,%eax               # 114
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $3,%eax                 # 3
        pushl   %eax                    
        movl    $99,%eax                # 99
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $4,%eax                 # 4
        pushl   %eax                    
        movl    $104,%eax               # 104
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        jmp     .L0001                  
.L0002:                                 #  else
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $65,%eax                # 65
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $112,%eax               # 112
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    $114,%eax               # 114
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $3,%eax                 # 3
        pushl   %eax                    
        movl    $105,%eax               # 105
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
        movl    $4,%eax                 # 4
        pushl   %eax                    
        movl    $108,%eax               # 108
        leal    -72(%ebp),%edx          
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # m_name[ ] = 
.L0001:                                 # End if statement
        movl    -76(%ebp),%eax          # -day
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $0,%eax                 # 0
        movl    %eax,-80(%ebp)          # ix = 
.L0003:                                 # Start for statement
        movl    -80(%ebp),%eax          # -ix
        pushl   %eax                    
        movl    $5,%eax                 # 5
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0004                  
        movl    -80(%ebp),%eax          # -ix
        leal    -72(%ebp),%edx          # m_name[ ]
        movl    (%edx,%eax,4),%eax      
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    -80(%ebp),%eax          # -ix
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-80(%ebp)          # ix = 
        jmp     .L0003                  
.L0004:                                 # End for statement
.exit$easter:
        leave                           
        ret                             # End function easter
        .globl  main                    
main:   enter   $4,$0                   # Start function main
        movl    $2010,%eax              # 2010
        movl    %eax,-4(%ebp)           # y = 
.L0005:                                 # Start for statement
        movl    -4(%ebp),%eax           # -y
        pushl   %eax                    
        movl    $2020,%eax              # 2020
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        cmpl    $0,%eax                 
        je      .L0006                  
        movl    -4(%ebp),%eax           # -y
        pushl   %eax                    
        call    easter                  # call easter()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    -4(%ebp),%eax           # -y
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
        movl    $10,%eax                # 10
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    -4(%ebp),%eax           # -y
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # y = 
        jmp     .L0005                  
.L0006:                                 # End for statement
.exit$main:
        leave                           
        ret                             # End function main
