
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "orders_image" {
  default = "weaveworksdemos/orders:0.4.7"
  description = "Image for the orders service"
}