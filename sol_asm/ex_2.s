 .data
    cerinta: .space 4
    matrice: .space 4
    matriceAux:.space 4
    matriceRez: .space 4
    numarVecini: .space 400
    strPrint: .asciz "%ld "
    strScan:  .asciz "%ld"
    numarNoduri: .space 4
    strLn:  .asciz "\n"
    idxVecin:.space 4
    idxNod: .space 4
    right: .space 4
    idxLin: .space 4
    idxCol: .space 4
    idxIter: .space 4
    exponent: .space 4
    nodStanga: .space 4
    nodDreapta: .space 4
    idxPozitie: .space 4
    marimeMatrice: .space 4

    PROT_RW: .long 0x3
    MAP_Flag: .long 0x22
.text

    init_mat:
        pushl %ebp
        movl %esp, %ebp

        pushl %esi
        pushl %edi
        pushl %ebx

        subl $12, %esp #3 variabile locale pt idxlin, idxnod, n

        // accesarea o fac prin scaderea lui ebp

        movl 8(%ebp), %esi
        movl 12(%ebp), %edi
        movl 16(%ebp), %eax
        movl %eax, -16(%ebp) #nr noduri
        movl $0, -20(%ebp) #idxLin
        movl $0, -24(%ebp) #idxCol
        xorl %ecx, %ecx

        li:

            movl -16(%ebp), %ebx
            movl -20(%ebp), %ecx
            cmp %ecx, %ebx
            //je lmultinit
            je init_matexit

            lj:
                movl -16(%ebp), %ebx
                movl -24(%ebp), %ecx
                cmp %ecx, %ebx
                je liexit

                xorl %edx, %edx
                movl -20(%ebp), %eax
                mull -16(%ebp)
                addl -24(%ebp), %eax

                movl (%esi, %eax, 4), %edx
                movl %edx, (%edi, %eax, 4)

                incl -24(%ebp)
                jmp lj

        liexit:

            incl -20(%ebp)
            movl $0, -24(%ebp)
            jmp li


        init_matexit:

            addl $12, %esp
            popl %ebx
            popl %edi
            popl %esi

            popl %ebp
            ret

    matrix_mult:

        //inmultesc m1 la m2 (matrice la matriceAux)

        pushl %ebp
        movl %esp, %ebp

        pushl %esi
        pushl %edi
        pushl %ebx

        #parametri
        # 8(%ebp) -> matriceAux
        # 12(%ebp) -> matrice
        # 16(%ebp) -> matriceRez
        # 20(%ebp) -> numarNoduri

        subl $20, %esp # variabilele unde stochez stuff
        # -16(%ebp) -> idxLin
        # -20(%ebp) -> idxCol
        # -24(%ebp) -> idxK
        # -28(%ebp) -> rezAd
        # -32(%ebp) -> rezinm

        movl $0, -16(%ebp)        
        movl $0, -20(%ebp)
        movl $0, -24(%ebp)
        movl $0, -28(%ebp)
        movl $0, -32(%ebp)        


        llin:

            movl -16(%ebp), %ecx
            movl 20(%ebp), %ebx
            cmp %ecx, %ebx
            je matrix_multexit

            lcol:

                movl -20(%ebp), %ecx
                movl 20(%ebp), %ebx
                cmp %ecx, %ebx
                je llinexit

                    liter:

                        movl -24(%ebp), %ecx
                        movl 20(%ebp), %ebx
                        cmp %ecx, %ebx
                        je lcolexit

                        xorl %edx, %edx

                        movl 8(%ebp), %esi

                        #eax este m[i][k]
                        #ecx este rezultatul inmultirii

                        xorl %eax, %eax
                        xorl %edx, %edx

                        movl -16(%ebp), %eax
                        mull 20(%ebp)
                        addl -24(%ebp), %eax
                        movl %eax, %ebx

                        movl (%esi, %ebx, 4), %ecx
                        movl %ecx, -32(%ebp)

                        movl 12(%ebp), %esi

                        xorl %eax, %eax
                        xorl %edx, %edx

                        movl -24(%ebp), %eax
                        mull 20(%ebp)
                        addl -20(%ebp), %eax
                        movl %eax, %ebx

                        movl (%esi, %ebx, 4), %ecx
                        movl -32(%ebp), %eax
                        xorl %edx, %edx
                        mull %ecx
                        addl %eax, -28(%ebp)

                        incl -24(%ebp)
                        jmp liter

                lcolexit:

                    #tre sa mut ce am in rezAd in edi pe index corect

                    movl 16(%ebp), %edi
                    movl -28(%ebp), %ebx

                    xorl %eax, %eax
                    xorl %edx, %edx

                    movl -16(%ebp), %eax
                    mull 20(%ebp)
                    addl -20(%ebp), %eax

                    movl %ebx, (%edi, %eax, 4)
                    
                    incl -20(%ebp)
                    movl $0, -24(%ebp)
                    movl $0, -28(%ebp)
                    jmp lcol        

            llinexit:

                incl -16(%ebp)
                movl $0, -20(%ebp)
                movl $0, -24(%ebp)
                movl $0, -28(%ebp)
                jmp llin

        matrix_multexit:

            addl $20, %esp
            
            popl %ebx
            popl %edi
            popl %esi

            popl %ebp
            ret

.global main

