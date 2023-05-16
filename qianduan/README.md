# bylw

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).


### 数据代理
'/api' 指向 'http://localhost:90'

### 各类网络请求接口
 this.request：封装axios进行网络请求
 this.request.get('/api/**/page',{params:{pageNum:？？,pageSize:？？，...}})  ：分页请求，带上请求参数页码和页的大小还有其他参数
 this.request.delete('/api/**/'+id) ：根据id号删除指定数据
 this.request.post('/api/**',this.form) ：根据传入的表格进行新增或更新
 this.request.delete('api/**/batch',{data:ids}) ：根据传入的多个id号进行批量删除
 this.request.post('api/user/login(register)',this.ruleForm) ：验证账号密码等进行登录注册
 this.request.get('/api/**/'+this.user.id) ：根据id号批量查询
 
 
 
