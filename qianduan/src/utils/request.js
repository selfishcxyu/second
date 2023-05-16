import axios from 'axios';
import ElementUI, { Message } from 'element-ui';

const http= axios.create({
    //通过请求的地址前缀// baseURL:'/api',
    timeout:10000,  //超时时间
})

// 添加请求拦截器
http.interceptors.request.use( config => {
    // 在发送请求之前做些什么
    config.headers['Content-Type'] = 'application/json;charset=utf-8';
    let user = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {}
    if(user){
      config.headers['token'] = user.token;  //设置请求头，，每次请求把token传给服务器
    }
    return config;
  },  error => {
    // 对请求错误做些什么
    return Promise.reject(error);
  });

// 添加响应拦截器
http.interceptors.response.use( response => {
    // 2xx 范围内的状态码都会触发该函数。
    // 对响应数据做点什么
    let res = response.data;
    //若返回文件
    if(response.config.responseType === 'blob'){
      return res
    }
    //兼容服务端返回的字符串数据
    // if(typeof res === 'string'){
    //   res = res ? JSON.parse(res) : res
    // }
    //当权限验证不通过时给出提示 调用elementui
    if(response.data.code === '401'){
      ElementUI.Message({
        message:res.msg,
        type:'error'
      });
    }
    return res;
  },  error => {
    // 超出 2xx 范围的状态码都会触发该函数。
    // 对响应错误做点什么
    if(error.message.includes('timeout')) {
      ElementUI.Message({
        message: '请求服务器超时',
        type: 'error',
        duration: 5*1000
      })
    }else {
      ElementUI.Message({
        message:"error",
        type: 'error',
        duration: 5*1000
      })
    }
    return Promise.reject(error);
  });

  export default http