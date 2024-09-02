#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;
int INF = 1e7;
vector<int> memo_black;
vector<int> memo_white;
int maximo(vector<int>& L, int i);
int maxLista(vector<int>&L);

int black(vector<int>& arr) {
    for(int i = 1; i < arr.size(); i++){
        for(int j = 0; j < i; j++){
            if(arr[j] < arr[i] && memo_black[i] < memo_black[j] + 1){
                memo_black[i] = memo_black[j] + 1;
            }
        }
    }
    return maxLista(memo_black);
}

int white(vector<int>& arr){
    for(int i = 1; i < arr.size(); i++){
        for(int j = 0; j < i; j++){
            if(arr[j] > arr[i] && memo_white[i] < memo_white[j] + 1){
                memo_white[i] = memo_white[j] + 1;
            }
        }
    }
    return maxLista(memo_white);
}



int maxLista(vector<int>& L){
    int res = 0;
    for(int i = 0; i < L.size(); i++){
        if(L[i] > res) res = L[i];
    }
    return res;
}


int main() {
    vector<int> res;
    while(true){
        int n;
        cin >> n;
        if(n == -1) break;
        vector<int> arr(n);

        for (int i = 0; i < n; i++) {
            cin >> arr[i];
        }

        memo_black = vector<int>(n, 1);
        memo_white = vector<int>(n, 1);        
        int asc = black(arr);
        int des = white(arr);

        res.push_back(n-asc-des);
       
    } 

    for(int i = 0; i < res.size(); i++){
        cout << res[i] << endl;
    }
    
    return 0;
}