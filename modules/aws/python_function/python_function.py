import json

def lambda_handler(event, context):
    print(event)
    print("Hello_from_terraform")
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }