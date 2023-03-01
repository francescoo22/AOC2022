#include <bits/stdc++.h>
#define ll long long int
#define el "\n"
using namespace std;
using iii = tuple<int, int, int>;

ifstream in ("input.txt");
// ifstream in ("sample_input.txt");
map<string, pair<int, int>> costs;
map<string, int> max_resource_needed; 
vector<string> materials = {"ore", "clay", "obsidian", "geode"};
int current_optimal = 0;
int MAX_MINUTE = 24;

int upper_bound(int minute, int geodes_robots, int geodes){
    int t = MAX_MINUTE - minute + geodes_robots;
    geodes += (t * (t + 1)) / 2;
    geodes -= (geodes_robots * (geodes_robots + 1)) / 2;
    return geodes;
}

bool producible (string s, map<string, int> resources){
    if (s == "ore"){
        return costs["ore"].first <= resources["ore"];
    }
    if (s == "clay"){
        return costs["clay"].first <= resources["ore"];
    }
    if (s == "obsidian"){
        return costs["obsidian"].first <= resources["ore"] && costs["obsidian"].second <= resources["clay"];
    }
    if (s == "geode"){
        return costs["geode"].first <= resources["ore"] && costs["geode"].second <= resources["obsidian"];
    }
    throw(std::runtime_error("che cazzo succede?"));
}

void sim(int minute, map<string, int> resources, map<string, int> robots, string to_produce){
    while(!producible(to_produce, resources)) {
        minute++;
        for(auto [key, value] : robots){
            resources[key] += value;
        }
        if(minute == MAX_MINUTE) {
            current_optimal = max(current_optimal, resources["geode"]);
            return;
        }
    } 

    minute++;
    for(auto [key, value] : robots){
        resources[key] += value;
    }
    if(minute == MAX_MINUTE) {
        current_optimal = max(current_optimal, resources["geode"]);
        return;
    }

    if(to_produce == "ore") resources["ore"] -= costs["ore"].first;
    if(to_produce == "clay") resources["ore"] -= costs["clay"].first;
    if(to_produce == "obsidian"){
        resources["ore"] -= costs["obsidian"].first;
        resources["clay"] -= costs["obsidian"].second;
    }
    if(to_produce == "geode"){
        resources["ore"] -= costs["geode"].first;
        resources["obsidian"] -= costs["geode"].second;
    }
    robots[to_produce]++;

    if (upper_bound(minute, robots["geode"], resources["geode"]) <= current_optimal) return;
    
    if(max_resource_needed["ore"] > robots["ore"]) sim(minute, resources, robots, "ore");
    if(max_resource_needed["clay"] > robots["clay"]) sim(minute, resources, robots, "clay");
    if(max_resource_needed["obsidian"] > robots["obsidian"]) sim(minute, resources, robots, "obsidian");
    sim(minute, resources, robots, "geode");
}

void solve(){
    int x;
    map<string, int> resources;
    map<string, int> robots;
    vector<int> optimals;

    while(in >> x){
        for(string s : materials) {
            resources[s] = 0;
            robots[s] = 0;
            max_resource_needed[s] = 0;
        }
        robots["ore"] = 1;

        in >> x;
        costs["ore"].first = x;
        max_resource_needed["ore"] = max(x, max_resource_needed["ore"]);

        in >> x;
        costs["clay"].first = x;
        max_resource_needed["ore"] = max(x, max_resource_needed["ore"]);

        in >> x;
        costs["obsidian"].first = x;
        max_resource_needed["ore"] = max(x, max_resource_needed["ore"]);
        in >> x;
        costs["obsidian"].second = x;
        max_resource_needed["clay"] = max(x, max_resource_needed["clay"]);

        in >> x;
        costs["geode"].first = x;
        max_resource_needed["ore"] = max(x, max_resource_needed["ore"]);
        in >> x;
        costs["geode"].second = x;
        max_resource_needed["obsidian"] = max(x, max_resource_needed["obsidian"]);

        sim(0, resources, robots, "ore");
        sim(0, resources, robots, "clay");

        cout << current_optimal << el;
        optimals.push_back(current_optimal);
        current_optimal = 0;
    }

    int ans = 0;
    for(int i=0; i<optimals.size(); i++){
        ans += optimals[i] * (i+1);
    }

    cout << "ans: " << ans << endl;
}

int main() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    solve();
    return 0;
}