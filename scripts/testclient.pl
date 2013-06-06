#!/usr/bin/perl -w
#
# This is not meant to be used by anybody outside the developers of
# this module
# -----------------------------------------------------------------

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use MRS::Client;
use Data::Dumper;

sub say { print @_, "\n"; }

my $client = MRS::Client->new();
my $job = $client->blast->run (fasta => ">b1gv78_schgr Insulin-related peptide transcript variant T1;\nMWKLCLRLLAVLAVCLCTATQAQSDLFLLSPKRSGAPQPVARYCGEKLSNALKIVCRGNYNTMFKKASQDVS\nDAESEDNYWSQSADEEVEAPALPPYPVLARPSAGGLLTAAVFRRRTRGVFDECCRKSCSISELQTYCGRR\n",
                              expect => '1.1E02',
 			     db => 'sprot');
say 'JOB ID: ' . $job->id;
say 'STATUS: ' . $job->status;

while (not $job->completed) {
     say 'Waiting for 10 seconds... [status: ' . $job->status . ']';
     sleep 10;
}
say $job->error if $job->failed;
print $job->results;

__END__

#my $client = MRS::Client->new ( search_url => 'http://localhost:18081/',
#				blast_url  => 'http://localhost:18082/',
#				admin_url  => 'http://localhost:18084/',
#    );

#my $client = MRS::Client->new(host => 'mrs.cbrc.kaust.edu.sa');
# my $client = MRS::Client->new(search_url => 'http://mrs.cmbi.ru.nl:18081/mrsws/search');
#my $client = MRS::Client->new(search_url => 'http://localhost:9999/mrsws/search');
#my $client = MRS::Client->new(search_url => 'http://mrs.cmbi.ru.nl:80/m6/mrsws/search');
#my $client = MRS::Client->new (admin_wsdl => 'admin.wsdl.template');

# $ENV{MRS_VERSION} = 5;
# my $client = MRS::Client->new (host => 'mrs.cbrc.kaust.edu.sa');

my $client = MRS::Client->new();

#print $client->db ('uniprot')->find ('sapiens')->count;
#print $client->db ('uniprot')->find ('sapiens')->next;
# {
#     my $query = $client->db ('enzyme')->find ('and' => ['snake', 'human'],
# 					      'format' => MRS::EntryFormat->HEADER);
#     while (my $record = $query->next) {
# 	print $record . "\n";
#     }
# }

{
    my $query = $client->db ('sprot')->find ('and' => ['snake', 'human'],
					       query => 'NOT (kinase OR reductase)',
					       'format' => MRS::EntryFormat->HEADER);
    print STDERR "Count: " . $query->count . "\n";
    print STDERR "Query:\n" . $query . "\n";
    while (my $record = $query->next) {
     	# print $record . "\n";
    }
}

__END__

my $db = $client->db ('enzyme');
my $find = $db->find ('human');



#print $client->search_url . "\n";

binmode STDOUT, ":utf8";
#my $result = $client->db;

$client->_create_proxy ('search');
my $answer = $client->_call (
    $client->{search_proxy}, 'GetDatabankInfo', { db => 'all' });
print Dumper ($answer);
__END__


$client->_create_proxy ('search');
my $answer = $client->_call (
    $client->{search_proxy}, 'Count',
    { db => 'sprot',
      booleanquery => '*' });
print Dumper ($answer);

__END__

my $result = $client->db ('uniprot')->find ('srl');
print $result->count;

__END__

#my @ids = map { $_->id } $client->db;
#print "Names:\n" . join ("\n", @ids) . "\n";

#print join ("\n", $client->db) ."\n";

# print $client->db ('enzyme');
# print $client->db ('enzyme')->version . "\n";
# print $client->db ('enzyme')->count . "\n";

#print MRS::Client::EntryFormat->check('title') . "\n";

# print $client->find (db => 'enzyme', query => 'retropepsin');
# print $client->find (query => 'retropepsin');
# print $client->find ('retropepsin');
# print $client->find ('retropepsin AND NOT human');
# print $client->find ( ['retropepsin', 'human'] );
# print $client->find ( or => ['retropepsin', 'human'] );
# print $client->find ( and => ['retropepsin', 'human'] );
# print $client->find ( and => ['retropepsin'], or => ['human'] );
# print $client->find (query => 'NOT human',
# 		     or => ['sapi'],
# 		     format => MRS::EntryFormat->HTML,
#                      offset => 21,
#                      db => 'enzyme',
#                     );
# print $client->find (algorithm => MRS::Algorithm->DICE, query => 'human');
#print $client->find (query => 'retropepsin', start => 5);
#print $client->find (query => 'retropepsin', start => 0);
#print $client->find (query => 'retropepsin', offset => -1);
#print $client->find (query => 'retropepsin', offset => -1, start => 6);
#print $client->find (query => 'retropepsin', start => 6);

