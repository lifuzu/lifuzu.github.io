import gevent  
from gevent import wsgi,pool 
#the application to handle the response  
def app(environ,start_response):  
     start_response("200 OK",[("Content-Type","text/plain")])  
     return "Hello World\n"  
if __name__=="__main__":  
     print "The sweet thing is running on http://localhost:8912/"  
     pool=gevent.pool.Pool() #A pool of greenlets.Each greenlets runs the above defined function app for a client request  
     server=wsgi.WSGIServer(("localhost",8912),app,spawn=pool) #the server is created and runs multiple greenlets concurrently  
     server.serve_forever() #the server is made to run in loop   
