#include <vector>
#include <iostream>
#include <map>

using namespace std;

vector<int> memo;
vector<int> estado;
vector<int> padre;
map<int, vector<int>> tree_edges;
vector<int> back_edges_con_extremo_superior_en;
vector<int> back_edges_con_extremo_inferior_en;
map<int, vector<int>> ady;

void dfs(int v, int p) {
    estado[v] = 1; // EMPECE_A_VER
    for (int u : ady[v]) {
        if (estado[u] == 0) { // NO_VI
            padre[u] = v;
            tree_edges[v].push_back(u);
            dfs(u, v);
        } else if (u != p) {
            if (estado[u] == 1) { // EMPECE_A_VER
                back_edges_con_extremo_superior_en[v]++;
            } else { // estado[u] == 2 // TERMINE_DE_VER
                back_edges_con_extremo_inferior_en[v]++;
            }
        }
    }
    estado[v] = 2; // TERMINE_DE_VER
}

int cubren(int v, int p) {
    if (memo[v] != -1) return memo[v];
    int res = 0;
    for (int hijo : tree_edges[v]) {
        if (hijo != p) {
            res += cubren(hijo, v);
        }
    }
    res += back_edges_con_extremo_superior_en[v];
    res -= back_edges_con_extremo_inferior_en[v];
    memo[v] = res;
    return res;
}

int main() {
    ady = {{0, {1, 1}}, {1, {0, 0}}};
    int n = ady.size(); // Número de nodos en el grafo

    // Inicializar las variables globales
    memo.assign(n, -1);
    estado.assign(n, 0);
    padre.assign(n, -1);
    back_edges_con_extremo_superior_en.assign(n, 0);
    back_edges_con_extremo_inferior_en.assign(n, 0);

    // Llamar a dfs para inicializar las estructuras necesarias
    dfs(0, -1);

    // Calcular cubren para todos los nodos
    for (int i = 0; i < n; ++i) {
        cout << "cubren(" << i << ") = " << cubren(i, -1) << endl;
    }

    return 0;
}