
rule irc_c_format : high {
  meta:
    pledge = "inet"
    description = "Uses IRC (Internet Relay Chat"
    hash_2023_Unix_Trojan_Tsunami_8555 = "855557e415b485cedb9dc2c6f96d524143108aff2f84497528a8fcddf2dc86a2"
    hash_2023_Unix_Trojan_Tsunami_d3b5 = "d3b513cb2eb19aad50a0d070f420a5f372d185ba8a715bdddcf86437c4ce6f5e"
    hash_2023_Win_Trojan_Perl_9aed = "9aed7ab8806a90aa9fac070fbf788466c6da3d87deba92a25ac4dd1d63ce4c44"
  strings:
    $ref = "PRIVMSG"
    $ref2 = "NOTICE %s"
    $ref3 = "NICK %s"
    $ref4 = "JOIN %s :%s"
  condition:
    any of them
}

rule irc_protocol : high {
  meta:
    pledge = "inet"
    description = "Uses IRC (Internet Relay Chat"
    credit = "Initially ported from https://github.com/jvoisin/php-malware-finder"
    hash_2023_Linux_Malware_Samples_3059 = "305901aa920493695729132cfd20cbddc9db2cf861071450a646c6a07b4a50f3"
    hash_2023_Linux_Malware_Samples_3668 = "3668b167f5c9083a9738cfc4bd863a07379a5b02ee14f48a10fb1240f3e421a6"
    hash_2023_Linux_Malware_Samples_3993 = "3993bc5c3cdfe470fab6f6b932a7e741630f0212a7f18249a61123e3b324edef"
  strings:
    $join = "JOIN" fullword
    $mode = "MODE" fullword
    $nick = "NICK" fullword
    $notice = "NOTICE" fullword
    $part = "PART" fullword
    $pass = "PASS" fullword
    $ping = "PING" fullword
    $pong = "PONG" fullword
    $privmsg = "PRIVMSG" fullword
    $user = "USER" fullword
  condition:
    $nick and $user and 2 of them
}
