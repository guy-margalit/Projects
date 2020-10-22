import socket
from PIL import ImageGrab


MAIN_DIRECTORY = "C:/Heights/Documents/Projects/untitled/webroot"
DEFAULT_RESOURCE = "index.html"
MSG_LEN = 1024
IP, PORT = "0.0.0.0", 80
SOCKET_TIMEOUT = 0.5


def initiate_server_socket():
    server_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    server_socket.bind((IP, PORT))
    server_socket.listen(10)
    print("Listening for connections on port %d" % PORT)
    return server_socket


def get_file_data(filename: str):
    try:
        file = open(MAIN_DIRECTORY + filename, "rb")
        error = 0
    except FileNotFoundError:
        file = open(MAIN_DIRECTORY+ "/404.html", "rb")
        error = 1
    except IOError:
        file = open(MAIN_DIRECTORY + "/error.html", "rb")
        error = 2
    return file.read(), error


def is_valid_request(request: str):
    request_type, resource, http_type = request.split()[:3]
    return request_type == "GET" and http_type == "HTTP/1.1", request_type, resource


def type_of_file(file_type: str):
    if file_type == 'jpg':
        return 'image/jpeg'

    elif file_type == 'ico':
        return 'image/ico'

    elif file_type == 'js':
        return 'text/javascript; charset=UTF-8'

    elif file_type == 'css':
        return 'text/css; charset=UTF-8'

    elif file_type == 'py':
        return 'text/python; charset=UTF-8'

    elif file_type == 'html':
        return 'text/html; charset=UTF-8'


def handle_client_request(request: str, client_socket: socket.socket):
    """ Check the required resource, generate proper HTTP response and send to client"""

    valid, request_type, resource = is_valid_request(request)

    if resource == '/':
        resource = DEFAULT_RESOURCE

    file_type = resource.split('.')[-1]

    if resource == '/screenshot.jpg':
        im = ImageGrab.grab()
        im.save(MAIN_DIRECTORY + resource)

    data, error = get_file_data(resource)
    typ = type_of_file(file_type)
    status = "200 OK"

    if error == 2:
        typ = 'text/html; charset=UTF-8'

    elif error == 1:
        typ = 'text/html; charset=UTF-8'
        status = "404 Not Found"

    length = str(len(data))
    http_response = "HTTP/1.1 %s\r\nContent-Type: %s\r\nContent-Length: %s\r\n%s" % (status, typ, length, data)
    client_socket.send(http_response.encode())


def handle_client(client_socket):
    """ Handles client requests: verifies client's requests are legal HTTP, calls function to handle the requests """
    client_request = client_socket.recv(MSG_LEN)
    handle_client_request(client_request.decode(), client_socket)


def handle_clients(server_socket):
    """ loop forever while waiting for clients """
    client_socket = None
    while True:
        try:
            client_socket, client_address = server_socket.accept()
            c_ip, c_port = client_address
            print('Connected to %s at port %d' % (c_ip, c_port))
            #client_socket.settimeout(0.5)
            handle_client(client_socket)
        except socket.error as e:
            print("client failed", e)
            client_socket.close()

def main():
    # Open a socket and loop forever while waiting for clients
    server_socket = initiate_server_socket()
    handle_clients(server_socket)


if __name__ == "__main__":
    # Call the main handler function
    main()
