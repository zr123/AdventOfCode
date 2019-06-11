use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my @botBuffer;
my @instructionBuffer;
my @outputBuffer;
my @currentBots = ();
my @searchValues = (17, 61);

foreach my $line (@input){
  bufferInstructions($line);
}

#rekursiv machen?

while((my $currentBotNumber = shift(@currentBots)) ne ""){
  if(${$botBuffer[$currentBotNumber]}[0] ~~ @searchValues  && ${$botBuffer[$currentBotNumber]}[1] ~~ @searchValues){
    print $currentBotNumber, "\n";
    last;
  }
  my @next = weasel($currentBotNumber);
  foreach my $n (@next){
    if(scalar(@{$botBuffer[$n]}) > 1){
      push(@currentBots, $n);
    }
  }
}


sub bufferInstructions{
  my ($line) = @_;
  if($line =~ /^value (\d+) goes to bot (\d+)$/){
    push(@{$botBuffer[$2]}, $1);
    if(scalar(@{$botBuffer[$2]}) > 1){
      push(@currentBots, $2);
    }
  }
  if($line =~ /^bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)$/){
    @{$instructionBuffer[$1]} = ($2, $3, $4, $5);
  }
}

sub weasel{
  my ($lineNumber) = @_;
  my ($lower, $higher) = @{$botBuffer[$lineNumber]};
  @{$botBuffer[$lineNumber]} = ();
  if($lower > $higher){
    ($lower, $higher) = ($higher, $lower);
  }
  my @followupBots = ();
  
  if(${$instructionBuffer[$lineNumber]}[0] eq "bot"){
    push(@{$botBuffer[${$instructionBuffer[$lineNumber]}[1]]}, $lower);
    push(@followupBots, ${$instructionBuffer[$lineNumber]}[1]);
  }else{
    push(@{$outputBuffer[${$instructionBuffer[$lineNumber]}[1]]}, $lower);
  }
  
  if(${$instructionBuffer[$lineNumber]}[2] eq "bot"){
    push(@{$botBuffer[${$instructionBuffer[$lineNumber]}[3]]}, $higher);
    push(@followupBots, ${$instructionBuffer[$lineNumber]}[3]);
  }else{
    push(@{$outputBuffer[${$instructionBuffer[$lineNumber]}[3]]}, $higher);
  }
  return @followupBots;
}