#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from http.server import BaseHTTPRequestHandler
from http.server import HTTPServer
import os
import subprocess

class MyBaseHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'Only handle POST requests.\n')

    def do_POST(self):
        statusCode = 403
        responseData = b"Reject the request"
        if self.path == "/pushed":
            statusCode, responseData = self.updateBlog()
        self.send_response(statusCode)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(bytes(responseData, "utf-8"))

    def updateBlog(self):
        os.chdir("/opt/hexo-blog")
        code, result = subprocess.getstatusoutput("git pull origin master")
        code = 200 if code == 0 else 500
        return code, result

def main():
    port = 2345
    httpd = HTTPServer(("", port), MyBaseHTTPRequestHandler)
    print("Running on port: %d"%(port))
    httpd.serve_forever()

if __name__ == "__main__":
    main()
