from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello! Server: %s' % socket.gethostname()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)