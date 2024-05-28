

.code
DADDUI r2, r0, 5        
loop: DADDI r2, r2, -1  
BNEZ r2, loop           
HALT                    
