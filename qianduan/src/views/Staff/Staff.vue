<template>
  <div class="staff">
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="请输入姓名" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="name"></el-input>
      <el-input placeholder="请输入职位" style="width:200px" prefix-icon="el-icon-message" clearable v-model.trim="position"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="name='',position=''" type="warning">重置</el-button>
    </div>
    <!-- 新增按钮 -->
    <el-button type="primary" @click="handleAdd" style="margin:10px 10px 10px 0;">新增 <i class="el-icon-circle-plus-outline" style="font-size: 14px;"></i></el-button>
    <!-- Form  dialog对话框 -->
    <el-dialog title="员工信息新增/更新" :visible.sync="dialogFormVisible" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="姓名">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="职位">
          <el-input v-model="form.position" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="月薪">
          <el-input v-model="form.salary" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="pid号">
          <el-input v-model="form.pid" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- data -->
    <el-table :data="tableData" stripe border style="width: 100%; margin-bottom: 15px;">
      <!-- 可选 -->
      <el-table-column prop="id" label="id" width="80"></el-table-column>
      <el-table-column prop="name" label="姓名" width="150"></el-table-column>
      <el-table-column prop="position" label="职位" width="150"></el-table-column>
      <el-table-column prop="salary" label="月薪" width="80"></el-table-column>
      <el-table-column prop="phone" label="电话" width="150"></el-table-column>
      <el-table-column prop="pid" label="pid号" width="150"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="mini" type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm
            style="margin-left: 5px;"
            confirm-button-text='确认'
            cancel-button-text='我再想想'
            icon="el-icon-info"
            icon-color="red"
            title="您确定删除吗？"
            @confirm="handleDelete(scope.row.id)"
          >
            <el-button slot="reference" size="mini" type="danger" v-if="scope.row.username!=='admin'">删除 <i class="el-icon-remove-outline"></i></el-button>
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
    name:'Staff',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:7,   //页数的大小
        total:0,
        name:'',position:'',  //搜索
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        form:{
          name:'',position:'', salary:'',phone:'',pid:''
        },   //表单数据
      }
    },
    created() {
      this.load() //初始载入user列表
    },
    methods: {
      // 切换当前页数大小
      handleSizeChange(val) {
        this.pageSize=val
        this.load()
      },
      // 切换当前页数
      handleCurrentChange(val) {
        this.pageNum=val
        this.load()
      },
      //获取数据库请求user列表的方法
      load(){
        this.request.get('/api/staff/page',
        {params:{pageNum:this.pageNum,pageSize:this.pageSize,name:this.name,position:this.position}})
        .then((value) => {
          console.log(value);
          if(value.code === '200'){
            this.tableData=value.data.records //获取用户列表
            this.total=value.data.total
          }
        })
      },
      //对用户的编辑和删除
      handleEdit(row) {
        this.form=row
        this.dialogFormVisible=true
      },
      handleDelete(id) {
        this.request.delete('/api/staff/'+id).then(res=>{
          if(res){
            this.$message.success("删除成功")
            this.load()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //新增按钮
      handleAdd(){
        this.form={}
        this.dialogFormVisible = true
      },
      //新增/编辑对话框确定
      save(){
        if(this.form.pid > 0){
          this.request.post('/api/user',{id:this.form.pid,level:"staff"}).then(value => {
            console.log(value);
            if(value.code === '200'){
              this.$message.success("员工绑定账户成功")
            }
          })
        }
        this.request.post('/api/staff',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{
            this.$message.error("新增/编辑失败")
          }
        })   
      },
    }
}
</script>

<style lang="less" scoped>
.staff{
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
}
  
</style>