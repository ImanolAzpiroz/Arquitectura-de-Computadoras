.code   
daddi r2, r0, 10
loop: daddi r2, r2, -1
    bnez r2, loop
halt