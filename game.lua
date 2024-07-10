local game = {
    shotsLeft = 0,
    shots = 0,
    lifes = math.random(2, 6)
}

-- We'll use 1 for real shots and 0 for fake ones
function game.recharge()
        game.shots = math.random(2, 8)
        game.shotsLeft = game.shots
        game.sequence = {}
        local remainingReal = game.shots // 2
        local remainingFake = game.shots - remainingReal
        for i = 1, game.shots, 1 do
                local bool = math.random(0, 1)
                if bool == 0 then
                        game.sequence[i] = 0
                        if remainingFake <= 0 then
                                game.sequence[i] = 1
                                remainingReal = remainingReal - 1
                        else
                                remainingFake = remainingFake - 1
                        end
                end
                if bool == 1 then
                        game.sequence[i] = 1
                        if remainingReal <= 0 then
                                game.sequence[i] = 0
                                remainingFake = remainingFake - 1
                        else
                                remainingReal = remainingReal - 1
                        end
                end
        end
end

function game.sleep(seconds)
        os.execute("sleep " .. tonumber(seconds))
end

return game