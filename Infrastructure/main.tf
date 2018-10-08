//*************************Top Config*********************************

provider "aws" {
  region     = "us-east-1"
  access_key = "REMOVED"
  secret_key = "REMOVED"
  version    = "~> 1.1"
}

provider "archive" {
  version = "~> 1.0"
}

data "aws_region" "current" {
  current = true
}

data "aws_caller_identity" "current" {}

data "aws_acm_certificate" "lucidify" {
  domain = "*.lucidi.fi"
}

//*************************S3 Config**********************************

resource "aws_s3_bucket" "static_site_bucket" {
  bucket = "www.lucidi.fi"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
	"Sid":"PublicReadGetObject",
        "Effect":"Allow",
	  "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::www.lucidi.fi/*"
      ]
    }
  ]
}
EOF
}

// Cloudfront Distribution Config

resource "aws_cloudfront_distribution" "site_distribution" {
  enabled = true

  "origin" {
    domain_name = "${aws_s3_bucket.static_site_bucket.bucket_domain_name}"
    origin_id   = "lucidifyOrigin"
  }

  default_root_object = "index.html"
  aliases             = ["lucidi.fi", "www.lucidi.fi"]

  default_cache_behavior {
    allowed_methods = ["HEAD", "GET"]
    cached_methods  = ["HEAD", "GET"]
    default_ttl     = 0

    "forwarded_values" {
      "cookies" {
        forward = "all"
      }

      query_string = true
    }

    max_ttl                = 0
    min_ttl                = 0
    target_origin_id       = "lucidifyOrigin"
    viewer_protocol_policy = "redirect-to-https"
  }

  "restrictions" {
    geo_restriction {
      restriction_type = "none"
    }
  }

  "viewer_certificate" {
    acm_certificate_arn      = "${data.aws_acm_certificate.lucidify.arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

//*********************Primary DNS Config****************************

resource "aws_route53_record" "static_site_dns" {
  name    = "www.lucidi.fi"
  type    = "A"
  zone_id = "${data.aws_route53_zone.primary.zone_id}"

  alias {
    name                   = "${aws_cloudfront_distribution.site_distribution.domain_name}"
    evaluate_target_health = false
    zone_id                = "${aws_cloudfront_distribution.site_distribution.hosted_zone_id}"
  }
}

resource "aws_route53_record" "static_site_dns_2" {
  name    = "lucidi.fi"
  type    = "A"
  zone_id = "${data.aws_route53_zone.primary.zone_id}"

  alias {
    name                   = "${aws_cloudfront_distribution.site_distribution.domain_name}"
    evaluate_target_health = false
    zone_id                = "${aws_cloudfront_distribution.site_distribution.hosted_zone_id}"
  }
}

data "aws_route53_zone" "primary" {
  name = "lucidi.fi."
}

//**************************Gateway Config***********************************

resource "aws_api_gateway_rest_api" "lucidify" {
  name        = "Lucidify-API"
  description = "The Lucidify API"
}

resource "aws_iam_role" "api_executor" {
  name = "api-executor-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "api_executor_policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  role = "${aws_iam_role.api_executor.id}"
}

resource "aws_api_gateway_deployment" "lucidify_v1" {
  rest_api_id = "${aws_api_gateway_rest_api.lucidify.id}"
  stage_name  = "v1"
}

resource "aws_api_gateway_domain_name" "lucidify" {
  domain_name     = "api.lucidi.fi"
  certificate_arn = "${data.aws_acm_certificate.lucidify.arn}"
}

resource "aws_route53_record" "lucidify_api" {
  zone_id = "${data.aws_route53_zone.primary.id}"
  name    = "${aws_api_gateway_domain_name.lucidify.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_api_gateway_domain_name.lucidify.cloudfront_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.lucidify.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_api_gateway_base_path_mapping" "lucidify_v1" {
  api_id      = "${aws_api_gateway_rest_api.lucidify.id}"
  domain_name = "${aws_api_gateway_domain_name.lucidify.domain_name}"
  stage_name  = "${aws_api_gateway_deployment.lucidify_v1.stage_name}"
  base_path   = "${aws_api_gateway_deployment.lucidify_v1.stage_name}"
}

//**********************Lambda Config*******************************

resource "aws_lambda_permission" "from_apigw" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.api_login.function_name}"
  principal     = "apigateway.amazonaws.com"
  statement_id  = "AllowExecutionFromApiGatewayMethod"
  source_arn    = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.lucidify.id}/*/*/"
}

