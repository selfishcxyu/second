<template>
  <div>
    <el-container>
      <!-- 侧边栏导航 -->
      <el-aside width="auto">
        <SysAside></SysAside>
      </el-aside>
      <!-- 顶部 -->
      <el-container>
        <el-header>
          <SysHeader></SysHeader>
        </el-header>
      <!-- 主体内容 -->
        <SysTab></SysTab>
        <el-main>
          <keep-alive>
            <router-view></router-view>
          </keep-alive>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import SysAside from '../components/SysAside.vue';
import SysHeader from '../components/SysHeader.vue';
import SysTab from '../components/SysTab.vue';
export default {
    name:'Main',
    components:{
      SysHeader,SysAside,SysTab
    },
}
</script>

<style scoped>
.el-main{
  padding: 20px;
  background-color: rgb(226, 240, 246);
}
.el-header{
  background-color: rgb(79, 160, 78);;
}
</style>