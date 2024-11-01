resource "kubernetes_deployment" "shipping" {
  metadata {
    name      = "shipping"
    namespace = var.namespace
    labels = { name = "shipping" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "shipping" } }
    template {
      metadata { labels = { name = "shipping" } }
      spec {
        container {
          name  = "shipping"
          image = var.shipping_image
          env {
            name  = "ZIPKIN"
            value = "zipkin.jaeger.svc.cluster.local"
          }
          env {
            name  = "JAVA_OPTS"
            value = "-Xms64m -Xmx128m -XX:+UseG1GC -Djava.security.egd=file:/dev/urandom -Dspring.zipkin.enabled=false"
          }
          resources {
            limits   = { cpu = "300m", memory = "500Mi" }
            requests = { cpu = "100m", memory = "300Mi" }
          }
          port { container_port = 80 }
        }
      }
    }
  }
}

resource "kubernetes_service" "shipping" {
  metadata {
    name      = "shipping"
    namespace = var.namespace
    labels = { name = "shipping" }
  }
  spec {
    selector = { name = "shipping" }
    port {
      port        = 80
      target_port = 80
    }
  }
}