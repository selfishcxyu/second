<template>
  <!-- submenu是有子菜单 -->
  <!-- 默认展开 :default-openeds="['1', '3']" -->
  <!-- @open="handleOpen" -->
    <!-- @close="handleClose" -->
    <!-- default-active="2"   -->
    <!-- active-text-color包括子菜单选中的字体颜色 -->
  <el-menu
    :default-active="($route.path).slice(1)"
    class="el-menu-vertical-demo"
    :collapse="isCollapse"
    background-color="rgb(70 81 91)"
    text-color="#fff"
    active-text-color="#0979b4"
  >
    <!-- 标题 -->
    <h3 class="title"> {{isCollapse ? '社区物业' : '社区物业管理系统'}}</h3>

    <!-- <el-menu-item @click="$router.push({path:'home'})">
        <i class="el-icon-s-home"></i>
        <span slot="title">首页</span>
    </el-menu-item> -->

    <!-- 没有子菜单的 -->
    <el-menu-item 
        @click="handleTo(item)"
        v-for="item in list" 
        :key="item.path" 
        :index="item.path"
    >
        <i :class="`el-icon-${item.icon}`"></i>
        <span slot="title">{{item.name}}</span>
    </el-menu-item>
  </el-menu>
</template>

<script>
export default {
  name:'SysAside',
  data() {
    return {}
  },
  methods: {
    //点击跳转指定页面
    handleTo(item){
      this.$router.push({path:item.path})
      this.$store.commit('man/tabListAdd',{
        path:item.path,
        name:item.name,
      })
    },
  },
  computed: {
    isCollapse(){
      return this.$store.state.man.isCollapse
    },
    list(){
      return JSON.parse(sessionStorage.getItem('menu')) || this.$store.state.man.menuList
    }
  }
}
</script>

<style lang="less" scoped>
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 220px;
  height: 150vh;
}  
.el-menu{
  height: 150vh;
  border-right: 3px solid rgb(70 81 91);
  .title{
    padding: 10px 20px;
    color: #d6d6dd;
  }
}
</style>