
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "session_db_image" {
  default = "redis:alpine"
  description = "Image for the session database service"
}