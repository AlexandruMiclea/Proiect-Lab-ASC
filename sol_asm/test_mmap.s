.data
    matriceAns: .space 4
    matriceAux: .space 4
    matriceRez: .space 4
    PROT_RW: .long 0x3
    MAP_Flag: .long 0x22
.text

.global main

main:


    


    movl %eax, matriceAns

    movl $192, %eax #codul pentru apel de sistem mmap2
    xorl %ebx, %ebx #parametru adresa, punand valoarea NULL las SO sa decida
                  #unde anume sa imi aloce spatiul de memorie
    movl $40000, %ecx #aici o sa fie n*n pe care l-am obtinut anterior
    movl PROT_RW, %edx #0x1 este codul pentru read, 0x2 cel pentru write
                       #intre ele fac inclusive or si obtin 0x3, adica
                       #codul pentru read-write
    movl MAP_Flag, %esi #tot prin inclusive or-are, obtin codul 0x24.
                        #0x20 este codul pentru anonymous mapping, adica
                        #nu doresc folosirea unui fisier in maparea zonei de memorie
                        #iar 0x4 este codul pentru shared memory mapping
    movl $-1, %edi #nu folosesc un fisier, asa ca pasez o valoare care sa indice
                   #sistemului de operare sa nu caute o locatie
    int $0x80 #system call


etexit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
    