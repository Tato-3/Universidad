#include <iostream>
#include <vector>
#include <tuple>
#include <algorithm>
#include <map>
#include <unordered_set>
#include <climits> // Para INT_MAX

using namespace std;

class Disjointset {
public:
    vector<int> rank;
    vector<int> parent;
    vector<int> size;
    Disjointset(int n) {
        rank.resize(n, 0);
        size.resize(n, 1);
        parent.resize(n);
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    int findparent(int u) {
        if (u == parent[u]) {
            return u;
        }
        return parent[u] = findparent(parent[u]);
    }
    void unionbyrank(int u, int v) {
        int ulp_u = findparent(u);
        int ulp_v = findparent(v);

        if (ulp_u == ulp_v) {
            return;
        }
        if (rank[ulp_u] < rank[ulp_v]) {
            parent[ulp_u] = ulp_v;
        } else if (rank[ulp_u] > rank[ulp_v]) {
            parent[ulp_v] = ulp_u;
        } else if (rank[ulp_u] == rank[ulp_v]) {
            parent[ulp_u] = ulp_v;
            rank[ulp_v]++;
        }
    }
    void unionbysize(int u, int v) {
        int ulp_u = findparent(u);
        int ulp_v = findparent(v);

        if (ulp_u == ulp_v) {
            return;
        }
        if (size[ulp_u] < size[ulp_v]) {
            parent[ulp_u] = ulp_v;
            size[ulp_v] += size[ulp_u];
        } else if (size[ulp_u] > size[ulp_v]) {
            parent[ulp_v] = ulp_u;
            size[ulp_u] += size[ulp_v];
        } else if (size[ulp_u] == size[ulp_v]) {
            parent[ulp_u] = ulp_v;
            size[ulp_v] += size[ulp_u];
        }
    }
};


int pseudo_criticaledges(vector<vector<int>> aristas_agregadas, int indice, int n) {
        Disjointset ds2(n);
        int pesoMST = 0;

        int wt = aristas_agregadas[indice][0];
        int idx = aristas_agregadas[indice][1];
        int u = aristas_agregadas[indice][2];
        int v = aristas_agregadas[indice][3];

        if (ds2.findparent(u) != ds2.findparent(v)) {
            pesoMST += wt;
            ds2.unionbyrank(u, v);
        }

        for (int i = 0; i < aristas_agregadas.size(); i++) {

            int wt = aristas_agregadas[i][0];
            int idx = aristas_agregadas[i][1];
            int u = aristas_agregadas[i][2];
            int v = aristas_agregadas[i][3];

            if (ds2.findparent(u) != ds2.findparent(v)) {
                pesoMST += wt;
                ds2.unionbyrank(u, v);
            }
        }
        for(int i=0; i<n; i++){
            if(ds2.findparent(i)!=ds2.findparent(0)){
                return INT_MAX;
            }
        }
        return pesoMST;
    }

int criticaledges(vector<vector<int>> aristas_agregadas, int indice, int n) {
        Disjointset ds1(n);
        int pesoMST = 0;
        
        for (int i = 0; i < aristas_agregadas.size(); i++) {
            if (i == indice) {
                continue;
            }

            int wt = aristas_agregadas[i][0];
            int idx = aristas_agregadas[i][1];
            int u = aristas_agregadas[i][2];
            int v = aristas_agregadas[i][3];

            if (ds1.findparent(u) != ds1.findparent(v)) {
                pesoMST += wt;
                ds1.unionbyrank(u, v);
            }
        }
        for(int i=0; i<n; i++){
            if(ds1.findparent(i)!=ds1.findparent(0)){
                return INT_MAX;
            }
        }
        return pesoMST;
    }

vector<vector<int>>findCriticalAndPseudoCriticalEdges(int n, vector<vector<int>>& aristas) {
        vector<vector<int>> ans;
        vector<int> critical;
        vector<int> pseudo_critical;

        vector<vector<int>> aristas_agregadas;

        for (int i = 0; i < aristas.size(); i++) {
            vector<int> temp;
            int u = aristas[i][0];
            int v = aristas[i][1];
            int wt = aristas[i][2];
            int idx = i;

            temp = {wt, i, u, v};

            aristas_agregadas.push_back(temp);
        }
        
        int pesoMST = 0;
        sort(aristas_agregadas.begin(), aristas_agregadas.end());
        Disjointset ds(n);
        for (auto it : aristas_agregadas) {
            int wt = it[0];
            int idx = it[1];
            int u = it[2];
            int v = it[3];

            if (ds.findparent(u) != ds.findparent(v)) {
                pesoMST += wt;
                ds.unionbysize(u, v);
            }
        }
        for (int i = 0; i < aristas_agregadas.size(); i++) {
            int wt = criticaledges(aristas_agregadas, i, n);
            int wt1 = pseudo_criticaledges(aristas_agregadas, i, n);

            if (wt > pesoMST) {
                critical.push_back(aristas_agregadas[i][1]);
            } else if (wt1 == pesoMST) {
                pseudo_critical.push_back(aristas_agregadas[i][1]);
            }
        }
        ans.push_back(critical);
        ans.push_back(pseudo_critical);
        return ans;
}


int main(){
    int n, m;
    cin >> n >> m;
    vector<vector<int>> aristas(m);
    for(int i = 0; i < m; i++){
        int u, v, w;
        cin >> u >> v >> w;
        aristas[i] = {u-1, v-1, w};
    }

    vector<vector<int>> result = findCriticalAndPseudoCriticalEdges(n, aristas);

    vector<string>respuestas(m, "none");

    for (int edge : result[0]) {
        respuestas[edge] = "any";
    }

    for (int edge : result[1]) {
        respuestas[edge] = "at least one";
    }

    for(auto res : respuestas){
        cout << res << endl;
    }
    return 0;
}