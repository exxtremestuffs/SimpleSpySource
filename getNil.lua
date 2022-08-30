function getNil(name, class)
    for _, v in pairs(getnilinstances()) do
        if typeof(v) == 'Instance' and v.ClassName == class and v.Name == name then
            return v
        end
    end
end
