#####################
## SNS Topics
#####################

resource "aws_sns_topic" "experian_inbound_sns" {
  name = "experian_inbound_file_notifications"
  tags = {
    Owner        = "Pradeep_Reddy_B"
    Environment  = "QA"
  }
}

##############################
## Subscriptions
##############################

# Email Subscription for Experian Files
resource "aws_sns_topic_subscription" "experian_inbound_email" {
  topic_arn = aws_sns_topic.experian_inbound_sns.arn
  protocol  = "email"
  endpoint  = "pradeepbyreddy140298@gmail.com"
}

# resource "aws_sns_topic_subscription" "experian_file_subscriptions" {
#   count    = 2
#   topic_arn = aws_sns_topic.experian_file_notifications.arn
#   protocol  = element(["email", "sqs"], count.index)
#   endpoint  = element(
#     [
#       "pradeepbyreddy140298@gmail.com",
#       "arn:aws:sqs:us-east-1:123456789012:experian_file_notifications_queue"
#     ],
#     count.index
#   )
# }

##########################
## SNS Topic Policy
##########################

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.experian_inbound_sns.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.experian_inbound_sns.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn": "arn:aws:s3:::inbound-astra-files"
          }
        }
      }
    ]
  })
}
