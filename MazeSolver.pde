Maze maze;
Graph graph;
ArrayList<Node> alNodes = new ArrayList<Node>();
float cellsize;
ArrayList<Node> solution = new ArrayList<Node>();

void setup() {
 maze = new Maze("normal.png");
 println("***** MAZE   LOADED *****");
 graph = new Graph(maze);
 println("***** GRAPH  LOADED *****");
 size(1000, 1000, P2D);
}

void draw() {
 background(0);
 maze.show();
 for(Node n : alNodes) {
   n.show();
 }
} 
 // Dijkstra Shit 
 ArrayList<Node> getShortestPathToEnd() {
   Node source = maze.entry.node;
   Node current;
   Node next;
   Integer cost;
   source.distance = 0;
   
   ArrayList<Node> settled = new ArrayList<Node>();
   ArrayList<Node> unsettled = new ArrayList<Node>();
   
   unsettled.add(source);
   while(!unsettled.isEmpty()) {
     current = getLowestDistanceNode(unsettled);
     unsettled.remove(current);
     for(HashMap.Entry<Node, Integer> entry : current.adjacentNodes.entrySet()) {
       next = entry.getKey();
       cost = entry.getValue();
       if(!settled.contains(next)) {
         calculateMinimumDistance(next, cost, current);
         unsettled.add(next);
       } 
     }
     settled.add(current);
   } 
   
   return maze.exit.node.shortestPath;
 }

Node getLowestDistanceNode(ArrayList<Node> unsettled) {
  Node nearestNode = null;
  Integer lowestDistance = Integer.MAX_VALUE;
  int distance;
  for(Node n : unsettled) {
    distance = n.distance;
    if(distance < lowestDistance) {
      lowestDistance = distance;
      nearestNode = n;
    }
  }
  return nearestNode;
}

void calculateMinimumDistance(Node eval, Integer cost, Node source) {
  Integer sourceDistance = source.distance;
  if (sourceDistance + cost < eval.distance) {
    eval.distance = sourceDistance + cost;
    ArrayList<Node> shortestPath = new ArrayList<Node>(source.shortestPath);
    shortestPath.add(source);
    eval.shortestPath = shortestPath;
  }
}
