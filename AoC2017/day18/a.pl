use strict;
#use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

my %reg = ("COUNT" => -1); #registry

while(1){
	my $instruction = $input[++$reg{"COUNT"}];
	if($instruction =~ /^snd (\w)$/){ 			$reg{"SOUND"} 	= 	$reg{$1}; 							next;}
	if($instruction =~ /^set (\w) (-?\d+)$/){ 	$reg{$1} 		= 	$2;									next;}
	if($instruction =~ /^set (\w) (\w)$/){ 		$reg{$1} 		= 	$reg{$2};							next;}
	if($instruction =~ /^add (\w) (-?\d+)$/){	$reg{$1} 		+= 	$2;									next;}
	if($instruction =~ /^add (\w) (\w)$/){ 		$reg{$1} 		+= 	$reg{$2};							next;}
	if($instruction =~ /^mul (\w) (-?\d+)$/){ 	$reg{$1} 		*= 	$2;									next;}
	if($instruction =~ /^mul (\w) (\w)$/){ 		$reg{$1} 		*= 	$reg{$2};							next;}
	if($instruction =~ /^mod (\w) (-?\d+)$/){ 	$reg{$1} 		%= 	$2;									next;}
	if($instruction =~ /^mod (\w) (\w)$/){ 		$reg{$1} 		%= 	$reg{$2};							next;}
	if($instruction =~ /^rcv (\w)$/){ 			($reg{$1} != 0)	?	last							:	next;}	
	if($instruction =~ /^jgz (\w) (-?\d+)$/){ 	($reg{$1} != 0)	? 	$reg{"COUNT"} += $2 -1			:	next;}
	if($instruction =~ /^jgz (\w) (\w)$/){ 		($reg{$1} != 0)	? 	$reg{"COUNT"} += $reg{$2} -1 	:	next;}
}

print $reg{"SOUND"};

=pod
sub parseInstruction {
	my ($instruction, $varsRef) = @_;
	if($instruction =~ /^snd (\w)$/){ 			return asmSNDreg($1, 		$varsRef);}
	if($instruction =~ /^set (\w) (-?\d+)$/){ 	return asmSETval($1, $2, 	$varsRef);}
	if($instruction =~ /^set (\w) (\w)$/){ 		return asmSETreg($1, $2, 	$varsRef);}
	if($instruction =~ /^add (\w) (-?\d+)$/){	return asmADDval($1, $2, 	$varsRef);}
	if($instruction =~ /^add (\w) (\w)$/){ 		return asmADDreg($1, $2, 	$varsRef);}
	if($instruction =~ /^mul (\w) (-?\d+)$/){ 	return asmMULval($1, $2, 	$varsRef);}
	if($instruction =~ /^mul (\w) (\w)$/){ 		return asmMULreg($1, $2,	$varsRef);}
	if($instruction =~ /^mod (\w) (-?\d+)$/){ 	return asmMODval($1, $2, 	$varsRef);}
	if($instruction =~ /^mod (\w) (\w)$/){ 		return asmMODreg($1, $2, 	$varsRef);}
	if($instruction =~ /^rcv (\w)$/){ 			return asmRCVreg($1, 		$varsRef);}
	if($instruction =~ /^jgz (\w) (-?\d+)$/){ 	return asmJGZval($1, $2, 	$varsRef);}
	if($instruction =~ /^jgz (\w) (\w)$/){ 		return asmJGZreg($1, $2, 	$varsRef);}
	$varsRef->{"COUNT"}++;
}

    snd X plays a sound with a frequency equal to the value of X.
    set X Y sets register X to the value of Y.
    add X Y increases register X by the value of Y.
    mul X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
    mod X Y sets register X to the remainder of dividing the value contained in register X by the value of Y (that is, it sets X to the result of X modulo Y).
    rcv X recovers the frequency of the last sound played, but only when the value of X is not zero. (If it is zero, the command does nothing.)
    jgz X Y jumps with an offset of the value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)
