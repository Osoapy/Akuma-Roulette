local game = {}

function game.Recharge()
    game.shots = math.random(2, 8)
    print(game.shots)
    game.sequence = {}
end

return game