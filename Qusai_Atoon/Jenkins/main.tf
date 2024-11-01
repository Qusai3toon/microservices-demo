provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = "jenkins"
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins_pvc" {
  metadata {
    name      = "jenkins-pvc"
    namespace = kubernetes_namespace.jenkins.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace.jenkins.metadata[0].name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "jenkins"
      }
    }
    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }
      spec {
        security_context {
          fs_group = 1000
          run_as_user = 1000 
        }
        container {
          name  = "jenkins"
          image = "jenkins/jenkins:lts"

          port {
            container_port = 8080
          }
          port {
            container_port = 50000
          }

          volume_mount {
            mount_path = "/var/jenkins_home"
            name       = "jenkins-storage"
          }
        }
        volume {
          name = "jenkins-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.jenkins_pvc.metadata[0].name
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace.jenkins.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.jenkins.spec[0].template[0].metadata[0].labels["app"]
    }
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30000
    }
    type = "NodePort"
  }
}
