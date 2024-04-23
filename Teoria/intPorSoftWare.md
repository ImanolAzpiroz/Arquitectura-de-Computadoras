| Interrupcion | Funcion |
| ------------- | ------------- |
| INT 0  | Detiene el programa. Igual a HLT  |
| INT 3  | Debug. No lo vamos a utilizar  |
| INT 6  | Lee un caracter desde teclado  |
| INT 7  | Imprime un string en pantalla  |


<table>
<tr>
<td>INT 6</td> <td>INT 7</td>
</tr>

<tr>
<td>

``` Assembly 
org 1000h
    Car db ?
org 2000h
    mov bx, offset Car
    int 6
    int 0
end
```

</td>

<td>

``` Assembly 
org 1000h
    msj db "Mensaje a Imprimir"
    fin db ?
org 2000h
    mov bx, offset msj
    mov al, offset fin - offset msj
    int 7
    int 0
end
```
</td>
</tr>

</table>