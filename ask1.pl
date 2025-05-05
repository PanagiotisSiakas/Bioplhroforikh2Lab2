use strict ;
use warnings;

while (<>){
   if(/^>\S+\|(\w+)\|/){
    print "Found Accession: $1\n";
   } 
}