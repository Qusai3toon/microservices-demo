
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}
variable "payment_image" {
  default = "weaveworksdemos/payment:0.4.3"
  description = "Image for the payment service"
}