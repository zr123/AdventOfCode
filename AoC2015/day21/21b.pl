use strict;
use warnings;

my @weapons = ([8, 4, 0], [10, 5, 0], [25, 6, 0], [40, 7, 0], [74, 8, 0]);
my @armor = ([0, 0, 0], [13, 0, 1], [31, 0, 2], [53, 0, 3], [75, 0, 4], [102, 0, 5]);
my @rings = ([0, 0, 0], [0, 0, 0], [25, 1, 0], [50, 2, 0], [100, 3, 0], [20, 0, 1], [40, 0, 2], [80, 0, 3]);

my ($bossHp, $bossDmg, $bossArmor) = (109, 8, 2);

sub challangeBoss {
  sub calcDamage {
    my ($attackerDamage, $defenderArmor) = @_;
    if($defenderArmor >= $attackerDamage){
      return 1;
    }else{
      return $attackerDamage - $defenderArmor;
    }
  }
  my ($playerHp, $playerDmg, $playerArmor) = @_;
  my $playerHitsToKillBoss = $bossHp / calcDamage($playerDmg, $bossArmor);
  my $bossHitsToKillPlayer = $playerHp / calcDamage($bossDmg, $playerArmor);
  return $bossHitsToKillPlayer > $playerHitsToKillBoss ;
}

my $maxGold = 0;
for my $w (@weapons){
  for my $a (@armor){
    for(my $r1 = 0; $r1 < scalar(@rings); ++$r1){
      for(my $r2 = 0; $r2 < scalar(@rings); ++$r2){
        if($r1 == $r2){next;}
        my $gold = $$w[0] + $$a[0] + $rings[$r1][0] + $rings[$r2][0];
        my $dmg = $$w[1] + $$a[1] + $rings[$r1][1] + $rings[$r2][1];
        my $armor = $$w[2] + $$a[2] + $rings[$r1][2] + $rings[$r2][2];
        if($gold > $maxGold && !challangeBoss(100, $dmg, $armor)){
          $maxGold = $gold;
        }
      }
    }
  }
}

print "$maxGold\n";