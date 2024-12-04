resource "aws_ecs_service" "ecs_service" {
  name            = "my-fargate-service"
  cluster         = aws_ecs_cluster.demo-ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.demo-subnet.id]
    security_groups = [aws_security_group.demo-vpc-sg.id]
    assign_public_ip = true
  }
}
