#!usr/bin/perl
    use strict;
    use warnings;
    my $position = '';
    my %id2seq = ();
    my $id = '';
    my $length = "";
    my $x=  1;
    open F,$ARGV[0],or die $!;
    while(<F>){
        chomp;
        if($_ =~ /^>(.+)/){
            $id = $1;
        }else{
            $id2seq{$id} .= $_;
        }
        
	while($id2seq{$id} =~ m/R|H|K/g)
        {
        $position = pos($id2seq{$id});
        $length = length($id2seq{$id});
        print "$id\t$x\t$length\t$position\t1\n";
        }
       


    }
close F;
