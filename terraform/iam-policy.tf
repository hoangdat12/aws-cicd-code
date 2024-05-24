resource "aws_iam_role_policy" "execution_policy" {
  name   = "ECS-execution-policy"
  role   = aws_iam_role.execution_role.id
  policy = file("${path.module}/policies/execution-policy.json")
}

resource "aws_iam_role_policy" "task_policy" {
  name   = "ECS-task-policy"
  role   = aws_iam_role.task_role.id
  policy = file("${path.module}/policies/task-policy.json")
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "codebuild-policy"
  role   = aws_iam_role.codebuild_role.id
  policy = file("${path.module}/policies/codebuild-policy.json")
}

resource "aws_iam_role_policy" "codedeploy_policy" {
  name   = "codedeploy-policy"
  role   = aws_iam_role.codedeploy_role.id
  policy = file("${path.module}/policies/codedeploy-policy.json")
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline-policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = file("${path.module}/policies/codepipeline-policy.json")
}


resource "aws_iam_role_policy" "codedeploy_access_cloudformation_policy" {
  name   = "codepipeline-access-cloudformation-policy"
  role   = aws_iam_role.codedeploy_access_cloudformation_role.id
  policy = file("${path.module}/policies/codepipeline-access-cloudformation-policy.json")
}

