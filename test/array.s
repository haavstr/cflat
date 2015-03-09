        .data
.tmp:   .fill   4                       # Temporary storage
        .text
        .globl  main                    
main:   enter   $12,$0                  # Start function main
        movl    $0,%eax                 # 0
        pushl   %eax                    
        movl    $1,%eax                 # 1
        leal    -8(%ebp),%edx           
        popl    %ecx                    
        movl    %eax,(%edx,%ecx,4)      # a[ ] = 
.exit$main:
        leave                           
        ret                             # End function main
