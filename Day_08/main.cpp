#include <bits/stdc++.h>
using namespace std;

int main(){
    ifstream fin("../input.txt");
    vector <string> v;
    string s;

    while(fin >> s){
        v.push_back(s);
    }
    bool visible[v.size()][v[0].size()];
    memset(visible, false, sizeof(visible));

    int I = v.size(), J = v[0].size();

    for (int i = 0; i < I; i++){
        int max_tree = v[i][0];
        visible[i][0] = true;
        for (int j = 1; j < I; j++){
            if (v[i][j] > max_tree) {
                max_tree = v[i][j];
                visible[i][j] = true;
            }
        }

        max_tree = v[i][J-1];
        visible[i][J-1] = true;
        for (int j = J-2; j >= 0; j--){
            if (v[i][j] > max_tree) {
                max_tree = v[i][j];
                visible[i][j] = true;
            }
        }
    }

    for (int j = 0; j < J; j++){
        int max_tree = v[0][j];
        visible[0][j] = true;
        for (int i = 1; i < I; i++){
            if (v[i][j] > max_tree) {
                max_tree = v[i][j];
                visible[i][j] = true;
            }
        }

        max_tree = v[I-1][j];
        visible[I-1][j] = true;
        for (int i = I-2; i >= 0; i--){
            if (v[i][j] > max_tree) {
                max_tree = v[i][j];
                visible[i][j] = true;
            }
        }
    }

    int ans = 0;
    for(int i=0;i<I;i++){
        for(int j=0;j<J;j++)
            ans += visible[i][j];
    }

    cout << ans << endl;
}