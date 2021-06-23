output "db_instance_endpoint" {
  value = aws_db_instance.coinsfast_db.address
}
output "db_instance_port" {
  value = aws_db_instance.coinsfast_db.port
}