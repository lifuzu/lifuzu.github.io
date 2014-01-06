import eventlet
from eventlet import wsgi
def app(environ,start_response):
  start_response("200 OK",[("Content-Type","text/plain")])
  return "Hello World\n"  
if __name__=="__main__":  
  wsgi.server(eventlet.listen(("localhost",6785)),app)
