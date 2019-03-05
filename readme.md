## 请求获取token
```
http://host:port/context-path/auth
```
方法类型为POST，提交数据格式为：json，内容为：
```
{
	"username":username,
	"password":password
}
```  

返回token格式为：
```
{
    "token": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImNyZWF0ZWQiOjE1MDE0NjkzOTk4ODMsImV4cCI6MTUwMjA3NDE5OX0.w0FDAFhm6-oWn7tUcx2CIDHF9NfwpmFEcHIkPEfCp5ejzXeDFfeOd-WeX_-V4zcTZeZTOXWPXwl1Yzkc-g4UGg"
}
```
## 访问api
将获取到的token放入request header中 格式：
key为 Authorization  

value为 Bearer + " "+ token   
Bearer 为我们预先设置的token head 在配置文件中可以修改任意值