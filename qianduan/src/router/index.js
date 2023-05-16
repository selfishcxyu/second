import Vue from 'vue';
import VueRouter from 'vue-router';
import Main from '../views/Main.vue';

Vue.use(VueRouter)

const router = new VueRouter({
    mode: 'history',
    routes: [
        //主路由
        {
            name: 'Main',
            path: '/',
            component: Main,
            redirect: '/login',
            children: [
                { name: '首页', path: 'home', component: () => import('../views/Home.vue')},
                { name: '个人信息',path: 'person',meta:{label:'个人信息'},component: () => import('../views/User/Person.vue')},
                { name: '修改密码',path: 'password',meta:{label:'修改密码'},component: () => import('../views/User/Password.vue')},
            ]
        },
        { name: 'Login',path: '/login',component: () => import('../views/Login/Login.vue')},
        { name: 'Register',path: '/register',component: () => import('../views/Login/Register.vue')},
        { name: '404',path: '/404',component: () => import('../views/404.vue')},
    ]
})

//添加全局前置守卫,跳转前触发  //判断登录
router.beforeEach((to, from, next) => {
    //判断token存不存在
    const token = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")).token : ''
    //token不存在,用户未登录且想要跳转到其他页面，则跳转到login
    if (to.path === '/register'){
      next()
    } else if (!token && to.path !== '/login') {
      next({ path: 'login' })
    } else if (token && to.path === '/login'){ // token存在，说明用户登录，此时跳转至首页
      next({ path: 'home' })
    } else {
      next()
    }
  })

//解决重复点击相同页面时跳转错误问题
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}

export default router