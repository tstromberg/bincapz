
rule base64_python_functions : critical {
  meta:
    description = "contains base64 Python code"
    hash_2023_0xShell_0xencbase = "50057362c139184abb74a6c4ec10700477dcefc8530cf356607737539845ca54"
    hash_2023_0xShell_wesobase = "17a1219bf38d953ed22bbddd5aaf1811b9380ad0535089e6721d755a00bddbd0"
    hash_2024_static_demonizedshell_static = "b4e65c01ab90442cb5deda26660a3f81bd400c205e12605536483f979023aa15"
  strings:
    $b64decode = "base64.b64decode" base64
    $decode = "decode()" base64
    $eval = "eval(" base64
    $exc = "except Exception as" base64
    $exec = "exec(" base64
    $import = "__import__" base64
    $importlib = "importlib" base64
    $import_module = "import_module" base64
    $import_os = "import os" base64
	$python = "python" base64
    $read = "read()" base64
    $requests_get = "requests.get" base64
    $thread = "threading.Thread" base64
    $urllib = "urllib.request" base64
    $urlopen = "urlopen" base64
  condition:
    2 of them
}
