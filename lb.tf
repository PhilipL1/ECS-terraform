resource "aws_lb" "lb" {
  name               = "${var.name}-lb"
  internal           = false // for public use so it generates a public ip (dont want to use it for interntal use -false )
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id, aws_security_group.docker.id]
  subnets            = [aws_subnet.main_pub.id, aws_subnet.second_pub.id]
  tags = {
    Name  = "${var.name}-lb"
    Owner = var.name
  }
}

//group that it send the traffic to 
resource "aws_lb_target_group" "target" {
  name     = "${var.name}-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name  = "${var.name}-target-group"
    Owner = var.name
  }
}

//someone rings the door bell do this 
//listen to http on port 80 then it will go to the target group defined in "default action" 
//from the target group it will go to the websoite on port 3000 specified 
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action { // when it gets it then do somthing 
    type             = "forward"
    target_group_arn = aws_lb_target_group.target.arn
  }
  tags = {
    Name  = "${var.name}-lb-listener"
    Owner = var.name
  }
}
