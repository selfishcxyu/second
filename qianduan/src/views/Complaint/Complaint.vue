<template>
  <div class="Complaint">
    <!-- 搜索 admin-->
    <div class="search">
      <el-input placeholder="搜索投诉人门牌号" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="doorplate"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="doorplate=''" type="warning">重置</el-button>
    </div>

    <!-- 批量删除按钮 admin-->
    <el-popconfirm
      style="margin-left: 5px;"
      confirm-button-text='确认'
      cancel-button-text='我再想想'
      icon="el-icon-info"
      icon-color="red"
      title="您确定批量删除这些数据吗？"
      @confirm="delBatch"
    >
      <el-button type="danger" slot="reference" style="margin:10px 10px 10px 0;">批量删除 <i class="el-icon-delete-solid" style="font-size: 14px;"></i></el-button>
    </el-popconfirm>

    <!-- data -->
    <el-table
      :data="tableData"
      stripe
      border
      style="width: 100%; margin-bottom: 15px;"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="编号" width="70"></el-table-column>
      <el-table-column prop="nickname" label="投诉人" width="150"></el-table-column>
      <el-table-column prop="doorplate" label="门牌号" width="150"></el-table-column>
      <el-table-column prop="pid" label="投诉人id" width="80"></el-table-column>
      <el-table-column prop="event" label="投诉事件" width="200"></el-table-column>
      <el-table-column prop="time" label="处理时间" width="190"></el-table-column>
      <el-table-column prop="state" label="处理状态" width="160">
        <template slot-scope="scope">
          <span v-if="scope.row.state =='未处理'" style="backgroundColor:#909399;" class="text">{{scope.row.state}}</span> 
          <span v-else-if="scope.row.state =='已处理'" style="backgroundColor:#67C23A;" class="text">{{scope.row.state}}</span>
          <span v-else style="backgroundColor:#E6A23C;" class="text">{{scope.row.state}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope"> 
          <el-popconfirm
            style="margin-left: 5px;"
            confirm-button-text='确认'
            cancel-button-text='我再想想'
            icon="el-icon-info"
            icon-color="red"
            title="是否开启处理？"
            @confirm="handle(scope.row.id)"
          >
            <el-button slot="reference" size="mini" type="info" v-if="scope.row.state=='未处理'">处理 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
          <el-popconfirm
            style="margin-left: 5px;"
            confirm-button-text='确认'
            cancel-button-text='再想想'
            icon="el-icon-info"
            icon-color="red"
            title="您确定删除吗？"
            @confirm="handleDelete(scope.row.id)"
          >
            <el-button slot="reference" size="mini" type="danger">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
  </el-table>

    <!-- 分页器 -->
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pageNum"
      :page-sizes="[5, 10, 15, 20]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total">
    </el-pagination>
  </div>
</template>

<script>
export default {
    name:'Complaint',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        doorplate:'',
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        multipleSelection:[],   //批量选择 列表
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
      //获取数据库请求
      load(){
        this.request.get('/api/complaint/page',{params:{pageNum:this.pageNum,pageSize:this.pageSize,doorplate:this.doorplate}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records //获取用户列表
            this.total=value.data.total
            this.$message.success("get notice success")
          }
        })
      },
      //开始处理
      handle(id) {
        this.request.post('/api/complaint',{id:id,state:'正在处理'}).then(res=>{
          if(res.code === '200'){
            this.$message.success("开始处理")
            this.load()
          }else{this.$message.error("操作失败")}
        })  
      },
      handleDelete(id) {
        this.request.delete('/api/complaint'+id).then(res=>{
          if(res.code === '200'){
            this.$message.success("删除成功")
            this.load()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //批量选择时
      handleSelectionChange(val){
        this.multipleSelection=val
      },
      //批量删除按键方法
      delBatch(){
        let ids = this.multipleSelection.map(v=>v.id)  //[1,2,3,4]
          this.request.delete('api/complaint/batch',{data:ids}).then(res => {
            if(res.code === '200'){
              this.$message.success("批量删除成功")
              this.load()
            }else{
              this.$message.error("批量删除失败")
            }
          })
      },
    }
}
</script>

<style lang="less" scoped>
.Complaint{
  .search{
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
  .el-popover{
    border: 1px solid #333;
    min-height: 150px;
  }

.text{
  color:#000;
  padding:5px;
  border-radius:20px;
}
}
</style>