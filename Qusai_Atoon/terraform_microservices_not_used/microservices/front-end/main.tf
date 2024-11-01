resource "kubernetes_deployment" "front_end" {
  metadata {
    name      = "front-end"
    namespace = var.namespace
    labels = { name = "front-end" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "front-end" } }
    template {
      metadata { labels = { name = "front-end" } }
      spec {
        container {
          name  = "front-end"
          image = var.front_end_image
          resources {
            limits   = { cpu = "300m", memory = "1000Mi" }
            requests = { cpu = "100m", memory = "300Mi" }
          }
          port { container_port = 8079 }
          env {
            name  = "SESSION_REDIS"
            value = "true"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "front_end" {
  metadata {
    name      = "front-end"
    namespace = var.namespace
    labels = { name = "front-end" }
  }
  spec {
    selector = { name = "front-end" }
    type     = "NodePort"
    port {
      port        = 80
      target_port = 8079
      node_port   = 30001
    }
  }
}