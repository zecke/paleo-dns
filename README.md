# DNS for Pharo (Smalltalk)

This is an implementation of DNS encoding/decoding, transport. It
includes the beginning of a stub resolver and should be a modern
replacement for *NetNameResolver*.

## Example usage

A DNSQuery can be sent over UDP, TCP or TLS (TLS over TCP). An example
query sent over UDP is:

```smalltalk
PaleoDNSTLSTransport new
	destAddress: #[8 8 4 4] port: 853;
	timeout: 2 seconds;
	query: (PaleoDNSQuery new
			   transactionId: (SharedRandom globalGenerator nextInt: 65535);
				addQuestion: (PaleoRRA new rr_name: 'pharo.org.');
				addAdditional: (PaleoRROpt new udpPayloadSize: 4096))
```


## Your contribution here

If you are interested to modernize Pharo, want to learn about a
protocol we use all the time. Then please consider making a contribution.

Below you can see a list of tasks and who implemented them. Most of them
are bite sized tasks and easy to implement.

### Unix integration

  - [ ] Parse /etc/hosts and build local database (todo)
  - [ ] Parse /etc/resolv.conf (todo)
  - [ ] Parse _hosts:_ in /etc/nsswitch.conf

### MacOS integration

  - [ ] Get system configuration?
  
### Windows integration

  - [ ] Tell me!
  
### Stub resolver

  - [ ] Add a basic stub resolver
  - [ ] Add validation (transactionId match, qname matches)
  - [ ] Add caching and respect TTL
  - [ ] Add 0x20 randomization to the qname
  - [ ] Respect platform settings
 
### Transport

  - [ ] Validate UDP src addr/port match the dest one
  - [ ] Validate TLS certificate
  - [ ] Add DNS over HTTP (DoH) support
  - [ ] Learn reasonable timeouts for look-up based on past look-ups.

### Resource Records:

Not all of them are equally important. The list attempts to order them in
importannce.

  - [x] A record (zecke)
  - [x] OPT record (zecke)
  - [ ] AAAA record
  - [ ] NS record
  - [ ] CNAME record
  - [ ] SOA record
  - [ ] SRV record
  - [ ] MX record
  - [ ] TXT record
  
  - [ ] NULL record
  - [ ] PTR record
  - [ ] HINFO record
  - [ ] MINFO record
  - [ ] RP record
  - [ ] AFSDB record
  - [ ] RT record
  - [ ] SIG record
  - [ ] KEY record
  - [ ] LOC record
  - [ ] NAPTR record
  - [ ] KX record
  - [ ] CERT record
  - [ ] DNAME record
  - [ ] APL record
  - [ ] DS record
  - [ ] SSHFP record
  - [ ] IPSECKEY record
  - [ ] RRSIG record
  - [ ] NSEC record
  - [ ] DNSKEY record
  - [ ] DHCID record
  - [ ] NSEC3 record
  - [ ] NSEC3PARAM record
  - [ ] TLSA record
  - [ ] CDS record
  - [ ] CDNSKEY record
  - [ ] SPF record
  - [ ] NID record
  - [ ] L32 record
  - [ ] L64 record
  - [ ] LP record
  - [ ] EUI48 record
  - [ ] EUI64 record
  - [ ] TKEY record
  - [ ] TSIG record
  - [ ] IXFR record
  - [ ] AFXR record
  - [ ] ANY record
  - [ ] URI record
  - [ ] CAA record
  
  
 ### EDNS Options
 
 EDNS(0) is a way to extend DNS. The OPT record will contain a list of options. The most
 prominent is the Client Subnet Option (ECS).
 
  - [ ] Client Subnet (RFC 7871)
  - [ ] Padding (RFC 8467)
  
  
  ### DNSSEC
  
  DNSSEC allows an authoriative server to sign a response and a validating resolver will
  validate this. It's a complicated protocol and we could add support here (e.g. to build
  a resolver).
  
  
  ### DANE
  
  DNS-Based Authentication of Named Entities (DANE) is a separate root of trust anchored
  in DNS. This could be integrated with Zinc. The primary RFC is 6698.
  
