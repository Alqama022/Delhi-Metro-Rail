#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>
#include <climits>

using namespace std;

// Structure to represent a node (metro station)
struct Node {
    string name;
    vector<pair<int, int>> edges; // Pair of (neighboring node index, distance)
};

// Graph class to represent the metro map
class Graph {
public:
    Graph(int numStations);
    void addStation(int index, string name);
    void addEdge(int src, int dest, int distance);
    pair<vector<int>, int> dijkstra(int src, int dest);
    void printShortestPath(int src, int dest);

private:
    vector<Node> stations;
};

Graph::Graph(int numStations) {
    stations.resize(numStations);
}

void Graph::addStation(int index, string name) {
    stations[index].name = name;
}

void Graph::addEdge(int src, int dest, int distance) {
    stations[src].edges.push_back({dest, distance});
    stations[dest].edges.push_back({src, distance}); // Assuming undirected graph
}

pair<vector<int>, int> Graph::dijkstra(int src, int dest) {
    vector<int> dist(stations.size(), INT_MAX);
    vector<int> prev(stations.size(), -1);
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

    dist[src] = 0;
    pq.push({0, src});

    while (!pq.empty()) {
        int u = pq.top().second;
        pq.pop();

        if (u == dest) break;

        for (auto edge : stations[u].edges) {
            int v = edge.first;
            int weight = edge.second;

            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                prev[v] = u;
                pq.push({dist[v], v});
            }
        }
    }

    return {prev, dist[dest]};
}

void Graph::printShortestPath(int src, int dest) {
    auto result = dijkstra(src, dest);
    vector<int> prev = result.first;
    int distance = result.second;

    if (distance == INT_MAX) {
        cout << "No path found between " << stations[src].name << " and " << stations[dest].name << endl;
        return;
    }

    vector<int> path;
    for (int at = dest; at != -1; at = prev[at]) {
        path.push_back(at);
    }
    reverse(path.begin(), path.end());

    cout << "Shortest path from " << stations[src].name << " to " << stations[dest].name << ":\n";
    for (int i = 0; i < path.size(); ++i) {
        cout << stations[path[i]].name;
        if (i != path.size() - 1) cout << " -> ";
    }
    cout << "\nTotal distance: " << distance << endl;
}

int main() {
    // Create a graph with the number of stations
    Graph metroMap(5);

    // Add stations
    metroMap.addStation(0, "Station A");
    metroMap.addStation(1, "Station B");
    metroMap.addStation(2, "Station C");
    metroMap.addStation(3, "Station D");
    metroMap.addStation(4, "Station E");

    // Add edges (distances between stations)
    metroMap.addEdge(0, 1, 5);
    metroMap.addEdge(0, 2, 10);
    metroMap.addEdge(1, 2, 3);
    metroMap.addEdge(1, 3, 20);
    metroMap.addEdge(2, 3, 2);
    metroMap.addEdge(3, 4, 1);

    // Print shortest path from Station A to Station E
    metroMap.printShortestPath(0, 4);

    return 0;
}
