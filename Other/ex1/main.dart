import 'dart:io';

main() {
    var input = File('input.txt').readAsStringSync();
    var lines = input.split('\n');
    var ans = 0, temp_ans = 0;
    lines.forEach((line) {
        if (line != ''){
            temp_ans += int.parse(line);
        } else {
            ans = ans > temp_ans ? ans : temp_ans;
            temp_ans = 0;
        }
    });
    ans = ans > temp_ans ? ans : temp_ans;
    print(ans);
    
}