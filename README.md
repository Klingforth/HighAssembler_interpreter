Ruby CPU Emulator & Interpreter

Ein leichtgewichtiger Instruction Set Emulator, der in Rubygeschrieben wurde. Dieses Projekt dient dazu, die fundamentale Funktionsweise einer CPU, des RAMs und eines Stacks auf unterster Ebene zu visualisieren und zu verstehen.
 Projektziel

Das Hauptziel dieses Interpreters ist die Edukation. Anstatt komplexe moderne Architekturen zu abstrahieren, bildet dieser Code die Kernkonzepte eines Prozessors ab:

    Registersatz: Simulation von Registern wie RAX, RBX, RIP (Instruction Pointer) etc.
geschrieben wurde. Dieses Projekt dient dazu, die fundamentale Funktionsweise einer CPU, des RAMs und eines Stacks auf unterster Ebene zu visualisieren und zu verstehen.
🎯 Projektziel

Das Hauptziel dieses Interpreters ist die Edukation. Anstatt komplexe moderne Architekturen zu abstrahieren, bildet dieser Code die Kernkonzepte eines Prozessors ab:

    Registersatz: Simulation von Registern wie RAX, RBX, RIP (Instruction Pointer) etc.

    Opcodes: Abbildung von Assembly-Befehlen auf Hexadezimal-Werte.

    Stack-Management: Direkte Manipulation des Stacks mit PUSH und POP.

    Control Flow: Implementierung von Sprungmarken (Labels) und bedingten Sprüngen (JZ, JMP).

🛠 Features

    Custom Assembler Parser: Liest eine Textdatei mit Assembly-ähnlichem Code ein und wandelt sie in Opcodes (RAM-Werte) um.

    Execution Engine: Durchläuft den RAM und führt die Befehle Schritt für Schritt aus.

    Status-Monitor: Gibt nach jedem Schritt den Zustand der wichtigsten Register und des Stacks aus.

🚀 Nutzung

    Erstelle eine Datei (z.B. program.txt) mit folgendem Format:
    Code-Snippet

    MOV RAX 1
    PUSH RAX
    MOV RBX 34
    LABEL loop:
    INC RAX
    CMP RAX 5
    JZ loop
    RET

    Starte den Emulator:
    Bash

    ruby emulator.rb program.txt

🧠 Lerneffekt

Durch die Arbeit an diesem Projekt wurden folgende Konzepte vertieft:

    Instruction Pointer (RIP): Wie der Computer weiß, welcher Befehl als Nächstes kommt.

    ALU (Arithmetic Logic Unit): Die Logik hinter Berechnungen und Vergleichen.

    Memory Mapping: Wie Textbefehle in numerische Opcodes übersetzt werden, die im "RAM" (Array) liegen.
    Opcodes: Abbildung von Assembly-Befehlen auf Hexadezimal-Werte.

    Stack-Management: Direkte Manipulation des Stacks mit PUSH und POP.

    Control Flow: Implementierung von Sprungmarken (Labels) und bedingten Sprüngen (JZ, JMP).

 Features

    Custom Assembler Parser: Liest eine Textdatei mit Assembly-ähnlichem Code ein und wandelt sie in Opcodes (RAM-Werte) um.

    Execution Engine: Durchläuft den RAM und führt die Befehle Schritt für Schritt aus.

    Status-Monitor: Gibt nach jedem Schritt den Zustand der wichtigsten Register und des Stacks aus.

 Nutzung

    Erstelle eine Datei (z.B. program.txt) mit folgendem Format:
    Code-Snippet

    MOV RAX 1
    PUSH RAX
    MOV RBX 34
    LABEL loop:
    INC RAX
    CMP RAX 5
    JZ loop
    RET

    Starte den Emulator:
    Bash

    ruby emulator.rb program.txt

 Lerneffekt

Durch die Arbeit an diesem Projekt wurden folgende Konzepte vertieft:

    Instruction Pointer (RIP): Wie der Computer weiß, welcher Befehl als Nächstes kommt.

    ALU (Arithmetic Logic Unit): Die Logik hinter Berechnungen und Vergleichen.

    Memory Mapping: Wie Textbefehle in numerische Opcodes übersetzt werden, die im "RAM" (Array) liegen.
