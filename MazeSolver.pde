import java.util.PriorityQueue;
import java.util.Queue;

Maze maze;
ArrayList<Node> alNodes = new ArrayList<Node>();
float cellsize;
ArrayList<Node> solution = new ArrayList<Node>();

void setup() {
 maze = new Maze("normal.png");
 println("***** MAZE   LOADED *****");
 for(Cell c : maze.alCell)
  if(c.neighbours!=5&&c.neighbours!=10) alNodes.add(new Node(c));
     
 for(Node n : alNodes) n.initAdjacentNodes();
 println("***** NODES  LOADED *****");
 size(1000, 1000, P2D);
}

void draw() {
 background(0);
 maze.show();
 for(Node n : alNodes) {
   n.show();
 }
} 


 // Dijkstra
 ArrayList<Node> dijkstraSolve() {
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
       if(settled.contains(maze.exit.node)) return maze.exit.node.shortestPath;
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

// A* baby
ArrayList<Node> reconstructPath(Node current, HashMap<Node,Node> cameFrom) {
  ArrayList<Node> path = new ArrayList<Node>();
  path.add(current);
  while(cameFrom.containsKey(current)) {
    current = cameFrom.get(current);
    path.add(current);
  }
  return path;
}

ArrayList<Node> aStarSolve() {
    Node start = maze.entry.node;
    Node end = maze.exit.node;
    HashMap<Node,Node> cameFrom = new HashMap<Node,Node>();
    PriorityQueue<Node> openList = new PriorityQueue<Node>();
    openList.add(start);
    start.distance = 0;
    start.predictedDistance = estimateDistance(start);
    
    while(!openList.isEmpty()) {
     Node current = openList.poll();
     if(current == end) return reconstructPath(current, cameFrom);
     openList.remove(current);
     for(HashMap.Entry<Node,Integer> entry : current.adjacentNodes.entrySet()) {
       int tentative = current.distance;
       Node neighbour = entry.getKey();
       if(tentative < neighbour.distance) {
         if(cameFrom.containsKey(neighbour)) cameFrom.remove(neighbour);
         cameFrom.put(neighbour,current);
         neighbour.distance = tentative;
         neighbour.predictedDistance = current.distance + estimateDistance(neighbour); 
         if(!openList.contains(neighbour)) openList.add(neighbour);
       }
     }
   }
   return  new ArrayList<Node>();
}

int estimateDistance(Node n1) {
  return round(sqrt(abs(n1.cell.x+maze.exit.x)^2+abs(n1.cell.y+maze.exit.y)^2));
}
