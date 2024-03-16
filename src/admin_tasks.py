import os
import time

import boto3  # type: ignore


def invoke_restart_dashboard() -> dict[str, str | int]:
    if os.environ.get("ENV_TYPE") != "prod":
        time.sleep(3)
        return {
            "response_code": 200,
            "response_message": "Restarted Dashboard Successfully",
        }
    else:
        # pass
        lambda_client = boto3.client("lambda")
        response = lambda_client.invoke(
            FunctionName="shiny_dashboard_prod_lambda",
            InvocationType="RequestResponse",
            Payload="{}",
        )
        if response["StatusCode"] == 200:
            return {
                "response_code": response["StatusCode"],
                "response_message": "Restarted Dashboard Successfully",
            }
        else:
            return {
                "response_code": response["StatusCode"],
                "response_message": "An Error Occurred when Invoking the Restart Dashboard Lambda",
            }
