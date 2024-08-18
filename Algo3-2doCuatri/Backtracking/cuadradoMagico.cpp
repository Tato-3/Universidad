#include <iostream>
#include <vector>

using namespace std;

static bool cuadradoMagicoValido(vector<vector<int>> matriz, int m);
int sumRow(vector<int> l);
int sumColumn(vector<vector<int>> matriz, int j);
int sumDiagonalPrincipal(const vector<vector<int>>& matriz);
int sumDiagonalSecundaria(const vector<vector<int>>& matriz);

void cuadradoMagico(vector<vector<int>> matriz, int i, int j, int m){

    int n = matriz.size();
    if(i == n){
        if(cuadradoMagicoValido(matriz, m)){
            for (int k = 0; k < matriz.size(); k++){
                for (int h = 0; h < matriz.size(); h++){
                    cout << matriz[k][h] << " ";
                }
                cout << endl;
            }

            return;
        }else{
            return;
        }
    }

    int ni = (j == n - 1) ? i + 1 : i;
    int nj = (j + 1) % n;

    for(int num = 1; num < 1+(n*n); num++){
        matriz[i][j] = num;
        cuadradoMagico(matriz, ni, nj, m);
        matriz[i][j] = 0;
    }

}

static bool cuadradoMagicoValido(vector<vector<int>> matriz, int m){
    bool res = true;
    int n = matriz.size();
    
    if(matriz[n-1].size() != n) return false;
    
    vector<int> numeros(n*n);

    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            if(numeros[matriz[i][j]-1] == 1){
                return false;
            }
            else{
                numeros[matriz[i][j]-1] = 1;
            }
        }
    }

    for(int i = 0; i < n; i++){
        if(m != sumRow(matriz[i])) return false;
        if(m != sumColumn(matriz, i)) return false;
    }

    if(m != sumDiagonalPrincipal(matriz)) return false;
    if(m != sumDiagonalSecundaria(matriz)) return false;


    return res;

}   


int main(){
    int n;
    cin >> n;

    int m = n*(n*n+1)/2;

    vector<vector<int>> matriz(n, vector<int>(n, 0));

    vector<vector<int>> ejemplo = {{1,4,5}, {2,7,9}, {3,8,6}};

    bool ej = cuadradoMagicoValido(ejemplo, m);
    cout << ej << endl;
    //cuadradoMagico(matriz, 0, 0, m);

    return 0;
}


int sumRow(vector<int> l){
    int res = 0;
    for(int i = 0; i < l.size(); i++){
        res += l[i];
    }
    return res;
}

int sumColumn(vector<vector<int>> matriz, int j){
    int res = 0;
    for(int i = 0; i < matriz.size(); i++){
        res += matriz[j][i];
    }
    return res;
}

int sumDiagonalPrincipal(const vector<vector<int>>& matriz) {
    int res = 0;
    for (int i = 0; i < matriz.size(); i++) {
        res += matriz[i][i];
    }
    return res;
}

int sumDiagonalSecundaria(const vector<vector<int>>& matriz) {
    int res = 0;
    int n = matriz.size();
    for (int i = 0; i < n; i++) {
        res += matriz[i][n - 1 - i];
    }
    return res;
}