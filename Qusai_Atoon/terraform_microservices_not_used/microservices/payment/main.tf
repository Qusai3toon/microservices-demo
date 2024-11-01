resource "kubernetes_deployment" "payment" {
  metadata {
    name      = "payment"
    namespace = var.namespace
    labels = { name = "payment" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "payment" } }
    template {
      metadata { labels = { name = "payment" } }
      spec {
        container {
          name  = "payment"
          image = var.payment_image
          resources {
            limits   = { cpu = "200m", memory = "200Mi" }
            requests = { cpu = "99m", memory = "100Mi" }
          }
          port { container_port = 80 }
        }
      }
    }
  }
}

resource "kubernetes_service" "payment" {
  metadata {
    name      = "payment"
    namespace = var.namespace
    labels = { name = "payment" }
  }
  spec {
    selector = { name = "payment" }
    port {
      port        = 80
      target_port = 80
    }
  }
}