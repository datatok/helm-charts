import json
import yaml

str = open("interpreter-settings.json")
dd = json.load(str)

interpreters = [v for k, v in dd["interpreterSettings"].items()]

print(yaml.dump(interpreters))
