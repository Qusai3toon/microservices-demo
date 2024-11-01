resource "kubernetes_deployment" "catalogue" {
  metadata {
    name      = "catalogue"
    namespace = var.namespace
    labels = { name = "catalogue" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "catalogue" } }
    template {
      metadata { labels = { name = "catalogue" } }
      spec {
        container {
          name  = "catalogue"
          image = var.catalogue_image
          command = ["/app"]
          args = ["-port=80"]
          resources {
            limits   = { cpu = "200m", memory = "200Mi" }
            requests = { cpu = "100m", memory = "100Mi" }
          }
          port { container_port = 80 }
        }
      }
    }
  }
}



resource "kubernetes_service" "catalogue" {
  metadata {
    name      = "catalogue"
    namespace = var.namespace
    labels = { name = "catalogue" }
  }
  spec {
    selector = { name = "catalogue" }
    port {
      port        = 80
      target_port = 80
    }
  }
}