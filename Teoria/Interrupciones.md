<h1 align="center"> 💻Interrupciones</h1>

Indice
======
   * [Interrupciones por Software](#interrupciones_por_software)
   * [Memoria E/S y PIO](#memoria_e_s_y_pio)
     * [PIO](#PIO) 
   * [Interrupciones por Hardware](#Interrupciones_por_Hardware)
     * [PIC](#PIC) 
     * [EOI (20H)](#EOI_20H)
     * [IMR (21H)](#IMR_21H)
     * [Vector de Interrupciones](#VECTOR_DE_INTERRUCIONES)
     * [TIMER](#TIMER)
     * [F10](#F10)
   * [Handshake](#HANDSHAKE)
     * [Por Consulta de Estado](#IMPRIMIR_POR_CONSULTA_DE_ESTADO)
     * [Por interrupción](#IMPRIMIR_POR_INTERRUPCION)
   * [Impresora por PIO](#Impresora_Por_Pio)

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