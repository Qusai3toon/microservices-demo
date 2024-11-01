resource "kubernetes_deployment" "catalogue_db" {
  metadata {
    name      = "catalogue-db"
    namespace = var.namespace
    labels = { name = "catalogue-db" }
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { name = "catalogue-db" } }
    template {
      metadata { labels = { name = "catalogue-db" } }
      spec {
        container {
          name  = "catalogue-db"
          image = var.catalogue_db_image
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "fake_password"
          }
          env {
            name  = "MYSQL_DATABASE"
            value = "socksdb"
          }
          port { container_port = 3306 }
        }
      }
    }
  }
}

resource "kubernetes_service" "catalogue_db" {
  metadata {
    name      = "catalogue-db"
    namespace = var.namespace
    labels = { name = "catalogue-db" }
  }
  spec {
    selector = { name = "catalogue-db" }
    port {
      port        = 3306
      target_port = 3306
    }
  }
}