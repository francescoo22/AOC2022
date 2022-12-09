#include <bits/stdc++.h>
# define ll long long int
using namespace std;

ll get_ans (ll I, ll J, const vector<string> &v){
    ll ans = 0;
    for (int i = I + 1; i < v.size(); i++){
        ans++;
        if (v[i][J] >= v[I][J]) break;
    }


    ll temp_ans = 0;
    for (int i = I - 1; i >= 0; i--){
        temp_ans++;
        if (v[i][J] >= v[I][J]) break;
    }
    
    ans *= temp_ans;

    temp_ans = 0;
    for (int j = J + 1; j < v[0].size(); j++){
        temp_ans++;
        if (v[I][j] >= v[I][J]) break;
    }
    
    ans *= temp_ans;

    temp_ans = 0;
    for (int j = J - 1; j >= 0; j--){
        temp_ans++;
        if (v[I][j] >= v[I][J]) break;
    }
    
    ans *= temp_ans;

    return ans;
}

int main(){
    ifstream fin("../input.txt");
    vector <string> v;
    string s;

    while(fin >> s){
        v.push_back(s);
    }

    int I = v.size(), J = v[0].size();
    ll ans = 0;

    for(int i = 0; i < I; i++){
        for (int j = 0; j < J; j++){
            ll temp_ans = get_ans(i, j, v);
            ans = max(ans, temp_ans);
        }
    }

    cout << ans << endl;

}