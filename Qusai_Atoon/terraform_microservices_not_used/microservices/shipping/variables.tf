
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "shipping_image" {
  default = "weaveworksdemos/shipping:0.4.8"
  description = "Image for the shipping service"
}