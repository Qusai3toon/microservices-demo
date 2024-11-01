
variable "namespace" {
  default = "sock-shop"
  description = "Namespace for the sock-shop application"
}

variable "replicas" {
  default = 1
  description = "Number of replicas for deployment"
}

variable "queue_master_image" {
  default = "weaveworksdemos/queue-master:0.3.1"
  description = "Image for the queue-master service"
}