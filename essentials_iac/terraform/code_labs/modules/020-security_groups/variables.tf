variable "ec2_allow_ports" {
  description = "Puertos permitidos"
  type = list(number)
  default = [22,80,443]
}
