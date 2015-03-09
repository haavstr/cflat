        .data
.tmp:   .fill   4                       # Temporary storage
        .globl  prime
prime:  .fill   4004                    # int array  prime [ 1001] ;
        .globl  LF
LF:     .fill   4                       # int  LF;
        .text
        .globl  find_primes             
find_primes:
        enter   $8,$0                   # Start function find_primes
        movl    $2,%eax                 # 2
        movl    %eax,-4(%ebp)           # i1 = 
.L0001:                                 # Start for statement
        movl    -4(%ebp),%eax           # -i1
        pushl   %eax                    
        movl    $1000,%eax              # 1000
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        cmpl    $0,%eax                 
        je      .L0002                  
        movl    $2,%eax                 # 2
        pushl   %eax                    
        movl    -4(%ebp),%eax           # -i1
        movl    %eax,%ecx               
        popl    %eax                    
        imull   %ecx,%eax               # Compute *
        movl    %eax,-8(%ebp)           # i2 = 
.L0003:                                 # Start for statement
        movl    -8(%ebp),%eax           # -i2
        pushl   %eax                    
        movl    $1000,%eax              # 1000
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        cmpl    $0,%eax                 
        je      .L0004                  
        movl    -8(%ebp),%eax           # -i2
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    prime,%edx              
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # prime[ ] = 
        movl    -8(%ebp),%eax           # -i2
        pushl   %eax                    
        movl    -4(%ebp),%eax           # -i1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-8(%ebp)           # i2 = 
        jmp     .L0003                  
.L0004:                                 # End for statement
        movl    -4(%ebp),%eax           # -i1
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i1 = 
        jmp     .L0001                  
.L0002:                                 # End for statement
.exit$find_primes:
        leave                           
        ret                             # End function find_primes
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
        .globl  n_chars                 
n_chars:
        enter   $0,$0                   # Start function n_chars
                                        # Start if statement
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    $0,%eax                 # 0
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setl    %al                     # Test <
        cmpl    $0,%eax                 
        je      .L0005                  
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    8(%ebp),%eax            # -a
        movl    %eax,%ecx               
        popl    %eax                    
        subl    %ecx,%eax               # Compute -
        pushl   %eax                    
        call    n_chars                 # call n_chars()
        addl    $4,%esp                 # Remove parameters
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        jmp     .exit$n_chars           # Return
.L0005:                                 # End if statement
                                        # Start if statement
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    $9,%eax                 # 9
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        cmpl    $0,%eax                 
        je      .L0006                  
        movl    $1,%eax                 # 1
        jmp     .exit$n_chars           # Return
.L0006:                                 # End if statement
        movl    8(%ebp),%eax            # -a
        pushl   %eax                    
        movl    $10,%eax                # 10
        movl    %eax,%ecx               
        popl    %eax                    
        cdq                             
        idivl   %ecx                    # Compute /
        pushl   %eax                    
        call    n_chars                 # call n_chars()
        addl    $4,%esp                 # Remove parameters
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        jmp     .exit$n_chars           # Return
.exit$n_chars:
        leave                           
        ret                             # End function n_chars
        .globl  pn                      
pn:     enter   $4,$0                   # Start function pn
        movl    8(%ebp),%eax            # -v
        pushl   %eax                    
        call    n_chars                 # call n_chars()
        addl    $4,%esp                 # Remove parameters
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i = 
.L0007:                                 # Start for statement
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    12(%ebp),%eax           # -w
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        cmpl    $0,%eax                 
        je      .L0008                  
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i = 
        jmp     .L0007                  
.L0008:                                 # End for statement
        movl    8(%ebp),%eax            # -v
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
.exit$pn:
        leave                           
        ret                             # End function pn
        .globl  and                     
and:    enter   $0,$0                   # Start function and
                                        # Start if statement
        movl    8(%ebp),%eax            # -a
        cmpl    $0,%eax                 
        je      .L0010                  
        movl    12(%ebp),%eax           # -b
        jmp     .exit$and               # Return
        jmp     .L0009                  
.L0010:                                 #  else
        movl    $0,%eax                 # 0
        jmp     .exit$and               # Return
.L0009:                                 # End if statement
.exit$and:
        leave                           
        ret                             # End function and
        .globl  print_primes            
print_primes:
        enter   $8,$0                   # Start function print_primes
        movl    $0,%eax                 # 0
        movl    %eax,-4(%ebp)           # n_printed = 
        movl    $1,%eax                 # 1
        movl    %eax,-8(%ebp)           # i = 
.L0011:                                 # Start for statement
        movl    -8(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1000,%eax              # 1000
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        cmpl    $0,%eax                 
        je      .L0012                  
                                        # Start if statement
        movl    -8(%ebp),%eax           # -i
        leal    prime,%edx              # prime[ ]
        movl    (%edx,%eax,4),%eax      
        cmpl    $0,%eax                 
        je      .L0013                  
                                        # Start if statement
        movl    -4(%ebp),%eax           # -n_printed
        pushl   %eax                    
        movl    $0,%eax                 # 0
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setg    %al                     # Test >
        pushl   %eax                    
        movl    $10,%eax                # 10
        pushl   %eax                    
        movl    -4(%ebp),%eax           # -n_printed
        pushl   %eax                    
        call    mod                     # call mod()
        addl    $8,%esp                 # Remove parameters
        pushl   %eax                    
        movl    $0,%eax                 # 0
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        sete    %al                     # Test ==
        pushl   %eax                    
        call    and                     # call and()
        addl    $8,%esp                 # Remove parameters
        cmpl    $0,%eax                 
        je      .L0014                  
        movl    LF,%eax                 # -LF
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.L0014:                                 # End if statement
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $3,%eax                 # 3
        pushl   %eax                    
        movl    -8(%ebp),%eax           # -i
        pushl   %eax                    
        call    pn                      # call pn()
        addl    $8,%esp                 # Remove parameters
        movl    -4(%ebp),%eax           # -n_printed
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # n_printed = 
.L0013:                                 # End if statement
        movl    -8(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-8(%ebp)           # i = 
        jmp     .L0011                  
.L0012:                                 # End for statement
        movl    LF,%eax                 # -LF
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.exit$print_primes:
        leave                           
        ret                             # End function print_primes
        .globl  main                    
main:   enter   $4,$0                   # Start function main
        movl    $10,%eax                # 10
        movl    %eax,LF                 # LF = 
        movl    $1,%eax                 # 1
        pushl   %eax                    
        movl    $0,%eax                 # 0
        leal    prime,%edx              
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # prime[ ] = 
        movl    $2,%eax                 # 2
        movl    %eax,-4(%ebp)           # i = 
.L0015:                                 # Start for statement
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1000,%eax              # 1000
        popl    %ecx                    
        cmpl    %eax,%ecx               
        movl    $0,%eax                 
        setle   %al                     # Test <=
        cmpl    $0,%eax                 
        je      .L0016                  
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1,%eax                 # 1
        leal    prime,%edx              
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # prime[ ] = 
        movl    -4(%ebp),%eax           # -i
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        movl    %eax,-4(%ebp)           # i = 
        jmp     .L0015                  
.L0016:                                 # End for statement
        call    find_primes             # call find_primes()
        call    print_primes            # call print_primes()
        movl    $0,%eax                 # 0
        jmp     .exit$main              # Return
.exit$main:
        leave                           
        ret                             # End function main
