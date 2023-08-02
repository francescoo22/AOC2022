#include <bits/stdc++.h>
using namespace std;

pair<int,int> next (pair<int, int> a, pair<int, int> b){
    if (abs(a.first - b.first) <= 1 && abs(a.second - b.second) <= 1)
        return a;
    int x = a.first < b.first ? 1 : -1;
    int y = a.second < b.second ? 1 : -1;
    x = a.first == b.first ? 0 : x;
    y = a.second == b.second ? 0 : y;
    return {a.first + x, a.second + y};
}

int main(){
    ifstream fin("../input.txt");
    vector <pair<int, int>> v(10, {0, 0});
    set <pair<int, int>> s;
    s.insert(v[9]);

    char move;
    fin >> move;
    while (move != 'e'){
        int x;
        fin >> x;
        switch(move){
            case 'R':
                for (int i = 0; i < x; i++){
                    v[0].second++;
                    for (int j = 1; j < 10; j++)
                        v[j] = next(v[j], v[j-1]);
                    s.insert(v[9]);
                }
                break;
            case 'L':
                for (int i = 0; i < x; i++){
                    v[0].second--;
                    for (int j = 1; j < 10; j++)
                        v[j] = next(v[j], v[j-1]);
                    s.insert(v[9]);
                }
                break;
            case 'U':
                for (int i = 0; i < x; i++){
                    v[0].first--;
                    for (int j = 1; j < 10; j++)
                        v[j] = next(v[j], v[j-1]);
                    s.insert(v[9]);
                }
                break;
            case 'D':
                for (int i = 0; i < x; i++){
                    v[0].first++;
                    for (int j = 1; j < 10; j++)
                        v[j] = next(v[j], v[j-1]);
                    s.insert(v[9]);
                }
                break;
        }
        fin >> move;
        // for (auto i : v)
        //     cout << i.first << " " << i.second << " | ";
        // cout << endl;
    }

    cout << s.size() << endl;

    // for (auto i : s)
    //     cout << i.first << " " << i.second << endl;

}