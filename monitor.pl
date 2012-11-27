#!/usr/bin/perl

#  ====================================================================
#  Source code from www.blazonry.com/perl/monitor.php
#  Copyright (c) 2000 Astonish Inc. www.astonishinc.com
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  3. The name of the author may not be used to endorse or promote products
#     derived from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
#  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
#  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
#  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
#  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#  ====================================================================
#
#################################################################
#
# monitor.pl
#
# Perl script to monitor a website
# and e-mail out if it is not available
#
#################################################################

use LWP::Simple;

my $url = "http://www.calwqa.net/fac2";

# list of e-mails to send out message
@emails = ('john.zastrow@tetratech.com', 'jcz@northredoubt.com');

($min, $hr, $day, $mon) = (localtime)[1,2,3,4];
$qdate = "$mon/$day $hr:$min";

# fetch webpage
my $webpage = get $url;

	# if no page then create message
	# send e-mail out to list
	if (!$webpage) {
        $msg = "ERROR: Could not retrieve $url"; 

		foreach $email (@emails) {
			sendmail($email, $msg);
		}
	} 
    else {
        # no problems
    }

exit(0);

#-------------------------------------------------------------------------------------
# SUB:  sendmail(email-address, message)
#
# DESC: uses SENDMAIL to send out e-mail
#-------------------------------------------------------------------------------------
sub sendmail {
	my $email = $_[0];
	my $msg = $_[1];

	open (SENDMAIL, "|/usr/sbin/sendmail -oi -t -odq") || die ("No Sendmail: $!\n");
	print SENDMAIL "From: URL-Monitor\@somesite.com\n";
	print SENDMAIL "To: $email\n";
	print SENDMAIL "Subject: URL Monitor      \n\n";
	print SENDMAIL "$msg";
	close(SENDMAIL);
	
}
	
#-------------------------------------------------------------------------------------