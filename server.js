const http=require('http');
const fs=require('fs');
http.createServer((req,res)=>{
  if(req.url==='/r'){ try{res.end(fs.readFileSync('/tmp/r.txt'))}catch(e){res.end('none')} }
  else res.end('ok');
}).listen(process.env.PORT||3000);
