<template>
  <div id="header">
    <div class="left">
      <!-- 折叠按钮 -->
      <el-button @click="collapseMenu" size="mini" round><i class="foldBtn" :class="menuFold"></i></el-button>
      
      <!-- 面包屑 -->
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item >
          {{this.$route.name}}
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="right">
      <!-- <el-col :span="12"> -->
        <!-- 下拉菜单选项 -->
        <el-dropdown @command="handleCommand">
          <span class="el-dropdown-link">
            <img class="person" referrerpolicy="no-referrer" :src="userInfo.avatar" alt="">
            <!-- <el-avatar :size="mudium" :src="userInfo.avatar" class="person"></el-avatar> -->
            <span>{{userInfo.nickname}}</span><i class="el-icon-caret-bottom"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item icon="el-icon-user-solid" command="person">个人中心</el-dropdown-item>
            <el-dropdown-item icon="el-icon-tableware" command="out">退出</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      <!-- </el-col> -->
    </div>
  </div>
</template>

<script>
  export default {
    name:'SysHeader',
    data() {
      return {
        menuFold:'el-icon-s-unfold',
        userInfo: JSON.parse(sessionStorage.getItem("user")) || {}
      }
    },
    mounted () {
      this.$bus.$on("update",this.getUser)
    },
    methods: {
      handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath);
      },
      //折叠菜单
      collapseMenu(){
        this.$store.commit('man/collapseMenu')
        if(this.menuFold=='el-icon-s-unfold'){
          this.menuFold='el-icon-s-fold'
        }else{
          this.menuFold='el-icon-s-unfold'
        }
      },
      //下拉菜单点击事件，通过绑定command获取子菜单点击了哪个，由主菜单进行处理
      handleCommand(command){
        if(command=='out'){ //退出事件时
          sessionStorage.clear()
          this.$store.commit('man/clearTab')
          this.$router.push('/login')
          this.$message.success("success out")
        }else if(command=='person'){
          this.$router.push('/person')
          //面包屑添加
          this.$store.commit('man/tabListAdd',{
            path:'/person',
            name:"个人信息"
          })
        }
      },
      //获取新的用户信息
      getUser(){
        this.userInfo = JSON.parse(sessionStorage.getItem("user")) || {}
      }
    },
  }
</script>

<style lang="less" scoped>
.el-menu-vertical-demo:not(.el-menu--collapse) {
    min-height: 400px;
  }

#header{
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 5px;
  .left{
    display: flex;
    align-items: center;
    .foldBtn{
      // 字体变大，图标变大
      font-size: 20px;
    }
    .el-breadcrumb{
      margin-left: 20px;
      font-size: 16px;
    }
  }
  .right{
    text-align: center;
    /deep/ .el-dropdown{
      position: relative;
      top: 12px;
      width: 150px;
      height: 50px;
      cursor: pointer;
      .person{
        position: relative;
        width: 40px;
        height: 40px;
        border-radius: 20px;
        margin: 8px 10px 0 0 ;
      }
      span{
        position: relative;
        top: -13px;
        font-size: 16px;
        font-weight: 500;
        color: #000;
      }
    }
    
  }
}
</style>