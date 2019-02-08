service sshd stop
service capi stop
#service dropbox stop
service dovecot stop
service named stop
service cups stop
service wpa_supplicant stop
service proftpd stop
service ip6tables stop
service sendmail stop
service portmap stop
chkconfig --del portmap
chkconfig --level 15 portmap off
chkconfig sendmail off
chkconfig --del sendmail
chkconfig --level 15 sendmail off
chkconfig ip6tables off
chkconfig proftpd off
chkconfig wpa_supplicant off
chkconfig --del cups
chkconfig --level 15 cups off
chkconfig --del sshd
chkconfig --level 15 sshd off
chkconfig --del capi
chkconfig --level 15 capi off
chkconfig --del dropbox
chkconfig --level 15 dropbox off
chkconfig --del dovecot
chkconfig --level 15 dovecot off
chkconfig --del named
chkconfig --level 15 named off

