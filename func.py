import io
import json
import subprocess

from fdk import response

image_tag = "iad.ocir.io/ostrain-dev/meta-test"

def handler(ctx, data: io.BytesIO=None):
    print("hello world")

    try:
        output = subprocess.check_output(["img", "build", "./build", "-t", image_tag])
    except Exception as ex:
        return response.Response(
            ctx, response_data=json.dumps(
                {
                    "error": "Failed to build image {0}: {1}".format(image_tag, str(ex)),
                }
            ),
            headers={"Content-Type": "application/json"}
        )

    return response.Response(
        ctx, response_data=json.dumps(
            {"message": "Built image {0}".format(image_tag)}
        ),
        headers={"Content-Type": "application/json"}
    )
