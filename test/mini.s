        .data
.tmp:   .fill   4                       # Temporary storage
        .text
        .globl  main                    
main:   enter   $0,$0                   # Start function main
        movl    $120,%eax               # 120
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.exit$main:
        leave                           
        ret                             # End function main
