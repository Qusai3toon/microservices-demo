
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "rabbitmq_image" {
  default = "rabbitmq:3.6.8-management"
  description = "Image for the rabbitmq service"
}