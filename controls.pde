void keyPressed() {
  if(key == 'A') {
    solution = aStarSolve();
    solution.add(maze.exit.node);
  } else if(key == 'D') {
    solution = dijkstraSolve();
    solution.add(maze.exit.node);
  }
}
