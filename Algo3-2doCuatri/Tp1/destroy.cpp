#include <iostream>
#include <vector>


using namespace std;
int n;
const int INF = 1e7;
vector<int> costo;
vector<int> damage;

int calcularDamage(int i, int c, int d){

    if(c > 4) return -INF;

    if(i == n) return d;

    int noAgrego = calcularDamage(i+1, c, d);

    cartasUsadas += 1;
    int nuevoDamage = d + damage[i];
    if(cartasUsadas == 10){
        nuevoDamage += damage[i];
    }
    int agrego = calcularDamage(i+1, c + costo[i], nuevoDamage);
    cartasUsadas -= 1;
    
    return max(noAgrego, agrego);

}

int main(){
    int t;
    cin >> t;
    int total = 0;
    for(int k = 0; k < t; k++){
        cin >> n;
        costo = vector<int>(n);
        damage = vector<int>(n);
        for(int i = 0; i < n; i++){
            cin >> costo[i];
            cin >> damage[i];
        }
        int cartasUsadas = 0;
        int res = calcularDamage(0, 0, 0);
        
        total += res;
    }

    cout << total << endl;
}