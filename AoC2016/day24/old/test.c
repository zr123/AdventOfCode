#include <stdio.h>

#define MAX_X 11
#define MAX_Y 4
#define NODES 5

typedef struct node{
  short x;
  short y;
  short value;
  short paths[NODES];
}node;

void printField(short field[MAX_Y][MAX_X]){
  for(int y = 0; y < MAX_Y; ++y){
    for(int x = 0; x < MAX_X; ++x){
      if(field[y][x] < 0)printf("#");
      if(field[y][x] == 0)printf(".");
      if(field[y][x] > 0)printf("O");
    }
    printf("\n");
  }
}

void calcPaths(short field[MAX_Y][MAX_X], int pos_x, int pos_y, int steps){
  if(field[pos_y][pos_x] != 0 && steps >= field[pos_y][pos_x])return;
  field[pos_y][pos_x] = steps;
  //move up
  calcPaths(field, pos_x, pos_y-1, steps+1);
  //move down
  calcPaths(field, pos_x, pos_y+1, steps+1);
  //move left
  calcPaths(field, pos_x-1, pos_y, steps+1);
  //move right
  calcPaths(field, pos_x+1, pos_y, steps+1);
}

void readInput(short field[MAX_Y][MAX_X], node poi[NODES], const char* filename){
  FILE* handle = fopen(filename, "r");
  char buffer[MAX_X+2];
  int nodeCount = 0;
  for(int y = 0; y < MAX_Y; ++y){
    fgets(buffer, MAX_X+2, handle);
    for(int i = 0; buffer[i] != 0; ++i){
      if(buffer[i] == '#'){field[y][i] = -1;}
      else{field[y][i] = 0;}
      if(buffer[i] != '#' && buffer[i] != '.' && buffer[i] != '\n'){
        poi[nodeCount].x = i;
        poi[nodeCount].y = y;
        nodeCount++;
      }
    }
  }
  fclose(handle);
}

void resetField(short field[MAX_Y][MAX_X]){
  for(int y = 0; y < MAX_Y; ++y)
    for(int x = 0; x < MAX_X; ++x)
      if(field[y][x] > 0)
        field[y][x] = 0;
}

int tryPaths(node poi[NODES], int currentNode, int* remainingNodes, int count, int pathLength){
  if(count == 0){
    return pathLength;
  }
  int nextRemainingNodes[count-1];
  for(int i = 0; i < (count-1); ++i)
    if(i >= currentNode)
      nextRemainingNodes[i] = remainingNodes[i+1];
    else
      nextRemainingNodes[i] = remainingNodes[i];
  int shortestPath = pathLength;
  for(int i = 0; i < (count-1); ++i){
    int tmpPathLength = tryPaths(poi, nextRemainingNodes[i], nextRemainingNodes, count-1, pathLength + poi[currentNode].paths[nextRemainingNodes[i]]);
    if(shortestPath == pathLength || tmpPathLength < shortestPath)
      shortestPath = tmpPathLength;
  }
  //printf("%d\n", shortestPath);
  return shortestPath;
}

int main(){
  short field[MAX_Y][MAX_X];
  node poi[NODES]; // "points of interest"
  readInput(field, poi, "test.txt");
  for(int i = 0; i < NODES; ++i){
    calcPaths(field, poi[i].x, poi[i].y, 0);
    for(int c = 0; c < NODES; ++c){
      if(field[poi[c].y][poi[c].x] != 2)
        poi[i].paths[c] = field[poi[c].y][poi[c].x];
      else
        poi[i].paths[c] = 0;
    }
    resetField(field);
  }
  
  int nodes[NODES];
  for(int i = 0; i < NODES; ++i)nodes[i] = i;
  printf("%d\n", tryPaths(poi, 3, nodes, 8, 0));
  // 363 too low
  //printField(field);
}


