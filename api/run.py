from flask import Flask
from flask import request
import os
import json

app = Flask(__name__)

APPS_LIST_PATH = "/".join(os.path.realpath(os.path.dirname(__file__)).split("/")[:-1]) + "/resources/app_list.json"


@app.route('/getAllApps')
def get_all_apps():
    try:
        if request.method == "GET":
            with open(APPS_LIST_PATH, 'r') as appsList:
                appsList = json.loads(appsList.read())
                return appsList, 200
        else:
            return "Method not allowed", 400
    except Exception as e:
        return "Error while getting all apps: {err}".format(err=str(e)), 400


@app.route('/getPackageByName')
def get_package_by_name():
    try:
        if request.method == "GET":
            app_name = request.args.get('app_name')
            with open(APPS_LIST_PATH, 'r') as appsList:
                appsList = json.loads(appsList.read())
                for item in appsList:
                    if item['name'] == app_name:
                        return json.dumps(item), 200
                return "No package found with name {name}".format(name=app_name), 400
        else:
            return "Method not allowed", 400
    except Exception as e:
        return "Error while getting all apps: {err}".format(err=str(e)), 400


def main():
    app.run(port=8745, debug=True)


if __name__ == "__main__":
    main()
