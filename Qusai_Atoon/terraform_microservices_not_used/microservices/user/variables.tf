
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "user_image" {
  default = "weaveworksdemos/user:0.4.7"
  description = "Image for the user service"
}