my $protein= "MNVEHE_123! LLVEE \$";
$protein=~ s/[^A-Z]/-/g;
print "cleaned sequence: $protein\n";
