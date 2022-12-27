#include <bits/stdc++.h>
#define ll long long
#define key 811589153
using namespace std;

int main (){
    ifstream fin ("input.txt");
    list<ll> l;
    ll x;
    while (fin >> x) l.push_back(x * key);
    vector<list<ll>::iterator> v;
    for (auto it = l.begin(); it != l.end(); it++) v.push_back(it);
    
    ll size = l.size() - 1;
    
    for (int T = 0; T < 10; T++){
        for (ll i = 0; i < v.size(); i++){
            auto a = v[i], b = v[i];

            if (*a >= 0){
                for (ll j = 0; j <= *a % size; j++){
                    b++;
                    if (b == l.end()) b = l.begin();
                    if (j == 0) l.erase(a);
                }
            } else {
                for (ll j = 0; j <= (-*a - 1) % size; j++){
                    if (b == l.begin()) b = l.end();
                    b--;
                    if (j == 0) l.erase(a);
                }
            }
            auto new_it = l.insert(b, *a);
            v[i] = new_it;
        }
    }

    auto it = l.begin();
    while (*it != 0) it++;

    ll ans = 0;
    for (ll i = 0; i <= 3000; i++, it++){
        if (it == l.end()) it = l.begin();
        if (i % 1000 == 0){
            ans += *it;
        } 
    }

    cout << "ans: " << ans << endl;
}