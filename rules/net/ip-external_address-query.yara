rule iplookup_website {
  meta:
    hash_2023_stealer_hashbreaker = "016a1a4fe3e9d57ab0b2a11e37ad94cc922290d2499b8d96957c3ddbdc516d74"
    hash_2022_CloudMensis_WindowServer_2 = "b8a61adccefb13b7058e47edcd10a127c483403cf38f7ece126954e95e86f2bd"
  strings:
    $ipify = "ipify.org"
    $wtfismyip = "wtfismyip"
    $iplogger = "iplogger.org"
    $getjsonip = "getjsonip"
    $ipinfo = "ipinfo.io"
    $ipify_b = "ipify.org" base64
    $wtfismyip_b = "wtfismyip" base64
    $iplogger_b = "iplogger.org" base64
    $getjsonip_b = "getjsonip" base64
    $ipinfo_b = "ipinfo.io" base64
    $ipify_x = "ipify.org" xor(1-255)
    $wtfismyip_x = "wtfismyip" xor(1-255)
    $iplogger_x = "iplogger.org" xor(1-255)
    $getjsonip_x = "getjsonip" xor(1-255)
    $ipinfo_x = "ipinfo.io" xor(1-255)
  condition:
    any of them
}