#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;
vector<bool> used;  // Para saber si un número ya fue usado
vector<vector<int>> memo_black;
vector<vector<int>> memo_white;

// Función para encontrar la subsecuencia negra más larga (creciente)
int black(vector<int>& arr, int i, vector<int>& usados) {
    if (i >= arr.size()) return usados.size();

    if (memo_black[i][usados.size()] != -1) return memo_black[i][usados.size()];

    int noAgrego = black(arr, i + 1, usados);

    if (usados.empty() || arr[i] > usados.back()) {
        used[i] = true;  // Marcar el número como usado
        usados.push_back(arr[i]);
        int agrego = black(arr, i + 1, usados);
        usados.pop_back();
        used[i] = false;  // Desmarcar después de usar
        return memo_black[i][usados.size()] = max(noAgrego, agrego);
    }

    return memo_black[i][usados.size()] = noAgrego;
}

// Función para encontrar la subsecuencia blanca más larga (decreciente) usando los números no usados por black
int white(vector<int>& arr, int i, vector<int>& usados) {
    if (i >= arr.size()) return usados.size();

    if (memo_white[i][usados.size()] != -1) return memo_white[i][usados.size()];

    int noAgrego = white(arr, i + 1, usados);

    if (!used[i] && (usados.empty() || arr[i] < usados.back())) {
        used[i] = true;  // Marcar el número como usado
        usados.push_back(arr[i]);
        int agrego = white(arr, i + 1, usados);
        usados.pop_back();
        used[i] = false;  // Desmarcar después de usar
        return memo_white[i][usados.size()] = max(noAgrego, agrego);
    }

    return memo_white[i][usados.size()] = noAgrego;
}

int main() {
    vector<int> res;
    while (true) {
        int n;
        cin >> n;
        if (n == -1) break;
        vector<int> arr(n);

        for (int i = 0; i < n; i++) {
            cin >> arr[i];
        }

        used = vector<bool>(n, false);
        vector<int> usados;
        memo_black = vector<vector<int>>(n, vector<int>(n + 1, -1));
        memo_white = vector<vector<int>>(n, vector<int>(n + 1, -1));
        
        // Calcular subsecuencia negra
        int asc = black(arr, 0, usados);
        usados.clear();  // Limpiar la lista de usados para la siguiente operación
        
        // Calcular subsecuencia blanca utilizando los elementos no utilizados en black
        int des = white(arr, 0, usados);
        
        // Calcular el máximo número de elementos pintados
        int maxLength = asc + des;
        res.push_back(n - maxLength);  // Calcular elementos no pintados
    }

    for (int i = 0; i < res.size(); i++) {
        cout << res[i] << endl;
    }

    return 0;
}
