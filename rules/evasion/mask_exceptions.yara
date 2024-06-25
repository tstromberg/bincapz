import "math"

private rule pythonSetup {
  strings:
    $i_distutils = "from distutils.core import setup"
    $i_setuptools = "from setuptools import setup"
    $setup = "setup("
    $not_setup_example = ">>> setup("
    $not_setup_todict = "setup(**config.todict()"
    $not_import_quoted = "\"from setuptools import setup"
    $not_setup_quoted = "\"setup(name="
    $not_distutils = "from distutils.errors import"
  condition:
    filesize < 131072 and $setup and any of ($i*) and none of ($not*)
}

rule py_no_fail : notable {
  meta:
    description = "Python code that hides exceptions"
    hash_2023_grandmask_3_13_setup = "8835778f9e75e6493693fc6163477ec94aba723c091393a30d7e7b9eed4f5a54"
    hash_2023_libgrandrandomintel_3_58_setup = "cd211e0f8d84100b1b4c1655e913f40a76beaacc482e751e3a7c7ed126fe1a90"
    hash_2023_py_guigrand_4_67_setup = "4cb4b9fcce78237f0ef025d1ffda8ca8bc79bf8d4c199e4bfc6eff84ce9ce554"
  strings:
    $e_short = /except:.{0,4}pass/ fullword
    $e_long = /except Exception as.{0,8}pass/ fullword
  condition:
    any of them
}

rule setuptools_no_fail : suspicious {
  meta:
    description = "Python library installer that hides exceptions"
  condition:
    pythonSetup and py_no_fail
}

rule php_disable_errors : medium {
  meta:
    description = "PHP code that disables error reporting"
    hash_2024_2024_Inull_Studio_err = "5dbab6891fefb2ba4e3983ddb0d95989cf5611ab85ae643afbcc5ca47c304a4a"
    hash_2024_2024_Inull_Studio_godzilla_xor_base64 = "699c7bbf08d2ee86594242f487860221def3f898d893071426eb05bec430968e"
    hash_2024_2024_S3RV4N7_SHELL_crot = "2332fd44e88a571e821cf2d12bab44b45e503bc705d1f70c53ec63a197e4bb1a"
  strings:
    $err_rep = "error_reporting(0)"
    $log_errs = /ini_set\(\Wlog_errors\W{0,4}0/
    $display_0 = /ini_set\(\Wdisplay_errors\W{0,4}0/
    $error_log = /ini_set\(\Werror_log\W{0,4}NULL/
    $display_off = /ini_set\(\Wdisplay_errors\W{0,4}Off/
    $display_false = /ini_set\(\Wdisplay_errors\W{0,4}FALSE/
  condition:
    1 of them
}
