#!/usr/bin/env python
#http://rpicamera.local/html/status_mjpeg.php?last=halted
#http://rpicamera.local/html/status_mjpeg.php?last=ready
#http://rpicamera.local/html/cam_pic.php?time=1494172204126&pDelay=40000
#http://rpicamera.local/html/cmd_pipe.php?cmd=ru%200
import requests, os, sys

def CreateFIFO():
    ""

    path = "/tmp/my_program.fifo"
    if isfile(path) == False: open(path, 'a').close()
    fifo = open(path, "r+")

    return fifo


def TurnOff(sess):
    ""
    r = sess.get('http://rpicamera.local/html/cmd_pipe.php?cmd=ru%200', headers={'x-test2': 'true'})
    print(r.content)
    return True


f = CreateFIFO()
while True:
    for line in fifo:
        print("Received: " + line)

f.close()

s = requests.Session()
s.auth = ('surveiller', '5odRziMXq2TosG9')
s.headers.update({'x-test': 'true'})
TurnOff(s)
#print(r.text)
