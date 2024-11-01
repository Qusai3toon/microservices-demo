output "carts_db_ready" {
  value = kubernetes_deployment.carts_db.metadata[0].name
}
