void keyPressed() {
  if(key == ' ') {
    solution = aStarSolve(maze.entry.node,maze.exit.node);
    solution.add(maze.exit.node);
  }
}
