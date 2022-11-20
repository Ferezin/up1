# gerador de sequência de potências de 2


loop: # volta sempre aqui
    LOAD a
    ADD b
    STORE c
    LOAD c
    STORE a
    LOAD c 
    STORE b
    JUMP loop

# variáveis
.a 1
.b 1
.c 0