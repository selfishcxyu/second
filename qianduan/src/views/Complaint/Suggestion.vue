<template>
  <div class="suggestion">
    <h2>住户建议留言表</h2>
    <el-card class="input">
      <el-input type="textarea" :rows="2" placeholder="请输入内容" v-model="suggestion"></el-input>
      <el-button type="primary" @click="sendSuggestion" class="send">发送留言</el-button>
    </el-card>

    <div style="margin-bottom: 10px;">
      <el-radio-group v-model="reverse">
        <el-radio :label="true">倒序</el-radio>
        <el-radio :label="false">正序</el-radio>
      </el-radio-group>
    </div>

    <el-timeline v-infinite-scroll="load" infinite-scroll-disabled="disabled" infinite-scroll-distance="10" infinite-scroll-delay="1000" :reverse="reverse">
      <el-timeline-item 
        v-for="msg in msgData"
        :key="msg.id"
        :timestamp="msg.time"
        placement="top">
        <el-card body-style="display: flex; position: relative;">
          <img :src="msg.avatar" style="width:50px;border-radius:25px;margin-right:25px;">
          <div>
            <h4 style="margin-bottom:10px;">{{msg.username}}</h4>
            <p>{{msg.suggestion}}</p>
          </div>
          <el-popconfirm
            style="margin-left: 5px;position: absolute; right: 20px; top :15px;"
            confirm-button-text='确认'
            cancel-button-text='再想想'
            icon="el-icon-info"
            icon-color="red"
            title="您确定删除吗？"
            @confirm="handleDelete(msg.id)"
          >
            <el-button slot="reference" type="danger" size="small" v-if="msg.username == user.username || user.username =='admin'">删除留言</el-button>
          </el-popconfirm>
        </el-card>
      </el-timeline-item>
      <p v-if="loading" style="margin-top:10px;" class="loading">
        <span></span>
      </p>
      <p v-if="noMore" style="margin-top:10px;font-size:13px;color:#ccc">没有更多了...</p>
    </el-timeline>

    <el-backtop target=".suggestion"><i class="el-icon-caret-top"></i></el-backtop>
  </div>
</template>

<script>
export default {
    name:'Suggestion',
    data() {
      return {
        msgData:[],
        pageNum:0,
        pageSize:5, //每次获取5条留言，下拉刷新(使pageNum+1）后再获取5条，添加到msgData中
        total:0,
        loading:false, //控制加载是否显示
        user: JSON.parse(sessionStorage.getItem("user")) || '',
        suggestion:'',
        reverse: false,
      }
    },
    created() {
      this.load()
    },
    computed: {
      noMore(){  //获取的数据的长度比总数大时就为true
        return this.msgData.length >= this.total 
      },
      disabled(){
        return this.loading || this.noMore;
      }
    },
    methods: {
      //载入建议
      load(){
        this.loading = true
        this.pageNum += 1
        console.log(this.pageNum);
        this.request.get('/api/suggestion/page',{params:{pageNum:this.pageNum,pageSize:this.pageSize}}).then((value) => {
          if(value.code === '200'){
            this.msgData = this.msgData.concat(value.data.records)
            this.total=value.data.total
            this.loading = false
          }
        })
      },
      //删除自己的建议
      handleDelete(id) {
        this.request.delete('/api/suggestion/'+id).then(res=>{
          console.log(res);
          if(res.code === '200'){
            this.$message.success("删除成功")
            location.reload()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //新增建议
      sendSuggestion(){
        const time = this.tool.getNowDate()
        this.request.post('/api/suggestion',{
          username:this.user.username,
          avatar:this.user.avatar,
          time:time,
          suggestion:this.suggestion,
        }).then(res => {
          if(res.code === '200'){
            this.$message.success("新增成功")
            this.request.get('/api/suggestion/new').then(value => {
              console.log(value);
              if(value.code === '200'){
                this.msgData.unshift(value.data)
                this.total += 1
              }
            })
            this.suggestion = ''
          }else{
            this.$message.error("新增失败")
          }
        })   
      }
    }
}
</script>

<style lang="less" scoped>
.suggestion{
  height: 100vh;
  overflow-y: auto;
  .input{
    height: 128px;
    margin:20px auto;
    position: relative;
    .send{
      margin-top: 10px;
      position: absolute;
      right: 20px;
      bottom: 10px;
    }
  }
  .loading span {
    display: inline-block;
    width: 20px;
    height: 20px;
    border: 2px solid #409eff;
    border-left: transparent;
    animation: zhuan 0.5s linear infinite;
    border-radius: 50%;
  }
}
</style>