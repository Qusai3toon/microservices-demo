
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "catalogue_image" {
  default = "weaveworksdemos/catalogue:0.3.5"
  description = "Image for the catalogue service"
}