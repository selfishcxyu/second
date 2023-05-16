<template>
  <div class="parking">
    <!-- admin车位管理表  居民查看车位，购买车位，租借车位-->
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="请输入车位编号(如:A-101)" style="width:250px" prefix-icon="el-icon-search" clearable v-model.trim="number"></el-input>
      <el-input placeholder="请输入楼宇(如:happyA)" style="width:250px" prefix-icon="el-icon-search" clearable v-model.trim="building"></el-input>
      <el-input placeholder="请输入住户" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="nickname"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="number='',building='',nickname=''" type="warning">重置</el-button>
    </div>
    <!-- 新增按钮 -->
    <el-button type="primary" @click="handleAdd" style="margin:10px 10px 10px 0;">新增车位信息 <i class="el-icon-circle-plus-outline" style="font-size:14px;"></i></el-button>
    <!-- Form  dialog对话框 -->
    <el-dialog title="车位信息新增/更新" :visible.sync="dialogFormVisible" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="车位编号">
          <el-input v-model="form.number" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="楼宇">
          <el-select v-model="form.building" placeholder="请选择类型">
            <el-option value="happyA"></el-option>
            <el-option value="happyB"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="户主">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="户主信息id">
          <el-input v-model="form.pid" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="确认房源信息">
          <el-input v-model="form.req" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="form.state" placeholder="默认为空闲">
            <el-option value="空闲"></el-option>
            <el-option value="购买"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false,form={}">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;">
      <el-table-column prop="id" label="id号" width="60"></el-table-column>
      <el-table-column prop="number" label="车位编号" width="160" style="text-align:center;"></el-table-column>
      <el-table-column prop="building" label="楼宇" width="160"></el-table-column>
      <el-table-column prop="nickname" label="户主" width="160"></el-table-column>
      <el-table-column prop="pid" label="户主信息id" width="160"></el-table-column>
      <el-table-column prop="req" label="确认房源信息" width="180"></el-table-column>
      <el-table-column prop="state" label="车位状态" width="160">
        <template slot-scope="scope">
          <span v-if="scope.row.state =='空闲'" style="backgroundColor:#909399;" class="text">{{scope.row.state}}</span> 
          <span v-else style="backgroundColor:#67C23A;" class="text">{{scope.row.state}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope">
          <el-button size="mini" type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm style="margin-left: 5px;" confirm-button-text='确认' cancel-button-text='我再想想'
            icon="el-icon-info" icon-color="red" title="您确定删除吗？" @confirm="handleDelete(scope.row.id)">
            <el-button slot="reference" size="mini" type="danger">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
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
    name:'Parking',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        number:'',building:'',nickname:'',
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        form:{ number:'',building:'',nickname:'',pid:0,state:'空闲'},
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
        this.request.get('/api/parking/page',
        {params:{pageNum:this.pageNum,pageSize:this.pageSize,number:this.number,building:this.building,nickname:this.nickname}})
        .then((value) => {
          console.log(value);
          if(value.code === '200'){
            this.tableData=value.data.records 
            this.total=value.data.total
          }
        })
      },
      //编辑和删除
      handleEdit(row) {
        this.form=row
        if(this.form.req){
          const info = JSON.parse(this.form.req)
          this.form.nickname = info.nickname
          this.form.pid = info.id
        }
        this.dialogFormVisible=true
      },
      handleDelete(id) {
        this.request.delete('/api/parking/'+id).then(res=>{
          if(res.code === '200'){
            this.$message.success("删除成功")
            this.load()
          }else{ this.$message.error("删除失败") }
        })  
      },
      //新增按钮
      handleAdd(){
        this.form={}
        this.dialogFormVisible = true
      },
      //新增/编辑对话框确定
      save(){
        if(!this.form.pid){
          this.form.pid = 0
        }
        this.request.post('/api/parking',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{ this.$message.error("新增/编辑失败")}
        })   
      },
    }
}
</script>

<style lang="less" scoped>
.parking{
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
  padding:10px;
  border-radius:20px;
}
}
</style>