#print join ("\n", $client->databank_info ()) ."\n";
#print $client->db ('enzyme') ."\n";

#print $client->db ('uniprot')->entry ('Q14547_HUMAN') . "\n";
#print $client->db ('uniprot')->entry ('Q14547_HUMAN', MRS::EntryFormat->FASTA) . "\n";

# my $my_count = 0;
# # #my $result = $client->db ('enzyme')->find ('snakelinismus');
# my $result = $client->db ('uniprot')->find (and => ['human', 'snake'],
#  					   query => 'NOT (kinase OR reductase)',
#  					   format => MRS::EntryFormat->HEADER);
#  while (my $record = $result->next) {
#      print $record . "\n";
#      $my_count++;
# }
#  print "My count:    $my_count\n";
#  print "Their count: " . $result->count . "\n";
#  print "$result\n";

# my $my_count = 0;
# my $result = $client->db ('uniprot')->find (and => ['human', 'snake'],
# 					   format => MRS::EntryFormat->TITLE);
# #my $result = $client->db ('enzyme')->find (query => 'snake AND NOT human',
# #					   format => MRS::EntryFormat->HEADER);
# while (my $record = $result->next) {
#     print $record . "\n";
#     $my_count++;
# }
# print "My count:    $my_count\n";
# print "Their count: " . $result->count . "\n";
# print "$result\n";

# my $result = $client->db ('enzyme')->find (query => '',
# 					   format => MRS::EntryFormat->HEADER);
# while (my $record = $result->next) {}
# print "Count: " . $result->count . "\n";

# foreach my $db ($client->db) {
#     printf ("%-10s %8d\n", $db->id, $db->count());
# }

# use Error qw(:try);
# try {
#     print $client->db ('enzymeX') ."\n";
# } otherwise {
#     my $E = shift;
#     print STDERR
# 	"ERROR: " . $E->{'-text'} .
# 	"\n[Caused at " . $E->{'-file'} . " line " . $E->{'-line'} . "]\n";
# };
#print MRS::Client::Databank->new();

#print $client->db ('enzyme') ."\n";
#print $client->db ('uniprot') ."\n";
#print $client->db ('uniprot')->version ."\n";
#print $client->db ('enzyme')->count ."\n";

# print $client->db ('enzyme')->find ('human')->count ."\n";
# print $client->db ('uniprot')->find (['human', 'snake'])->count ."\n";

# print $client->db ('uniprot')->find ('sapiens')->next ."\n";
# print $client->db ('uniprot')->find ('sapiens')->count ."\n";

# my $query = $client->db ('enzyme')->find (or => ['snake', 'human'],
# 					  format => MRS::EntryFormat->HEADER);
# while (my $record = $query->next) {
#    print $record . "\n";
# }

# print $client->db ('enzyme')->find (['snake', 'human']);

    # my $query = $client->db ('uniprot')->find (and => ['snake', 'human'],
    #                                           query => 'NOT (kinase OR reductase)',
    # 					      format => MRS::EntryFormat->HEADER);
    # print "Count: " . $query->count . "\n";
    # while (my $record = $query->next) {
    #    print $record . "\n";
    # }

# print "Databank\tID\tScore\ttitle\n";
# my $query = $client->find (and => ['cone', 'snail'], format => MRS::EntryFormat->HEADER);
# while (my $record = $query->next) {
#     print $record . "\n";
# }
# print $query->count . "\n";

# my $query = $client->find (and => ['cone', 'snail'], format => MRS::EntryFormat->HEADER);
# print $query . "\n";
# print $query->count . "\n";

# print $client->parser ('enzyme');  # security concern into docs
#print $client->parser ('../update_scripts/databank.info');  # security concern into docs

#print $client->db('uniprot')->find ('cone AND snail')->count;

   # my $db = $client->db('omim');
   # print $db->id        . "\n";
   # print $db->name      . "\n";
   # print $db->version   . "\n";
   # print $db->blastable . "\n";
   # print $db->url       . "\n";
   # print $db->script    . "\n";

   # sub say { print @_, "\n"; }

   # my $db_files = $client->db('uniprot')->files;
   # foreach my $file (@{ $db_files }) {
   #    say $file->id;
   #    say $file->version;
   #    say $file->last_modified;
   #    say $file->entries_count;
   #    say $file->raw_data_size;
   #    say $file->file_size;
   #    say '';
   # }

   # my $db_indices = $client->db('uniprot')->indices;
   # foreach my $idx (@{ $db_indices }) {
   #    printf ("%-15s%9d  %-9s %s\n",
   # 	      $idx->id,
   #            $idx->count,
   #            $idx->type,
   #            $idx->description);
   # }

