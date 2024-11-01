resource "kubernetes_deployment" "rabbitmq" {
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace
    labels = { name = "rabbitmq" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "rabbitmq" } }
    template {
      metadata { labels = { name = "rabbitmq" } }
      spec {
        container {
          name  = "rabbitmq"
          image = var.rabbitmq_image
          port {
            container_port = 15672
            name           = "management"
          }
          port {
            container_port = 5672
            name           = "rabbitmq"
          }
        }
        container {
          name  = "rabbitmq-exporter"
          image = "kbudde/rabbitmq-exporter"
          port {
            container_port = 9090
            name           = "exporter"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "rabbitmq" {
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace
    labels = { name = "rabbitmq" }
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port"   = "9090"
    }
  }
  spec {
    selector = { name = "rabbitmq" }
    port {
      port        = 5672
      target_port = 5672
      name        = "rabbitmq"
    }
    port {
      port        = 9090
      target_port = 9090
      name        = "exporter"
    }
  }
}