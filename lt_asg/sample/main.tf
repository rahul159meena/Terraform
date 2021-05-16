module "lt_and_asg" {
  # details for launch template
  source                 = "git::ssh://gitlab.com/ot-client/docasap/tf-modules/asg_lt"
  lt_name                = var.launch_template_name
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  lt_tags                = var.additional_tags
  iam_instance_profile = [{
    arn = var.iam_instance_profile_arn
  }]
  lt_description = var.lt_description
  user_data      = filebase64("../script.sh")

  # details for auto scaling group
  asg_name         = var.asg_name
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  subnet_ids       = var.pvt_subnet_ids
  asg_tags         = var.additional_tags_asg
  target_group_arn = var.target_group_arn
}
