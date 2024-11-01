
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "user_db_image" {
  default = "weaveworksdemos/user-db:0.3.0"
  description = "Image for the user database service"
}