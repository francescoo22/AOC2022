#include <fstream>
#include <bits/stdc++.h>
using namespace std;

vector<string> split(string s, string delimiter){
    vector<string> v;
    string curr = "";
    for (int i=0; i<s.length(); i++){
        if (s.substr(i, delimiter.length()) == delimiter){
                v.push_back(curr);
                curr = "";
                i += delimiter.length()-1;
        }
        else{
            curr += s[i];
        }
    }
    v.push_back(curr);
    return v;
}

int main(){
    ifstream fin("input.txt");
    string s;
    std::getline(fin, s);
    vector<vector<pair<int,int>>> v;

    int max_x = 0, min_x = INT_MAX, max_y = 0;
    while (s != ""){
        vector<string> coords = split(s, " -> ");
        vector<pair<int,int>> temp;
        for (string coord : coords){
            vector<string> xy = split(coord, ",");
            temp.push_back({stoi(xy[0]), stoi(xy[1])});
            max_x = max(max_x, stoi(xy[0]));
            min_x = min(min_x, stoi(xy[0]));
            max_y = max(max_y, stoi(xy[1]));
        }
        v.push_back(temp);

        std::getline(fin, s);
    }

    int delta = max_x - min_x;

    for (auto &line : v){
        for (auto &coord : line){
            coord.first -= min_x;
        }
    }

    char mat[max_y + 1][delta + 1];

    for (int i = 0; i < max_y + 1; i++)
        for (int j = 0; j < delta + 1; j++)
            mat[i][j] = '.';

    for (auto line : v){
        for (int i = 0; i < line.size()-1; i++){
            if (line[i].first == line[i+1].first){
                int j1 = line[i].second, j2 = line[i+1].second;
                if (j1 > j2) swap(j1, j2);
                for (int j = j1; j <= j2; j++){
                    mat[j][line[i].first] = '#';
                }
            }
            else{
                int j1 = line[i].first, j2 = line[i+1].first;
                if (j1 > j2) swap(j1, j2);
                for (int j = j1; j <= j2; j++){
                    mat[line[i].second][j] = '#';
                }
            }
        }
    }

    int start = 500 - min_x;

    bool guard = true;
    int ans = 0;
    while(guard){
        bool guard2 = true;
        int i = 0, j = start;
        while(guard2){
            // cout << i << " " << j << endl;
            if (i + 1 > max_y){
                guard = false;
                break;
            } else if (mat[i + 1][j] == '.'){
                i++;
                continue;
            } else if (j -1 < 0) {
                guard = false;
                break;
            } else if (mat[i + 1][j-1] == '.') {
                i++;
                j--;
                continue;
            } else if (j + 1 > delta) {
                guard = false;
                break;
            } else if (mat[i + 1][j+1] == '.') {
                i++;
                j++;
                continue;
            } else {
                mat[i][j] = 'o';
                ans++;
                guard2 = false;
            }
        }
    }
    cout << ans << endl;

}