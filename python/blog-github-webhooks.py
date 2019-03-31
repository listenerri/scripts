#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from http.server import BaseHTTPRequestHandler
from http.server import HTTPServer
import os
import subprocess
import sys

class MyBaseHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'Only handle POST requests.\n')
        flushLog()

    def do_POST(self):
        statusCode = 403
        responseData = b"Reject the request"
        if self.path == "/pushed":
            statusCode, responseData = self.updateBlog()
        self.send_response(statusCode)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(bytes(responseData, "utf-8"))
        flushLog()

    def updateBlog(self):
        os.chdir("/opt/hexo-blog")
        code, result = subprocess.getstatusoutput("git pull origin master")
        print(result)
        if code == 0:
            code = 200
            result = "blog updated :)"
        else:
            code = 500
            result = "blog update failed :("
        return code, result

def flushLog():
    sys.stdout.flush()
    sys.stderr.flush()

def main():
    port = 2345
    httpd = HTTPServer(("", port), MyBaseHTTPRequestHandler)
    print("Running on port: %d"%(port))
    flushLog()
    httpd.serve_forever()

if __name__ == "__main__":
    main()
