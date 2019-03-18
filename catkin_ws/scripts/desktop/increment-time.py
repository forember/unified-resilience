#!/usr/bin/env python3

import datetime
import subprocess

def main():
    now = datetime.datetime.now()
    inc = datetime.timedelta(minutes=1)
    arg = (now + inc).isoformat(sep=" ", timespec="seconds")
    subprocess.run(["timedatectl", "set-time", arg])

if __name__ == "__main__":
    main()
