#provider "aws" {
 # region = "us-west-1" # Set your desired AWS region here
#}
# Create an ALB
resource "aws_lb" "my_lb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet03.id, aws_subnet.subnet04.id] # Specify the subnet IDs for the ALB
#  enable_deletion_protection = false # Set to true if you want to enable deletion protection
#  enable_http2       = true # Optional: Enable HTTP/2
#  idle_timeout       = 60   # Optional: Adjust the idle timeout as needed
#  enable_cross_zone_load_balancing = true # Optional: Enable cross-zone load balancing
}

# Create a target group
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id # Specify your VPC ID
  target_type = "ip"

   health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }
}

# Create a listener for the ALB
#resource "aws_lb_listener" "my_listener" {
 # load_balancer_arn = aws_lb.my_lb.arn
 # port              = 80
 # protocol          = "HTTP"

  #default_action {
   # target_group_arn = aws_lb_target_group.my_target_group.arn
   # type             = "fixed-response"
   # fixed_response {
    #  content_type    = "text/plain"
     # status_code     = "200"
    #  message_body    = "OK"
   # }
#  }
#}

#associating target group with ALB
#resource "aws_lb_target_group_attachment" "my_attachment" {
#  target_group_arn  = aws_lb_target_group.my_target_group.arn
#  target_id         = aws_ecs_task_definition.example_task.arn # Replace with the appropriate target ID (e.g., instance or Fargate task ARN)
#}

#resource "aws_lb_target_group_attachment" "my_attachment" {
 # target_group_arn  = aws_lb_target_group.my_target_group.arn
 # target_id         = aws_ecs_service.example_service.cluster
 # port              = 80
#}

#creating cluster
resource "aws_ecs_cluster" "example_cluster" {
  name = "cluster-fargate"
}

#create an ECS task definition
resource "aws_ecs_task_definition" "example_task" {
family                   = "example-task"
network_mode             = "awsvpc" # Use awsvpc network mode for Fargate

 execution_role_arn = "arn:aws:iam::318988877498:role/ecsTaskExecutionRole" # Specify the ECS task execution role ARN

  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" # Set your desired CPU units
  memory                   = "0.5GB" # Set your desired memory

  container_definitions = jsonencode([
    {
      name  = "example-container"
      image = "nginx:latest" # Set your desired Docker image here
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
    # Add more container definitions as needed
  ])
}

#create ecs service
resource "aws_ecs_service" "example_service" {
  name            = "example-service"
  cluster         = aws_ecs_cluster.example_cluster.id
  task_definition = aws_ecs_task_definition.example_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
#  load_balancer   = aws_lb.my_lb.id
 # role            = aws_iam_role.ecs_service_role.name # Make sure this points to the correct role

  network_configuration {
    subnets = ["subnet-02bd91d4f14332a2a"] # Specify your subnet IDs
  #  assign_public_ip = "ENABLED"
  }
 load_balancer {
     target_group_arn = aws_lb_target_group.my_target_group.arn # Specify your target group ARN
     container_name   = "example-container"
     container_port   = 80
  }
}
 # Extract the task definition ARN for the Fargate task
#data "aws_ecs_task_definition" "example_task" {
 # task_definition = aws_ecs_task_definition.example_task.family # Use a unique identifier here

#}

# Associating the target group with the ALB
resource "aws_lb_target_group_attachment" "my_attachment" {
  target_group_arn  = aws_lb_target_group.my_target_group.arn
  target_id         = aws_ecs_service.example_service.cluster
  port              = 80
}
