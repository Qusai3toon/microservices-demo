resource "kubernetes_deployment" "user" {
  metadata {
    name      = "user"
    namespace = var.namespace
    labels = { name = "user" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "user" } }
    template {
      metadata { labels = { name = "user" } }
      spec {
        container {
          name  = "user"
          image = var.user_image
          resources {
            limits   = { cpu = "300m", memory = "200Mi" }
            requests = { cpu = "100m", memory = "100Mi" }
          }
          port {
            container_port = 80
          }
          env {
            name  = "mongo"
            value = "user-db:27017"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user" {
  metadata {
    name      = "user"
    namespace = var.namespace
    labels = { name = "user" }
  }
  spec {
    selector = { name = "user" }
    port {
      port        = 80
      target_port = 80
    }
  }
}