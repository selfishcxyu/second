export default {
    namespaced: true,
    state:{
        isCollapse:false,
        tabList:[],
        menuList:[]
        // store里的数据是保存在运行内存中的,当页面刷新时，页面会重新加载vue实例，store里面的数据就会被重新赋值
        // 将state里的数据保存一份到本地存储(localStorage、sessionStorage、cookie）中
    },
    dispatch:{},
    mutations:{
        //折叠菜单
        collapseMenu(state){
            state.isCollapse=!state.isCollapse
        },
        //点击子菜单，面包屑列表添加新面包
        tabListAdd(state,menu){
            const index = state.tabList.findIndex(item=>item.path==menu.path)
            if(index===-1){
                state.tabList.push(menu)
            }
            //存入浏览器
            sessionStorage.setItem("tabList",JSON.stringify(state.tabList))
        },
        //刷新后设置state的菜单列
        cTabList(state){
            state.tabList = JSON.parse(sessionStorage.getItem("tabList"))
        },
        //关闭标签(面包屑)
        tabClose(state,path){
            //主页不能删除
            //遍历tabList,选出与传入路径相同的索引,splice去除
            if(path=='home') return
            state.tabList.map((item,index,arr)=>{
                if(item.path===path) arr.splice(index,1)
            })
            //更新浏览器的tabList
            sessionStorage.setItem("tabList",JSON.stringify(state.tabList))
        },
        //清理tabList
        clearTab(state){
            state.tabList = [{
                path:'home',
                name:'首页',
            }]
        },
        //动态添加菜单
        addMenu(state,router){
            const menu = JSON.parse(sessionStorage.getItem("menu")) || []
            if(!menu) return
            state.menuList = menu
            //组装动态路由数据
            const menuArray=[]
            menu.forEach(item=>{
                item.component=()=>import(`../views/${item.url}`)
                menuArray.push(item)
            })
            //路由动态添加
            menuArray.forEach(item=>{
                router.addRoute("Main",item)
            })
            router.addRoute({
                path: '*',
                redirect: '/404'
            })
        }

    }
}