#!/usr/bin/env python

import boto3

dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('counter')

table.put_item()
        
