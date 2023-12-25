import json
import boto3
import botocore
import uuid
import random
import time
import string
from aws_xray_sdk.core import xray_recorder
from aws_xray_sdk.core import patch_all

patch_all()

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('xray-demo-table1')

def lambda_handler(event, context):
    i = random.randint(0, 99)
    status_code = 200
    if i < 5:
      return {
        "statusCode": 501,
      }
    elif i < 15:
      return {
        "statusCode": 400,
      }
    elif i < 50:
      time.sleep(random.randint(100, 300)/1000) 

    #body_str = event['body']
    
    #print(body_str)
    #body = json.loads(body_str)
    value = ''.join(random.choices(string.ascii_uppercase + string.digits, k=5))
    #print(json.dumps(body))
    uuid_str = str(uuid.uuid4())
    try:
        table.put_item(
                    Item={
                        "id": uuid_str,
                        "value": value
                    }
                )
    except botocore.exceptions.ClientError as err:
            raise
    response = {
        "isBase64Encoded": False,
        "statusCode": status_code,
        "headers": { "headerName": "headerValue" },
        "body": json.dumps({"uuid": uuid_str})
    }
    return response