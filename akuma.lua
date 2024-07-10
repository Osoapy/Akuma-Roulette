local akuma = {}

function akuma.setLifes(lifes)
    akuma.lifes = lifes
end

function akuma.decide(sequence, shots_left, shots)
    local remainingReal = shots // 2
    local remainingFake = shots - remainingReal
    for i = 0, shots - shots_left - 1, 1 do
        if sequence[shots - i] == 0 then
            remainingFake = remainingFake - 1
        else
            remainingReal = remainingReal - 1
        end
    end
    if remainingReal >= remainingFake then
        return 1
    else
        return 0
    end
end

return akuma