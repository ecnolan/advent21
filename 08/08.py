
def get_easy(code):
    length = len(code)
    if length == 2:
        return 1
    if length == 4:
        return 4
    if length == 3:
        return 7
    if length == 7:
        return 8
    return False

def get_hard(code, key):
    (one_a, one_b) = (key[1][0], key[1][1])
    if len(code) == 5:
        # either 2, 3, or 5
        if one_a in code and one_b in code:
            return 3

    else:
        # either 0, 6, or 9
        # if it doesn't contain 1, it's 6
        if one_a not in code or one_b not in code:
            return 6
        # if it contains 4, it's 9
        for char in key[4]:
            if char not in code:
                return 0

        return 9

    return 10

def get_two_five(two_five, key):
    six_code = key[6]
    for char in two_five[0]:
        if char not in six_code:
            return (two_five[0], two_five[1])
    return (two_five[1], two_five[0])

def create_key(clues):
    key = ["", "", "", "", "", "", "", "", "", ""]
    others = []
    two_five = []
    for code in clues:
        num = get_easy(code)
        if num:
            key[num] = code
        else:
            others.append(code)

    for code in others:
        num = get_hard(code, key)
        if num < 10:
           key[num] = code
        else:
           two_five.append(code)

    (key[2], key[5]) = get_two_five(two_five, key)

    return key

def alphebatize(list):
    # print(list)
    for index in range(len(list)):
        str = list[index]
        str_list = sorted(str)
        str = ''
        for ch in str_list:
            str += ch
        list[index] = str
    # print(list, "sorted")
    return list

def decipher(puzzle, key):
    answer = []
    for code in puzzle:
        num = key.index(code)
        answer.append(num)
    return answer


def nums_in_line(line):
    # print(line)
    list = line.split()
    list = alphebatize(list)
    (clues, puzzle) = (list[:10], list[11:])
    # print("clues:", clues)
    # print("puzzle:", puzzle)
    # print()
    # create key for first four numbers
    key = create_key(clues)
    # get rest of numbers
    nums = decipher(puzzle, key)
    return nums

def convert(nums):
    k = (1000 * nums[0]) + (100 * nums[1]) + (10 * nums[2]) + nums[3]
    return k

def main():
    with open('input.txt') as f:
        lines = f.readlines()
    prev_space = 0
    count = 0
    solution = 0
    total = 0
    for line in lines:
        nums = nums_in_line(line)
        # print(nums)
        for num in nums:
            if num == 1 or num == 4 or num == 7 or num == 8:
                solution += 1
        # print("sum of 1s, 4s, 7s, and 8s: ", solution)
        value = convert(nums)
        total += value
        count += 1
    print("sum of 1s, 4s, 7s, and 8s: ", solution)
    print("sum of all values:", total)


main()
