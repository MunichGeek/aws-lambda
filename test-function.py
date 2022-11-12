import json


def lambda_handler(event, context):
    print("Hey! I just added this Lambda with Terraform")
    return {"statusCode": 200, "body": json.dumps("Hello from Lambda!")}
