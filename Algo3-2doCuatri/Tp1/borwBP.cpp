#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

vector<vector<vector<int>>> memo;
vector<int> arr;
int INF = 1e7;

// Función para calcular LIS que termina en cada índice i
int borw(int i, int black, int white, int ultimoBlack, int ultimoWhite){
    int n = arr.size();

    if(i == n) return n - (black + white);

    if(memo[i][black][white] != -1) return memo[i][black][white];

    int noAgrego = borw(i+1, black, white, ultimoBlack, ultimoWhite);

    int pintoNegro = INF;
    if(black == 0 || arr[ultimoBlack] < arr[i]){
        pintoNegro = borw(i+1, black + 1, white, i, ultimoWhite);
    }

    int pintoBlanco = INF;
    if(white == 0 || arr[i] < arr[ultimoWhite]){
        pintoBlanco = borw(i+1, black, white + 1, ultimoBlack, i);

    }

    return memo[i][black][white] = min(noAgrego, min(pintoNegro, pintoBlanco));

}

int main() {
    vector<int> res;
    while (true) {
        int n;
        cin >> n;
        if (n == -1) break;

        arr = vector<int>(n);
        for (int i = 0; i < n; i++) {
            cin >> arr[i];
        }

        memo = vector<vector<vector<int>>>(n + 1, vector<vector<int>>(n + 1, vector<int>(n + 1, -1)));

        int longi = borw(0, 0, 0, -1, -1);

        res.push_back(longi);
    }

    for (int i = 0; i < res.size(); i++) {
        cout << res[i] << endl;
    }

    return 0;
}