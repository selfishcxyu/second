<template>
  <div class="notice">
    <!-- 搜索 -->
    <div class="search">
      <el-input placeholder="请输入标题" style="width:200px" prefix-icon="el-icon-search" clearable v-model.trim="title"></el-input>
      <el-button @click="load" type="primary" style="margin-left: 5px;">搜索</el-button>
      <el-button @click="title=''" type="warning">重置</el-button>
    </div>
    <!-- 新增按钮 -->
    <el-button v-if="user.level == 'admin'" type="primary" @click="handleAdd" style="margin:10px 10px 10px 0;">新增公告 <i class="el-icon-circle-plus-outline" style="font-size: 14px;"></i></el-button>
    <!-- Form  dialog对话框 -->
    <el-dialog title="新增公告信息" :visible.sync="dialogFormVisible" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="标题">
          <el-input v-model="form.title" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="内容">
          <el-input v-model="form.content" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 批量删除按钮 -->
    <el-popconfirm
      v-if="user.level == 'admin'"
      style="margin-left: 5px;"
      confirm-button-text='确认'
      cancel-button-text='我再想想'
      icon="el-icon-info"
      icon-color="red"
      title="您确定批量删除这些数据吗？"
      @confirm="delBatch"
    >
      <el-button type="danger" slot="reference" style="margin:10px 10px 10px 0;">批量删除 
        <i class="el-icon-delete-solid" style="font-size: 14px;"></i></el-button>
    </el-popconfirm>

    <el-table :data="tableData" stripe border style="width: 100%; margin-top: 20px; margin-bottom: 15px;"
      @selection-change="handleSelectionChange"
    >
      <!-- 可选 -->
      <el-table-column type="selection" width="55" v-if="user.level=='admin'"></el-table-column>
      <el-table-column prop="id" label="id" width="100" v-if="user.level=='admin'"></el-table-column>
      <el-table-column prop="title" label="公告标题" width="180"></el-table-column>
      <el-table-column prop="time" label="发布时间" width="180"></el-table-column>
      <el-table-column prop="content" label="公告内容" :show-overflow-tooltip='true'>
        <template slot-scope="scope">
          <el-popover
            placement="top-start"
            width="400"
            trigger="hover">
						<span>公告内容:{{scope.row.content}}</span>
						<span slot="reference">{{scope.row.content.length>20 ? scope.row.content.substr(1,30) + '...' : scope.row.content}}</span>
					</el-popover>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" v-if="user.level == 'admin'">
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
            <el-button slot="reference" size="mini" type="danger">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
  </el-table>

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
    name:'Notice',
    data() {
      return {
        tableData:[],
        pageNum:1,  //当前页数
        pageSize:5,   //页数的大小
        total:0,
        title:'',
        dialogFormVisible: false, //新增按钮的表单对话框的显示
        form:{
          title:'',
          content:'',
        },   //表单数据
        multipleSelection:[],   //批量选择 列表
        user: JSON.parse(sessionStorage.getItem("user")) || '',
      }
    },
    created() {
      this.load() //初始载入
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
      //获取数据库请求
      load(){
        this.request.get('/api/notice/page',
        {params:{pageNum:this.pageNum,pageSize:this.pageSize,title:this.title}})
        .then((value) => {
          if(value.code === '200'){
            this.tableData=value.data.records //获取用户列表
            this.total=value.data.total
            this.$message.success("get notice success")
          }
        })
      },
      //对用户的编辑和删除
      handleEdit(row) {
        this.form=row
        this.dialogFormVisible=true
      },
      handleDelete(id) {
        this.request.delete('/api/notice/'+id).then(res=>{
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
        this.form={}
        this.dialogFormVisible = true
      },
      //新增/编辑对话框确定
      save(){
        this.request.post('/api/notice',this.form).then(res => {
          if(res.code === '200'){
            this.$message.success("新增/编辑成功")
            this.dialogFormVisible = false
            this.load()
          }else{
            this.$message.error("新增/编辑失败")
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
          this.request.delete('api/notice/batch',{data:ids}).then(res => {
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
.notice{
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

}


</style>