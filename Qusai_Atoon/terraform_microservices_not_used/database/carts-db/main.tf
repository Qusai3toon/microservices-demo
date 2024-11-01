resource "kubernetes_deployment" "carts_db" {
  metadata {
    name      = "carts-db"
    namespace = var.namespace
    labels = { name = "carts-db" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "carts-db" } }
    template {
      metadata { labels = { name = "carts-db" } }
      spec {
        container {
          name  = "carts-db"
          image = var.carts_db_image
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

resource "kubernetes_service" "carts_db" {
  metadata {
    name      = "carts-db"
    namespace = var.namespace
    labels = { name = "carts-db" }
  }
  spec {
    selector = { name = "carts-db" }
    port {
      port        = 27017
      target_port = 27017
    }
  }
}