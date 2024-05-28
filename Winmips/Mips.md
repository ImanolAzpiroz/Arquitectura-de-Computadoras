
Indice
- [Atascos](#atascos)
- [Instrucciones](#instrucciones)
- [Variables](#registros-y-variables)
- [Atascos y Dependencia de control](#atascos-y-dependencia-de-control)


## Ejecucion Secuencial
![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/9c5874f0-a333-4a21-87f4-cfff85ef94f1)

## Ejecucion Segmentada
![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/4847609a-f563-40d0-b7b9-76758d49b661)

### Las instrucciones se organizan en fases
- IF - Instruction Fetch.
    - Se accede a memoria por la instrucción
    - Se incrementa el PC
- ID - Instruction Decoder.
    - Se decodifica la instrucción
    - Se accede al banco de registros por los operandos (Se atasca si no estan disponibles)
    - Se calcula el valor del operando inmediato
    - Si es un salto, se calcula el destino y si se toma o no
- EX - Execution
    - Si es instrucción de computo, se ejecuta la alu.
    - Si es un acceso a memoria, se calcula la dirección efectiva
    - Si es un salto, se realiza(Se modifica el registro PC)
- ME - Memory Access
    - Si es un acceso a memoria se lee/escribe el dato.
- WB - Write Back
    - Se almacena el resultado(si lo hay) en los registros

Todas las etapas tardan lo mismo a excepcion de la de EX.

![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/cd4cf9d3-39b6-4a46-a1fb-8afa0b5b58f2)

## Atascos
Se pueden dar situaciones que impiden que la siguiente instruccion se ejecute en el ciclo que corresponde, a esto se le llama **Atascos**.
Hay de 3 tipos:
- Estructurales - Provocados por conflictos de recursos
- Dependencia de datos
    - Raw - Read after write
    - War - Write after read
    - Waw - Write after write
- Dependencia de Control - Provocados al esperar la desición de otra instrucción

## Registros y Variables
32 Registros de uso general <br>
32 Registros de punto flotante

### Variables: 
<table>
<tr>
<td>

``` mips
.data
A: .byte 1
B: .word16 2
C: .word32 3
D: .word 2882
TABLA: .byte 'Hola'
```
</td>

<td>

- .byte 8 bits 
- .word16 16 bits
- .word32 32 bits
- .word 64 bits

</td>
</tr>
</table>

## Instrucciones

### Sumar Dos registros
``` mips
.code
DADD R1, R2, R3  ;(R1 = R2 + R3)
```
### Sumar un registro con un valor inmediato
``` mips
.code
DADDI R1, R2, 5  ;(R1 = R2 + 5)
```
### XOR con un valor inmediato
``` mips
.code
XORI R6, R6, 0xFD  ;(R6 = R6 XOR 253)
```
### Resta
``` mips
.code
DSUB R1, R2, R3  ;(R1 = R2 + R3)
```
### Multiplicacion y division
``` mips
.code
DMUL R1, R2, R3  ;(R1 = R2 * R3)
```
``` mips
.code
DDIV R1, R2, R3  ;(R1 = R2 / R3)
```
-----------------

Todas las operaciones aritmetico-logicas deben hacerse con registros<br>
Si quiero usar variables debo cargarlas antes en un registro <br>
Para tomar una variable se usa: LD (DESTINO), (VARIABLE)(DESPLAZAMIENTO)
``` mips
.data
A: word 5
.code
LD R1, A (R0)  ;(R1 = Var en dir de A + Desp(0))
```

### Guardar un valor en memoria
``` mips
.data
A: word 0
.code
DADDI R1, R0, 5  ;
SD R1, A (R0)
```

## Forwarding
![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/1b4cc8bc-a07f-4740-99a8-ad0845b134b4)

Guarda en unos Buffer el resultado de la operacion anterior, para que los mismos se puedan usar en la siguiente instruccion sin necesidad de esperar a la etapa de WriteBack.

## Saltos
- Condicionales: Salta dependiendo de que se cumpla una condicion.
- Incondicionales: Salta siempre. 
En la etapa ID se calcula el salto.


Condicional:
``` mips
loop: DADDI r2, r2, -1
BNEZ r2, loop
DADDI r7, r0, r1
```

## Atasco por dependencia de control
Branch Taken Stall
Salto que se deberia haber hecho y no se ejecuto.