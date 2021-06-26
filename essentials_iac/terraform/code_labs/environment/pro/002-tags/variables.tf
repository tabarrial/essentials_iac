variable "tg_region" {
  description = "Region AWS"
  type        = string
  default     = "null"
}
variable "tg_customer" {
  description = "Cliente"
  type        = string
  default     = "null"
}
variable "tg_project" {
  description = "Proyecto"
  type        = string
  default     = "null"
}
variable "tg_enviroment" {
  description = "Entorno"
  type        = string
  default     = "null"
}
variable "tg_version" {
  description = "Version (fecha)"
  type        = string
  default     = "null"
}
variable "tg_service" {
  description = "Servicio"
  type        = string
  default     = "null"
}
variable "tg_security" {
  description = "Seguridad del recurso"
  type        = string
  default     = "NoSec"
}
variable "tg_analyzed" {
  description = "Analisis equipo de seguridad"
  type        = string
  default     = "No"
}
variable "tg_encrypted" {
  description = "Indica si los datos estan cifrados o no"
  type        = string
  default     = "No"
}
variable "tg_provisionedBy" {
  description = "Se indica la tecnologia que provisiona el recurso"
  type        = string
  default     = "null"
}
variable "tg_backup" {
  description = "Si el recurso tiene backup"
  type        = string
  default     = "null"
}
variable "tg_scheduledPowerOff" {
  description = "Si el recurso se apaga"
  type        = string
  default     = "null"
}
