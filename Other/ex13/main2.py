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

def sort(lists):
    for i in range(len(lists)):
        for j in range(i + 1, len(lists)):
            if not compare(lists[i], lists[j]):
                lists[i], lists[j] = lists[j], lists[i]

def main():
    with open('input.txt', 'r') as f:
        lines = f.read().split("\n")

    lists = [[[2]],[[6]]]

    for line in lines:
        if line != '':
            list = eval(line)
            lists.append(list)

    sort(lists)
    ans = 1
    for i, list in enumerate(lists):
        if list == [[2]] or list == [[6]]:
            print(f'{i+1}: {list}')
            ans *= i + 1

    print(f'ans: {ans}')
        

if __name__ == "__main__":
    main()