PORT = 8080

class Handler(SimpleHTTPRequestHandler):
    pass

with HTTPServer(("", PORT), Handler) as httpd:
    print(f"Server running on port {PORT}")
    httpd.serve_forever()
