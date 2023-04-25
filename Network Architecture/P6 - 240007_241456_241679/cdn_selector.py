from flask import Flask, redirect, request
import random
import sys

app = Flask(__name__)
origin='10.10.10.2'
option = sys.argv[1]

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/repository/<path:filename>")
def download(filename):
    if option == 'origin':
        redirect_url = 'http://%s:5200/repository/%s'%(origin,filename)
    elif option == 'random':
        pop_ips = ['10.10.15.2','10.10.25.2','10.10.35.2','10.10.45.2']
        index = random.randrange(0, len(pop_ips))
        redirect_url = 'http://%s:5200/repository/%s'%(pop_ips[index],filename)
    elif option == 'optimize':
        pop_ips = ['10.10.15.2','10.10.25.2','10.10.35.2','10.10.45.2']
        client_ip = request.remote_addr
        topology_matrix = [['10.1.1.11', '10.1.1.12','10.1.1.13','10.1.1.14','10.1.1.15','10.1.1.16'],['10.1.2.11', '10.1.2.12','10.1.2.13','10.1.2.14','10.1.2.15','10.1.2.16'], ['10.1.3.11', '10.1.3.12','10.1.3.13','10.1.3.14','10.1.3.15','10.1.3.16'], ['10.1.4.11', '10.1.4.12','10.1.4.13','10.1.4.14','10.1.4.15','10.1.4.16']]
        '''
        TODO
        Create your own code to improve download times for each user,
        depending on client IP, calculate index in pop_ips array to give a redirect url to client.
        '''
        for i in range(len(topology_matrix)):
            for j in range(len(topology_matrix[i])):
                if(topology_matrix[i][j] == client_ip):
                    index = i
        redirect_url = 'http://%s:5200/repository/%s'%(pop_ips[index],filename)
    else:
        return "ERROR option no detected"
    return redirect(redirect_url, code=302)

if __name__ == '__main__':
    app.run(debug=False, host="0.0.0.0", port=5200)
