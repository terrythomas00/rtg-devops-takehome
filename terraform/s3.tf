
resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = local.s3_bucket_name

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  depends_on = [
  aws_s3_bucket_public_access_block.my_bucket_public_access_block]
  bucket = aws_s3_bucket.my_bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MyBucketPolicy",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.my_bucket.arn}/*"
    }
  ]
}
POLICY
}


