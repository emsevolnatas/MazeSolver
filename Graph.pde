class Graph {
    Maze maze;
    Graph(Maze maze) {
      this.maze = maze;
      for(Cell c : maze.alCell)
        if(c.neighbours!=5&&c.neighbours!=10) alNodes.add(new Node(c));
     
      for(Node n : alNodes) n.initAdjacentNodes();
    }
}
