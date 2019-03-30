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
        print("got POST request")

def main():
    port = 2345
    httpd = HTTPServer(("", port), MyBaseHTTPRequestHandler)
    print("Running on port: %d"%(port))
    httpd.serve_forever()

if __name__ == "__main__":
    main()
