resource "aws_instance" "web-server-instance" {
   ami               = data.aws_ami.ubuntu-linux-2204.id
   instance_type     = var.instance_type
   availability_zone = var.aws_az
   instance_count    = var.instance_count
   key_name          = "nuvtask-key"

   network_interface {
     device_index         = 0
     network_interface_id = aws_network_interface.web-server-nic.id
     }

    # root disk
    root_block_device {
      volume_size           = var.linux_root_volume_size
      volume_type           = var.linux_root_volume_type
      delete_on_termination = true
      encrypted             = true
      }

    # extra disk
    ebs_block_device {
      device_name           = "nuvedb"
      volume_size           = var.linux_data_volume_size
      volume_type           = var.linux_data_volume_type
      encrypted             = true
      delete_on_termination = true
    }

   user_data = file("aws-user-data.sh")

   tags = {
     Name = "web-server"
   }
 }