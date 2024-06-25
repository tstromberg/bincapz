
rule reverse_shell : critical {
  meta:
    hash_2023_UPX_0c25a05bdddc144fbf1ffa29372481b50ec6464592fdfb7dec95d9e1c6101d0d_elf_x86_64 = "818b80a08418f3bb4628edd4d766e4de138a58f409a89a5fdba527bab8808dd2"
    hash_2023_OK_ad69 = "ad69e198905a8d4a4e5c31ca8a3298a0a5d761740a5392d2abb5d6d2e966822f"
    hash_2023_ciscotools_4247 = "42473f2ab26a5a118bd99885b5de331a60a14297219bf1dc1408d1ede7d9a7a6"
  strings:
    $bash_dev_tcp = "bash -i >& /dev/tcp/"
    $stdin_redir = "0>&1" fullword
    $reverse_shell = "reverse_shell"
    $reverse_space_shell = "reverse shell" nocase
    $revshell = "revshell"
  condition:
    any of them
}

rule mkfifo_netcat : critical {
  meta:
    description = "creates a reverse shell using mkfifo and netcat"
  strings:
    $mkfifo = "mkfifo" fullword
    $sh_i = "sh -i"
    $nc = /\| {0,2}nc /
  condition:
    filesize < 16384 and all of them
}

rule perl_reverse_shell : critical {
  meta:
    hash_2023_Win_Trojan_Perl_9aed = "9aed7ab8806a90aa9fac070fbf788466c6da3d87deba92a25ac4dd1d63ce4c44"
    hash_2023_uacert_socket = "912dc3aee7d5c397225f77e3ddbe3f0f4cf080de53ccdb09c537749148c1cc08"
  strings:
    $socket = "socket("
    $open = "open("
    $redir_double = "\">&"
    $redir_single = "'>&"
    $sh_i = "sh -i"
  condition:
    $socket and $open and any of ($redir*) and $sh_i
}

rule reverse_shell_ref : high {
  meta:
    description = "references a reverse shell"
    hash_2024_2024_Kaiji_eight_nebraska_autumn_illinois = "38edb3ab96a6aa6c3f4de3590dfb63ca44ddf29d5579ef3b12de326c86145537"
    hash_2024_2024_sagsooz = "9f1821dbc40edebf4291abb64abc349c3fdf75eece9820c67ea00adf1a25aed4"
    hash_2024_2024_sagsooz_bestmini = "a14563aaa8d069d2094709d1e0932a76d4c500f45c5ecde213565973e16b9e74"
  strings:
    $ = /(r[e3]v[e3]rs[e3]|w[3e]b|cmd)\s*sh[e3]ll/ nocase
  condition:
    any of them
}
