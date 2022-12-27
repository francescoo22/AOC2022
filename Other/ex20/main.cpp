#include <bits/stdc++.h>
using namespace std;

int main (){
    ifstream fin ("input.txt");
    list<int> l;
    int x;
    while (fin >> x) l.push_back(x);
    vector<list<int>::iterator> v;
    for (auto it = l.begin(); it != l.end(); it++) v.push_back(it);
    
    for (int i = 0; i < v.size(); i++){
        auto a = v[i];
        auto b = v[i];

        if (*a >= 0){
            b++;
            if (b == l.end()) b = l.begin();
            l.erase(a);
            for (int j = 0; j < *a; j++){
                b++;
                if (b == l.end()) b = l.begin();
            }
        } else {
            if (b == l.begin()) b = l.end();
            b--;
            l.erase(a);
            for (int j = 0; j < -*a - 1; j++){
                if (b == l.begin()) b = l.end();
                b--;
            }
        }
        l.insert(b, *a);
    }

    auto it = l.begin();
    while (*it != 0) it++;

    int ans = 0;
    for (int i = 0; i <= 3000; i++, it++){
        if (it == l.end()) it = l.begin();
        if (i % 1000 == 0){
            // cout << *it << endl;
            ans += *it;
        } 
    }

    cout << "ans: " << ans << endl;
}