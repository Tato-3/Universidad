#include<vector>
#include<iostream>
#include<tuple>

using namespace std;

const int INF = 99999999;

tuple<int, int> minTuple(const tuple<int, int> a, const tuple<int, int> b);

tuple<int,int> cc(vector<int> billetes, int n, int c){
    if(c == 0) return {0,0};
    if(c < 0) return {0, 0};
    if(n < 0 && c > 0) return {INF, INF};
    return minTuple(cc(billetes, n-1, c), make_tuple(get<0>(cc(billetes, n-1, c-billetes[n])) + billetes[n], get<1>(cc(billetes, n-1, c-billetes[n])) + 1));
}

tuple<int, int> minTuple(const tuple<int, int> a, const tuple<int, int> b) {
    if (get<0>(a) < get<0>(b)) return a;
    if (get<0>(a) > get<0>(b)) return b;
    if (get<1>(a) < get<1>(b)) return a;
    return b;
}

int main(){
    int n;
    cin >> n;

    int c;
    cin >> c;
    vector<int> billetes(n);
    for(int i = 0; i < n; i++){
        cin >> billetes[i];
    }

    tuple<int,int> res;
    res = cc(billetes, n-1, c);

    cout << get<0>(res) << " " << get<1>(res) << endl;
}