resource "aws_iam_policy_attachment" "lambda_vpc_policy" {
  name       = "lambda_vpc_policy"
  roles      = ["${aws_iam_role.api_lambda.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role" "api_lambda" {
  name = "api-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com", "apigateway.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "login_lambda_zip" {
  source_dir  = "lambdas/login"
  output_path = "login_lambda.zip"
  type        = "zip"
}

resource "aws_lambda_function" "api_login" {
  filename         = "${data.archive_file.login_lambda_zip.output_path}"
  function_name    = "login-lambda"
  role             = "${aws_iam_role.api_lambda.arn}"
  handler          = "login.lambda_handler"
  source_code_hash = "${data.archive_file.login_lambda_zip.output_base64sha256}"
  runtime          = "python3.6"

  vpc_config {
    security_group_ids = ["sg-37b46246"]
    subnet_ids         = ["subnet-ff10dff0", "subnet-a0a6e99f", "subnet-5c0d4173", "subnet-d2bd8db6", "subnet-0a357557", "subnet-1785905c"]
  }
}

data "archive_file" "recent_tracks_lambda_zip" {
  source_dir  = "lambdas/recent-tracks"
  output_path = "recent_tracks_lambda.zip"
  type        = "zip"
}

resource "aws_lambda_function" "api_recent_tracks" {
  filename         = "${data.archive_file.recent_tracks_lambda_zip.output_path}"
  function_name    = "recent-tracks-lambda"
  role             = "${aws_iam_role.api_lambda.arn}"
  handler          = "recent_tracks.lambda_handler"
  source_code_hash = "${data.archive_file.recent_tracks_lambda_zip.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = 30
  memory_size      = 512

  vpc_config {
    security_group_ids = ["sg-37b46246"]
    subnet_ids         = ["subnet-ff10dff0", "subnet-a0a6e99f", "subnet-5c0d4173", "subnet-d2bd8db6", "subnet-0a357557", "subnet-1785905c"]
  }
}

data "archive_file" "site_stats_lambda_zip" {
  source_dir  = "lambdas/site-stats"
  output_path = "site_stats_lambda.zip"
  type        = "zip"
}

resource "aws_lambda_function" "api_site_stats" {
  filename         = "${data.archive_file.site_stats_lambda_zip.output_path}"
  function_name    = "site-stats-lambda"
  role             = "${aws_iam_role.api_lambda.arn}"
  handler          = "site_stats.lambda_handler"
  source_code_hash = "${data.archive_file.site_stats_lambda_zip.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = 30
  memory_size      = 128

  vpc_config {
    security_group_ids = ["sg-37b46246"]
    subnet_ids         = ["subnet-ff10dff0", "subnet-a0a6e99f", "subnet-5c0d4173", "subnet-d2bd8db6", "subnet-0a357557", "subnet-1785905c"]
  }
}

//************************Gateway Endpoint Config*******************************

//**Login Endpoint**
resource "aws_api_gateway_resource" "login" {
  rest_api_id = "${aws_api_gateway_rest_api.lucidify.id}"
  parent_id   = "${aws_api_gateway_rest_api.lucidify.root_resource_id}"
  path_part   = "login"
}

resource "aws_api_gateway_method" "login_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.lucidify.id}"
  resource_id   = "${aws_api_gateway_resource.login.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "login_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.lucidify.id}"
  resource_id             = "${aws_api_gateway_resource.login.id}"
  http_method             = "${aws_api_gateway_method.login_get.http_method}"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.api_login.arn}/invocations"
  integration_http_method = "POST"
  credentials             = "${aws_iam_role.api_executor.arn}"
}

//**Recent Tracks Endpoint**
resource "aws_api_gateway_resource" "recent_tracks" {
  rest_api_id = "${aws_api_gateway_rest_api.lucidify.id}"
  parent_id   = "${aws_api_gateway_rest_api.lucidify.root_resource_id}"
  path_part   = "usermetrics"
}

resource "aws_api_gateway_method" "recent_tracks_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.lucidify.id}"
  resource_id   = "${aws_api_gateway_resource.recent_tracks.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "recent_tracks_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.lucidify.id}"
  resource_id             = "${aws_api_gateway_resource.recent_tracks.id}"
  http_method             = "${aws_api_gateway_method.recent_tracks_get.http_method}"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.api_recent_tracks.arn}/invocations"
  integration_http_method = "POST"
  credentials             = "${aws_iam_role.api_executor.arn}"
}

//**Site statistics endpoint**
resource "aws_api_gateway_resource" "site_stats" {
  rest_api_id = "${aws_api_gateway_rest_api.lucidify.id}"
  parent_id   = "${aws_api_gateway_rest_api.lucidify.root_resource_id}"
  path_part   = "stats"
}

resource "aws_api_gateway_method" "site_stats_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.lucidify.id}"
  resource_id   = "${aws_api_gateway_resource.site_stats.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "site_stats_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.lucidify.id}"
  resource_id             = "${aws_api_gateway_resource.site_stats.id}"
  http_method             = "${aws_api_gateway_method.site_stats_get.http_method}"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.api_site_stats.arn}/invocations"
  integration_http_method = "POST"
  credentials             = "${aws_iam_role.api_executor.arn}"
}

//*********************Database Config****************************************
resource "aws_db_instance" "default" {
  apply_immediately         = true
  allocated_storage         = 10
  storage_type              = "gp2"
  engine                    = "postgres"
  instance_class            = "db.t2.micro"
  identifier                = "lucidifydb"
  name                      = "LucidifyDB"
  username                  = "lucidify"
  password                  = "REMOVED"
  final_snapshot_identifier = "final-snap"
  publicly_accessible       = true
}
