program Hello;
Uses sysutils;
var
    i : integer;
    j : integer;
    s : string;
    ans : integer;
    c : char;
    v : array [0..3] of string;
    a : array [0..3] of integer;
begin
    ans := 0;
    c := 'a';
    for i :=1 to 1000 do
    begin
        readln(s);
        j := 1;
        
        v[0] := '';
        while (s[j] <> '-') do
        begin
            v[0] := v[0] + s[j];
            j := j + 1;
        end;

        j := j + 1;
        v[1] := '';
        while (s[j] <> ',') do
        begin
            v[1] := v[1] + s[j];
            j := j + 1;
        end;

        j := j + 1;
        v[2] := '';
        while (s[j] <> '-') do
        begin
            v[2] := v[2] + s[j];
            j := j + 1;
        end;

        j := j + 1;
        v[3] := '';
        while (j <= length(s)) do
        begin
            v[3] := v[3] + s[j];
            j := j + 1;
        end;

        for j := 0 to 3 do
        begin
            a[j] := StrToInt(v[j]);
        end;

        if ((a[0] >= a[2]) and (a[1] <= a[3])) or ((a[0] <= a[2]) and (a[1] >= a[3])) then ans := ans + 1;
    end;
    writeLn(ans);
end.