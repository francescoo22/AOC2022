#include <bits/stdc++.h>
using namespace std;

bool is_adjacent (pair<int, int> a, pair<int, int> b){
    if (abs(a.first - b.first) <= 1 && abs(a.second - b.second) <= 1)
        return true;
    return false;
}

int main(){
    ifstream fin("../input.txt");
    pair<int, int> h {0, 0}, t {0, 0};
    set<pair<int, int>> s;
    s.insert(t);

    char move;
    fin >> move;
    while (move != 'e'){
        int x;
        fin >> x;
        pair <int, int> prev_h = h;
        switch(move){
            case 'R':
                for (int i = 0; i < x; i++){
                    prev_h = h;
                    h.first++;
                    if (!is_adjacent(h, t)){
                        t = prev_h;
                        s.insert(t);
                    }
                }
                break;
            case 'L':
                for (int i = 0; i < x; i++){
                    prev_h = h;
                    h.first--;
                    if (!is_adjacent(h, t)){
                        t = prev_h;
                        s.insert(t);
                    }
                }
                break;
            case 'U':
                for (int i = 0; i < x; i++){
                    prev_h = h;
                    h.second--;
                    if (!is_adjacent(h, t)){
                        t = prev_h;
                        s.insert(t);
                    }
                }
                break;
            case 'D':
                for (int i = 0; i < x; i++){
                    prev_h = h;
                    h.second++;
                    if (!is_adjacent(h, t)){
                        t = prev_h;
                        s.insert(t);
                    }
                }
                break;
        }
        fin >> move;
    }

    cout << s.size() << endl;

    // for (auto i : s)
    //     cout << i.first << " " << i.second << endl;

}