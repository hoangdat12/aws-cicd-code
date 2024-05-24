resource "aws_iam_role" "execution_role" {
  name               = "ECS-execution-role"
  assume_role_policy = file("${path.module}/roles/execution-role.json")
}

resource "aws_iam_role" "task_role" {
  name               = "ECS-task-role"
  assume_role_policy = file("${path.module}/roles/task-role.json")
}

resource "aws_iam_role" "codebuild_role" {
  name               = "codebuild-role"
  assume_role_policy = file("${path.module}/roles/codebuild-role.json")
}

resource "aws_iam_role" "codedeploy_role" {
  name               = "codedeploy-role"
  assume_role_policy = file("${path.module}/roles/codedeploy-role.json")
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "codepipeline-role"
  assume_role_policy = file("${path.module}/roles/codepipeline-role.json")
}

resource "aws_iam_role" "codedeploy_access_cloudformation_role" {
  name               = "codepipeline-access-cloudformation-role"
  assume_role_policy = file("${path.module}/roles/codedeploy-access-cloudformation-role.json")
}