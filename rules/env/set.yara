rule setenv_putenv : harmless {
  strings:
	$setenv = "_setenv" fullword
	$putenv = "_putenv" fullword
  condition:
	any of them
}