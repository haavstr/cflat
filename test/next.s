        .data
.tmp:   .fill   4                       # Temporary storage
        .text
        .globl  main                    
main:   enter   $0,$0                   # Start function main
        movl    $63,%eax                # 63
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        movl    $32,%eax                # 32
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
        call    getint                  # call getint()
        pushl   %eax                    
        movl    $1,%eax                 # 1
        movl    %eax,%ecx               
        popl    %eax                    
        addl    %ecx,%eax               # Compute +
        pushl   %eax                    
        call    putint                  # call putint()
        addl    $4,%esp                 # Remove parameters
        movl    $10,%eax                # 10
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.exit$main:
        leave                           
        ret                             # End function main
