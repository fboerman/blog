---
title: "DIY IT: running your own DNS nameservers"
date: 2021-03-12
draft: false
description: "Over the years I have started to run more and more of my own IT infrastructure as a hobby. The latest adventure in this is the wonderfull world of running your own DNS nameserver."
---
The worldwide DNS system is one of the backbones of the internet, yet very few people have actually heard of it. The [Domain Name System](https://en.wikipedia.org/wiki/Domain_Name_System) can be most simply explained as being the phonebook of the internet. It maps domain names that you type in, for example boerman.dev, to an IP address, for example 195.201.95.231, which corresponds to the server that hosts the website. DNS is a distributed system, meaning that it is a global spanning network of servers (so called nameservers) which sync entries between eachother.  

{{< figure src="dns-basic.svg" >}}

I started researching about DNS because I found it fascinating and because I wanted to setup my own nameservers. As a hobby I have build a small server infrastructure to try out different things and host various systems I use. Besides this website I also run my own git server (git.boerman.dev), a data scraping system with grafana frontend (data.boerman.dev), a personal jupyterhub (hub.boerman.dev) and various other small things. Running my own nameserver would be a cool addition.

The first part of this post will explain the practical basics of DNS and the way nameservers keep eachother up to date with the latest changes. It is not meant as an exhaustive explanation of it, but as a basis of understanding, which is helpfull for the second part. For a full explaination please read this in depth article from [cloudflare](https://www.cloudflare.com/learning/dns/what-is-dns/). In the second part I will explain how I setup my own nameservers, with as a bonus easy integration for wildcard domains for LetsEncrypt.

## DNS records
There are many different types of DNS records, but there is a small subset of ones that are most used in typical usage.
A: this is the most common one, it maps a hostname to an ipv4 ip address.  
AAAA: same purpose as for A but then for a mapping to an ipv6 address.  
MX: maps a domain to the ip of a mail server. So this is specificially for email traffic.  
CNAME: maps a domain to another domain, usefull for shared hosting.  
TXT: is a bit different then the others, it is used to store a key value pair, commonly used for verifying domains.  

For the purpose of our experiment to setup own nameservers there are two other important record types: NS and SOA. NS stands for NameServer and is meant for delegating a (sub)domain to a different nameserver then the one you just asked.  
SOA stands for Start Of Authority and contains a bunch of administrative information about a domain from the nameserver. It is a large string of space seperated parts. The format is nicely broken down on [wikipedia](https://en.wikipedia.org/wiki/SOA_record) and consists of the master nameserver for a domain, email address for the hostmaster, and various settings for caching the dns records. It is very important to set this up correctly, or other dns servers can't find your domain. To understand the various settings it is important to understand DNS hierarchy.

## Nameservers hierarchy



## Open source nameservers

# LetsEncrypt

{{< ping key="DNS" >}}
