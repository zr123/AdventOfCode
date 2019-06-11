use strict;
use warnings;

my ($MAXMANA, $MAXHP) = (500, 50);

sub calcEffects {
  my (%stats) = @_;
  if($stats{"poison"} > 0){
    $stats{"bossHp"} -= 3;
    $stats{"poison"}--;
  }
  if($stats{"recharge"} > 0){
    $stats{"recharge"}--;
    $stats{"mana"} += 101;
    if($stats{"mana"} > $MAXMANA){
      $stats{"mana"} = $MAXMANA;
    }
  }
  if($stats{"shield"} > 0){
    $stats{"shield"}--;
  }
  return %stats;
}

sub calcBossTurn {
  my (%stats) = @_;
  %stats = calcEffects(%stats);
  if($stats{"bossHp"} > 0){
    if($stats{"shield"} > 0){
      $stats{"playerHp"} -= 1;
    }else{
      $stats{"playerHp"} -= 8;
    }
  }
  return %stats;
}

my $globalMin = 99999999;
sub weasel {
  my (%stats) = @_;
  %stats = calcEffects(%stats);
  $stats{"playerHp"}--;
  if($stats{"playerHp"} <= 0 || $stats{"manaSpend"} >= $globalMin){
    return;
  }
  if($stats{"bossHp"} <= 0){
    $globalMin = $stats{"manaSpend"};
    return;
  }
  if($stats{"mana"} >= 53){
    my %s = %stats;
    $s{"manaSpend"} += 53;
    $s{"mana"} -= 53;
    $s{"bossHp"} -= 4;
    weasel(calcBossTurn(%s));
  }
  if($stats{"mana"} >= 73){
    my %s = %stats;
    $s{"manaSpend"} += 73;
    $s{"mana"} -= 73;
    $s{"bossHp"} -= 2;
    $s{"playerHp"} += 2;
    if($s{"playerHp"} > $MAXHP){$s{"playerHp"} = $MAXHP;}
    weasel(calcBossTurn(%s));
  }
  if($stats{"mana"} >= 113){
    my %s = %stats;
    $s{"manaSpend"} += 113;
    $s{"mana"} -= 113;
    $s{"shield"} = 6;
    weasel(calcBossTurn(%s));
  }
  if($stats{"mana"} >= 173){
    my %s = %stats;
    $s{"manaSpend"} += 173;
    $s{"mana"} -= 173;
    $s{"poison"} = 6;
    weasel(calcBossTurn(%s));
  }
  if($stats{"mana"} >= 229){
    my %s = %stats;
    $s{"manaSpend"} += 229;
    $s{"mana"} -= 229;
    $s{"recharge"} = 5;
    weasel(calcBossTurn(%s));
  }
}

my %status;
$status{"poison"} = 0;
$status{"shield"} = 0;
$status{"recharge"} = 0;
$status{"mana"} = $MAXMANA;
$status{"playerHp"} = $MAXHP;
$status{"manaSpend"} = 0;
$status{"bossHp"} = 55;
weasel(%status);
print "$globalMin\n";