import Vue from 'vue'
import App from './App.vue'
//引入css初始化
import './assets/css/base.css'
//路由引入
import router from './router/index';
//store引入
import store from './store/index';
//全局引入element-ui和样式
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css'
//引入封装的axios，直接调用
import request from '@/utils/request.js';
//引入封装的工具类，全局调用
import tool from '@/utils/tool';

Vue.config.productionTip = false
Vue.use(ElementUI)
Vue.prototype.request=request
Vue.prototype.tool=tool

new Vue({
  router,
  store,
  beforeCreate(){
    //全局事件总线
    Vue.prototype.$bus=this
  },
  created(){
    if(sessionStorage.getItem("refresh")){
      //刷新后从浏览器获取路由菜单和菜单列
      store.commit('man/addMenu',router)
      store.commit('man/cTabList')
    }
  },
  render: h => h(App)
}).$mount('#app')
