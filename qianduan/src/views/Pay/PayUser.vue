<template>
  <div class="pay">
    <el-select v-model="currentDoorplate" placeholder="请选择" @change="selectDoor">
      <el-option
        v-for="item in residenceInfo"
        :key="item.id"
        :label="item.doorplate"
        :value="item.doorplate">
      </el-option>
    </el-select>
    <el-tag type="primary">可选择对应房产查看缴费信息</el-tag>

    <el-table :data="tableData" stripe border style="width: 100%; margin: 15px 0;" v-if="!noNeedToPay">
      <el-table-column prop="doorplate" label="门牌号" width="140"></el-table-column>
      <el-table-column prop="building" label="楼宇" width="140"></el-table-column>
      <el-table-column prop="type" label="费用类型" width="140"></el-table-column>
      <el-table-column prop="money" label="缴费金额" width="140"></el-table-column>
      <el-table-column prop="createTime" label="开始时间" width="140"></el-table-column>
      <el-table-column prop="payTime" label="缴费时间" width="140"></el-table-column>
      <el-table-column prop="state" label="是否已缴费" width="140">
        <template slot-scope="scope">
          <span slot="reference" v-if="scope.row.state == '未支付'" style="backgroundColor:#909399;" class="text">{{scope.row.state}}</span>
          <span slot="reference" v-else style="backgroundColor:#67C23A;" class="text">{{scope.row.state}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope">
          <el-popconfirm 
            style="margin-left: 5px;" confirm-button-text='确认' cancel-button-text='再想想'
            icon="el-icon-info" icon-color="red" title="是否确认缴费？" @confirm="handlePay(scope.row.id)">
            <el-button v-if="scope.row.state == '未支付'" size="mini" type="success" slot="reference">缴费 <i class="el-icon-edit"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination v-if="!noNeedToPay" @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
      :page-sizes="[5, 10, 15, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
    </el-pagination>

    <el-tag v-if="noNeedToPay">您还未购置房产，无需缴纳费用</el-tag>
  </div>
</template>

<script>
export default {
    name:'PayUser',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        user:JSON.parse(sessionStorage.getItem("user")) || '',
        noNeedToPay:false,
        residenceInfo: JSON.parse(sessionStorage.getItem("residence")) || '',
        currentDoorplate: '',
      }
    },
    created() {
      if(!this.residenceInfo){
        this.noNeedToPay = true
      }else{
        this.currentDoorplate = this.residenceInfo[0].doorplate
        this.load()
      }
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
      //只获取居民自己的缴费记录
      load(){
        this.request.get('/api/pay/page',{params:{pageNum:this.pageNum,pageSize:this.pageSize,doorplate:this.currentDoorplate}})
        .then(value => {
          if(value.code === '200'){
            this.tableData = value.data.records
            this.total = value.data.total
          }
        })
      },
      //缴费功能
      handlePay(id){
        const payTime = this.tool.getNowDate()
        this.request.post('/api/pay',{id:id,state:"已缴费",payTime:payTime}).then(res => {
          if(res.code === '200'){
            this.$message.success("缴费成功")
            this.load()
          }else{ this.$message.error("缴费失败")}
        })   
      },
      selectDoor(e){
        this.currentDoorplate = e
        this.load()
      }
    }
}
</script>

<style lang="less" scoped>
.pay{
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
    padding:5px;
    border-radius:20px;
    color:#000;
  }
}
</style>