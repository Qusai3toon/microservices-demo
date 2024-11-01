resource "kubernetes_deployment" "orders" {
  metadata {
    name      = "orders"
    namespace = var.namespace
    labels = { name = "orders" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "orders" } }
    template {
      metadata { labels = { name = "orders" } }
      spec {
        container {
          name  = "orders"
          image = var.orders_image
          env {
            name  = "JAVA_OPTS"
            value = "-Xms64m -Xmx128m -XX:+UseG1GC -Djava.security.egd=file:/dev/urandom -Dspring.zipkin.enabled=false"
          }
          resources {
            limits   = { cpu = "500m", memory = "500Mi" }
            requests = { cpu = "100m", memory = "300Mi" }
          }
          port { container_port = 80 }
        }
      }
    }
  }
}

resource "kubernetes_service" "orders" {
  metadata {
    name      = "orders"
    namespace = var.namespace
    labels = { name = "orders" }
  }
  spec {
    selector = { name = "orders" }
    port {
      port        = 80
      target_port = 80
    }
  }
}