# sub say { print @_, "\n"; }
# say $client->db ('enzyme')->entry ('3.4.21.60');
# say $client->db ('enzyme')->entry ('3.4.21.60',
# 				   MRS::EntryFormat->TITLE);

   # sub say { print @_, "\n"; }

   # my $find = $client->db('uniprot')->find(['sapiens', 'ape']);
   # say $find->db;
   # say join (", ", @ {$find->terms });
   # say $find->query;
   # say $find->max_entries;
   # say $find->all_terms_required;
   # say $find->count;

# sub say { print @_, "\n"; }
# foreach my $db ($client->db) {
#     say $db->links;
# }

# my $job = $client->blast->run (fasta => ">b1gv78_schgr Insulin-related peptide transcript variant T1;\nMWKLCLRLLAVLAVCLCTATQAQSDLFLLSPKRSGAPQPVARYCGEKLSNALKIVCRGNYNTMFKKASQDVS\nDAESEDNYWSQSADEEVEAPALPPYPVLARPSAGGLLTAAVFRRRTRGVFDECCRKSCSISELQTYCGRR\n",
#                              expect => '1.1E02',
# 			     db => 'uniprot');
# #my $job = $client->blast->job ('0f37a544-a7a2-4239-b950-65a6aa07d1ef');
# say 'JOB ID: ' . $job->id;
# say 'STATUS: ' . $job->status;

# while (not $job->completed) {
#     say 'Waiting for 10 seconds... [status: ' . $job->status . ']';
#     sleep 10;
# }
# say $job->error if $job->failed;
# print $job->results;

# print my $result = $client->clustal->run (fasta_file => '/home/senger/tmp/several.proteins.2.fasta');
# say $result->diagnostics;

# my @run_args = (fasta_file => '/home/senger/tmp/snake.protein.fasta', db => 'sprot');
# my $job = $client->blast->run (@run_args);
# sleep 10 while (not $job->completed);
# print $job->error if $job->failed;
# print $job->results;

#my $find = $client->db ('sprot')->find (and => ['rds', 'os:human']);

# my $find = $client->db('sprot')->find
# #    (and      => ['DNP_DENAN'],
#     (and      => ['VE6_HPV16'],
#      'format' => MRS::EntryFormat->HTML,
#      xformat  => {
# 	 MRS::XFormat::ONLY_LINKS()  => 1,
# #	 MRS::XFormat::CSS_CLASS()   => 'mrslink',
# #	 MRS::XFormat::URL_PREFIX()  => 'http://yes/no/',
# #	 MRS::XFormat::REMOVE_DEAD() => ['embl'],
# #	 MRS::XFormat::REMOVE_DEAD() => 1,
#      },
#     );
# while (my $record = $find->next) {
#     if (ref $record eq 'ARRAY') { 
# 	say join ("\n", @$record);
#     } else {
# 	say $record;
#     }
# }

# my $entry = $client->db('sprot')->entry
#     ('DNP_DENAN',
#      MRS::EntryFormat->HTML,
#      {
# 	 MRS::XFormat::ONLY_LINKS()  => 1,
# 	 MRS::XFormat::CSS_CLASS()   => 'mrslink',
# #	 MRS::XFormat::URL_PREFIX()  => 'http://yes/no/',
# #	 MRS::XFormat::REMOVE_DEAD() => ['embl'],
# #	 MRS::XFormat::REMOVE_DEAD() => 1,
#      });
# if (ref $entry eq 'ARRAY') { 
#     say join ("\n", @$entry);
# } else {
#     say $entry;
# }

my $result = $client->find (and      => ["B4VVS2"],
			    'format' => MRS::EntryFormat->PLAIN);
while (my $record = $result->next) {
    print $record . "\n";
}

my $client = MRS::Client->new(host => 'mrs.cbrc.kaust.edu.sa', mrs_version => 5);
$client->_create_proxy ('search');
my $answer = $client->_call (
    $client->{search_proxy}, 'Count',
    { db => 'all',
      booleanquery => '*' });
print Dumper ($answer);

my $client = MRS::Client->new();
$client->_create_proxy ('search');
my $answer = $client->_call (
    $client->{search_proxy}, 'GetLinkedEx', { db => 'embl', linkedDatabank => 'taxonomy', id => 'M29954' });
print Dumper ($answer);

__END__

