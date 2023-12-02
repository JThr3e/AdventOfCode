with open("input", "r") as f:
    games = f.read().splitlines()
    game_sum = 0
    for i,game in enumerate(games):
        game = game[game.find(":")+1:]
        turns = game.split(";")
        game_illegal = False
        game_spec = {
            "red": 0,
            "green": 0,
            "blue": 0,
        }
        for turn in turns:
            moves = turn.split(",")
            for move in moves:
                data = move.split(" ")
                num = data[1]
                color = data[2]
                if int(num) > game_spec[color]:
                    game_spec[color] = int(num)
        power = game_spec["red"]*game_spec["green"]*game_spec["blue"]
        game_sum += power
    print(game_sum)
