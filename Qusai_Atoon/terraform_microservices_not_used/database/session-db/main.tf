resource "kubernetes_deployment" "session_db" {
  metadata {
    name      = "session-db"
    namespace = var.namespace
    labels = { name = "session-db" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "session-db" } }
    template {
      metadata { labels = { name = "session-db" } }
      spec {
        container {
          name  = "session-db"
          image = var.session_db_image
          port {
            container_port = 6379
            name           = "redis"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "session_db" {
  metadata {
    name      = "session-db"
    namespace = var.namespace
    labels = { name = "session-db" }
  }
  spec {
    selector = { name = "session-db" }
    port {
      port        = 6379
      target_port = 6379
    }
  }
}