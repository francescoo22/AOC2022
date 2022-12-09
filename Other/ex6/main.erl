-module(main).
-compile(export_all).


readlines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    try get_all_lines(Device)
      after file:close(Device)
    end.

get_all_lines(Device) ->
    case io:get_line(Device, "") of
        eof  -> [];
        Line -> Line ++ get_all_lines(Device)
    end.

uniq(List) ->
    Set = sets:from_list(List),
    sets:to_list(Set).

f(Acc, List, F) ->
    [A, B, C, D | _] = List,
    Temp = uniq ([A, B, C, D]),
    if length(Temp) == 4 -> Acc;
        true -> [_ | T] = List,
                f(Acc + 1, T, F)
    end.


main() ->
    In = readlines("../input.txt"),
    Ans = f(4, In, f),
    io:format("~p~n", [Ans]).
    