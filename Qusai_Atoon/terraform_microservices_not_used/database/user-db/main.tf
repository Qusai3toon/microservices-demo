resource "kubernetes_deployment" "user_db" {
  metadata {
    name      = "user-db"
    namespace = var.namespace
    labels = { name = "user-db" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "user-db" } }
    template {
      metadata { labels = { name = "user-db" } }
      spec {
        container {
          name  = "user-db"
          image = var.user_db_image
          port {
            container_port = 27017
            name           = "mongo"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user_db" {
  metadata {
    name      = "user-db"
    namespace = var.namespace
    labels = { name = "user-db" }
  }
  spec {
    selector = { name = "user-db" }
    port {
      port        = 27017
      target_port = 27017
    }
  }
}