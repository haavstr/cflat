        .data
.tmp:   .fill   4                       # Temporary storage
        .globl  two
two:    .fill   8                       # double  two;
        .text
        .globl  main                    
main:   enter   $16,$0                  # Start function main
        movl    $2,%eax                 # 2
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   -16(%ebp)               # a = (double)
        movl    $2,%eax                 # 2
        movl    %eax,.tmp               
        fildl   .tmp                    
        fstpl   -8(%ebp)                # b = (double)
                                        # Start if statement
        fldl    -16(%ebp)               # a
        subl    $8, %esp                
        fstpl   (%esp)                  
        fldl    -8(%ebp)                # b
        fldl    (%esp)                  
        addl    $8,%esp                 
        fsubp                           
        fstps   .tmp                    
        cmpl    $0,.tmp                 
        movl    $0,%eax                 
        sete    %al                     # Test ==
        cmpl    $0,%eax                 
        je      .L0001                  
        movl    $120,%eax               # 120
        pushl   %eax                    
        call    putchar                 # call putchar()
        addl    $4,%esp                 # Remove parameters
.L0001:                                 # End if statement
.exit$main:
        leave                           
        ret                             # End function main
