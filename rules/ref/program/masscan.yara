
rule masscan : medium {
  meta:
    hash_2023_Linux_Malware_Samples_1d28 = "1d2800352e15175ae5fa916b48a96b26f0199d9f8a9036648b3e44aa60ed2897"
    hash_2023_Linux_Malware_Samples_5a62 = "5a628dc26dae0309941d70021cfbb4281189f85b074bf3e696058d73c4609101"
    hash_2023_Linux_Malware_Samples_d13f = "d13fd21514f7ee5e58343aa99bf551c6a56486731c50daefcce233fdb162def8"
  strings:
    $ref = "masscan" fullword
  condition:
    $ref
}

rule masscan_config {
  meta:
    ref = "https://cert.gov.ua/article/6123309"
  strings:
    $adapter_ip = "adapter-ip"
    $nocapture = "nocapture"
    $output_format = "output-format"
    $randomize_hosts = "randomize-hosts"
  condition:
    75% of them
}
