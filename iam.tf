resource "aws_iam_role" "ecs" { //create the iam role 
  name = "ecs-instance-role-${var.name}"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs" {
  role       = aws_iam_role.ecs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role" //attach a policy 
}

resource "aws_iam_instance_profile" "ecs" {
  role = aws_iam_role.ecs.name //create an account 
}
