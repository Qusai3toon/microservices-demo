resource "kubernetes_deployment" "queue_master" {
  metadata {
    name      = "queue-master"
    namespace = var.namespace
    labels = { name = "queue-master" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "queue-master" } }
    template {
      metadata { labels = { name = "queue-master" } }
      spec {
        container {
          name  = "queue-master"
          image = var.queue_master_image
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

resource "kubernetes_service" "queue_master" {
  metadata {
    name      = "queue-master"
    namespace = var.namespace
    labels = { name = "queue-master" }
  }
  spec {
    selector = { name = "queue-master" }
    port {
      port        = 80
      target_port = 80
    }
  }
}