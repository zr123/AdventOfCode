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
    return (char)255;
  else
    return 0;
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

void markFields(char field[MAX_Y][MAX_X], int pos_x, int pos_y, int steps){
  if(steps > 50)return;
  if(!sanityCheck(pos_x, MAX_X))return;
  if(!sanityCheck(pos_y, MAX_Y))return;
  if(field[pos_y][pos_x] == (char)255)return;
  if(field[pos_y][pos_x] != 0 && steps > field[pos_y][pos_x])return;
  field[pos_y][pos_x] = steps;
  //move up
  markFields(field, pos_x, pos_y-1, steps+1);
  //move down
  markFields(field, pos_x, pos_y+1, steps+1);
  //move left
  markFields(field, pos_x-1, pos_y, steps+1);
  //move right
  markFields(field, pos_x+1, pos_y, steps+1);
}

int countFields(char field[MAX_Y][MAX_X]){
  int count = 0;
  for(int y = 0; y < MAX_Y; ++y)
    for(int x = 0; x < MAX_X; ++x)
      if(field[y][x] > 0 && field[y][x] < 255)
        count++;
  return count;
}

int main(){
  char field[MAX_Y][MAX_X];
  initField(field, INPUT);
  markFields(field, 1, 1, 0);
  printf("%d\n", countFields(field));
}


