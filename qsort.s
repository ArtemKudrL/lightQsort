; void lightQsort(int* data, unsigned long size);
global lightQsort

section .text
    lightQsort:
%define data rdi
%define size rsi
%define pivot eax
%define left dword [rcx]
%define right dword [rdx]

%define at(i) dword [data+4*(i)]
%define next add rcx, 4
%define prev sub rdx, 4
%macro swap 0
    mov ebx, left
    xchg ebx, right
    mov left, ebx
%endmacro

    cmp size, 2
    jg .work
    jl .nothing
    mov eax, at(0)
    cmp eax, at(1)
    jle .nothing
    xchg eax, at(1)
    mov at(0), eax
    .nothing:
    ret
    .work:

    mov rax, size
    shr rax, 1
    mov pivot, at(rax)

    lea rcx, at(-1)
    lea rdx, at(rsi)

    .leftLoop:
    next
    cmp left, pivot
    jl .leftLoop

    .rightLoop:
    prev
    cmp rcx, rdx
    jge .loopDone
    cmp right, pivot
    jg .rightLoop

    swap
    jmp .leftLoop
    .loopDone:

    push rcx
    mov rax, rsi
    mov rsi, rcx
    sub rsi, rdi
    shr rsi, 2
    sub rax, rsi
    push rax
    call lightQsort
    pop rsi
    pop rdi
    call lightQsort

    ret
