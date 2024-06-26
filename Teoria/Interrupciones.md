<h1 align="center"> Interrupciones</h1>

Indice
======
   * [Interrupciones por Software](#interrupciones_por_software)
   * [Memoria E/S y PIO](#memoria_e_s_y_pio)
     * [PIO](#pio) 
   * [Interrupciones por Hardware](#interrupciones_por_hardware)
     * [PIC](#pic) 
     * [EOI (20H)](#eoi_20h)
     * [IMR (21H)](#IMR_21H)
     * [Vector de Interrupciones](#vector_de_interrupciones)
     * [Timer](#timer)
     * [F10](#F10)
   * [Handshake](#handshake)
     * [Por Consulta de Estado](#IMPRIMIR_POR_CONSULTA_DE_ESTADO)
     * [Por interrupción](#IMPRIMIR_POR_INTERRUPCION)
   * [Impresora por PIO](#impresora_por_pio)

Interrupciones_por_Software
===========================
| Interrupcion | Funcion |
| ------------- | ------------- |
| INT 0  | Detiene el programa. Igual a HLT  |
| INT 3  | Debug. No lo vamos a utilizar  |
| INT 6  | Lee un caracter desde teclado  |
| INT 7  | Imprime un string en pantalla  |

<table>
<tr>
<td> INT 6 </td> <td> INT 7 </td>
</tr>
<tr>
<td>

```Assembly
ORG 1000H
    car db ?
ORG 2000H
    mov bx, offset car
    int 6
    int 0
end
```
</td>
<td>
 
```Assembly
ORG 1000H
 msj db "Mensaje: "
 fin db ?
ORG 2000H
    mov bx, offset msj
    mov al, offset fin - offset msj
    int 7
    int 0
end
```
</td>
</tr>
</table>


Memoria_E_S_y_PIO
=================
La memoria E/S es igual a la memoria común!
Como son iguales, necesito de un mecanismo para distinguirlas :
- Para leer desde la memoria E/S usaremos ```IN```, para escribir en ella ```OUT```. Ambas instrucciones ***solo se pueden usar*** con el registro ```AL```
- Ej. Lectura: Leer el dato que está en la posición 40H de E/S, ```IN AL, 40H```
- Ej. Escritura: Poner el valor 30 en la posicion 50H de E/S, ```OUT 50H, AL``` 

Nos comunicamos con los dispositivos de E/S a través de dispositivos internos.

<img src="https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/0f76c466-ac77-4be5-82af-c1fe3c92d2c8" width="550"/>

Cada uno de estos dispositivos internos se configuran, a través de la E/S y tienen asignado una zona de memoria fija (de E/S)

Pio
=================
Puerto paralelo a E/S <br>
Consta de 2 puertos paralelos configurables
- 2 de datos (PA y PB)
- 2 de configuracion (CA y CB)

<table>
<tr>
<td align="center"> Memoria </td>
<td align="center"> Dispositivos </td>
</tr>
<tr>
<td>

![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/ff6e063e-712f-4ee6-943e-cd0c805061cf)

</td>
<td>

![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/08405cd9-4c74-4b08-a0d6-8c07c64d78d1)

</td>
</tr>
</table>

Interrupciones_Por_Hardware
=================
Cuando se interrumpe se apila la dir de retorno y el psw (flags y otra info) <br>
luego de atender la interrupcion, se desapila y se vuelve al programa <br>
Las interrupciones por software usan este mismo sistema <br>

4 dispositivos externos <br>
![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/2708cb5b-f73a-4529-a599-50b83045067b)




Pic
=================
Los dispositivos interrumpen al cpu a travez del Pic que sirve como intermediario. <br>
Se configura dentro de las sentencias ```CLI``` y ```STI``` que bloquean y habilitan las interrupciones <br>
La cpu tiene una sola linea de interrupcion.
El Pic tiene 8 lineas de entrada:

![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/2d2cedeb-8bed-4985-aea7-46acd66f2174)




Eoi_(20h)
=================
- El ***PIC*** nos avisa que un dispositivo nos quiere interrumpir. Nosotros le avisamos que ya atendimos la interrupcion.
- Antes de volver de la subrutina de la interrupcion debemos poner el valor 20H en el ***EOI***.
```Assembly
MOV AL, 20H
OUT 20H, AL ;EOI = 20H
```

IMR_21H
=======

- Nos permite definir qué interrupciones vamos a atender y cuáles ignorar.
- 1 Significa deshabilitada, 0 habilitada

![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/a9faf931-2a93-438a-b609-27c5f4a19e25)



Vector_de_Interrupciones
=================

Ejemplo Configuracion
```Assembly
eoi equ 20h
imr equ 21h
int0 equ 24h
ORG 1000H
    msj db "Hola "


ORG 3000H
saludar: mov bx, offset msj
    mov al, 5
    int 7

    ; Aviso al eoi que ya finalizó la int
    mov al, 20h
    out eoi, al

    iret

ORG 2000H
    
    cli
        ; Config IMR
        mov al, 0feh    ; 1111 1110  Habilita el f10
        out imr, al

        ; eligo ID = 24  y lo envio al registro del pic correspondiente a la int0
        mov al, 24
        out int0, al

        ; Muevo a la pos 96 en el vector de int, la direccion de la subrutina.
        mov bx, 96 ; 24 * 4
        mov word ptr[bx], saludar
    sti

    loop: jmp loop

    int 0
END
```

Timer
=================
Contiene 2 registros, ```Cont``` (Contador)(10h) y ```comp``` (Comparacion)(11h)
- Cont: Se incrementa una vez por segundo
- Comp: Cuando Comp = Cont, se dispara la interrupcion.

 ``` Assembly
 eoi equ 20h
 imr equ 21h
 int1 equ 25h

 cont equ 10h
 comp equ 11h

ORG 1000H
    msj db "Hola "
    flag db 0

ORG 80
Dir_atender dw 3100h

ORG 3100H
atender: mov bx, offset msj
    mov al, 5
    int 7

    mov flag, 1

    mov al, 20h
    out eoi, al

    iret
ORG 2000h
    cli
        mov al, 0fdh   ;1111 1101
        out imr, al

        mov al, 20
        out int1, al

        ; Config Timer
        mov al, 0
        out cont, al

        mov al, 10
        out comp, al


    sti

    loop: cmp flag, 1
        jnz loop

    int 0
END
 ```


Handshake
=================
Dispositivo interno de E/S <br>
Diseñado especifiamenter para la impresora centronics del simulador <br>
Envia señal de Strobe automaticamente
Nos Interrumpe a travez del Pic <br>

Conectado a impresora por 2 registros
![image](https://github.com/ImanolAzpiroz/Arquitectura-de-Computadoras/assets/122705871/9e0ae6b7-c707-4674-a25a-b92782649780)

<h3> 2 formas </h3> 

    - Consulta de estado (Polling)
    - Por Interrupcion

<table>
<tr><td>Por Polling</td> <td>Por Interrupcion</td></tr>
<tr>
<td>

``` Assembly
dato equ 40h
estado equ 41h

org 1000h
    msj db "Algo"
    fin db ?
org 2000h
    ; Configuro bit de int por consulta de estado
    in al, estado
    and al, 01111111b
    out estado, al

    ; Loop de Polling
    mov bx, offset msj
    poll: in al, estado
        and al, 1
        jnz poll

        ; Imprimir
        mov al, [bx]
        out dato, al
        inc bx
        cmp bx, offset fin
        jnz pool
    int 0 
end
```
</td>
<td>

``` Assembly
eoi equ 20h
imr equ 21h
int2 equ 26h
dato equ 40h
estado equ 41h

org 1000h
    msj db "Algo"
    fin db ?

org 3000h
    imprimir: push ax  ; Salvo el valor de ax
    mov al, [bx]
    out dato, al
    inc bx
    
    ; Aviso a eoi que termino la int
    mov al, 20h
    out eoi, al

    pop ax  
    iret

org 2000h
    ; Ponemos la direccion de la interrupcion en 36
    mov ax, imprimir
    mov bx, 36   ; 9 * 4 = 36 
    mov [bx], ax
    ; Otra opcion [org 36, sub_dir dw 3000h]

    ;Configuro el Pic
    cli
        mov al, 11111011b
        out imr, al

        mov al, 9
        out int2, al
    sti
    mov bx, offset msj

    ; config Hs por interrupcion
    in al, estado
    or al, 10000000b
    out estado, al

    ; Otro programa
    poll: cmp bx, offset fin
    jnz poll

    ; desactivo hs por interrupcion
    in al, estado
    and al, 01111111b
    out estado, al

    int 0
end
```

</td>
<t/r>
</table>



<h3>Imprimir Un Caracter</h3>

```Assembly
dato equ 40h
estado equ 41h

ORG 1000H
    car db "a"
ORG 2000H
    mov al, car
    out dato, al
    int 0
END
```

<h3>Consulta de estado (Busy)</h3>

```Assembly

hs_dato equ 40h
hs_estado equ 41h



org 1000h
  msj db "Hs con polling "
  fin db ?
  
org 2000h
  ; Configurar int por polling
  in al, hs_estado
  and al, 01111111b
  out hs_estado, al
  
  mov bx, offset msj
  poll: in al, hs_estado
    and al, 1
    jnz poll

    mov al, [bx]
    out hs_dato, al

    inc bx
    cmp bx, offset fin
    jnz poll
    
  int 0
end
```

<h3> Imprimir con Interrupciones </h3>

``` Assembly
dato equ 40h
estado equ 41h

org 1000h
    car db "A"

org 3000h
imp: mov al, car
    out dato, al

    mov al 0ffh
    out imr, al

    mov al, 20h
    out eoi, al
    iret

org 2000h
    mov cl, 9
    mov bx, offset msj

    loop: in al, estado
        and al, 1
        jnz loop

        mov al, [bx]
        out dato, al
        inc bx
        dec cl
        jnz loop
    int0
end 
```

















Impresora_por_Pio
==========

``` Assembly
pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
  msj db "Impresora por pio"
  fin db ?

org 2000h
  ; Config pio 
  ; Strobe como entrada
   mov al, 11111101b
   out ca, al

  ; CB como salida
  mov al, 0
  out cb, al

  ; Recorremos el string
  mov bx, offset msj
  loop: in al, pa
  and al, 1
  jnz loop

  ; Imprimi caracter
  mov al, [bx]
  out pb, al

  
  in al, pa
  or al, 2   ; Fuerzo strobe a 1
  out pa, al

  in al, pa
  and al, 0fdh   ; Fuerzo el strobe en 0
  out pa, al

  ; Sig bit
  inc bx
  cmp bx, offset fin
  jnz loop

  
  int 0
end
```

