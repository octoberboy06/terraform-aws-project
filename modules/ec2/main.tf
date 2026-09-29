resource "aws_instance" "this" {
  count = length(var.subnet_ids)

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]

  vpc_security_group_ids = var.security_group_ids

  associate_public_ip_address = false

  key_name = var.key_name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size

    encrypted = true
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-${count.index + 1}"
    }
  )
}