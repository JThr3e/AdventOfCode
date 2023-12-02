game_spec = {
    "red": 12,
    "green": 13,
    "blue": 14,
}

with open("input", "r") as f:
    games = f.read().splitlines()
    game_sum = 0
    for i,game in enumerate(games):
        game = game[game.find(":")+1:]
        turns = game.split(";")
        game_illegal = False
        for turn in turns:
            moves = turn.split(",")
            for move in moves:
                data = move.split(" ")
                num = data[1]
                color = data[2]
                if int(num) > game_spec[color]:
                    game_illegal = True
        if not game_illegal:
            game_sum += (i+1)
    print(game_sum)
