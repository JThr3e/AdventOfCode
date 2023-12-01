
def is_digit(x : String):
    return ord(x) >= 48 and ord(x) <= 57

def main():
    var f = open("input", "r")
    var ipt = f.read()
    var first : String = ""
    var last : String = ""
    var calib_sum : Int = 0 
    for i in range(0, len(ipt)):
        if is_digit(ipt[i]):
            if first == "":
                first = ipt[i]
            else:
                last = ipt[i]
        if ipt[i] == '\n':
            if last == "":
                last = first
            print(first+last)
            calib_sum = calib_sum + atol(first+last)
            first = ""
            last = ""
    print(calib_sum)
    f.close()
