# Delhi-Metro-Rail
DELHI METRO RAIL APP
Please don't get confused, this is NOT an ANDROID Application!

This is a simple C++ program that takes the source and destination station names of the Delhi Metro from the user and displays the fare and shortest metro route to reach the destination. It also includes a metro map for better commuter navigation.

The idea is implemented using Graph and Heap data structures. The graph has nodes and edges. Nodes represent metro stations and contain information such as the station name, metro corridor, and connecting lines. Edges represent the distance between two stations, and the cost of each edge is equal to the distance between the two connected stations.

By using algorithms like Dijkstra, breadth-first search, and depth-first search, the shortest path between the source and destination stations is determined. The fare is then calculated based on the total distance between the two stations. Finally, the metro route and total fare are displayed.

main.cpp contains the major code, and heap.cpp contains the heap implementation.
