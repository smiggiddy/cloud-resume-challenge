#!/usr/bin/env python

import boto3
import os

TABLE = os.environ.get("TABLE")


def lambda_handler(event, context):
    """Updates visitor in dynamodb table

    :return visits

    """
    dynamodb = boto3.resource("dynamodb")

    table = dynamodb.Table(TABLE)

    response = table.update_item(
        Key={"SiteId": event.get("SiteId", "")},
        UpdateExpression="SET Visits = Visits + :newVisit",
        ExpressionAttributeValues={":newVisit": 1},
        ReturnValues="UPDATED_NEW",
    )
    visits = response["Attributes"]

    return visits
