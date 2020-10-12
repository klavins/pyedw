import pandas as pd
import subprocess
import re
import getpass
import os

def kinit():
    user = input("Enter UW NetID: ")
    pw = getpass.getpass("Enter Password: ")
    cmd = "echo '" + pw + "' | kinit " + user
    result = os.system(cmd)
    if result != 0:
        print("kinit failed. Are you logged into the UW VPN?")
    else:
        print("authenticated")

def kdestroy():
    os.system("kdestroy -A")

def run_sqlcmd(str, db):
    result = subprocess.run(

          [
            "/opt/mssql-tools/bin/sqlcmd", 
            "-E",
            "-S",
            "edwpub.s.uw.edu",
            "-Q",
            str,
            "-s|",
            "-d",
            db
          ], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if result.returncode == 1:
        print("sqlcmd failed. Are you logged into the UW VPN? Did you run kinit?\n\n")
        print(result.stdout.decode('utf-8'))
        raise RuntimeError
    else:
        return result

def str_query(str, db, debug=False):
    result = run_sqlcmd(str,db)
    if debug:
        print("query:\n-------------------\n", str)
        print("\nraw results:\n-------------------")
        print(result.stdout.decode('utf-8'))

    rows = result.stdout.decode('utf-8').split("\n")
    if result.stderr:
        print(result.stderr.decode('utf-8'))
    rows = [ [val.strip() for val in row.split("|")] for row in rows]
    keys = rows[0]
    rows = rows[2:-3]
    return pd.DataFrame(rows,columns=keys)

def query(file,db,subs={},debug=False):
    path = "/home/jovyan/work/queries/" + file
    if debug:
        print("query path::\n-------------------\n", path,"\n")    
    f = open(path, "r")
    q = f.read()
    for key in subs:
        expr = re.compile("@"+key)
        q = re.sub(expr,subs[key],q)
    return str_query(q,db,debug)