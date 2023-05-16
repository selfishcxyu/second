<template>
  <div>
    <h1 style="margin-bottom: 20px; text-align: center">
      欢迎来到社区物业管理系统~~
    </h1>
    <el-row :gutter="-10">
      <!-- 用户最新一条公告信息 -->
      <el-col :span="12" style="padding-left:20px;">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <el-tag style="fontSize: 14px;">最新公告</el-tag>
            <el-button style="float: right; padding: 3px 0" type="text" @click="toNotice">查看更多公告...</el-button>
          </div>
          <h1 class="text item center">{{notice.title}}</h1>
          <p style="margin-bottom:25px;" class="center">  {{notice.content}}</p>
          <p style="text-align:right;">发布时间：{{notice.time}}</p>
        </el-card>
      </el-col>
      <!-- 缴费通知 -->
      <el-col :span="12">
        <el-card shadow="hover">
          <div slot="header" class="clearfix">
            <el-tag type="danger" style="fontSize: 14px;">欠费通知</el-tag>
            <el-button style="float: right; padding: 3px 0" type="text" @click="toPay">前往缴费</el-button>
          </div>
          <div style="display: flex; flex-direction: column; text-align:center;">
            <el-tag type="primary" style="fontSize: 16px; margin-bottom:10px;">您有{{houseLength}}处房产</el-tag>
            <el-tag type="warning" style="fontSize: 16px;">您还有{{noPayLength}}条费用需缴纳</el-tag>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "Home",
  data() {
    return {
      user: JSON.parse(sessionStorage.getItem("user")) || "",
      notice: "",
      houseLength:0,  //房产数量
      noPayLength:0,  //未支付缴费信息
    };
  },
  created() {
    //tab列的数据存入sessionStorage
    sessionStorage.setItem("tabList",JSON.stringify(this.$store.state.man.tabList));
    //管理获取用户数量，
    this.getNotice();
    this.getPayInfo();
  },
  methods: {
    //用户进入获取最新公告
    getNotice() {
      this.request.get("/api/notice/new").then((res) => {
        if (res.code === "200") {
          this.notice = res.data;
        }
      });
    },
    async getPayInfo(){
      const res = await this.getDoorplate()//根据用户拥有的门牌号获取缴费信息
      this.houseLength = res.data.length
      //对每条房产遍历获取未支付数量
      if(res.data !== null){
        for(let item of res.data){
          this.request.get('/api/pay/nopay/'+ item.doorplate ).then((value) => {   //获取用户未支付的费用数量
            if(value.code === '200'){
              this.noPayLength += value.data.length
            }
          }) 
        }
      }
      //购置的房产存入本地
      sessionStorage.setItem("residence",JSON.stringify(res.data))
    },
    getDoorplate(){
      return this.request.get('/api/residence/'+this.user.id)
    },
    toNotice(){
      this.$router.push({path:'notice'})
      this.$store.commit('man/tabListAdd',{
        path:"notice",
        name:"公告",
      })
    },
    toPay(){
      this.$router.push({path:'payUser'})
      this.$store.commit('man/tabListAdd',{
        path:"payUser",
        name:"生活缴费",
      })
    }
  },
};
</script>

<style lang="less" scoped>
.text {
  font-size: 18px;
}
.item {
  margin-bottom: 18px;
}
.center {
  text-align: center;
  margin-bottom: 15px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both;
}

.box-card {
  width: 520px;
}
</style>