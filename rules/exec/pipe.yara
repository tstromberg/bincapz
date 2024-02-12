rule popen {
	meta:
		description = "Uses popen to launch a program and pipe output to/from it"
		syscall = "pipe"
	strings:
		$_popen = "_popen" fullword
		$_pclose = "_pclose" fullword
	condition:
		any of them
}
