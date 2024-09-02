#include<iostream>
#include<vector>

using namespace std;

int n;
int maximo(vector<int>& longitudes);

int oneElement(vector<int>& numeros){
    vector<int> longitudes(n, 1);

    for(int i = 1; i < n; i++){
        for(int j = 0; j < i; j++){
            if(numeros[j] < numeros[i] && longitudes[i] < longitudes[j] + 1){
                longitudes[i] = longitudes[j] + 1;
            }
        }
    }

    return maximo(longitudes);

}

int maximo(vector<int>& longitudes){
    int res = 0;
    for(int i = 0; i < n; i++){
        if(longitudes[i] > res) res = longitudes[i];
    }
    return res;
}

int main(){
    cin >> n;
    vector<int> numeros(n);
    for(int i = 0; i < n; i++){
        cin >> numeros[i];
    }

    cout << oneElement(numeros) << endl;
}