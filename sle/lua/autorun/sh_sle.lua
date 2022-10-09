-- Global table
sle = {}

-- Conversion function 
-- Used for converting diffrent data types
-- into others
function sle.Convert(str, type)
    type = string.lower(type)

    if !istable(str) then
        str = str:ToTable()
    end

    for k, v in pairs(str) do
        if type == "binary" then
            str[k] = math.IntToBin(string.byte(v))
        elseif type == "cbinary" then
            str[k] = math.IntToBin(v)
        elseif type == "byte" then
            str[k] = string.byte(v)
        elseif type == "char" then
            str[k] = string.char(v)
        elseif type == "fbin" then
            str[k] = math.BinToInt(v)
        elseif type == "fbinf" then
            str[k] = string.char(math.BinToInt(v))
        end
    end

    return str
end

-- Encryption function 
function sle.Encrypt(str, key)
    if #str >= #key then
        ErrorNoHalt("Can't convert without proper lengths")
        return
    end

    str = sle.Convert(str, "byte")
    key = sle.Convert(key, "byte")

    -- MATH OPERATIONS --
    for k, v in pairs(str) do
        local kv = key[k]
        str[k] = (v * kv) - (kv / 2)
    end

    return table.concat(str, " ")
end

-- Decryption function
function sle.Decrypt(str, key)
    str = string.Split(str, " ")
    key = sle.Convert(key, "byte")

    -- REVERSE MATH --
    for k, v in pairs(str) do
        local kv = key[k]
        str[k] = ((2 * v) + kv) / (kv * 2)
    end

    return table.concat(sle.Convert(str, "char"), "")
end