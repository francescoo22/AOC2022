#include <bits/stdc++.h>
using namespace std;

bool is_alone (pair<int,int> position, const set<pair<int,int>> & plant){
    if (plant.find({position.first-1, position.second}) == plant.end() &&
        plant.find({position.first+1, position.second}) == plant.end() &&
        plant.find({position.first, position.second-1}) == plant.end() &&
        plant.find({position.first, position.second+1}) == plant.end() &&
        plant.find({position.first-1, position.second-1}) == plant.end() &&
        plant.find({position.first-1, position.second+1}) == plant.end() &&
        plant.find({position.first+1, position.second-1}) == plant.end() &&
        plant.find({position.first+1, position.second+1}) == plant.end()){
            return true;
        }
    return false;
}

bool move ( pair<int,int> pos, char coord,
            set<pair<int,int>> & plant,
            multiset<pair<int,int>> & next_to_move,
            map<pair<int,int>, pair<int,int>> & prev_pos){
    switch (coord){
        case 'N':
            if (plant.find({pos.first-1,pos.second}) == plant.end() &&
                plant.find({pos.first-1,pos.second-1}) == plant.end() &&
                plant.find({pos.first-1,pos.second+1}) == plant.end()){
                    next_to_move.insert({pos.first-1,pos.second});
                    prev_pos[{pos.first-1,pos.second}] = pos;
                    return true;
            } else return false;
            break;
        case 'S':
            if (plant.find({pos.first+1,pos.second}) == plant.end() &&
                plant.find({pos.first+1,pos.second-1}) == plant.end() &&
                plant.find({pos.first+1,pos.second+1}) == plant.end()){
                    next_to_move.insert({pos.first+1,pos.second});
                    prev_pos[{pos.first+1,pos.second}] = pos;
                    return true;
                } else return false;
            break;
        case 'W':
            if (plant.find({pos.first,pos.second-1}) == plant.end() &&
                plant.find({pos.first-1,pos.second-1}) == plant.end() &&
                plant.find({pos.first+1,pos.second-1}) == plant.end()){
                    next_to_move.insert({pos.first,pos.second-1});
                    prev_pos[{pos.first,pos.second-1}] = pos;
                    return true;
                } else return false;
            break;
        case 'E':
            if (plant.find({pos.first,pos.second+1}) == plant.end() &&
                plant.find({pos.first-1,pos.second+1}) == plant.end() &&
                plant.find({pos.first+1,pos.second+1}) == plant.end()){
                    next_to_move.insert({pos.first,pos.second+1});
                    prev_pos[{pos.first,pos.second+1}] = pos;
                    return true;
                } else return false;
            break;
        default:
            throw std::invalid_argument("Invalid direction");
    }
}

int main (){
    ifstream fin("input.txt");
    vector<string> input;
    string line;
    while(fin >> line){
        input.push_back(line);
    }
    
    set<pair<int,int>> positions;
    multiset<pair<int,int>> next_to_move;
    map<pair<int, int>, pair<int,int>> prev_pos;

    for (int i = 0; i < input.size(); i++){
        for (int j = 0; j < input[i].size(); j++){
            if (input[i][j] == '#'){
                positions.insert({i,j});
            }
        }
    }

    const int ROUNDS = 10;
    const vector<char> moves = {'N', 'S', 'W', 'E'};

    for(int i = 0; i < ROUNDS; i++){
        for (auto pos : positions){
            if (!is_alone(pos, positions)){
                bool done = false;
                for (int j = i; j <= i+4 && !done; j++){
                    done = move(pos, moves[j%4], positions, next_to_move, prev_pos);
                }
            }
        }

        for (auto pos : next_to_move){
            if (next_to_move.count(pos) == 1){
                positions.insert(pos);
                positions.erase(prev_pos[pos]);
            }
        }

        next_to_move.clear();
        prev_pos.clear();
    }



    int min_x = INT_MAX, min_y = INT_MAX, max_x = INT_MIN, max_y = INT_MIN;

    for (auto pos : positions){
        min_x = min(min_x, pos.first);
        min_y = min(min_y, pos.second);
        max_x = max(max_x, pos.first);
        max_y = max(max_y, pos.second);
    }

    // **************** PRINT THE MAP ****************
    //
    // for (int i = min_x; i <= max_x; i++){
    //     for (int j = min_y; j <= max_y; j++){
    //         if (positions.find({i,j}) != positions.end()){
    //             cout << "#";
    //         } else {
    //             cout << ".";
    //         }
    //     }
    //     cout << endl;
    // }
    //
    // ***********************************************

    int ans = (max_x - min_x + 1) * (max_y - min_y + 1) - positions.size();
    cout << "ans: " << ans << endl;

}