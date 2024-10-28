#include <iostream>
#include <vector>
#include <tuple>
#include <algorithm>
#include <map>
using namespace std;

int n;

struct Arista {
    int u, v, peso;
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
        if (node == parent[node]) return node;
        return parent[node] = find(parent[node]);  // Path compression
    }
 
    void unite(int u, int v) {
        int uRepresentative = find(u);
        int vRepresentative = find(v);
        if (uRepresentative == vRepresentative) return;
 
        if (rank[uRepresentative] < rank[vRepresentative]) {
            parent[vRepresentative] = uRepresentative;
        } else if(rank[uRepresentative] > rank[vRepresentative]) {
            parent[uRepresentative] = vRepresentative;
        } else {
            parent[vRepresentative] = uRepresentative;
            rank[uRepresentative]++;
        }
    }
};

void kruskal(vector<Arista>& E, int n) {
    long long res = 0;
    sort(E.begin(), E.end(), [](const Arista& a, const Arista& b) {
        return a.peso < b.peso;
    });

    DSU dsu(n);
 
    int aristas = 0;
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

            map<int, vector<int>> map_ady;
            for(auto [u, v] : aristas_G){
                int rep_u = dsu.find(u);
                int rep_v = dsu.find(v);
                if(rep_u != rep_v){
                    map_ady[rep_u].push_back(rep_v);
                    map_ady[rep_v].push_back(rep_u);
                }    
            }
            cout << "Breakpoint" << endl;

        }

        else if(dsu.find(arista.u) != dsu.find(arista.v)){
            dsu.unite(arista.u, arista.v);
            res += arista.peso;
            aristas++;
            arista.tipo = "any";
        }else{
            arista.tipo = "none";
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
        lista_aristas[i] = {nodo1, nodo2, peso_arista, ""};
    }
    kruskal(lista_aristas, n);
    return 0;
}
