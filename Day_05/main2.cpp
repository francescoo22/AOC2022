#include <bits/stdc++.h>
using namespace std;

ifstream fin ("../input.txt");
int main()
{
    vector <string> stacks;
    string s;
    std::getline(fin, s);

    while (s[1] != '1'){
        stacks.push_back(s);
        std::getline(fin, s);
    }

    int n = (s.length() + 1) / 4;
    vector <stack<char>> v(n);

    for (int i = stacks.size() - 1; i >= 0; i--){
        for (int j = 0; j < n; j++){
            if (stacks[i][j * 4 + 1] != ' '){
                v[j].push(stacks[i][j * 4 + 1]);
            }
        }
    }

    getline(fin, s);
    getline(fin, s);

    while(s!="end"){
        s = s.substr(5);

        int i = 0;
        string ss1 = "";
        while(s[i] != ' '){
            ss1.push_back(s[i]);
            i++;
        }

        int s1;
        s1 = std::stoi(ss1);

        while (s[i] > '9' || s[i] < '0'){
            i++;
        }

        int s2;
        s2 = s[i] - '0';

        int s3;
        s3 = *s.rbegin() - '0';

        stack <char> temp_stack;

        for (int i = 0; i<s1; i++){
            if (v[s2 -1].empty())break;

            char c = v[s2 - 1].top();
            v[s2 - 1].pop();

            temp_stack.push(c);
        }

        while (!temp_stack.empty()){
            v[s3 -1].push(temp_stack.top());
            temp_stack.pop();
        }

        getline(fin, s);
    }
    
    string ans = "";
    for (int i=0; i<n; i++){
        if (!v[i].empty()){
            ans += v[i].top();
        }
    }

    cout << ans << endl;

    return 0;
}