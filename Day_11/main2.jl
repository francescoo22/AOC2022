struct Monkey
    items::Vector{Int}
    operator::String
    argument::Int
    test::Int
    true_test::Int
    false_test::Int
end

function main()

    s = read("input.txt", String)
    monkeys = split(s, "\n\n")
    monkeys = map(monkeys) do monkey
        split(monkey, "\n")
    end
    m = Vector{Monkey}()

    for monkey in monkeys
        items_st = monkey[2][19:end]
        items_st = split(items_st, ", ")
        items = map(items_st) do item
            parse(Int, item)
        end
        line3 = split(monkey[3], " ")
        
        operator = line3[7]
        argument = line3[8] == "old" ? -1 : parse(Int, line3[8])

        line4 = split(monkey[4], " ")
        test = parse(Int, line4[6])

        line5 = split(monkey[5], " ")
        true_test = parse(Int, line5[10]) + 1
        
        line6 = split(monkey[6], " ")
        false_test = parse(Int, line6[10]) + 1
        
        push!(m, Monkey(items, operator, argument, test, true_test, false_test))
    end

    v = zeros(Int, length(m))
    mod_arg = 1
    for monkey in m
        mod_arg = mod_arg * monkey.test
    end


    for i in 1:10000
        for (j, monkey) in enumerate(m)
            for item in monkey.items
                v[j] += 1
                operand = monkey.argument == -1 ? item : monkey.argument
                if monkey.operator == "*"
                    new_worry = mod(item * operand, mod_arg)
                else
                    new_worry = mod(item + operand, mod_arg)
                end

                if mod(new_worry, monkey.test) == 0
                    push!(m[monkey.true_test].items, new_worry)
                else
                    push!(m[monkey.false_test].items, new_worry)
                end
            end
            empty!(monkey.items)
        end
    end

    v = sort(v)
    println(v[end] * v[end-1])

end

main()