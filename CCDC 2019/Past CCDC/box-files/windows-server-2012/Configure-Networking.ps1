Function Configure-Networking-CCDC {
	# exceptions to allow browsing, windows update, web hosting, and echo service
	new-netfirewallrule -displayname HTTP-out -direction outbound -action allow -protocol tcp -localport 80,443
	new-netfirewallrule -displayname HTTP-in -direction inbound -action allow -protocol tcp -localport 80,443
	new-netfirewallrule -displayname DNS-out -direction outbound -action allow -protocol tcp -localport 53
	new-netfirewallrule -displayname echo-in -direction inbound  -action allow -protocol tcp -localport 7
	new-netfirewallrule -displayname echo-out -direction outbound  -action allow -protocol tcp -localport 7
	
	# turn the firewall on, enable detailed logging, and ensure it's either on domain or private
	set-netfirewallprofile -name domain,public,private -enabled true -DefaultInboundAction Block -DefaultOutboundAction Block
	set-NetConnectionProfile -interfacealias ethernet -NetworkCategory private # can't set category to domain (enforced by the domain membership)
	set-netfirewallprofile -name domain,private -logallowed true -logblocked true -logmaxsizekilobytes 10240
	set-netfirewallprofile -name domain -logfilename "c:\firelog\domain.log"
	set-netfirewallprofile -name private -logfilename "c:\firelog\private.log"
	
	# disable unneeded networking options
	set-net6to4configuration -state disabled
	set-netteredoconfiguration -type disabled
	set-netisatapconfiguration -state disabled
	
	# patch SMB signature vulnerability
	set-itemproperty -path hklm:\system\currentcontrolset\services\lanmanserver\parameters -name requiresecuritysignature -value 1
}
Configure-Networking-CCDC
