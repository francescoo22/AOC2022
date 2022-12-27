def compare(list1, list2):
    if type(list1) is int and type(list2) is int:
        if list1 < list2: return True
        elif list1 > list2: return False
        else : return None
    else:
        if type(list1) is int:
            list1 = [list1]
        if type(list2) is int:
            list2 = [list2]
        for i in range(len(list1)):
            if i >= len(list2):
                return False
            if compare(list1[i], list2[i]) is not None:
                return compare(list1[i], list2[i])
        if len(list1) < len(list2):
            return True
        else:
            return None

def main():
    with open('input.txt', 'r') as f:
        input = f.read().split("\n\n")

    ans = 0

    for i, lines in enumerate(input):
        lists = lines.split("\n")
        list1 = eval(lists[0])
        list2 = eval(lists[1])
        if compare(list1, list2):
            ans += 1 + i
    
    print(f'ans: {ans}')

if __name__ == "__main__":
    main()