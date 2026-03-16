$RAM    = []
$stack  = []
$label =  {}
$datei = ARGV[0]

REG = {
    RAX:  {id: 0xA0, val: 0x00},
    RBX:  {id: 0xA1, val: 0x00},
    RCX:  {id: 0xA2, val: 0x00},
    RDX:  {id: 0xA3, val: 0x00},
    RSI:  {id: 0xA4, val: 0x00},
    RDI:  {id: 0xA5, val: 0x00},
    RBP:  {id: 0xA6, val: 0x00},
    RSP:  {id: 0xA7, val: 0x00},
    R8:   {id: 0xA9, val: 0x00},
    R9:   {id: 0xAA, val: 0x00},
    R10:  {id: 0xAB, val: 0x00},
    R11:  {id: 0xAC, val: 0x00},
    R12:  {id: 0xAD, val: 0x00},
    R13:  {id: 0xAE, val: 0x00},
    R14:  {id: 0xAF, val: 0x00},
    R15:  {id: 0xD0, val: 0x00},
    RIP:  {id: 0xD1, val: 0x00},
    IR:   {id: 0xD2, val: 0x00},
    ALU:  {id: 0xD3, val: 0x00},
}

FLAG = {
    ZF: 0,
    CF: 0,
    SF: 0,
    OF: 0
}

OPCODE = {
    MOV:  0xB8,
    ADD:  0x83,
    INC:  0x48,
    PUSH: 0x50,
    POP:  0x58,
    RET:  0x37,
    DEC:  0x0E,
    CMP:  0x42,
    JMP:  0xE9,
    JNE:  0xA3,
    JZ:   0xA4,
    LABEL:0xFF,
    DB:   0xBB
}

def printReg()
    puts "RAX:#{REG[:RAX][:val]}"
    puts "RBX:#{REG[:RBX][:val]}"
    puts "RCX:#{REG[:RCX][:val]}"
    puts "RDX:#{REG[:RDX][:val]}"
    puts "R9:#{REG[:R9][:val]}"
    puts "Stack#{$stack}"
    puts "------------------------"
    puts "------------------------"
end

def move(reg1, value)
    reg1_sym = reg1.to_sym
    REG[reg1_sym][:val] = value.to_i
end

def add(reg1, reg2)
    reg1_sym = reg1.to_sym
    if reg2.is_a?(Integer)
        REG[reg1_sym][:val] += reg2
    else
        reg2_sym = reg2.to_sym
        REG[reg1_sym][:val] += REG[reg2_sym][:val]
    end
end

def push(reg1)
    reg1_sym = reg1.to_sym
    reg1_value = REG[reg1_sym][:val]
    $stack.unshift(reg1_value)
end

def pop()
    REG[:R9][:val] = $stack[0]
    $stack.shift
end

def stepForward()
    REG[:IR][:val] = $RAM[REG[:RIP][:val]]
    REG[:ALU][:val] = REG[:RIP][:val] + 1
end

def stepForwardOut()
    REG[:ALU][:val] += 1
    REG[:RIP][:val] = REG[:ALU][:val]
end

File.foreach($datei) do |binary|
    binary = binary.sub(",","")
    
    $RAMParts = binary.split
    $RAMParts.map! do |item|
        case item
            when "MOV"
                item = OPCODE[:MOV]
            when "ADD"
                item = OPCODE[:ADD]
            when "PUSH"
                item = OPCODE[:PUSH]
            when "POP"
                item = OPCODE[:POP]
            when "INC"
                item = OPCODE[:INC]
            when "DEC"
                item = OPCODE[:DEC]
            when "RET"
                item = OPCODE[:RET]
            when "CMP"
                item = OPCODE[:CMP]
            when "JNE"
                item = OPCODE[:JNE]
            when "JZ"
                item = OPCODE[:JZ]
            when "JMP"
                item = OPCODE[:JMP]
            when "LABEL"
                item = OPCODE[:LABEL]
            when "DB"
                item = OPCODE[:DB]
            else 
                if item =~ /^\d+$/
                    item.to_i  
                else
                    item 
                end
        end
    end
    $RAM.concat($RAMParts)
end

while $RAM[REG[:RIP][:val]] != 0x37
    REG[:IR][:val] = $RAM[REG[:RIP][:val]]
    labelcheck = $RAM[REG[:RIP][:val]].to_s
    if labelcheck.strip.end_with?(":")
        $label[labelcheck] = REG[:ALU][:val]
    end
    REG[:ALU][:val] = REG[:RIP][:val] +1
    REG[:RIP][:val] = REG[:ALU][:val]
end
REG[:RIP][:val] = 0

while $RAM[REG[:RIP][:val]] != 0x37
    opcodeREG = $RAM[REG[:RIP][:val]]
    printReg()
    case opcodeREG
        when 0xB8
            stepForward()
            reg1 = $RAM[REG[:ALU][:val]] 
            REG[:ALU][:val] += 1 
            reg2 = $RAM[REG[:ALU][:val]]
            if reg2.is_a?(Integer)
                move(reg1, reg2)
            else
                wert_aus_reg2 = REG[reg2.to_sym][:val]
                move(reg1, wert_aus_reg2)
            end
            stepForwardOut()
        when 0x83
            stepForward()
            reg1 = $RAM[REG[:ALU][:val]]
            REG[:ALU][:val] += 1
            reg2 = $RAM[REG[:ALU][:val]]
            add(reg1,reg2)
            stepForwardOut
        when 0x48
            stepForward()
            reg1 = $RAM[REG[:ALU][:val]]
            REG[reg1.to_sym][:val] += 1
            stepForwardOut()
        when 0x0E
            stepForward()
            reg1 = $RAM[REG[:ALU][:val]]
            REG[reg1.to_sym][:val] -= 1
            stepForwardOut()
        when 0x50
            stepForward()
            reg1 = $RAM[REG[:ALU][:val]]
            push(reg1)
            stepForwardOut()
        when 0x58
            REG[:IR][:val] = $RAM[REG[:RIP][:val]]
            REG[:ALU][:val] = REG[:RIP][:val]
            pop()
            REG[:ALU][:val] += 1
            REG[:RIP][:val] = REG[:ALU][:val]
        when 0xE9
            stepForward()
            reg1 = $RAM[REG[:ALU][:val]]
            REG[:RIP][:val]  = $label[reg1 + ":"]
        when 0x42
            stepForward()
            reg1 = $RAM[REG[:ALU][:val]]
            wert_aus_reg1 = REG[reg1.to_sym][:val]
            REG[:ALU][:val] += 1
            reg2 = $RAM[REG[:ALU][:val]]
            if wert_aus_reg1 == reg2
                FLAG[:ZF] = 1
            elsif wert_aus_reg1 != reg2 
                FLAG[:ZF] = 0
            end
            stepForwardOut()
        when 0xA4
            stepForward()
            if FLAG[:ZF]  == 1
                REG[:ALU][:val] = REG[:RIP][:val] + 1
                REG[:RIP][:val] = REG[:ALU][:val]
            elsif FLAG[:ZF] == 0
                reg1 = $RAM[REG[:ALU][:val]]
                REG[:RIP][:val]  = $label[reg1 + ":"]
            end
        when 0xBB
            stepForward()

        else
            REG[:RIP][:val] += 1
    end
end
printReg()