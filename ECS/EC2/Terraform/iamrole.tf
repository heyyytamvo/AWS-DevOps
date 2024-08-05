# resource "aws_iam_role_policy" "fullaccess_s3_policy" {
#   name = "full_access_s3"
#   role = aws_iam_role.ec2_role.name

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "s3:*",
#       "Resource": [
#         "${aws_s3_bucket.s3bucket.arn}",
#         "${aws_s3_bucket.s3bucket.arn}/*"
#       ]
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role" "ec2_role" {
#   name = "ec2_role"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_instance_profile" "ec2_profile"{
#     name = "album_instance_profile"
#     role = aws_iam_role.ec2_role.name
# }