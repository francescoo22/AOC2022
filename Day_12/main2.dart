import 'dart:io';
import 'dart:collection';

void main() {
    var input = File('input.txt').readAsStringSync();
    var lines = input.split('\n');
    
    var map = [];
    var starts = [], end = [0, 0];
    for (var i = 0; i < lines.length; i++) {
        map.add([]);
        for (var j = 0; j < lines[i].length; j++) {
            map[i].add(-1);
            if (lines[i][j] == 'S' || lines[i][j] == 'a') {
                starts.add ([i, j]);
                lines[i] = lines[i].substring(0,j) + 'a' + lines[i].substring(j + 1);
            } else if (lines[i][j] == 'E') {
                end = [i, j];
                lines[i] = lines[i].substring(0,j) + 'z' + lines[i].substring(j + 1);
            }
        }
    }

    
    var ans = 100000000;

    starts.forEach((start){
        var queue = Queue();
        queue.add(start);
        map = [];
        for (var i = 0; i < lines.length; i++) {
            map.add([]);
            for (var j = 0; j < lines[i].length; j++) {
                map[i].add(-1);
            }
        }
        map[start[0]][start[1]] = 0;
        while(!queue.isEmpty && map[end[0]][end[1]] == -1){
            var cur = queue.removeFirst();
            var x = cur[0], y = cur[1];
            if (x-1 >= 0 && lines[x-1][y].codeUnits.first <= lines[x][y].codeUnits.first + 1 && map[x-1][y] == -1){
                map[x-1][y] = map[x][y] + 1;
                queue.add([x-1, y]);
            }
            if (x+1 < lines.length && lines[x+1][y].codeUnits.first <= lines[x][y].codeUnits.first + 1 && map[x+1][y] == -1){
                map[x+1][y] = map[x][y] + 1;
                queue.add([x+1, y]);
            }
            if (y-1 >= 0 && lines[x][y-1].codeUnits.first <= lines[x][y].codeUnits.first + 1 && map[x][y-1] == -1){
                map[x][y-1] = map[x][y] + 1;
                queue.add([x, y-1]);
            }
            if (y+1 < lines[x].length && lines[x][y+1].codeUnits.first <= lines[x][y].codeUnits.first + 1 && map[x][y+1] == -1){
                map[x][y+1] = map[x][y] + 1;
                queue.add([x, y+1]);
            }
        }
        if (map[end[0]][end[1]] < ans && map[end[0]][end[1]] != -1) {
            ans = map[end[0]][end[1]];
        }
    });

    print(ans);
}