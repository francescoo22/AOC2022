#include <bits/stdc++.h>
using namespace std;
using ll = long long int;

ifstream in("input.txt");

ll snafu_to_int (string s){
    reverse(s.begin(), s.end());

    ll ans = 0;
    ll pow = 1;
    auto ctoi = [](char c){
        switch(c){
            case '-': return -1;
            case '=': return -2;
            default: return c - '0';
        }
    };
    for(char c : s){
        ans += pow * ctoi(c);
        pow *= 5;
    }

    return ans;
}

string int_to_snafu(ll n){
    vector<int> v;
    while(n != 0){
        v.push_back(n % 5);
        n /= 5;
    }
    
    v.push_back(0);
    for(int i=0; i< v.size(); i++){
        if(v[i] > 2){
            v[i+1]++;
            v[i] -= 5;
        }
    }

    while(v.back() == 0) v.pop_back();

    auto itoc = [](int i){
        switch(i){
            case -2: return '=';
            case -1: return '-';
            default: return char('0' + i);
        }
    };
    
    string ans = "";

    for(int i=v.size()-1; i>=0; i--){
        ans += itoc(v[i]);
    }

    return ans;
}

int main(){
    vector<string> strings;
    string t;

    while(in >> t) strings.push_back(t);

    ll sum = 0;
    for(string s : strings) sum += snafu_to_int(s);

    cout << sum << endl;

    cout << int_to_snafu(sum) << endl;
}