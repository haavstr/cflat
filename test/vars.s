        .data
.tmp:   .fill   4                       # Temporary storage
        .globl  FOO
FOO:    .fill   4                       # int  FOO;
        .globl  BAR
BAR:    .fill   4                       # int  BAR;
        .text
        .globl  main                    
main:   enter   $8,$0                   # Start function main
.exit$main:
        leave                           
        ret                             # End function main
