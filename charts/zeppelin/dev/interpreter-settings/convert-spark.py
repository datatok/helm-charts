import json
import yaml

str = open("spark-settings.json")
dd = json.load(str)

buffer = {}

for k, v in dd.items():
    buffer[k] = {
        "description" : v["description"],
        "value" : v["defaultValue"],
        "type" : v["type"]
    }

print(yaml.dump(buffer))
