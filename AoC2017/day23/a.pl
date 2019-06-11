use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

#registry
my %reg = ("COUNT" => 0);
my $mulCount = 0;

while($reg{"COUNT"} < @input){
	my $instruction = $input[$reg{"COUNT"}];
	if($instruction =~ /^snd (\w)$/){ 			$reg{"SOUND"} 	= 	$reg{$1}; 							$reg{"COUNT"}++;next;}
	if($instruction =~ /^set (\w) (-?\d+)$/){ 	$reg{$1} 		= 	$2;									$reg{"COUNT"}++;next;}
	if($instruction =~ /^set (\w) (\w)$/){ 		$reg{$1} 		= 	$reg{$2};							$reg{"COUNT"}++;next;}
	if($instruction =~ /^add (\w) (-?\d+)$/){	$reg{$1} 		+= 	$2;									$reg{"COUNT"}++;next;}
	if($instruction =~ /^add (\w) (\w)$/){ 		$reg{$1} 		+= 	$reg{$2};							$reg{"COUNT"}++;next;}
	if($instruction =~ /^sub (\w) (-?\d+)$/){	$reg{$1} 		-= 	$2;									$reg{"COUNT"}++;next;}
	if($instruction =~ /^sub (\w) (\w)$/){ 		$reg{$1} 		-= 	$reg{$2};							$reg{"COUNT"}++;next;}
	if($instruction =~ /^mul (\w) (-?\d+)$/){ 	$reg{$1} 		*= 	$2;					$mulCount++;	$reg{"COUNT"}++;next;}
	if($instruction =~ /^mul (\w) (\w)$/){ 		$reg{$1} 		*= 	$reg{$2};			$mulCount++;	$reg{"COUNT"}++;next;}
	if($instruction =~ /^mod (\w) (-?\d+)$/){ 	$reg{$1} 		%= 	$2;									$reg{"COUNT"}++;next;}
	if($instruction =~ /^mod (\w) (\w)$/){ 		$reg{$1} 		%= 	$reg{$2};							$reg{"COUNT"}++;next;}
	if($instruction =~ /^rcv (\w)$/){ 			($reg{$1} != 0)	?	last							:	$reg{"COUNT"}++;next;}	
	if($instruction =~ /^jgz (\w) (-?\d+)$/){ 	($reg{$1} != 0)	? 	$reg{"COUNT"} += $2 -1			:	$reg{"COUNT"}++;next;}
	if($instruction =~ /^jgz (\w) (\w)$/){ 		($reg{$1} != 0)	? 	$reg{"COUNT"} += $reg{$2} -1 	:	$reg{"COUNT"}++;next;}
}

print $mulCount;
