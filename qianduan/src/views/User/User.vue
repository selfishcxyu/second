<template>
  <div class="block">
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="请输入用户名" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="username"></el-input>
      <el-input placeholder="请输入邮箱" style="width:200px" prefix-icon="el-icon-message" clearable v-model.trim="email"></el-input>
      <el-input placeholder="请输入昵称" style="width:200px" prefix-icon="el-icon-position" clearable v-model.trim="nickname"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="reset" type="warning">重置</el-button>
    </div>
    <!-- 新增按钮 -->
    <el-button type="primary" @click="handleAdd" style="margin:10px 10px 10px 0;">新增 <i class="el-icon-circle-plus-outline" style="font-size: 14px;"></i></el-button>
    <!-- Form  dialog对话框 -->
    <el-dialog title="用户信息新增/更新" :visible.sync="dialogFormVisible" width="500px">
      <el-form :model="form" :label-width="formLabelWidth">
        <el-form-item label="用户名">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-select v-model="form.gender" placeholder="请选择性别">
            <el-option value="男"></el-option>
            <el-option value="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="form.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="身份证号">
          <el-input v-model="form.idcard" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 批量删除按钮 -->
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

    <!-- 导入和导出按钮 -->
    <el-button type="primary" @click="exp" style="margin:10px 10px 10px 0;">导出</el-button>

    <el-upload action="http://localhost:90/user/import" :show-file-list="false" accept=".xlsx" :on-success="handleExcelImpSuccess" style="display: inline-block;">
     <el-button type="primary" style="margin:10px 10px 10px 0;">导入</el-button>
    </el-upload>

    <!-- data -->
    <el-table
      :data="tableData"
      stripe
      border
      style="width: 100%; margin-bottom: 15px;"
      @selection-change="handleSelectionChange"
    >
      <!-- 可选 -->
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="id" width="80"></el-table-column>
      <el-table-column prop="username" label="用户名" width="150"></el-table-column>
      <el-table-column prop="nickname" label="昵称" width="150"></el-table-column>
      <el-table-column prop="gender" label="性别" width="80"></el-table-column>
      <el-table-column prop="email" label="邮箱" width="150"></el-table-column>
      <el-table-column prop="phone" label="电话" width="150"></el-table-column>
      <el-table-column prop="idcard" label="身份证号"></el-table-column>
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
    <!-- <span class="demonstration"></span> -->
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
    name:'User',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        username:'',email:'',nickname:'',  //搜索
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        form:{
          username:'',password:'',nickname:'', email:'',phone:'',address:''
        },   //表单数据
        formLabelWidth: '80px',    //表单中标签名的宽
        multipleSelection:[],   //批量选择 列表
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
        this.request.get('/api/user/page',
        {params:{pageNum:this.pageNum,pageSize:this.pageSize,username:this.username,email:this.email,nickname:this.nickname}})
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
        this.request.delete('/api/user/'+id).then(res=>{
          if(res){
            this.$message.success("删除成功")
            this.load()
          }else{
            this.$message.error("删除失败")
          }
        })  
      },
      //重置输入框
      reset(){
        this.username=""
        this.email=""
        this.nickname=""
      },
      //新增按钮
      handleAdd(){
        this.form={}
        this.dialogFormVisible = true
      },
      //新增/编辑对话框确定
      save(){
        this.request.post('/api/user',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{
            this.$message.error("新增/编辑失败,用户名已存在或服务器error")
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
          this.request.delete('api/user/batch',{data:ids}).then(res => {
            if(res.data){
              this.$message.success("批量删除成功")
              this.load()
            }else{
              this.$message.error("批量删除失败")
            }
          })
      },
      //导出
      exp(){
        //打开新窗口就导出
        window.open("http://localhost:90/user/export")
      },
      //导入成功后
      handleExcelImpSuccess(){
        this.$message.success("导入成功")
        this.load()
      }
    }
}
</script>

<style lang="less" scoped>
.block{
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