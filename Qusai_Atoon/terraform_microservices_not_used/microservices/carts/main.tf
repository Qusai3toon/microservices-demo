resource "kubernetes_deployment" "carts" {
  metadata {
    name      = "carts"
    namespace = var.namespace
    labels = { name = "carts" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "carts" } }
    template {
      metadata { labels = { name = "carts" } }
      spec {
        container {
          name  = "carts"
          image = var.carts_image
          resources {
            limits   = { cpu = "300m", memory = "500Mi" }
            requests = { cpu = "100m", memory = "200Mi" }
          }
          port { container_port = 80 }
          env {
            name  = "JAVA_OPTS"
            value = "-Xms64m -Xmx128m -XX:+UseG1GC -Djava.security.egd=file:/dev/urandom -Dspring.zipkin.enabled=false"
          }
        }
      }
    }
  }
}