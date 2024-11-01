
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "front_end_image" {
  default = "weaveworksdemos/front-end:0.3.12"
  description = "Image for the front-end service"
}