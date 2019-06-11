#include <stdio.h>

#define INPUT 1358
#define MAX_X 50
#define MAX_Y 50

int countBits(int number){
  int count = 0;
  for(int i = 0; i < 31; ++i){
    if(number & 1)count++;
    number >>= 1;
  }
  return count;
}

char quiteLogicalFunction(int x, int y, int number){
  if(countBits(x*x + 3*x + 2*x*y + y + y*y + number) % 2)
    return '#';
  else
    return '.';
}

void initField(char field[MAX_Y][MAX_X], int input){
  for(int y = 0; y < MAX_Y; ++y)
    for(int x = 0; x < MAX_Y; ++x)
      field[y][x] = quiteLogicalFunction(x, y, INPUT);
}

void printField(char field[MAX_Y][MAX_X]){
  for(int y = 0; y < MAX_Y; ++y){
    for(int x = 0; x < MAX_Y; ++x)
      printf("%c", field[y][x]);
    printf("\n");
  }
}

int sanityCheck(int val, int maximum){
  if(val < 0 || val >= maximum)return 0;
  return 1;
}

int solve(char field[MAX_Y][MAX_X], int pos_x, int pos_y){
  if(pos_x == 31 && pos_y == 39)
    return 1;
  if(!sanityCheck(pos_x, MAX_X))return 0;
  if(!sanityCheck(pos_y, MAX_Y))return 0;
  if(field[pos_y][pos_x] != '.')return 0;
  
  field[pos_y][pos_x] = 'O';
  int pathCount = 0;
  int tmp = 0;
  //move up
  tmp = solve(field, pos_x, pos_y-1);
  if(tmp != 0 && (tmp < pathCount || pathCount == 0))
    pathCount = tmp;
  //move down
  tmp = solve(field, pos_x, pos_y+1);
  if(tmp != 0 && (tmp < pathCount || pathCount == 0))
    pathCount = tmp;
  //move left
  tmp = solve(field, pos_x-1, pos_y);
  if(tmp != 0 && (tmp < pathCount || pathCount == 0))
    pathCount = tmp;
  //move right
  tmp = solve(field, pos_x+1, pos_y);
  if(tmp != 0 && (tmp < pathCount || pathCount == 0))
    pathCount = tmp;
  
  //return
  field[pos_y][pos_x] = '.';
  if(pathCount)
    return pathCount+1;
  else
    return 0;
}
 
int main(){
  char field[MAX_Y][MAX_X];
  initField(field, INPUT);
  //printf("%d\n", solve(field, 1, 1) -1);
  printField(field);
}


