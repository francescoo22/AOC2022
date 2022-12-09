#include <bits/stdc++.h>
using namespace std;

ifstream fin("../input.txt");

int main() {
    vector <int> oppo, me;
    char s;
    fin >> s;
    while(s != 'E'){
        oppo.push_back(s - 'A');
        fin >> s;
        me.push_back(s - 'X');
        fin >> s;
    }
    int ans = 0;
    for(int i = 0; i < oppo.size(); i++){
        ans += me[i] + 1;
        if(oppo[i] == me[i]){
            ans += 3;
        } else if (me[i] == oppo[i] + 1 || me[i] == 0 && oppo[i] == 2){
            ans += 6;
        }
    }

    cout << ans << endl;
}