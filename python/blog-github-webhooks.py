#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from http.server import BaseHTTPRequestHandler
from http.server import HTTPServer

class MyBaseHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'Only handle POST requests.\n')
        print("got GET request")
    def do_POST(self):
        print("got POST request\n")
        print("the header is:", self.headers)
        print("the path is:", self.path)
        print("the request is:", self.request)
        print("the request line is:", self.requestline)

def main():
    port = 2345
    httpd = HTTPServer(("", port), MyBaseHTTPRequestHandler)
    print("Running on port: %d"%(port))
    httpd.serve_forever()

if __name__ == "__main__":
    main()
