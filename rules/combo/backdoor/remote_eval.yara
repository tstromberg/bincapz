import "math"

rule remote_eval : critical {
  meta:
    description = "Evaluates remotely sourced code"
    hash_2019_restclient_request = "ba46608e52a24b7583774ba259cf997c6f654a398686028aad56855a2b9d6757"
  strings:
    $http = "http"
    $eval_open_ruby = /eval\(open[\(\)\"\'\-\w:\/\.]{0,32}/
    $exec_requests = /exec\(requests\.get[\(\)\"\'\-\w:\/\.]{0,32}/
    $eval_requests = /eval\(requests\.get[\(\)\"\'\-\w:\/\.]{0,32}/
  condition:
    filesize < 65535 and $http and any of ($e*)
}

rule remote_eval_close : critical {
  meta:
    description = "Evaluates remotely sourced code"
    hash_2019_active_controller_middleware = "9a85e7aee672b1258b3d4606f700497d351dd1e1117ceb0e818bfea7922b9a96"
    hash_2023_1_1_6_payload = "cbe882505708c72bc468264af4ef5ae5de1b75de1f83bba4073f91568d9d20a1"
    hash_2023_0_0_7_payload = "bb6ca6bfd157c39f4ec27589499d3baaa9d1b570e622722cb9bddfff25127ac9"
  strings:
    $eval = "eval("
    $header = /(GET|POST|COOKIE|cookie)/
  condition:
    math.max(@header, @eval) - math.min(@header, @eval) < 96
}

rule python_exec_near_requests : critical {
  meta:
    description = "Executes code from encrypted remote content"
  strings:
    $exec = "exec("
    $requests = "requests.get"
  condition:
    all of them and math.abs(@requests - @exec) <= 256
}

rule python_eval_near_requests : critical {
  meta:
    description = "Evaluates code from encrypted remote content"
  strings:
    $eval = "eval("
    $requests = "requests.get"
  condition:
    all of them and math.abs(@requests - @eval) <= 256
}

rule python_exec_near_get : critical {
  meta:
    description = "Executes code from encrypted content"
    hash_2024_2024_d3duct1v_xfilesyncerx = "b87023e546bcbde77dae065ad3634e7a6bd4cc6056167a6ed348eee6f2a168ae"
  strings:
    $exec = "exec("
    $requests = /[a-z]{1,4}.get\(/ fullword
  condition:
    all of them and math.abs(@requests - @exec) <= 32
}

rule python_eval_near_get : critical {
  meta:
    description = "Executes code from encrypted content"
  strings:
    $eval = "eval("
    $requests = /[a-z]{1,4}.get\(/ fullword
  condition:
    all of them and math.abs(@requests - @eval) <= 32
}

rule php_remote_exec : critical {
  meta:
    description = "Executes code from a remote source"
    credit = "Inspired by DodgyPHP rule in php-malware-finder"
    hash_2024_2024_Inull_Studio_godzilla_xor_base64 = "699c7bbf08d2ee86594242f487860221def3f898d893071426eb05bec430968e"
    hash_2024_2024_malcure_simple = "b52dd01d1f1416820108af0be32067e8990e076bf8f917a40a61c919e89e5551"
    hash_2023_0xShell = "acf556b26bb0eb193e68a3863662d9707cbf827d84c34fbc8c19d09b8ea811a1"
  strings:
    $php = "<?php"
    $f_execution = /\b(popen|eval|assert|passthru|exec|include|system|pcntl_exec|shell_exec|base64_decode|`|array_map|ob_start|call_user_func(_array)?)\s*\(\s*(base64_decode|php:\/\/input|str_rot13|gz(inflate|uncompress)|getenv|pack|\\?\$_(GET|REQUEST|POST|COOKIE|SERVER))/ nocase
    $f_execution2 = /\b(array_filter|array_reduce|array_walk(_recursive)?|array_walk|assert_options|uasort|uksort|usort|preg_replace_callback|iterator_apply)\s*\(\s*[^,]+,\s*(base64_decode|php:\/\/input|str_rot13|gz(inflate|uncompress)|getenv|pack|\\?\$_(GET|REQUEST|POST|COOKIE|SERVER))/ nocase
    $f_execution3 = /\b(array_(diff|intersect)_u(key|assoc)|array_udiff)\s*\(\s*([^,]+\s*,?)+\s*(base64_decode|php:\/\/input|str_rot13|gz(inflate|uncompress)|getenv|pack|\\?\$_(GET|REQUEST|POST|COOKIE|SERVER))\s*\[[^]]+\]\s*\)+\s*;/ nocase
    $f_register_function = /register_[a-z]+_function\s*\(\s*['"]\s*(eval|assert|passthru|exec|include|system|shell_exec|`)/
  condition:
    filesize < 1048576 and $php and any of ($f*)
}
