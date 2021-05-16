# Output for Launch Template
output "launch_template_id" {
  value = aws_launch_template.default_launch_template.id
}

# Output for ASG
output "aws_autoscaling_id" {
  value = aws_autoscaling_group.asg_via_launch_template.id
}
