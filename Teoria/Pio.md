


<h1 align="center">PIO   </h1>

--------------------
- PA  30h &nbsp; &nbsp; (Datos Llaves)  
- PB  31h &nbsp; &nbsp; (Datos Luces)   
- CA  32h &nbsp; &nbsp; (Config Datos)
- CB  33h &nbsp; &nbsp; (Config Luces)

1 Entrada <br>
0 Salida

--------------------
<h3> Configurar Llaves como entrada </h3>

``` assembly
mov al, 0ffh  ; 11111111b
out CA, al 
```
--------------------
<h3> Configurar Luces como Salida </h3>

``` assembly
mov al, 00h   ; 00000000b
out CB, al 

; Leo el estado de las llaves.
in al, PA
```
--------------------
<h3> Actualizar luces con el valor de las llaves</h3>

``` assembly
org 2000h
  ; Config llaves como entrada
  mov al, 0ffh
  out ca, al

  ; Config luces como salida
  mov al, 00h
  out cb, al

  
loop:
  ; Leo en al el valor de las llaves
  in al, pa

  ; Envio el valor a las luces
  out pb, al
  jmp loop
  
int 0 
end
```

--------------------