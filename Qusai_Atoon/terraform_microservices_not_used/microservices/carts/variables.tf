
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

# Image Variables
variable "carts_image" {
  default = "weaveworksdemos/carts:0.4.8"
  description = "Image for the carts service"
}

variable "carts_db_image" {
  default = "mongo"
  description = "Image for the carts database service"
}