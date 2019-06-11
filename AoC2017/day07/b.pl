use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my %programs; # programName -> weigth
my @remainingTowers;

for my $line (@input){
	if($line =~ /->/){
		push(@remainingTowers, $line);
	}else{
		$line =~ /^(\b.+\b) \((\d+)\)$/;
		$programs{$1} = $2;
	}
}

my $balanced = 1;
while($balanced){
	my @tmpRemainingTowers = ();
	for my $tower (@remainingTowers){
		$tower =~ /^(\b[a-z]+\b) \((\d+)\) ->(.*)$/;
		my $programName = $1;
		my $programWeight = $2;
		my $subProgramsString = $3;
		my @subPrograms = getSubPrograms($subProgramsString);
		my @subProgramWeights;
		my $skip = 0;
		for my $sub (@subPrograms){
			if(exists($programs{$sub})){
				push(@subProgramWeights, $programs{$sub});
			}else{
				$skip = 1;
			}
		}
		if($skip){
			push(@tmpRemainingTowers, $tower);
			next;
		}
		# -> alle SupProgrammgewichte sind evaluiert und können auf gleichheit getestet werden;
		if(!allEqual(@subProgramWeights)){
			$balanced = 0;
			#print "unbalance at: $programName \n";
			#for(my $i = 0; $i < @subPrograms; $i++){
			#	print "$subPrograms[$i] wiegt: $subProgramWeights[$i]\n";
			#}
			my $oddElementIndex = findOddElement(@subProgramWeights);
			#print "odd element Nr: " . $oddElementIndex . "\n";
			my $offbalance;
			if($oddElementIndex > 0){
				$offbalance = abs($subProgramWeights[$oddElementIndex] - $subProgramWeights[0]);
			}else{
				$offbalance = abs($subProgramWeights[1] - $subProgramWeights[0]);
			}
			#print "offbalance: $offbalance \n";
			print "original weight of $subPrograms[$oddElementIndex] - $offbalance";
			last;
		}
		$programs{$programName} = $programWeight + (scalar(@subProgramWeights) * $subProgramWeights[0]);
	}
	@remainingTowers = @tmpRemainingTowers;
}


sub getSubPrograms{
	my ($subProgramList) = @_;
	my @subPrograms;
	while($subProgramList =~ /(\b[a-z]+\b)/g){
		push(@subPrograms, $1);
	}
	return @subPrograms;
}

sub allEqual{
	my (@integers) = @_;
	if(@integers == 1){return 1;}
	for(my $i = 1; $i < @integers; $i++){
		if($integers[$i-1] != $integers[$i]){
			return 0;
		}
	}
	return 1;
}

sub findOddElement{
	my (@elements) = @_;
	if($elements[0] != $elements[1] && $elements[0] != $elements[2]){
		return 0;
	}
	for(my $i = 1; $i < @elements-1; $i++){
		if($elements[$i] != $elements[0] && $elements[$i] != $elements[$i+1]){
			return $i;
		}
	}
	return scalar(@elements)-1;
}
