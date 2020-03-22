class Node implements Comparable {
  Cell cell;
  color col = #00FF00;
  ArrayList<Node> shortestPath = new ArrayList<Node>();

  Integer distance = Integer.MAX_VALUE;
  Integer predictedDistance = Integer.MAX_VALUE;
  
  HashMap<Node, Integer> adjacentNodes = new HashMap<Node, Integer>();
  float centerX, centerY;
  
  Node(Cell cell) {
    this.cell = cell;
    this.centerX = cell.centerX;
    this.centerY = cell.centerY;
    cell.node = this;
  }
  
  void initAdjacentNodes() {
    Integer cost;
    Cell other;
    
    // north
    if(cell.nwse[0] != null) {
      other = cell;
      cost = 1;
      while(other.nwse[0] != null){
        other = other.nwse[0];
        cost++;
        if(other.node != null) break;
      }
      if(other != cell)
      adjacentNodes.put(other.node, cost);
    }
    
    // west
   if(cell.nwse[1] != null) {
      other = cell;
      cost = 1;
      while(other.nwse[1] != null) {
        other = other.nwse[1];
        cost++;
        if(other.node != null) break;
      }
      if(other != cell) 
      adjacentNodes.put(other.node, cost);
    }
    
    // south
    if(cell.nwse[2] != null) {
      other = cell;
      cost = 1;
      while(other.nwse[2] != null) {
        other = other.nwse[2];
        cost++;
        if(other.node != null) break;
      }
      if(other != cell) adjacentNodes.put(other.node, cost);
    }
    
    // east
    if(cell.nwse[3] != null) {
      other = cell;
      cost = 1;
      while(other.nwse[3] != null) {
        other = other.nwse[3];
        cost++;
        if(other.node != null) break;
      }
      if(other != cell)
      adjacentNodes.put(other.node, cost);
    }
  }
  
  public int compareTo(Object other) { 
    Node otherNode = null;
    if(other.getClass() == this.getClass()) otherNode = (Node) other; 
    if(this.predictedDistance < otherNode.predictedDistance) return 1;
    else if ( this.predictedDistance == otherNode.predictedDistance ) return 0;    
    return -1;
  }
  
  void show() {
    fill(col);
    if(maze.exit.node.shortestPath.contains(this) || maze.exit.node == this) fill(#0000FF); 
    strokeWeight(0);
    circle(this.centerX,this.centerY, cellsize/2-1);
    for(HashMap.Entry<Node, Integer> entry : adjacentNodes.entrySet()) {
      if(solution.contains(entry.getKey()) && solution.contains(this)) {
        strokeWeight(5);
        stroke(#00FFFF);
        line(this.centerX,this.centerY,entry.getKey().centerX,entry.getKey().centerY);
      }
    }
  }
}