main:

    pushl $cerinta
    pushl $strScan
    call scanf
    addl $8, %esp

    pushl $numarNoduri
    pushl $strScan
    call scanf
    addl $8, %esp

    #marime matrice

    xorl %edx, %edx
    movl numarNoduri, %eax
    mull numarNoduri
    shl $2, %eax
    movl %eax, marimeMatrice

    movl $192, %eax #codul pentru apel de sistem mmap2
    xorl %ebx, %ebx #parametru adresa, punand valoarea NULL las SO sa decida
                  #unde anume sa imi aloce spatiul de memorie
    movl marimeMatrice, %ecx #aici o sa fie n*n pe care l-am obtinut anterior
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

    movl %eax, matrice

    movl $192, %eax #codul pentru apel de sistem mmap2
    xorl %ebx, %ebx #parametru adresa, punand valoarea NULL las SO sa decida
                  #unde anume sa imi aloce spatiul de memorie
    movl marimeMatrice, %ecx #aici o sa fie n*n pe care l-am obtinut anterior
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

    movl %eax, matriceAux

    movl $192, %eax #codul pentru apel de sistem mmap2
    xorl %ebx, %ebx #parametru adresa, punand valoarea NULL las SO sa decida
                  #unde anume sa imi aloce spatiul de memorie
    movl marimeMatrice, %ecx #aici o sa fie n*n pe care l-am obtinut anterior
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

    movl %eax, matriceRez

    movl numarNoduri, %ebx
    xorl %ecx, %ecx
    lea numarVecini, %esi
    movl $0, idxNod
    movl $0, idxVecin

lscannrvec:

    cmp %ecx, %ebx
    je lcitnrvec
    
    lea (%esi, %ecx, 4), %edi

    pushl %ecx #trebuie sa restaurez ecx dupa scanf?
    pushl %edi
    pushl $strScan
    call scanf
    addl $8, %esp
    popl %ecx

    incl %ecx

    jmp lscannrvec

lcitnrvec:

    movl idxNod, %ecx
    movl numarNoduri, %ebx
    cmp %ecx, %ebx
    je etcerinta
    lea numarVecini, %esi
    movl (%esi, %ecx, 4), %ebx

    lcitvec:
        lea numarVecini, %esi
        movl idxNod, %ecx
        movl (%esi, %ecx, 4), %ebx

        movl idxVecin, %ecx
        cmp %ecx, %ebx
        je lcitvecexit

        pushl $right
        pushl $strScan
        call scanf
        addl $8, %esp

        // in right am dreapta, in idxNod stanga

        xorl %eax, %eax
        xorl %edx, %edx
        movl idxNod, %eax
        mull numarNoduri
        addl right, %eax

        movl matrice, %esi
        #lea (%esi, %eax, 4), %edi
        movl $1, (%esi, %eax, 4)

        incl idxVecin
        jmp lcitvec

    lcitvecexit:

    incl idxNod
    movl $0, idxVecin
    jmp lcitnrvec

etcerinta:

    movl cerinta, %eax
    movl $1, %ebx
    cmp %eax, %ebx
    je lprintlin
    jne etcitc2

lprintlin:

    movl matrice, %esi
    movl idxLin, %ecx
    movl numarNoduri, %ebx
    cmp %ecx, %ebx
    je etexit

    lprintcol:

        movl idxCol, %ecx
        movl numarNoduri, %ebx
        cmp %ecx, %ebx
        je lprintcolexit

        movl idxLin, %eax
        xorl %edx, %edx
        mull numarNoduri
        addl idxCol, %eax

        movl (%esi, %eax, 4), %edx

        pushl %edx
        pushl $strPrint
        call printf
        addl $8, %esp

        pushl $0
        call fflush
        addl $4, %esp

        incl idxCol
        jmp lprintcol        

    lprintcolexit:

        pushl $strLn
        call printf
        addl $4, %esp

        pushl $0
        call fflush
        addl $4, %esp

        incl idxLin
        movl $0, idxCol
        jmp lprintlin

etcitc2:

    pushl $exponent
    pushl $strScan
    call scanf
    addl $8, %esp
    subl $1, exponent

    pushl $nodStanga
    pushl $strScan
    call scanf
    addl $8, %esp

    pushl $nodDreapta
    pushl $strScan
    call scanf
    addl $8, %esp

    pushl numarNoduri
    pushl matriceRez
    pushl matrice
    call init_mat
    addl $12, %esp

    xorl %ecx, %ecx
    movl exponent, %ebx

    // todo matriceAux ia ce este in matriceRez
    // matriceRez trebuie sa fie initializata cu matrice

lmult:

    cmp %ecx, %ebx
    je afisc2

    pushl %ecx
    pushl numarNoduri
    pushl matriceAux
    pushl matriceRez
    call init_mat
    addl $12, %esp
    popl %ecx

    // asta o fac de k-1 ori
    pushl %ecx
    pushl numarNoduri
    pushl matriceRez
    pushl matrice
    pushl matriceAux
    call matrix_mult
    addl $16, %esp
    popl %ecx

    incl %ecx
    jmp lmult

afisc2:

    // ma duc la nodStanga * n + nodDreapta
    // si iau valoarea din (matriceAns, adr, 4)
    // o afisez ik ez stuff

    movl matriceRez, %esi
    xorl %eax, %eax
    xorl %ecx, %ecx
    movl nodStanga, %eax
    mull numarNoduri
    addl nodDreapta, %eax
    movl (%esi, %eax, 4), %ebx

    pushl %ebx
    pushl $strPrint
    call printf
    addl $8, %esp

    pushl $0
    call fflush
    addl $4, %esp

etexit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
    
 
    