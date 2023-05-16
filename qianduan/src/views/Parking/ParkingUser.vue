<template>
  <div class="parking">
    <!-- 居民查看车位，购买车位，租借车位，管理员管理 -->
    <div class="search">
      <el-input placeholder="请输入车位编号" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="number"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="number=''" type="warning">重置</el-button>
    </div>

    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;">
      <el-table-column prop="number" label="车位编号" ></el-table-column>
      <el-table-column prop="building" label="楼宇" width="180"></el-table-column>
      <el-table-column prop="state" label="车位状态" width="150">
        <template slot-scope="scope">
          <span v-if="scope.row.state =='空闲'" style="backgroundColor:#909399;" class="text">{{scope.row.state}}</span> 
          <span v-else style="backgroundColor:#67C23A;" class="text">{{scope.row.state}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="300" align="center">
        <template slot-scope="scope">
          <!-- <el-button size="mini" type="success" @click="handleRent(scope.row)">租用 <i class="el-icon-edit"></i></el-button> -->
          <el-button size="mini" type="success" @click="handlePurchase(scope.row)">购买 <i class="el-icon-edit"></i></el-button>
        </template>
      </el-table-column>
  </el-table>

    <!-- 分页器 -->
    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
      :page-sizes="[5, 10, 15, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
    </el-pagination>
  </div>
</template>

<script>
export default {
    name:'ParkingUser',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        number: '',
        req:{
          id: JSON.parse(sessionStorage.getItem("user")).id || '',
          nickname: JSON.parse(sessionStorage.getItem("user")).nickname || '',
        },
      }
    },
    created() {
      this.load() //初始载入
    },
    methods: {
      handleSizeChange(val) {
        this.pageSize = val
        this.load()
      },
      handleCurrentChange(val) {
        this.pageNum = val
        this.load()
      },
      load(){
        this.request.get('/api/parking/page',
        {params:{pageNum:this.pageNum,pageSize:this.pageSize,number:this.number,other:'other'}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records //获取车位信息列表
            this.total=value.data.total
            this.$message.success("get Parking success")
          }
        })
      },
      //租用和购买
      // handleRent(row){
      //   this.request.post('/api/parking',{id:row.id,req:JSON.stringify(this.req)}).then(value => {
      //     if(value.code === '200'){
      //       console.log('success');
      //     }
      //   })
      // },
      handlePurchase(row){
        this.request.post('/api/parking',{id:row.id,req:JSON.stringify(this.req)}).then(value => {
          if(value.code === '200'){
            this.$message.success("success")
          }
        })
      },
    }
}
</script>

<style lang="less" scoped>
.parking{
  .search{
    margin-bottom: 15px;
    .el-input{
      margin-right: 5px;
    }
  }
  .el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
  .el-tooltip__popper{
    display: none;
  }

.text{
  color:#000;
  padding:10px;
  border-radius:20px;
}
}
</style>