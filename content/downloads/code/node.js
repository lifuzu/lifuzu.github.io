 var http=require("http");  
 http.createServer(function(req,res){  
      res.writeHead(200,{"Content-Type":"text/plain"});  
      res.end("Hello World\n");  
 }).listen(9124,"localhost");   
 console.log("The sweet thing is running on http://localhost:9124");
