resource "aws_launch_template" "default_launch_template" {
  name                   = var.lt_name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile
    content {
      arn = iam_instance_profile.value.arn
    }
  }
  user_data   = var.user_data
  description = var.lt_description
  tags        = merge(local.tags, var.lt_tags)
}

resource "aws_autoscaling_group" "asg_via_launch_template" {
  name                = var.asg_name
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]
  tags = concat([{
    key                 = "Managed_By"
    value               = "launch_template_${var.lt_name}"
    propagate_at_launch = true
  }], var.asg_tags)
  launch_template {
    id      = aws_launch_template.default_launch_template.id
    version = "$Latest"
  }
}