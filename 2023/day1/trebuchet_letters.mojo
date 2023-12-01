
def get_num_or_empty(idx: Int, ipt: String) -> String:
    var nums = VariadicList("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
    if ord(ipt[idx]) >= 48 and ord(ipt[idx]) <= 57:
        return ipt[idx]
    else:
        for i in range(0, len(nums)):
            if ipt.find(nums[i], idx) == 0:
                return String(i)
    return ""

def main():
    var f = open("input", "r")
    var ipt = f.read()
    var first : String = ""
    var last : String = ""
    var calib_sum : Int = 0 
    for i in range(0, len(ipt)):
        let maybe_num : String = get_num_or_empty(i, ipt)
        if maybe_num != "":
            if first == "":
                first = maybe_num
            else:
                last = maybe_num
        if ipt[i] == '\n':
            if last == "":
                last = first
            print(first+last)
            calib_sum = calib_sum + atol(first+last)
            first = ""
            last = ""
    print(calib_sum)
    f.close()
