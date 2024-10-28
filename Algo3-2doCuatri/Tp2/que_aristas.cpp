#include <iostream>
#include <vector>
#include <tuple>
#include <algorithm>
#include <map>
using namespace std;

int n;
int NO_LO_VI = 0, EMPECE_A_VER = 1, TERMINE_DE_VER = 2;
vector<int> estado;
vector<int> memo;
vector<int> padre;
vector<vector<int>> tree_edges;
vector<int> back_edges_con_extremo_inferior_en;
vector<int> back_edges_con_extremo_superior_en;
map<int, vector<int>> map_ady;


struct Arista {
    int u, v, peso, indice;
    string tipo;
};

class DSU {
    vector<int> rank, parent;
public:
    DSU(int n) {
        rank.resize(n + 1, 0);
        parent.resize(n + 1);
        for(int i = 0; i < n + 1; i++){
            parent[i] = i;
        }
    }
 
    int find(int node){
 
        // En caso que nodo sea el representante
        if (node == parent[node]) return node;
 
        // Hago path compression
        return parent[node] = find(parent[node]);
    }
 
    void unite(int u, int v) {
        int uRepresentative = find(u);
        int vRepresentative = find(v);
 
        // Si tienen el mismo representante, entonces pertenece al
        // mismo conjunto
        if (uRepresentative == vRepresentative) return;
 
        // Actualizamos el representante segun el caso del rank
        if (rank[uRepresentative] < rank[vRepresentative]) {
            parent[uRepresentative] = vRepresentative;
        } else if(rank[uRepresentative] > rank[vRepresentative]) {
            parent[vRepresentative] = uRepresentative;
        } else {
            parent[vRepresentative] = uRepresentative;
            rank[uRepresentative]++;
        }
    }
};

void dfs(int v, int p) {
    estado[v] = 1; // EMPECE_A_VER
    for (int u : map_ady[v]) {
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

void kruskal(vector<Arista>& E, int n) {
    long long res = 0;
    sort(E.begin(), E.end(), [](const Arista& a, const Arista& b) {
        return a.peso < b.peso;
    });

    DSU dsu(n);
 
    for(int i = 0; i < E.size() - 1; i++){
        auto& arista = E[i];        
        //Si la prox arista tiene el mismo peso que la actual, entonces voy a iterar para agarrarme las aristas del mismo peso y luego agregarlas al grafo G'
        // y usar las componentes conexas de mi AGM actual como vertices, para luego hacer Tarjan(detectar las aristas puentes) y decir que estas son "any"
        // y las restantes son "at least one"
        if(arista.peso == E[i+1].peso){
            int j = i;
            vector<tuple<int, int>> aristas_G;
            while(j < E.size() && arista.peso == E[j].peso){
                aristas_G.push_back({E[j].u, E[j].v});
                j++;
            }

            for(auto [u, v] : aristas_G){
                int rep_u = dsu.find(u);
                int rep_v = dsu.find(v);
                if(rep_u != rep_v){
                    map_ady[rep_u].push_back(rep_v);
                    map_ady[rep_v].push_back(rep_u);
                }    
            }

            estado.assign(n + 1, NO_LO_VI);
            memo.assign(n + 1, -1);
            padre.assign(n + 1, -1);
            tree_edges.assign(n + 1, vector<int>());
            back_edges_con_extremo_inferior_en.assign(n + 1, 0);
            back_edges_con_extremo_superior_en.assign(n + 1, 0);

            dfs(0, -1);
            cubren(arista.u, -1);
            for (auto [u, v] : aristas_G) {
                if (cubren(dsu.find(u), -1) > 0) {
                    E[i].tipo = "at least one";
                } else {
                    E[i].tipo = "any";
                }
            }
            i = j - 1;
        }


        else if(dsu.find(arista.u) != dsu.find(arista.v)){
            dsu.unite(arista.u, arista.v);
            res += arista.peso;
            arista.tipo = "any";
        }

    }

}

int main() {
    int m;
    cin >> n >> m;
    vector<Arista> lista_aristas(m);
    for (int i = 0; i < m; i++) {
        int nodo1, nodo2, peso_arista;
        cin >> nodo1 >> nodo2 >> peso_arista;
        lista_aristas[i] = {nodo1, nodo2, peso_arista, i, "none"};
    }
    
    kruskal(lista_aristas, n);
    
    // Ordenar las aristas por su índice original para restaurar el orden
    sort(lista_aristas.begin(), lista_aristas.end(), [](const Arista& a, const Arista& b) {
        return a.indice < b.indice;
    });

    for (const auto& arista : lista_aristas) {
        cout << arista.tipo << endl;
    }

    return 0;
}
