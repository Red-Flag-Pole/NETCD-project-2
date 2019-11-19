output "instance_domain_name" {
  value       = [
    "${azurerm_public_ip.netcdTestingIP1.domain_name_label}",
    "${azurerm_public_ip.netcdTestingIP2.domain_name_label}"
  ]
  description = "The domain names for the public ips."
}
