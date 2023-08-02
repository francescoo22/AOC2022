#include <bits/stdc++.h>
using namespace std;

class Position{
public:
    int x, y, round;
    Position(int x, int y, int round){
        this->x = x;
        this->y = y;
        this->round = round;
    }
};

class Blizzard{
public:
    int x, y;
    pair<int, int> direction;

    Blizzard(int x, int y, char c){
        this->x = x;
        this->y = y;
        switch (c){
            case '^':
                direction = {-1, 0};
                break;
            case 'v':
                direction = {1, 0};
                break;
            case '<':
                direction = {0, -1};
                break;
            case '>':
                direction = {0, 1};
                break;
            default:
                throw std::runtime_error("Invalid direction");
        }
    }

    pair <int, int> get_position (int round, int height, int width){
        int x = this->x + round * this->direction.first;
        int y = this->y + round * this->direction.second;
        if (x < height) x += height * round;
        if (y < width) y += width * round;
        if (x > height) x = x % height == 0 ? height : x % height;
        if (y > width) y = y % width == 0 ? width : y % width;

        return {x, y};
    }
};

int main (){
    auto start_time = std::chrono::system_clock::now();
    ifstream fin("input.txt");
    vector<string> input;
    string line;
    while(fin >> line){
        input.push_back(line);
    }

    vector<Blizzard> blizzards;

    for (int i = 0; i < input.size(); i++){
        for (int j = 0; j < input[i].size(); j++){
            if (input[i][j] != '.' && input[i][j] != '#'){
                blizzards.push_back(Blizzard(i, j, input[i][j]));
            }
        }
    }

    pair<int, int> start, end;
    for (int i = 0; i < input[0].size(); i++){
        if (input[0][i] == '.'){
            start = {0, i};
            break;
        }
    }

    for (int i = 0; i < input[input.size() - 1].size(); i++){
        if (input[input.size() - 1][i] == '.'){
            end = {input.size() - 2, i};
            break;
        }
    }

    deque<Position> q;
    q.push_back(Position(start.first, start.second, 0));

    const int HEIGHT = input.size() - 2;
    const int WIDTH = input[0].size() - 2;
    const int MAX_ROUND = 1000;

    bool visited[HEIGHT + 2][WIDTH + 2][MAX_ROUND];
    memset(visited, false, sizeof(visited));

    while (q.front().x != end.first || q.front().y != end.second){

        Position p = q.front();
        
        q.pop_front();
        bool move_up, move_down, move_left, move_right, stay = true;
        if (p.x == 0 || input[p.x - 1][p.y] == '#') move_up = false; else move_up = true;
        if (input[p.x + 1][p.y] == '#') move_down = false; else move_down = true;
        if (input[p.x][p.y - 1] == '#') move_left = false; else move_left = true;
        if (input[p.x][p.y + 1] == '#') move_right = false; else move_right = true;

        for (auto blizzard : blizzards){
            pair<int, int> pos = blizzard.get_position(p.round + 1, HEIGHT, WIDTH);
            if (pos.first == p.x - 1 && pos.second == p.y) move_up = false;
            if (pos.first == p.x + 1 && pos.second == p.y) move_down = false;
            if (pos.first == p.x && pos.second == p.y - 1) move_left = false;
            if (pos.first == p.x && pos.second == p.y + 1) move_right = false;
            if (pos.first == p.x && pos.second == p.y) stay = false;
        }

        if (move_up && !visited[p.x - 1][p.y][p.round + 1]){
            q.push_back(Position(p.x - 1, p.y, p.round + 1));
            visited[p.x - 1][p.y][p.round + 1] = true;
        }
        if (move_down && !visited[p.x + 1][p.y][p.round + 1]){
            q.push_back(Position(p.x + 1, p.y, p.round + 1));
            visited[p.x + 1][p.y][p.round + 1] = true;
        }
        if (move_left && !visited[p.x][p.y - 1][p.round + 1]){
            q.push_back(Position(p.x, p.y - 1, p.round + 1));
            visited[p.x][p.y - 1][p.round + 1] = true;
        }
        if (move_right && !visited[p.x][p.y + 1][p.round + 1]){
            q.push_back(Position(p.x, p.y + 1, p.round + 1));
            visited[p.x][p.y + 1][p.round + 1] = true;
        }
        if (stay && !visited[p.x][p.y][p.round + 1]){
            q.push_back(Position(p.x, p.y, p.round + 1));
            visited[p.x][p.y][p.round + 1] = true;
        }
    }
    
    auto end_time = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed_seconds = end_time - start_time;
    
    std::cout << "answer: " << q.front().round + 1 << endl;
    cout << "elapsed time: " << elapsed_seconds.count() << "s" << endl;
    
    
}