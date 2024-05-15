
rule netcat_exec_backdoor : high {
  meta:
    ref = "https://cert.gov.ua/article/6123309"
    hash_2023_uacert_nc = "dd8a8a9dde32a14a7222a28e878d13c4f0bccd5eb54d0575fa6332d001226715"
    hash_2024_reverse_shells_nc = "fe518473fbc051bf9e393251bad2f02cb936d134404421bf27363bcd0a31f787"
  strings:
    $nc_e = "nc -e "
  condition:
    filesize < 10485760 and all of them
}

rule generic_perl_socket_exec {
  strings:
    $perl = "perl"
    $socket_inet = "IO::Socket::INET"
    $socket = "use Socket"
    $and_exec = "exec"
    $and_system = "system("
    $and_backtick = "`;"
    $not_nuclei = "NUCLEI_TEMPLATES"
    $not_kitten = "KITTY_KITTEN_RUN_MODULE"
  condition:
    filesize < 1048576 and $perl and any of ($socket*) and any of ($and_*) and none of ($not_*)
}

rule ipinfo_and_bash : high {
  meta:
    hash_2023_Unix_Coinminer_Xanthe_7ea1 = "7ea112aadebb46399a05b2f7cc258fea02f55cf2ae5257b331031448f15beb8f"
    hash_2022_CloudMensis_WindowServer = "317ce26cae14dc9a5e4d4667f00fee771b4543e91c944580bbb136e7fe339427"
    hash_2022_CloudMensis_WindowServer_2 = "b8a61adccefb13b7058e47edcd10a127c483403cf38f7ece126954e95e86f2bd"
  strings:
    $ipinfo = "ipinfo.io"
    $bash = "/bin/bash"
  condition:
    all of them
}

rule readdir_inet_system : high {
  meta:
    description = "Lists directories, resolves IPs, calls shells"
    hash_2023_Lightning_48f9 = "48f9471c20316b295704e6f8feb2196dd619799edec5835734fc24051f45c5b7"
    hash_2023_Unix_Trojan_Mirai_2f98 = "2f987c374944a01717b1905f2bc063a3b577a1d9933a5225717332aa6e43eb90"
    hash_2023_Unix_Trojan_Mirai_c493 = "c493b42168323e2087025845c91274dabaefa70be951eac08746d4b7e900d627"
  strings:
    $dlsym = "readdir" fullword
    $openpty = "inet_addr" fullword
    $system = "system" fullword
  condition:
    all of them in (1200..3000)
}

rule pcap_shell_exec : high {
  meta:
    description = "sniffs network traffic, executes shell"
    hash_2023_BPFDoor_dc83 = "dc8346bf443b7b453f062740d8ae8d8d7ce879672810f4296158f90359dcae3a"
  strings:
    $libpcap = "libpcap"
    $shell = "shell" fullword
    $sh = "/bin/sh"
    $sh_bash = "/bin/bash"
    $y_exec = "exec" fullword
    $y_execve = "execve" fullword
    $y_execvp = "execvp" fullword
    $y_system = "system"
    $not_airportd = "airportd"
  condition:
    $libpcap and any of ($sh*) and any of ($y*) and none of ($not*)
}

rule go_pty_daemonize_net : critical {
  meta:
    description = "daemonizes and exposes a terminal to the internet"
  strings:
    $d1 = "go-daemon" fullword
    $d2 = "xdaemon" fullword
    $pty = "creack/pty" fullword
    $ptsname = "ptsname" fullword
    $net = "net.socket" fullword
    $nsocks = "go-socks5"
  condition:
    any of ($d*) and any of ($p*) and any of ($n*)
}
