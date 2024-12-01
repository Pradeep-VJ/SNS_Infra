#####################
## SNS Topics
#####################

resource "aws_sns_topic" "experian_file_notifications" {
  name = "experian_file_notifications"
  tags = {
    Owner        = "Pradeep_Reddy_B"
    Environment  = "QA"
  }
}

##############################
## Subscriptions
##############################

# Email Subscription for Nightly Batch
resource "aws_sns_topic_subscription" "experian_file_email" {
  topic_arn = aws_sns_topic.nightly_batch.arn
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
#       "arn:aws:sqs:us-east-1:123456789012:nightly_batch_notifications_queue"
#     ],
#     count.index
#   )
# }
