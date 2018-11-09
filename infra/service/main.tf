/*
 * Create security group for public HTTPS access
 */
resource "aws_security_group" "public_http" {
  name        = "public-http"
  description = "Allow HTTPS traffic from public"
  vpc_id      = "${data.terraform_remote_state.shared.vpc_id}"
}

resource "aws_security_group_rule" "public_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.public_http.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

/*
 * Create application load balancer
 */
resource "aws_alb" "alb" {
  name            = "alb-testmicroservices"
  internal        = false
  security_groups = ["${data.terraform_remote_state.shared.vpc_default_sg_id}", "${aws_security_group.public_http.id}"]
  subnets         = ["${data.terraform_remote_state.shared.public_subnet_ids}"]
}

//resource "aws_app_cookie_stickiness_policy" "cookie_policy" {
//  name                     = "cookie-policy"
//  load_balancer            = "${aws_alb.alb.name}"
//  lb_port                  = 80
//  cookie_name   = "JSESSIONID"
//}
/*
 * Create target group for ALB
 */
resource "aws_alb_target_group" "default" {
  name     = "tg-testmicroservices"
  deregistration_delay = 30
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.shared.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }


  health_check {
    healthy_threshold = 2
    interval = 10
    path = "/greeting"
    matcher = "200"
    timeout = 5
    unhealthy_threshold = 6
  }

}

/*
 * Create listeners to connect ALB to target group
 */
resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
//  ssl_policy        = "ELBSecurityPolicy-2016-08"
//  certificate_arn   = "${data.aws_acm_certificate.sslcert.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.default.arn}"
    type             = "forward"
  }
}

/*
 * Render task definition from template
 */
data "template_file" "task_def" {
  template = "${file("${path.module}/task-definition.json")}"

//  vars {
//    mysql_host = "${aws_db_instance.db_instance.address}"
//    hostname   = "https://${aws_alb.alb.dns_name}/"
//  }
}

/*
 * Create task definition
 */
resource "aws_ecs_task_definition" "td" {
  family                = "mpass"
  container_definitions = "${data.template_file.task_def.rendered}"
  network_mode          = "bridge"
}

/*
 * Create ECS Service
 */
resource "aws_ecs_service" "service" {
  name                               = "mpass"
  cluster                            = "${data.terraform_remote_state.shared.ecs_cluster_name}"
  desired_count                      = "1" // "${length(data.terraform_remote_state.shared.aws_zones)}"
  iam_role                           = "${data.terraform_remote_state.shared.ecsServiceRole_arn}"
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "50"

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.default.arn}"
    container_name   = "web"
    container_port   = "8080"
  }

  task_definition = "${aws_ecs_task_definition.td.family}:${aws_ecs_task_definition.td.revision}"
}

/*
 * Create DNS record
 */
resource "aws_route53_record" "mpass" {
  zone_id = "Z168GZSMJJ99XF"
  name    = "mpass"
  records   = ["${aws_alb.alb.dns_name}"]
  type    = "CNAME"
  ttl     = 300
}
