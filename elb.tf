# Create a new load balancer
resource "aws_elb" "demo-lb" {
  availability_zones = var.aws_az

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.web-server-instance]
  cross_zone_load_balancing   = true
  idle_timeout                = 40
 
  tags = {
    Name = "nuvei-demo-elb"
  }
}