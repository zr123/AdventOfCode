use strict;
use warnings;

open my $HANDLE, "<", "input.txt";
my @input = <$HANDLE>;
close $HANDLE;

#registry
my %registry1 = ("COUNT" => 0, "p" => 0, "QUEUE" => []);
my %registry2 = ("COUNT" => 0, "p" => 1, "QUEUE" => []);

my $sendCount = 0;
while($registry1{COUNT} < @input && $registry2{COUNT} < @input){
	my $snd1 = applyInstruction($input[$registry1{COUNT}], \%registry1);
	my $snd2 = applyInstruction($input[$registry2{COUNT}], \%registry2);
	
	if($snd1 eq "-1" && $snd2 eq "-1"){last;}
	
	if($snd1 =~ /^send:(-?\d+)$/){
		$sendCount++;
		push(@{$registry2{"QUEUE"}}, $1);
	}
	if($snd2 =~ /^send:(-?\d+)$/){
		push(@{$registry1{"QUEUE"}}, $1);
	}

	#printReg(\%registry1);
	#print "\n";
	#printReg(\%registry2);
	#print "\n\n";
	#print $registry1{"COUNT"} . "/" . $registry2{"COUNT"} . "\n"; 
}
	
print $sendCount;



sub applyInstruction {
	my ($inst, $reg) = @_;
	if($inst =~ /^snd (-?\d+)$/){ 																						$$reg{"COUNT"}++;		return "send:" . $1;}
	if($inst =~ /^snd ([^\W\d])$/){ 																					$$reg{"COUNT"}++;		return "send:" . $$reg{$1};}
	if($inst =~ /^set ([^\W\d]) (-?\d+)$/){ 		$$reg{$1} 				= 	$2;										$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^set ([^\W\d]) ([^\W\d])$/){ 		$$reg{$1} 				= 	$$reg{$2};								$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^add ([^\W\d]) (-?\d+)$/){			$$reg{$1} 				+= 	$2;										$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^add ([^\W\d]) ([^\W\d])$/){ 		$$reg{$1} 				+= 	$$reg{$2};								$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^mul ([^\W\d]) (-?\d+)$/){ 		$$reg{$1} 				*= 	$2;										$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^mul ([^\W\d]) ([^\W\d])$/){ 		$$reg{$1} 				*= 	$$reg{$2};								$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^mod ([^\W\d]) (-?\d+)$/){ 		$$reg{$1} 				%= 	$2;										$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^mod ([^\W\d]) ([^\W\d])$/){ 		$$reg{$1} 				%= 	$$reg{$2};								$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^jgz (-?\d+) (-?\d+)$/){			($1 != 0)				? 	$$reg{"COUNT"} += $2				:	$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^jgz ([^\W\d]) (-?\d+)$/){			($$reg{$1} != 0)		? 	$$reg{"COUNT"} += $2				:	$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^jgz ([^\W\d]) ([^\W\d])$/){ 		($$reg{$1} != 0)		? 	$$reg{"COUNT"} += $$reg{$2} 		:	$$reg{"COUNT"}++;		return	0;}
	if($inst =~ /^rcv ([^\W\d])$/){ 
		if(@{$$reg{"QUEUE"}} > 0){
			$$reg{$1} = shift(@{$$reg{"QUEUE"}});
			$$reg{"COUNT"}++;
			return 0;
		}else{
			return -1;
		}
	}
	die("unhandled input instruction" . $inst . "\n");
}

sub printReg {
	my ($reg) = @_;
	while(my ($key, $val) = each %$reg){
		if($key eq "QUEUE"){
			print "QUEUE: ";
			print "$_ " for @{$$reg{"QUEUE"}};
			print "\n";
		}else{
			print "$key: $val\n";	
		}
	}
}