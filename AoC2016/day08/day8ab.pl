use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my @display;
my ($HEIGHT, $WIDTH) = (6, 50);
rect($HEIGHT, $WIDTH, ".");
foreach my $line (@input){
  parseLine($line);
}

my $count;
for(my $y = 0; $y < $HEIGHT; ++$y){
  for(my $x = 0; $x < $WIDTH; ++$x){
    if($display[$y][$x] eq "#"){
      ++$count;
    }
  }
}

print "$count\n"; 
printField();

sub rect{
  my ($pos_y, $pos_x, $char) = @_;
  for(my $y = 0; $y < $pos_y; ++$y){
    for(my $x = 0; $x < $pos_x; ++$x){
      $display[$y][$x] = $char;
    }
  }
}

sub rotateRow{
  my ($row_y, $offset) = @_;
  my @originalrow = @{$display[$row_y]};
  for(my $oldpos = 0; $oldpos < $WIDTH; ++$oldpos){
    my $newpos = ($oldpos+$offset) % $WIDTH;
    $display[$row_y][$newpos] = $originalrow[$oldpos];
  }
}

sub rotateCol{
  my ($row_x, $offset) = @_;
  my @colBuffer;
  for(my $oldpos_y = 0; $oldpos_y < $HEIGHT; ++$oldpos_y){
    my $newpos_y = ($oldpos_y + $offset) % $HEIGHT;
    $colBuffer[$newpos_y] = $display[$oldpos_y][$row_x];
  }
  for(my $y = 0; $y < $HEIGHT; ++$y){
    $display[$y][$row_x] = $colBuffer[$y];
  }
}

sub parseLine{
  my ($line) = @_;
  if($line =~ /^rect (\d+)x(\d+)$/){
    rect($2, $1, "#");
    return;
  }
  if($line =~ /^rotate row y=(\d+) by (\d+)$/){
    rotateRow($1, $2);
    return;
  }
  if($line =~ /^rotate column x=(\d+) by (\d+)$/){
    rotateCol($1, $2);
    return;
  }
  die("unbehandelte Zeile $line");
}

sub printField{
  foreach my $line (@display){
    print @$line, "\n";
  }
}