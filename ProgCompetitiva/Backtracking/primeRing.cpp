#include<iostream>
#include<vector>

using namespace std;
int n;
void recursivo(vector<int>&, vector<bool>&);
bool esPrimo(int);

void ring(int num){
    n = num;
    vector<bool> usados(n+1, false);
    usados[1] = true;

    vector<int>lista;
    lista.push_back(1);   
    //El num 1 siempre va a estar en el primer lugar.

    recursivo(lista, usados);

    
    
}

void recursivo(vector<int>& lista, vector<bool>&usados){

    if(lista.size() == n){
        if(esPrimo(lista[0]+lista[n-1])){
            for (int i = 0; i < lista.size(); i++) {
                if (i > 0) cout << " ";
                cout << lista[i];
            }
            cout << endl;
        }
    }

    for(int i = 2; i <= n; i++){
        if(!usados[i] && esPrimo(i+lista[lista.size()-1])){
            lista.push_back(i);
            usados[i] = true;
            
            recursivo(lista, usados);

            lista.pop_back();
            usados[i] = false;
        }
        
    }

}

bool esPrimo(int n){
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int main(){

    while(true){
        cin >> n;
        ring(n);
    }

}