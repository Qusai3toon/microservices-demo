resource "kubernetes_deployment" "orders_db" {
  metadata {
    name      = "orders-db"
    namespace = var.namespace
    labels = { name = "orders-db" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "orders-db" } }
    template {
      metadata { labels = { name = "orders-db" } }
      spec {
        container {
          name  = "orders-db"
          image = var.orders_db_image
          resources {
            limits   = { cpu = "200m", memory = "300Mi" }
            requests = { cpu = "100m", memory = "150Mi" }
          }
          port { container_port = 27017 }
        }
      }
    }
  }
}

resource "kubernetes_service" "orders_db" {
  metadata {
    name      = "orders-db"
    namespace = var.namespace
    labels = { name = "orders-db" }
  }
  spec {
    selector = { name = "orders-db" }
    port {
      port        = 27017
      target_port = 27017
    }
  }
}