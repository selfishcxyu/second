<template>
  <div class="container">
    <div class="box">
      <h2>抱歉，您输入的地址没有找到</h2>
      <h3>o(╥﹏╥)o</h3>
      <el-button type="text" @click="router.push('/login')">点击返回主页</el-button>
    </div>
  </div>
</template>

<style lang="less" scoped>
.container{
  background: url(@/assets/images/404.jpg) no-repeat;
  height: 100vh;
  width: 100%;
  background-position: center;
  .box{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%)
  } 
}
</style>