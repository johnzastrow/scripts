#!/usr/bin/perl
# Modified jcz 2001-12-1
$mailprogram = "/usr/sbin/sendmail -t -oi"; # Location of Sendmail
$recipient = 'john.zastrow@tetratech-ffx.com, root@localhost';
$subjectline = "[ASTERIONELLA] Disk Space/Load Report ";
$serverrootemail = 'root@127.0.0.1';
$servername = "asterionella.tetratech-ffx.com";
# Do not change 
$report = `df -h`;
$date = `date`;
$julian = `date +%j`;
$report2 = `uptime`;
# $homes =  `du -sk /home/*`;
# $homes =  `du -sh /home/*`;
# $disk = `du /mnt/*`;
$userson = `/usr/bin/w`;
$last = `last`;
$availarchs = `ls -lhRt /mnt/hdb3/home/jcz/archi*`;
# $accesses = `wc -l /var/log/httpd/access_log`;
$job = `cat /home/jcz/scripts/job.txt`;
$smartctlca = `cat /home/jcz/scripts/drivetests.txt`;



open (MAIL, "|$mailprogram") || die("SpaceTracker: Could Not Open Mail Program -> spacetracker.cgi");
print MAIL <<__END_OF_MAIL__;
To: $recipient
From: $serverrootemail
Reply-to: DoNotReply ( DO NOT REPLY )
Subject: $date $subjectline



$availarchs


DAILY REPORT FOR $servername at $date
$julian DAYS INTO THE YEAR
DISK USAGE:
$report


SMART STATUS:

$smartctlca


USERS CURRENTLY ON SYSTEM:<
$userson
RECENT LOGINS
$last
SYSTEM LOAD:
$report2

$job

*** This report is generated automatically by the webserver $servername. 
and the script /home/jcz/bin/spacetracker.pl ***

__END_OF_MAIL__
close (MAIL);
exit;
