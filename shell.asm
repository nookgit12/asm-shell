section .data
    shell_prompt db "shell> ", 0
    hello_msg db "Hello world!", 10, 0
    help_msg db "Available commands:", 10, \
               "  hello - Prints a hello message", 10, \
               "  exit  - Exits the shell", 10, \
               "  help  - Displays this help message", 10, 0
    unknown_cmd db "Unknown command", 10, 0
    exit_cmd db "exit", 0
    hello_cmd db "hello", 0
    help_cmd db "help", 0
    input_buffer db 128 ; buffer to store input

section .bss
    user_input resb 128 ; reserve space for user input

section .text
    global _start

_start:
shell_loop:
    ; Print the shell prompt
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout
    mov ecx, shell_prompt ; address of the prompt string
    mov edx, 7          ; length of the prompt string
    int 0x80            ; make syscall

    ; Read user input
    mov eax, 3          ; syscall: sys_read
    mov ebx, 0          ; file descriptor: stdin
    mov ecx, input_buffer ; address of the input buffer
    mov edx, 128        ; max bytes to read
    int 0x80            ; make syscall
    mov esi, eax        ; save number of bytes read

    ; Null-terminate the input
    dec esi             ; eax - 1 (last character is newline)
    mov byte [input_buffer + esi], 0

    ; Compare input with "exit"
    mov eax, input_buffer
    mov ebx, exit_cmd
    call strcmp
    cmp eax, 0
    je exit_shell        ; Jump if input is "exit"

    ; Compare input with "hello"
    mov eax, input_buffer
    mov ebx, hello_cmd
    call strcmp
    cmp eax, 0
    je hello_command     ; Jump if input is "hello"

    ; Compare input with "help"
    mov eax, input_buffer
    mov ebx, help_cmd
    call strcmp
    cmp eax, 0
    je help_command      ; Jump if input is "help"

    ; Unknown command
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout
    mov ecx, unknown_cmd ; address of the unknown message
    mov edx, 16         ; length of the message
    int 0x80            ; make syscall
    jmp shell_loop      ; Loop back to prompt

hello_command:
    ; Print the hello message
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout
    mov ecx, hello_msg  ; address of the hello message
    mov edx, 14         ; length of the message
    int 0x80            ; make syscall
    jmp shell_loop      ; Loop back to prompt


help_command:
    ; Print the help message
    mov eax, 4          ; syscall: sys_write
    mov ebx, 1          ; file descriptor: stdout
    mov ecx, help_msg   ; address of the help message
    mov edx, 82         ; length of the help message
    int 0x80            ; make syscall
    jmp shell_loop      ; Loop back to prompt

exit_shell:
    ; Exit the program
    mov eax, 1          ; syscall: sys_exit
    xor ebx, ebx        ; exit status: 0
    int 0x80            ; make syscall

; strcmp implementation
strcmp:
    push esi
    push edi
    mov esi, eax        ; address of the first string
    mov edi, ebx        ; address of the second string
.compare_loop:
    lodsb               ; load byte from esi to al
    scasb               ; compare byte in al with byte at edi
    jne .not_equal      ; jump if not equal
    test al, al         ; check for null terminator
    jnz .compare_loop   ; continue loop if not null
    xor eax, eax        ; strings are equal, return 0
    pop edi
    pop esi
    ret
.not_equal:
    mov eax, 1          ; strings are not equal, return 1
    pop edi
    pop esi
    ret
