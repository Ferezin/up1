# gerador de sequência de potências de 2


loop: # volta sempre aqui
    LOAD a
    ADD a
    STORE b
    LOAD b
    STORE a
    JUMP loop

# variáveis
.a 1
.b 0