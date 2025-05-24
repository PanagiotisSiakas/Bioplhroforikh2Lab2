use strict;
use warnings;

my %codon_table = 
(
    'TTT'=>'F','TTC'=>'F','TTA'=>'L','TTG'=>'L',
    'CTT'=>'L','CTC'=>'L','CTA'=>'L','CTG'=>'L',
    'ATT'=>'I','ATC'=>'I','ATA'=>'I','ATG'=>'M',
    'GTT'=>'V','GTC'=>'V','GTA'=>'V','GTG'=>'V',
    'TCT'=>'S','TCC'=>'S','TCA'=>'S','TCG'=>'S',
    'CCT'=>'P','CCC'=>'P','CCA'=>'P','CCG'=>'P',
    'ACT'=>'T','ACC'=>'T','ACA'=>'T','ACG'=>'T',
    'GCT'=>'A','GCC'=>'A','GCA'=>'A','GCG'=>'A',
    'TAT'=>'Y','TAC'=>'Y','TAA'=>'*','TAG'=>'*',
    'CAT'=>'H','CAC'=>'H','CAA'=>'Q','CAG'=>'Q',
    'AAT'=>'N','AAC'=>'N','AAA'=>'K','AAG'=>'K',
    'GAT'=>'D','GAC'=>'D','GAA'=>'E','GAG'=>'E',
    'TGT'=>'C','TGC'=>'C','TGA'=>'*','TGG'=>'W',
    'CGT'=>'R','CGC'=>'R','CGA'=>'R','CGG'=>'R',
    'AGT'=>'S','AGC'=>'S','AGA'=>'R','AGG'=>'R',
    'GGT'=>'G','GGC'=>'G','GGA'=>'G','GGG'=>'G'
);

my $dna = "AAATGGCACGTTAGCCCATGAAATGACTGAATGATGATGGGGGGGCGATAA";

sub reverse_complement 
{
    my ($seq) = @_;
    $seq =~ tr/ACGT/TGCA/;
    return reverse($seq);
}

sub translate 
{
    my ($orf) = @_;
    my $protein = '';
    for (my $i = 0; $i <= length($orf) - 3; $i += 3) 
    {
        my $codon = substr($orf, $i, 3);
        my $aa = $codon_table{$codon} // '-';
        last if $aa eq '*';
        $protein .= $aa;
    }
    return $protein;
}

sub find_orfs 
{
    my ($seq) = @_;
    my @proteins;
    while ($seq =~ /(?=(ATG(?:...)*?(?:TAA|TAG|TGA)))/g) 
    {
        my $orf = $1;
        if (length($orf) % 3 == 0) 
        {
            my $protein = translate($orf);
            push @proteins, $protein;
        }
    }
    return @proteins;
}

print "Forward strand proteins:\n";
my @forward = find_orfs($dna);
print "$_\n" for @forward;

print "\nReverse strand proteins:\n";
my $reverse_dna = reverse_complement($dna);
my @reverse = find_orfs($reverse_dna);
print "$_\n" for @reverse;
