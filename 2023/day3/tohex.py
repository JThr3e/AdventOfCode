with open("input", "r") as f:
    txt = f.read()
    for line in txt.splitlines():
        for ch in line:
            print(format(ord(ch), '08b'))
