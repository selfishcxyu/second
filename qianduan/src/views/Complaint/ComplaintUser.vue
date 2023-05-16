<template>
  <div class="Complaint">
    <!-- 新增按钮 非admin-->
    <el-button type="primary" @click="handleAdd" style="margin-bottom:15px;">新增报修 <i class="el-icon-circle-plus-outline" style="font-size: 14px;"></i></el-button>
    <!-- Form  dialog对话框 -->
    <el-dialog title="新增公告信息" :visible.sync="dialogFormVisible" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="投诉人">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="门牌号">
          <el-input v-model="form.doorplate" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="报修事件">
          <el-input v-model="form.event" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;">
      <el-table-column prop="id" label="编号" width="103"></el-table-column>
      <el-table-column prop="nickname" label="投诉人" width="170"></el-table-column>
      <el-table-column prop="doorplate" label="门牌号" width="170"></el-table-column>
      <el-table-column prop="event" label="报修事件" width="220"></el-table-column>
      <el-table-column prop="time" label="处理时间" width="180"></el-table-column>
      <el-table-column prop="state" label="处理状态" width="180">
        <template slot-scope="scope">
          <span v-if="scope.row.state=='未处理'" style="backgroundColor:#909399;" class="text">{{scope.row.state}}</span> 
          <span v-else-if="scope.row.state=='已处理'" style="backgroundColor:#67C23A;" class="text">{{scope.row.state}}</span>
          <span v-else style="backgroundColor:#E6A23C;" class="text">{{scope.row.state}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="235">
        <template slot-scope="scope">
          <el-popconfirm
            style="margin-left: 5px;"
            confirm-button-text='确认'
            cancel-button-text='再想想'
            icon="el-icon-info"
            icon-color="red"
            title="是否确认已处理？"
            @confirm="handleConfirm(scope.row.id)"
          >
            <el-button size="mini" type="success" slot="reference" v-if="scope.row.state =='正在处理'">确认已处理 <i class="el-icon-edit"></i></el-button>
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
    name:'ComplaintUser',
    data() {
      return {
        tableData:[],
        pageNum:1,
        pageSize:5,
        total:0,
        user:JSON.parse(sessionStorage.getItem("user")) || '',
        dialogFormVisible: false, 
        form:{nickname:'',doorplate:'',pid:'',event:''},
        residenceInfo:JSON.parse(sessionStorage.getItem("residence")) || '',
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
        this.request.get('/api/complaint/page',{params:{pageNum:this.pageNum,pageSize:this.pageSize,pid:this.user.id}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records
            this.total=value.data.total
          }
        })
      },
      //对自己的报修的删除
      handleDelete(id) {
        this.request.delete('/api/complaint/'+id).then(res=>{
          if(res.code === '200'){
            this.$message.success("删除成功")
            this.load()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //新增按钮
      handleAdd(){
        if(!this.residenceInfo){
          this.$message.error("您未购置房产，无法申请报修")
          return
        }
        this.form={}
        this.form.nickname=this.user.nickname //投诉人的名字是姓名
        this.form.state="未处理"
        this.form.pid = this.user.id
        this.dialogFormVisible = true
      },
      //新增对话框确定
      save(){
        this.request.post('/api/complaint',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{
            this.$message.error("新增/编辑失败")
          }
        })   
      },
      handleConfirm(id){
        const date = new Date()
        const year = date.getFullYear()
        const month = date.getMonth()+1
        const day = date.getDate()
        const time = year+'-'+month+'-'+day
        console.log(time.toLocaleString());
        this.request.post('/api/complaint',{id:id,time:time.toLocaleString(),state:'已处理'}).then(res=>{
          if(res.code === '200'){
            this.$message.success("确认处理成功")
            this.load()
          }else{this.$message.error("操作失败")}
        })  
      }
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