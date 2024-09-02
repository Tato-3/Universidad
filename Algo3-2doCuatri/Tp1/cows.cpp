#include<iostream>
#include<vector>
#include<algorithm>

using namespace std;

int n;
int c;
vector<vector<int>> memo;
vector<int> usados;
vector<int> stalls;
int minDistancia(vector<int>& lista);
const int INF = 1e7;

int cows(int i, int k){
    if(c == k) return minDistancia(usados);

    if(i >= n && k < c) return -INF;

    if(memo[i][k] != -1) return memo[i][k];

    int noAgrego = cows(i+1, k);    
    
    usados.push_back(stalls[i]);
    int agrego = cows(i+1, k+1);
    usados.pop_back();

    return memo[i][k] = max(agrego, noAgrego);

}

int minDistancia(vector<int>& usados){
    sort(usados.begin(), usados.end());

    int minDist = 1e7;

    for(int i = 0; i < usados.size()-1; i++){
        int min = usados[i+1] - usados[i];
        if(min < minDist) minDist = min;
    }

    return minDist;
}


int main(){

    int t;
    cin >> t;
    for(int i = 0; i < t; i++){
        cin >> n;
        cin >> c;

        memo = vector<vector<int>>(n+1, vector<int>(c+1, -1));  
        stalls = vector<int>(n);

        for(int j = 0; j < n; j++){
            cin >> stalls[j];
        }

        cout << cows(0, 0) << endl;
    }


    return 0;
}